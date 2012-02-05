<?php # $Id$

if (IN_serendipity !== true) {
    die ("Don't hack!");
}

// Probe for a language include with constants. Still include defines later on, if some constants were missing
$probelang = dirname(__FILE__) . '/' . $serendipity['charset'] . 'lang_' . $serendipity['lang'] . '.inc.php';
if (file_exists($probelang)) {
    include $probelang;
}

include_once dirname(__FILE__) . '/lang_en.inc.php';

// define missing CONSTANTS (<en> fallback) if not within some current S9y installation
if(!defined(MODERATE_SELECTED_COMMENTS)) @define('MODERATE_SELECTED_COMMENTS', 'Approve selected comments');
if(!defined(ACTIVE_COMMENT_SUBSCRIPTION)) @define('ACTIVE_COMMENT_SUBSCRIPTION', 'Subscribed');
if(!defined(PENDING_COMMENT_SUBSCRIPTION)) @define('PENDING_COMMENT_SUBSCRIPTION', 'Pending confirmation');
if(!defined(NO_COMMENT_SUBSCRIPTION)) @define('NO_COMMENT_SUBSCRIPTION', 'Not subscribed');
if(!defined(SUMMARY)) @define('SUMMARY', 'Summary');

@define('CLEAN', 'Clean all compiled templates');
@define('PLUGIN_DASHBOARD_SYS', 'Dashboard System');
@define('PLUGIN_DASHBOARD_CLEANSMARTY', 'Cleanup Smarty\'s compiled templates');

class serendipity_event_dashboard extends serendipity_event {

    var $debug;

    function introspect(&$propbag) {
        global $serendipity;

        $propbag->add('name',          PLUGIN_DASHBOARD_TITLE);
        $propbag->add('description',   PLUGIN_DASHBOARD_DESC);
        $propbag->add('requirements',  array(
            'serendipity' => '1.6',
            'smarty'      => '2.6.7',
            'php'         => '4.1.0'
        ));

        $propbag->add('version',       '0.6.9-alpha-1');
        $propbag->add('author',        'Garvin Hicking');
        $propbag->add('stackable',     false);
        $propbag->add('configuration', array('read_only', 'limit_comments_pending', 'limit_comments', 'limit_draft', 'limit_future', 'sequence', 'update'));
        $propbag->add('event_hooks',   array(
                                            'backend_configure'             => true,
                                            'backend_header'                => true,
                                            'backend_frontpage_display'     => true,
                                            'css_backend'                   => true
                                        )
        );
        $propbag->add('groups', array('BACKEND_FEATURES'));
    }

    function introspect_config_item($name, &$propbag) {
        switch($name) {
            case 'read_only':
                $propbag->add('type',        'boolean');
                $propbag->add('name',        PLUGIN_DASHBOARD_READONLY);
                $propbag->add('description', PLUGIN_DASHBOARD_READONLY_DESC);
                $propbag->add('default',     'false');
                break;

            case 'limit_comments_pending':
                $propbag->add('type',        'string');
                $propbag->add('name',        PLUGIN_DASHBOARD_LIMIT_COMMENTS_PENDING);
                $propbag->add('description', '');
                $propbag->add('default',     '5');
                break;

            case 'limit_comments':
                $propbag->add('type',        'string');
                $propbag->add('name',        PLUGIN_DASHBOARD_LIMIT_COMMENTS);
                $propbag->add('description', '');
                $propbag->add('default',     '5');
                break;

            case 'limit_draft':
                $propbag->add('type',        'string');
                $propbag->add('name',        PLUGIN_DASHBOARD_LIMIT_DRAFT);
                $propbag->add('description', '');
                $propbag->add('default',     '5');
                break;

            case 'limit_future':
                $propbag->add('type',        'string');
                $propbag->add('name',        PLUGIN_DASHBOARD_LIMIT_FUTURE);
                $propbag->add('description', '');
                $propbag->add('default',     '5');
                break;

            case 'update':
                $propbag->add('type',        'radio');
                $propbag->add('name',        PLUGIN_DASHBOARD_UPDATE);
                $propbag->add('description', PLUGIN_DASHBOARD_UPDATE_DESC);
                $propbag->add('radio', array(
                    'value' => array('stable', 'beta', 'none'),
                    'desc'  => array(PLUGIN_DASHBOARD_STABLE, PLUGIN_DASHBOARD_UNSTABLE, PLUGIN_DASHBOARD_NONE)
                ));
                $propbag->add('radio_per_row', '1');
                $propbag->add('default',     'stable');
                break;

            case 'sequence':
                $propbag->add('type',        'sequence');
                $propbag->add('name',        PLUGIN_DASHBOARD_SEQUENCE);
                $propbag->add('description', PLUGIN_DASHBOARD_SEQUENCE_DESC);
                $propbag->add('checkable',   true);
                $values = array(
                    'comments_pending'     => array('display' => PLUGIN_DASHBOARD_COMMENTS_PENDING),
                    'comments'             => array('display' => COMMENT),
                    'draft'                => array('display' => DRAFT),
                    'future'               => array('display' => PLUGIN_DASHBOARD_FUTURE),
                    'update'               => array('display' => UPDATE),
                    'plugup'               => array('display' => PLUGUP),
                    'clean'                => array('display' => CLEAN)
                );
                $propbag->add('values',      $values);
                $propbag->add('default',     'comments_pending,comments,draft,future,update,plugup,clean');
                break;

            default:
                    return false;
        }
        return true;
    }

    function generate_content(&$title) {
        $title = PLUGIN_DASHBOARD_TITLE;
    }
    
    /* get the right template path - as default in template folder or the fallback plugin folder */
    function fetchTemplatePath($filename) {
        global $serendipity;

        $tfile = serendipity_getTemplateFile($filename, 'serendipityPath');
        if (!$tfile || $filename == $tfile) {
            $tfile = dirname(__FILE__) . '/' . $filename;
        }

        if(!isset($serendipity['smarty']->_version)) { 
            $content = $serendipity['smarty']->fetch('file:'. $tfile); // short notation with Smarty3 in S9y 1.7 and up
        } else { 
            $inclusion = $serendipity['smarty']->security_settings[@INCLUDE_ANY];
            $serendipity['smarty']->security_settings[@INCLUDE_ANY] = true;
            $content = $serendipity['smarty']->fetch('file:'. $tfile);
            $serendipity['smarty']->security_settings[@INCLUDE_ANY] = $inclusion;
        }
        return $content;
     }

    /**
     * check if plugin is available for install
     */
    function plugin_status($name='') {
        $plugins = serendipity_plugin_api::enum_plugins('*', false, $name);
        if(is_array($plugins) && !empty($plugins[0]['name'])) {
            return true;
        }
        return false;
    }

    function showElementCommentlist($where, $limit, $use_hook = null) {
        global $serendipity;
         
        if (!serendipity_checkPermission('adminComments')) {
            return;
        }

        $summaryLength = 120;
        $i = 0;

        if (version_compare(substr($serendipity['version'], 0, 3), '1.6') >= 0) { 
            $comments = serendipity_fetchComments(null, $limit, 'co.id DESC', true, 'NORMAL', $where);
        } else {
            $comments = serendipity_db_query("SELECT c.*, e.title FROM {$serendipity['dbPrefix']}comments c
                                        LEFT JOIN {$serendipity['dbPrefix']}entries e ON (e.id = c.entry_id)
                                        WHERE 1 = 1 " . $where
                                        . (!serendipity_checkPermission('adminEntriesMaintainOthers') ? 'AND e.authorid = ' . (int)$serendipity['authorid'] : '') . "
                                        ORDER BY c.id DESC LIMIT $limit");
        }

        if (!is_array($comments) || count($comments) == 0) {
            return;
        }
        
        if($use_hook == 'antispam') { 
            $serendipity['smarty']->assign('spamblockbayes_hookin', true);
        }

        $comment = array();
        foreach ($comments as $rs) {
            $comment[] = array(
                'fullBody'  => htmlspecialchars($rs['body']),
                'summary'   => htmlspecialchars(strip_tags($rs['body'])),
                'status'    => $rs['status'],
                'type'      => $rs['type'],
                'id'        => $rs['id'],
                'title'     => htmlspecialchars($rs['title']),
                'timestamp' => $rs['timestamp'],
                'pubdate'   => date("c", (int)$rs['timestamp']),
                'referer'   => htmlspecialchars($rs['referer']),
                'url'       => htmlspecialchars($rs['url']),
                'ip'        => htmlspecialchars($rs['ip']),
                'entry_url' => serendipity_archiveURL($rs['entry_id'], htmlspecialchars($rs['title'])),
                'email'     => htmlspecialchars($rs['email']),
                'author'    => (empty($rs['author']) ? ANONYMOUS : htmlspecialchars($rs['author'])),
                'entry_id'  => $rs['entry_id'],
                'entrylink' => serendipity_archiveURL($rs['entry_id'], 'comments', 'serendipityHTTPPath', true) . '#c' . $rs['id'],
                'excerpt'   => ((strlen($rs['body']) > serendipity_mb('substr', $rs['body'], 0, $summaryLength) ) ? true : false),
                'delete_id' => sprintf(COMMENT_DELETE_CONFIRM, $rs['id'], htmlspecialchars($rs['author']))
            );
            
            if (!empty($comment['url']) && substr($comment['url'], 0, 7) != 'http://' && substr($comment['url'], 0, 8) != 'https://') {
                $comment['url'] = 'http://' . $comment['url'];
            }
        }

        // what is this for?
        #serendipity_plugin_api::hook_event('backend_view_comment', $comment, '&amp;serendipity[page]='. $page . $searchString);
        
        $serendipity['smarty']->assign(
                        array(  'read_only' => serendipity_db_bool($this->get_config('read_only')),
                                'urltoken'  => serendipity_setFormToken('url'),
                                'formtoken' => serendipity_setFormToken()
                            ));
        return $comment;
    }

    function showElementEntrylist($filter = array(), $limit = 0) {
        global $serendipity;

        if (!serendipity_checkPermission('adminEntries')) {
            return;
        }

        if (!serendipity_checkPermission('adminEntriesMaintainOthers')) {
            $filter[] = 'e.authorid = ' . (int)$serendipity['authorid'];
        }
        
        $filter_sql = '(' . implode( ' AND ' , array_reverse($filter)) . ')';
        
        $orderby = 'timestamp DESC';
        // Fetch the entries
        $entries = serendipity_fetchEntries( false, false, $limit, true, false, $orderby, $filter_sql );

        if (!is_array($entries) || count($entries) == 0) {
            return;
        }
        
        $entry = array();
        foreach ($entries as $ey) {
            // Find out if the entry has been modified later than 30 minutes after creation
            if ($ey['timestamp'] <= ($ey['last_modified'] - 60*30)) {
                $lm = '<a href="#" title="' . LAST_UPDATED . ': ' . serendipity_formatTime(DATE_FORMAT_SHORT, $ey['last_modified']) . '" onclick="alert(this.title)"><img src="'. serendipity_getTemplateFile('admin/img/clock.png') .'" alt="*" /></a>';
            } else {
                $lm = '';
            }

            if (!$serendipity['showFutureEntries'] && $ey['timestamp'] >= serendipity_serverOffsetHour()) {
                $entry_pre = '<a href="#" title="' . ENTRY_PUBLISHED_FUTURE . '" onclick="alert(this.title)"><img src="'. serendipity_getTemplateFile('admin/img/clock_future.png') .'" alt="*" /></a> ';
            } else {
                $entry_pre = '';
            }

            if (serendipity_db_bool($ey['properties']['ep_is_sticky'])) {
                $entry_pre .= ' ' . STICKY_POSTINGS . ': ';
            }

            if (count($ey['categories'])) {
                $cats = array();
                foreach ($ey['categories'] as $cat) {
                    $caturl = serendipity_categoryURL($cat);
                    $cats[] = '<a href="' . $caturl . '">' . htmlspecialchars($cat['category_name']) . '</a>';
                }
                $entry_cats = implode(', ', $cats);
            }
            
            $entry[] = array(
                'clock'     => $entry_pre,
                'id'        => $ey['id'],
                'title'     => htmlspecialchars($ey['title']),
                'stime'     => serendipity_formatTime(DATE_FORMAT_SHORT, $ey['timestamp']) . ' ' .$lm,
                'author'    => htmlspecialchars($ey['author']),
                'cats'      => $entry_cats,
                'link'      => serendipity_archiveURL($ey['id'], $ey['title'], 'serendipityHTTPPath', true, array('timestamp' => $ey['timestamp'])),
                'draft_pre' => ((serendipity_db_bool($ey['isdraft']) || (!$serendipity['showFutureEntries'] && $ey['timestamp'] >= serendipity_serverOffsetHour())) ? true : false)
            );
            
        } // end entries output
        
        $serendipity['smarty']->assign('urltoken', serendipity_setFormToken('url'));
        
        return $entry;
    }

    function compareVersion($newV, $actV) {
        $newV = explode('.', $newV);
        $actV = explode('.', $actV);
        $length = ( count($newV) < count($actV) ? count($newV) : count($actV) );

        for($i=0; $i < $length; $i++){
            if ($newV[$i] > $actV[$i]){
                return 1;
            }
        }
        return 0;
    }
    

    function CheckUpdate() {
        global $serendipity;
        
        if (!serendipity_checkPermission('adminUsers')) {
            return;
        }

        if ($this->get_config('update') == 'none') {
            return;
        }
        $updateURL = 'https://raw.github.com/s9y/Serendipity/master/docs/RELEASE';

        $file = fopen($updateURL, 'r');
        if (!$file) {
            echo "PLUGIN_DASHBOARD_ERROR_URL";
            return;
        }
        
        $version = $this->get_config('update');
        
        while(!feof($file)){
            $line = fgets($file);

            if(preg_match('/^' . $version . ':(.+$)/', $line, $match)){
                $update_to_version = $match[1];
                $this->set_config('last_version', $update_to_version);
                
                $serendipity['smarty']->assign('showUpdateNotifier', true);
                
                if ($version == "stable"){
                    $url="http://prdownloads.sourceforge.net/php-blog/serendipity-" . $update_to_version . ".zip";
                }
                else {
                    if (date('H') >= 23 && date('i') >= 42){
                        $day = date("d");
                    }
                    else {
                        $day = date("d") - 1;
                    }
                    $url="http://www.s9y.org/snapshots/s9y_". date("Ym") . $day . "2342.tar.gz";
                }
                if($this->compareVersion($update_to_version, $serendipity['version'])){
                    $serendipity['smarty']->assign('showElementUpdate', true);
                    $u_text = PLUGIN_DASHBOARD_UPDATE_NOTIFIER . ' <a href="' . $url . '">' . $update_to_version . '</a>';
                    $this->set_config('update_text', $u_text);
                }
            }
        }
    }

    function showElementDraft($sort_id) {
        global $serendipity;
        
        $lim = $this->get_config('limit_draft');
        if ($lim < 1) return;

        $serendipity['smarty']->assign('showElementDraft', true);
        $serendipity['smarty']->assign('draft_block_id', $sort_id);
        $serendipity['smarty']->assign('draft_Entrylist', $this->showElementEntrylist(array("e.isdraft = 'true'"), $lim));
    }

    function showElementComments($sort_id) {
        global $serendipity;

        $lim = $this->get_config('limit_comments');
        if ($lim < 1) return;

        $serendipity['smarty']->assign('showElementComments', true);
        $serendipity['smarty']->assign('comments_block_id', $sort_id);
        $serendipity['smarty']->assign('entry_Commentlist', $this->showElementCommentlist("AND status = 'approved'", $lim));
    }
    
    function showElementCommentsPending($sort_id) {
        global $serendipity;

        $lim = $this->get_config('limit_comments_pending');
        if ($lim < 1) return;

        if($this->plugin_status('serendipity_event_spamblock_bayes')) { $hookin = 'antispam'; }
        $serendipity['smarty']->assign('showElementComPend', true);
        $serendipity['smarty']->assign('commpen_block_id', $sort_id);
        $serendipity['smarty']->assign('entry_Compendlist', $this->showElementCommentlist("AND status IN ('pending','confirm')", $lim, $hookin));
    }

    function showPluginNotifier($sort_id) {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers')) {
            return;
        }

        $serendipity['smarty']->assign('showElementPlugup', true);
        $serendipity['smarty']->assign('plugup_block_id', $sort_id);
        if (!isset($serendipity['eyecandy']) || serendipity_db_bool($serendipity['eyecandy'])) {
        
            // use_js_dragdrop no need actually
            $serendipity['smarty']->assign(array('use_js_dragdrop' => true, 'eyecandy' => $serendipity['eyecandy']));
        }
    }
    
    function showUpdateNotifier($sort_id) {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers')) {
            return;
        }

        // If we didn't check today, do it now and remember, that we did.
        if (($this->get_config('last_update') != date('Ymd'))){
            $this->set_config('last_update', date('Ymd'));
            $this->CheckUpdate(); // this will fill all needed config values
        }
        
        // Check if the last found update version is newer and tell it, if this is the case
        $newVersion = $this->get_config('last_version');
        
        $serendipity['smarty']->assign(array('update_block_id' => $sort_id, 'showElementUpdate' => true));
        
        if($this->compareVersion($newVersion, $serendipity['version'])){
            $eventData = '';
            serendipity_plugin_api::hook_event('plugin_dashboard_updater', $eventData, $newVersion);
            $update_text = $this->get_config('update_text');
            $serendipity['smarty']->assign(array('update_text' => $update_text, 'update_form' => $eventData));
        }
    }

    function showElementFuture($sort_id) {
        global $serendipity;

        $lim = $this->get_config('limit_future');
        if ($lim < 1) return;

        $serendipity['smarty']->assign('showElementFuture', true);
        $serendipity['smarty']->assign('future_block_id', $sort_id);
        $serendipity['smarty']->assign('entry_future', $this->showElementEntrylist(array("e.isdraft != 'true' AND e.timestamp >= " . serendipity_serverOffsetHour()), $lim));
    }

    function showElementClean($sort_id) {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers')) {
            return;
        }

        // forbid entry access if user is not in admin group level
        if ($serendipity['serendipityUserlevel'] < USERLEVEL_ADMIN) {
            return;
        }
        $serendipity['smarty']->assign(
                                    array(  'showCleanupSmarty' => true,
                                            'cleanup_block_id'  => $sort_id,
                                            'plugininstance'    => $this->instance)
                                        );
    }
    
    function showElement($element, $sortindex) {
        switch($element) {
            case 'update':
                $this->ShowUpdateNotifier($sortindex);
                break;
            case 'plugup':
                $this->ShowPluginNotifier($sortindex);
                break;
            case 'draft':
                $this->showElementDraft($sortindex);
                break;
            case 'comments':
                $this->showElementComments($sortindex);
                break;
            case 'comments_pending':
                $this->showElementCommentsPending($sortindex);
                break;
            case 'future':
                $this->showElementFuture($sortindex);
                break;
            case 'clean':
                $this->showElementClean($sortindex);
                break;
        }
        
        return true;
    }

    function event_hook($event, &$bag, &$eventData, $addData = null) {
        global $serendipity;

        $hooks = &$bag->get('event_hooks');

        $serendipity['plugin_dashboard_version'] = &$bag->get('version');
        
        /* Set global plugin path setting, to avoid different pluginpath '/plugins/' as plugins serendipity vars */
        if(!isset($serendipity['dashboard']['pluginpath'])) { 
            $pluginpath = pathinfo(dirname(__FILE__));
            $serendipity['dashboard']['pluginpath'] = basename(rtrim($pluginpath['dirname'], '/')) . '/serendipity_event_dashboard/';
        }
        
        // can we still keep this here or better move to backend_frontpage_display hook? (in some cases this place disrupted entry comments forms, why?)
        if (!is_object($serendipity['smarty'])) { 
            serendipity_smarty_init(); // if not set to avoid member function assign() on a non-object error, start Smarty templating
        }

        if (isset($hooks[$event]) && serendipity_userLoggedIn()) {
            switch($event) {
                case 'backend_configure':
                    // here we go and overwrite the backend structure - maybe ;-)
                    if( ( isset($serendipity['GET']['noSidebar']) || isset($serendipity['POST']['noSidebar']) ) 
                     ||  !isset($serendipity['GET']['adminAction']) 
                     || ( empty($serendipity['GET']['adminAction']) && !isset($serendipity['GET']['adminModule']) ) 
                     ) { 
                        $serendipity['POST']['noSidebar'] = true;
                        $serendipity['POST']['noBanner'] = true;
                        $serendipity['POST']['noFooter'] = true;
                    }
                    
                    break;

                 case 'backend_header':
                    // here we go and and add or restruct the backend header ;-)

                    // Enable the use of Serendipity JQuery in Backend, if not already done
                    // also either make sure this dashboard is for 1.6 up only or construct a fallback to google 
                    $serendipity['capabilities']['jquery'] = false;
                    
                    echo "\n\n";
                    echo '<link rel="stylesheet" type="text/css" href="'.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'css/mbContainer.css" title="style"  media="screen"/>'."\n";

                    echo '<script type="text/javascript" src="'.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'inc/modernizr-2.0.6.min.js"></script>'."\n";
                    echo '<script type="text/javascript" src="'.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'inc/jquery.min.js"></script>'."\n";
                    #echo '<script type="text/javascript"> jQuery.noConflict(); </script>'."\n";

                    echo '<script type="text/javascript" src="'.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'inc/ajax-dashboard.js"></script>'."\n";
                    echo '<script type="text/javascript" src="'.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'inc/jquery-dashboard.js"></script>'."\n";
                    echo '<script type="text/javascript" src="'.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'inc/jquery-ui-1.8.17.custom.min.js"></script>'."\n";
                    echo '<script type="text/javascript" src="'.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'inc/jquery.metadata.js"></script>'."\n";
                    echo '<script type="text/javascript" src="'.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'inc/mbContainer.js"></script>'."\n";
                    // set some JS vars
                    echo '<script type="text/javascript">
var const_view   = \''.VIEW_FULL.'\';
var const_hide   = \''.HIDE.'\';
var img_plus     = \''.serendipity_getTemplateFile("img/plus.png").'\';
var img_minus    = \''.serendipity_getTemplateFile("img/minus.png").'\';
var img_help2    = \''.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'img/help_oran.png\';
var img_help1    = \''.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'img/help_blue.png\';
var jspath       = \''.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'\';
var elpath       = \''.$serendipity['serendipityHttpPath'].$serendipity['dashboard']['pluginpath'].'elements/\';
var learncommentPath = \''.$serendipity['baseURL'].'index.php?/plugin/learncomment\';
var ratingPath   = \''.$serendipity['baseURL'].'index.php?/plugin/getRating\';
var bayesCharset = \''.LANG_CHARSET.'\';
var bayesDone    = \''.DONE.'\';
var bayesLoadIndicator = \''.$serendipity['serendipityHTTPPath'] . 'plugins/serendipity_event_spamblock_bayes/img/spamblock_bayes.load.gif\';
</script>'."\n";
                    //set spamblock_bayes
                    $bayespath = $serendipity['serendipityHTTPPath'] . 'plugins/serendipity_event_spamblock_bayes/';
                    echo "<script type='text/javascript' src='{$bayespath}bayes_commentlist.js'></script>";
                    
                    break;

                 case 'backend_frontpage_display':
                    $elements = array();
                    $elements = explode(',', $this->get_config('sequence'));
                    
                    $sysinfo = array();
                    /* we already have these infos - but will keep them here for future purposes */
                    if (serendipity_userLoggedIn()) {
                        $sysinfo['self_info'] = sprintf(USER_SELF_INFO, htmlspecialchars($serendipity['serendipityUser']), $serendipity['permissionLevels'][$serendipity['serendipityUserlevel']]);
                    } else {
                        $sysinfo['self_info'] = '';
                    }
                    
                    if ($serendipity['expose_s9y']) {
                        $sysinfo['version_info'] = sprintf(ADMIN_FOOTER_POWERED_BY, $serendipity['versionInstalled'], phpversion());
                    } else {
                        $sysinfo['version_info'] = sprintf(ADMIN_FOOTER_POWERED_BY, '', '');
                    }
                    $sysinfo['intitle'] = ADMIN_FRONTPAGE;
                    $sysinfo['title'] = PLUGIN_DASHBOARD_TITLE;
                    $sysinfo['dashboard_version'] = $serendipity['plugin_dashboard_version'];
                    $sysinfo['user'] = htmlspecialchars($serendipity['serendipityUser']);
                    $sysinfo['perm'] = $serendipity['permissionLevels'][$serendipity['serendipityUserlevel']];
                    
                    ob_start();

                    // include the POST % GET action file
                    include dirname(__FILE__) . '/' . 'dashboard_request_actions.inc.php';
                    $serendipity['smarty']->assign(
                                                array(  'start'         => $serendipity['GET']['adminModule'] == 'start' ? true : false,
                                                        'errormsg'      => $errormsg,
                                                        'elements'      => $elements,
                                                        'thispath'      => substr($serendipity['dashboard']['pluginpath'], 0, -1),
                                                        'fullpath'      => dirname(__FILE__),
                                                        'antispam_hook' => '',
                                                        'sysinfo'       => $sysinfo,
                                                        's9yheader'     => array($eventData),
                                                        'version'       => 'Serendipity ' . $serendipity['version'] . ' ['.$this->get_config('update').']'
                                                    )
                                                );
                    
                    
                    $eventData = null; // eventData holds the welcome User message and the link and bookmark box
                    
                    // gather the data
                    foreach($elements AS $key => $element) {
                        $this->showElement($element, $key);
                    }

                    /* get the dashboard template file */
                    echo $this->fetchTemplatePath('plugin_dashboard.tpl');
                    
                    $dashboard = ob_get_contents();
                    
                    ob_end_clean();

                    // who needs this?
                    $eventData['more'] = $dashboard;
                    break;

                case 'css_backend':
                    $filename = 'dashboard.css';
                    $tfile = serendipity_getTemplateFile($filename, 'serendipityPath');
                    if (!$tfile || $tfile == $filename) {
                        $tfile = dirname(__FILE__) . '/' . $filename;
                    }
                    echo file_get_contents($tfile);
                    break;

            }
        }

        return true;
    }
}

/* vim: set sts=4 ts=4 expandtab : */
