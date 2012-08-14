<?php # $Id$

// - last modified 2012-08-14

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
if(!defined('MODERATE_SELECTED_COMMENTS')) @define('MODERATE_SELECTED_COMMENTS', 'Approve selected comments');
if(!defined('ACTIVE_COMMENT_SUBSCRIPTION')) @define('ACTIVE_COMMENT_SUBSCRIPTION', 'Subscribed');
if(!defined('PENDING_COMMENT_SUBSCRIPTION')) @define('PENDING_COMMENT_SUBSCRIPTION', 'Pending confirmation');
if(!defined('NO_COMMENT_SUBSCRIPTION')) @define('NO_COMMENT_SUBSCRIPTION', 'Not subscribed');
if(!defined('SUMMARY')) @define('SUMMARY', 'Summary');

 /* check if bayes plugin is onBoard and installed */
if(!defined('BAYES_INSTALLED')) {
    if(serendipity_event_dashboard::check_plugin_status('serendipity_event_spamblock_bayes')) {
        @define('BAYES_INSTALLED', true);
    }
}
 /* check if freetags plugin is onBoard and installed */
if(!defined('FREETAG_INSTALLED')) {
    if(serendipity_event_dashboard::check_plugin_status('serendipity_event_freetag')) {
        @define('FREETAG_INSTALLED', true);
    }
}
 /* check if autoupdate plugin is onBoard and installed */
if(!defined('AUTOUPDATE_INSTALLED')) {
    if(serendipity_event_dashboard::check_plugin_status('serendipity_event_autoupdate')) {
        @define('AUTOUPDATE_INSTALLED', true);
    }
}


class serendipity_event_dashboard extends serendipity_event {

    var $debug;
    var $bayes_plugin;

    function introspect(&$propbag) {
        global $serendipity;

        $propbag->add('name',          PLUGIN_DASHBOARD_TITLE);
        $propbag->add('description',   PLUGIN_DASHBOARD_DESC);
        $propbag->add('requirements',  array(
            'serendipity' => '1.6',
            'smarty'      => '2.6.7',
            'php'         => '5.2.6'
        ));

        $propbag->add('version',       '0.9.2');
        $propbag->add('author',        'Garvin Hicking, Ian');
        $propbag->add('stackable',     false);
        $propbag->add('configuration', array('read_only', 'path', 'limit_comments_pending', 'limit_comments', 'limit_draft', 'limit_future', 'limit_feed', 'sequence', 'feed_url', 'feed_title', 'feed_content', 'feed_author', 'feed_conum', 'dependencynote', 'maintenance', 'maintenancenote', 'update', 'clean'));
        $propbag->add('event_hooks',   array(
                                            'backend_configure'             => true,
                                            'backend_header'                => true,
                                            'external_plugin'               => true,
                                            'backend_frontpage_display'     => true
                                        )
        );
        $propbag->add('groups', array('BACKEND_FEATURES'));
        $propbag->add('config_groups', array(
            DASHBOARD_MAIN    => array('read_only', 'path', 'dependencynote', 'clean'),
            DASHBOARD_LAYOUT  => array('sequence'),
            DASHBOARD_LIMITS  => array('limit_comments_pending', 'limit_comments', 'limit_draft', 'limit_future', 'limit_feed'),
            DASHBOARD_FEED    => array('feed_url', 'feed_title', 'feed_content', 'feed_author', 'feed_conum'),
            DASHBOARD_UPDATE  => array('maintenance', 'maintenancenote', 'update')
        ));
    }

    function introspect_config_item($name, &$propbag) {
        global $serendipity;
        switch($name) {
            case 'read_only':
                $propbag->add('type',        'boolean');
                $propbag->add('name',        PLUGIN_DASHBOARD_READONLY);
                $propbag->add('description', PLUGIN_DASHBOARD_READONLY_DESC);
                $propbag->add('default',     'false');
                break;

            case 'path':
                $propbag->add('type',        'string');
                $propbag->add('name',        PLUGIN_DASHBOARD_PATH);
                $propbag->add('description', PLUGIN_DASHBOARD_PATH_DESC);
                $propbag->add('default',     $serendipity['serendipityHTTPPath'] . 'plugins/serendipity_event_dashboard');
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

            case 'limit_feed':
                $propbag->add('type',        'string');
                $propbag->add('name',        PLUGIN_DASHBOARD_LIMIT_FEED);
                $propbag->add('description', '');
                $propbag->add('default',     '3');
                break;

            case 'dependencynote':
                $propbag->add('type',        'boolean');
                $propbag->add('name',        PLUGIN_DASHBOARD_DEPENDENCY_NOTE);
                $propbag->add('description', '');
                $propbag->add('default',     'true');
                break;

            case 'clean':
                $propbag->add('type',        'boolean');
                $propbag->add('name',        PLUGIN_DASHBOARD_CLEAN);
                $propbag->add('description', '');
                $propbag->add('default',     'true');
                break;

            case 'maintenance':
                $propbag->add('type',        'boolean');
                $propbag->add('name',        PLUGIN_DASHBOARD_MAINTENANCE);
                $propbag->add('description', '');
                $propbag->add('default',     'false');
                break;

            case 'maintenancenote':
                $propbag->add('type',        'text');
                $propbag->add('rows', 3);
                $propbag->add('name',        PLUGIN_DASHBOARD_MAINTENANCE_NOTE);
                $propbag->add('description', '');
                $propbag->add('default',     sprintf(PLUGIN_DASHBOARD_MAINTENANCE_TEXT, $serendipity['blogTitle']));
                break;

            case 'feed_url':
                $propbag->add('type',        'string');
                $propbag->add('name',        PLUGIN_DASHBOARD_FEED_URL);
                $propbag->add('description', '');
                $propbag->add('default',     'http://blog.s9y.org/feeds/index.rss2');
                break;

            case 'feed_title':
                $propbag->add('type',        'string');
                $propbag->add('name',        PLUGIN_DASHBOARD_FEED_TITLE);
                $propbag->add('description', '');
                $propbag->add('default',     PLUGIN_DASHBOARD_FEED);
                break;

            case 'feed_content':
                $propbag->add('type',        'boolean');
                $propbag->add('name',        PLUGIN_DASHBOARD_FEED_CONTENT);
                $propbag->add('description', '');
                $propbag->add('default',     'true');
                break;

            case 'feed_author':
                $propbag->add('type',        'boolean');
                $propbag->add('name',        PLUGIN_DASHBOARD_FEED_AUTHOR);
                $propbag->add('description', '');
                $propbag->add('default',     'true');
                break;

            case 'feed_conum':
                $propbag->add('type',        'boolean');
                $propbag->add('name',        PLUGIN_DASHBOARD_FEED_CONUM);
                $propbag->add('description', '');
                $propbag->add('default',     'true');
                break;

            case 'update':
                $propbag->add('type',        'radio');
                $propbag->add('name',        PLUGIN_DASHBOARD_UPDATE);
                $propbag->add('description', PLUGIN_DASHBOARD_UPDATE_DESC);
                $propbag->add('radio', array(
                    'value' => array('stable', 'none'),
                    'desc'  => array(PLUGIN_DASHBOARD_STABLE, PLUGIN_DASHBOARD_NONE)
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
                    'info'       => array('display' => PLUGIN_DASHBOARD_INFO),
                    'compen'     => array('display' => PLUGIN_DASHBOARD_COMMENTS_PENDING),
                    'future'     => array('display' => PLUGIN_DASHBOARD_FUTURE),
                    'draft'      => array('display' => DRAFT),
                    'feed'       => array('display' => PLUGIN_DASHBOARD_FEED),
                    'comapp'     => array('display' => COMMENT),
                    'update'     => array('display' => UPDATE),
                    'plugup'     => array('display' => PLUGUP)
                );
                $propbag->add('values',      $values);
                $propbag->add('default',     'info,compen,future,draft,feed,comapp,update,plugup');
                break;

            default:
                    return false;
        }
        return true;
    }

    function generate_content(&$title) {
        $title = PLUGIN_DASHBOARD_TITLE;
    }

    /**
     * Check if dependency plugin is available for install
     * @param  string   pluginname
     * @return boolean
     */
    static function check_plugin_status($name='') {
        $plugins = serendipity_plugin_api::enum_plugins('*', false, $name);
        if(is_array($plugins) && !empty($plugins[0]['name'])) {
            return true;
        }
        return false;
    }

    /**
     * Load its configured instance once, if the bayes plugin is onBoard and installed
     * @return string  instance
     */
    function findBayes() {
        if (!isset($this->bayes_plugin)) {
            // find installed plugin 
            $plugins = serendipity_plugin_api::enum_plugins('*', false, 'serendipity_event_spamblock_bayes');

            $plugin_found = null;

            foreach($plugins as $plugin) {
                // load instance
                $plugin_found = serendipity_plugin_api::load_plugin($plugin['name']);
                break;
            }

            $this->bayes_plugin = $plugin_found;
        }
        return $this->bayes_plugin;
    }

    /**
     * return classify bayes rating by configured instance of bayes plugin, else return false
     * @param  string   commentBody
     * @return boolean
     */
    function classifyBayes($coBody) {
        $theBayesInstance = $this->findBayes();
        if (isset($theBayesInstance)) {
            return $theBayesInstance->classify($coBody, 'body');
        }
        return false;
    }

    /**
     * Count the number of plugins to which the filter criteria matches
     *
     * @access public
     * @param   array  The filter for plugins (left|right|hide|event|eventh) and even more
     * @param   boolean If true, the filtering logic will be reversed an all plugins that are NOT part of the filter will be evaluated
     * @return  int     Number of plugins that were found.
     */
    function count_plugins($filter = array(), $negate = false) {
        global $serendipity;

        $sql = "SELECT COUNT(placement) AS count from {$serendipity['dbPrefix']}plugins ";

        if (is_array($filter)) {
            $sql .= "WHERE ( ";
            foreach ($filter as $f) {
                if ($negate) {
                    $sql .= "placement != '$f' ";
                } else {
                    $sql .= "placement='$f' ";
                }
                if (next($filter)==true) $sql .= "AND ";
            }
            $sql .= " ) ";
        }
        $count = serendipity_db_query($sql, true);
        if (is_array($count) && isset($count[0])) {
            return (int) $count[0];
        }

        return 0;
    }

    /**
     * Select rss feed content
     * thanks to Stuart Herbert http://blog.stuartherbert.com/php/2007/01/07/using-simplexml-to-parse-rss-feeds/
     * @param  string   feedContent
     * @param  int      Limit entries
     * @return array    articles
     **/
    function select_simple_xml($content, $num) {
        /* what we might need to extract
        <item>
            <title></title>
            <link></link>
                <category>Announcements</category>
                <category>Development</category>
                <category>Personal</category>
            <comments></comments>
            <wfw:comment></wfw:comment>
            <slash:comment></slash:comment>
            <author></author>
            <content:encoded></content:encoded>
            <pubDate></pubDate>
            <feedburner:origLink></feedburner:origLink>
        </item>
        */
        // define the namespaces that we are interested in
        $ns = array
        (
            'content' => 'http://purl.org/rss/1.0/modules/content/',
            'wfw' => 'http://wellformedweb.org/CommentAPI/',
            'dc' => 'http://purl.org/dc/elements/1.1/',
            'slash' => 'http://purl.org/rss/1.0/modules/slash/'
        );

        // obtain the articles in the feeds, and construct an array of articles
        $articles = array();

        // error_reporting
        try { $xmlData = @new SimpleXMLElement($content); } catch (Exception $e) {
            //error handling in here 
            $articles[0]['content'] = 'There was an error fetching the Serendipity Blog RSS Feed. Try again later.';
        }

        // step 1: get the feed (we already have that by function get_url_contents($url))
        $xml = new SimpleXmlElement($content);

        // step 2: extract the channel metadata
        $channel = array();
        $channel['title']       = $xml->channel->title;
        $channel['link']        = $xml->channel->link;
        $channel['description'] = $xml->channel->description;
        $channel['pubDate']     = $xml->pubDate;
        $channel['timestamp']   = strtotime($xml->pubDate);
        $channel['generator']   = $xml->generator;
        $channel['language']    = $xml->language;

        // step 3: extract the articles
        $i = 1;
        foreach ($xml->channel->item as $item)
        {
            $article = array();
            $article['channel'] = $blog;
            $article['title'] = $item->title;
            $article['author'] = $item->author;
            $article['link'] = $item->link;
            $article['comments'] = $item->comments;
            $article['pubDate'] = $item->pubDate;
            $article['timestamp'] = strtotime($item->pubDate);
            $article['description'] = (string) trim($item->description);
            $article['isPermaLink'] = $item->guid['isPermaLink'];

            // get data held in namespaces
            $content = $item->children($ns['content']);
            $dc      = $item->children($ns['dc']);
            $wfw     = $item->children($ns['wfw']);
            $slash   = $item->children($ns['slash']);

            $article['creator'] = (string) $dc->creator;
            foreach ($dc->subject as $subject)
                $article['subject'][] = (string)$subject;

            $article['content'] = (string)trim($content->encoded);
            $article['commentRss'] = $wfw->commentRss;
            $article['countcomments'] = $slash->comments;

            // add this article to the list
            $articles[$article['timestamp']] = $article;
            if ($i >= $num) break;
            $i++;
        }

        // a users note
        // Another way to get the CDATA is to load the xml using
        // $xml = simplexml_load_string($rawFeed, ‘SimpleXMLElement’, LIBXML_NOCDATA); //(PHP >= 5.1.0)
        // ~
        // Then you just get the CDATA elements without complications.
        // See: http://us.php.net/manual/en/function.simplexml-load-string.php

        // at this point, $channel contains all the metadata about the RSS feed,
        // and $articles contains an array of articles for us to repurpose
        return $articles;
    }

    /**
     * Read RSS feed Content
     * @param  string   content
     */
    function get_url_contents($url) {
        $crl = curl_init();
        $timeout = 5;
        $useragent = "Googlebot/2.1 ( http://www.googlebot.com/bot.html)";
        curl_setopt ($crl, CURLOPT_USERAGENT, $useragent);
        curl_setopt ($crl, CURLOPT_URL,$url);
        curl_setopt ($crl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt ($crl, CURLOPT_CONNECTTIMEOUT, $timeout);
        $ret = curl_exec($crl);
        curl_close($crl);
        return $ret;
    }

    /**
     * Set upgraders maintenance mode
     * @param  boolean
     */
    function s9y_maintenance_mode($mode=false) {
        global $serendipity;
        if (!serendipity_checkPermission('adminUsers')) {
            return;
        }

        $is_logged_in = serendipity_userLoggedIn();
        if($mode) 
            echo "This Maintenance Mode is still developing. Please send any ideas on how to proceed here to the s9y.org forum, or via  PM, or create a GitHub issue.";
        else
            echo "Undo Maintenance Dev Mode done!";
        // ToDo: finish
        if ( !$is_logged_in ) {
            //serendipity_die(nl2br($this->get_config('maintenancenote')));
        }
    }

    /**
     * Get Element comments List
     * @param  string   SQL-where
     * @param  int      SQL-limit
     * @param  string   use_hook
     * @return array    comments
     */
    function showElementCommentlist($where, $limit, $use_hook = null) {
        global $serendipity;

        if (!serendipity_checkPermission('adminComments')) {
            return;
        }

        $summaryLength = 120;
        $i = 0;

        // we already use 1.6 up with this dashboard
        $comments = serendipity_fetchComments(null, $limit, 'co.id DESC', true, 'NORMAL', $where);

        if (!is_array($comments) || count($comments) == 0) {
            return;
        }

        if($use_hook == 'antispam') {
            #serendipity_plugin_api::hook_event('backend_comments_top', $comments);
            $serendipity['smarty']->assign('spamblockbayes_hookin', true);
        }
        $comment = array();
        foreach ($comments as $rs) {
            $comment[] = array(
                'fullBody'  => htmlspecialchars($rs['body']),
                'status'    => $rs['status'],
                'type'      => $rs['type'],
                'id'        => $rs['id'],
                'cID'       => ($this->classifyBayes($rs['body']) * 100),
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
            #serendipity_plugin_api::hook_event('backend_view_comment', $comment, '&amp;serendipity[page]='. $page . $searchString);
            #serendipity_plugin_api::hook_event('backend_view_comment', $comment);

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

    /**
     * Get element Info List
     * @return array    infoList
     */
    function showElementInfolist() {
        global $serendipity;

        $infolist['total_count']      = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}entries", true);
        $infolist['draft_count']      = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}entries WHERE isdraft = 'true'", true);
        $infolist['publish_count']    = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}entries WHERE isdraft = 'false'", true);
        $infolist['category_count']   = serendipity_db_query("SELECT count(categoryid) FROM {$serendipity['dbPrefix']}category", true);
        $infolist['image_count']      = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}images", true);
        $infolist['comment_ct_all']   = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}comments WHERE type = 'NORMAL'", true);
        $infolist['comment_ct_app']   = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}comments WHERE type = 'NORMAL' AND status = 'approved'", true);
        $infolist['comment_ct_pen']   = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}comments WHERE type = 'NORMAL' AND status = 'pending'", true);
        if (defined('BAYES_INSTALLED')) {
            $infolist['total_spam']       = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}spamblock_bayes_recycler", true, 'num');
        }
        if (defined('FREETAG_INSTALLED')) {
            $infolist['total_tags']       = count(serendipity_db_query("SELECT DISTINCT tag FROM {$serendipity['dbPrefix']}entrytags", false, 'num'));
            $serendipity['smarty']->assign('is_freetag_installed', true);
        }
        return $infolist;
    }


    /**
     * Get Element Info Feed
     */
    function showElementInfoFeed() {
        $blogurl     = $this->get_config('feed_url');
        $blognum     = $this->get_config('limit_feed');
        // read blog rss
        $s9yblog = $this->get_url_contents($blogurl); // ToDo: cache this for a day.., see updater
        // select elements as array by limit
        $s9yblog = $this->select_simple_xml($s9yblog, $blognum);

        return $s9yblog;
    }


    /**
     * Get Element Entry List
     * @param  array      filter
     * @param  int        limit
     */
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
                'pubdate'   => date("c", (int)$ey['timestamp']),
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

    /**
     * Check update and autoupdate eventData
     */
    function CheckUpdate() {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers') || $this->get_config('update') == 'none') {
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
                if ( version_compare($update_to_version, $serendipity['version']) >= 0 ) {
                    $serendipity['smarty']->assign('showElementUpdate', true);
                    $or_use = (defined('AUTOUPDATE_INSTALLED') ? PLUGIN_DASHBOARD_UPDATE_NOTIFIER_AUTOADD : '');
                    $u_text = sprintf(PLUGIN_DASHBOARD_UPDATE_NOTIFIER, '<a class="link" href="' . $url . '">' . $update_to_version . '</a>' . $or_use);
                    $this->set_config('update_text', $u_text);
                }
            }
        }
    }

    /**
     * Create draft element
     * @param  int      index
     */
    function showElementDraft($sort_id) {
        global $serendipity;

        $lim = $this->get_config('limit_draft');
        if ($lim < 1) return;

        $serendipity['smarty']->assign('showElementDraft', true);
        $serendipity['smarty']->assign('draft_block_id', $sort_id);
        $serendipity['smarty']->assign('draft_Entrylist', $this->showElementEntrylist(array("e.isdraft = 'true'"), $lim));
    }

    /**
     * Create comapp element
     * @param  int      index
     */
    function showElementComments($sort_id) {
        global $serendipity;

        $lim = $this->get_config('limit_comments');
        if ($lim < 1) return;

        $serendipity['smarty']->assign('showElementComments', true);
        $serendipity['smarty']->assign('comments_block_id', $sort_id);
        $serendipity['smarty']->assign('entry_Commentlist', $this->showElementCommentlist("AND status = 'approved'", $lim));
    }

    /**
     * Create compen element
     * @param  int      index
     */
    function showElementCommentsPending($sort_id) {
        global $serendipity;

        static $hookin = null;

        $lim = $this->get_config('limit_comments_pending');
        if ($lim < 1) return;

        if (defined('BAYES_INSTALLED')) { $hookin = 'antispam'; }
        $serendipity['smarty']->assign('showElementComPend', true);
        $serendipity['smarty']->assign('commpen_block_id', $sort_id);
        $serendipity['smarty']->assign('entry_Compendlist', $this->showElementCommentlist("AND status IN ('pending','confirm')", $lim, $hookin));
    }

    /**
     * Create plugup element
     * @param  int      index
     */
    function showPluginNotifier($sort_id) {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers')) {
            return;
        }

        $serendipity['smarty']->assign('showElementPlugup', true);
        ob_start();
        serendipity_plugin_api::hook_event('backend_pluginlisting_header', $serendipity['eyecandy']);
        $candy = ob_get_contents();
        ob_end_clean();
        $plugupnote = str_replace('<br />', '', $candy);

        $serendipity['smarty']->assign('plugup_hook_note', (!empty($plugupnote) ? $plugupnote : ''));
        $serendipity['smarty']->assign('plugup_block_id', $sort_id);
        if (!isset($serendipity['eyecandy']) || serendipity_db_bool($serendipity['eyecandy'])) {
            // use_js_dragdrop ... no need actually
            $serendipity['smarty']->assign(array('use_js_dragdrop' => true, 'eyecandy' => $serendipity['eyecandy']));
        }
    }

    /**
     * Create update element
     * @param  int      index
     */
    function showUpdateNotifier($sort_id) {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers') || $this->get_config('update') == 'none') {
            return;
        }

        // If we didn't check today, do it now and remember, that we did.
        if (($this->get_config('last_update') != date('Ymd'))){
            $this->set_config('last_update', date('Ymd'));
            $this->CheckUpdate(); // this will fill all needed config values
        }

        // Check if the last found update version is newer and tell it, if this is the case
        $newVersion = $this->get_config('last_version');

        $serendipity['smarty']->assign(array('update_block_id' => $sort_id, 'showElementUpdate' => true, 'show_dependencynote' => $this->get_config('dependencynote')));

        if ( version_compare($newVersion, $serendipity['version']) >= 0 ) {
            $eventData = '';
            serendipity_plugin_api::hook_event('plugin_dashboard_updater', $eventData, $newVersion);
            $update_text = $this->get_config('update_text');
            $momabutton  = serendipity_db_bool($this->get_config('maintenance')) ? '<div id="cell_right"><button id="moma" class="button">set to Upgrade Maintenance Mode</button></div>' : '';
            $update_form = !empty($eventData) ? '<div id="cell_left">'.$eventData.'</div>' . $momabutton : 'You are running '.$serendipity['version'] . ' ['.$this->get_config('update').']';
            $serendipity['smarty']->assign(array('update_text' => $update_text, 'update_form' => $update_form));
        }
    }

    /**
     * Create future element
     * @param  int      index
     */
    function showElementFuture($sort_id) {
        global $serendipity;

        $lim = $this->get_config('limit_future');
        if ($lim < 1) return;

        $serendipity['smarty']->assign('showElementFuture', true);
        $serendipity['smarty']->assign('future_block_id', $sort_id);
        $serendipity['smarty']->assign('entry_future', $this->showElementEntrylist(array("e.isdraft != 'true' AND e.timestamp >= " . serendipity_serverOffsetHour()), $lim));
    }

    /**
     * Create clean element
     * @param  int      index
     */
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
                array( 'showCleanupSmarty' => true,
                       'cleanup_block_id'  => $sort_id,
                       'plugininstance'    => $this->instance
                     )
                );
        // cleanup post requests moved into dashboard_request_actions.inc.php
    }

    /**
     * Create info element
     * @param  int      index
     */
    function showElementInfo($sort_id) {
        global $serendipity;

        $serendipity['smarty']->assign('showElementInfo', true);
        $serendipity['smarty']->assign('info_block_id', $sort_id);
        $infolist = $this->showElementInfolist();
        $ilist = array();
        if (is_array($infolist)) {
            $ilist['total_entries'] = $infolist['total_count'][0];
            $ilist['draft_entries'] = $infolist['draft_count'][0];
            $ilist['pub_entries']   = $infolist['publish_count'][0];
            $ilist['total_cats']    = $infolist['category_count'][0];
            $ilist['total_imgs']    = $infolist['image_count'][0];
            $ilist['total_comts']   = $infolist['comment_ct_all'][0];
            $ilist['app_comts']     = $infolist['comment_ct_app'][0];
            $ilist['pen_comts']     = $infolist['comment_ct_pen'][0];
            $ilist['total_spam']    = $infolist['total_spam'][0];
            $ilist['total_tags']    = $infolist['total_tags'];
        }
        $serendipity['smarty']->assign('infolist', $ilist);

    }

    /**
     * Create feed element
     * @param  int      index
     */
    function showElementFeed($sort_id) {
        global $serendipity;

        $serendipity['smarty']->assign('showElementFeed', true);

        // gather the rss-data
        $s9yblog = $this->showElementInfoFeed();

        if ( is_array($s9yblog) && !empty($s9yblog) ) {
            $serendipity['smarty']->assign(
                    array(
                        'feed_block_id'     => $sort_id,
                        's9yblogfeed'       => $s9yblog,
                        'feed_header'       => $this->get_config('feed_title'),
                        'show_feedcontent'  => serendipity_db_bool($this->get_config('feed_content')),
                        'show_feedauthor'   => serendipity_db_bool($this->get_config('feed_author')),
                        'show_feedconum'    => serendipity_db_bool($this->get_config('feed_conum'))
                    )
            );
        }
    }

    /**
     * show elements sorted by default configuration 
     * @param  array    elements
     * @param  int      index
     * @return boolean  true
     */
     function showElement($element, $sortindex) {
        switch($element) {
            case 'info':
                $this->showElementInfo($sortindex);
                break;
            case 'compen':
                $this->showElementCommentsPending($sortindex);
                break;
            case 'future':
                $this->showElementFuture($sortindex);
                break;
            case 'draft':
                $this->showElementDraft($sortindex);
                break;
            case 'feed':
                $this->showElementFeed($sortindex);
                break;
            case 'comapp':
                $this->showElementComments($sortindex);
                break;
            case 'update':
                $this->ShowUpdateNotifier($sortindex);
                break;
            case 'plugup':
                $this->ShowPluginNotifier($sortindex);
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

        /* set global plugin path setting, to avoid different pluginpath '/plugins/', while some people use symlinked plugins dirs */
        if (!defined('DASHBOARD_PLUGINPATH')) {
            @define('DASHBOARD_PLUGINPATH',  $this->get_config('path'));
        }
        if (defined('BAYES_INSTALLED') && !defined('BAYES_PLUGINPATH')) {
            @define('BAYES_PLUGINPATH',  str_replace('/serendipity_event_dashboard', '/serendipity_event_spamblock_bayes', $this->get_config('path')));
        }
        // can we still keep this here or better move to backend_frontpage_display hook? (in some cases this place disrupted entry comments forms, why?)
        if (!is_object($serendipity['smarty'])) {
            serendipity_smarty_init(); // if not set start Smarty templating, to avoid member function assign() on a non-object error
        }

        if (isset($hooks[$event]) && serendipity_userLoggedIn()) {
            switch($event) {
                case 'backend_configure':
                    // here we go and overwrite the backend structure - maybe ;-)
                    // keep for future purposes
                    /*if( ( isset($serendipity['GET']['noSidebar']) || isset($serendipity['POST']['noSidebar']) ) 
                     ||  !isset($serendipity['GET']['adminAction']) 
                     || ( empty($serendipity['GET']['adminAction']) && !isset($serendipity['GET']['adminModule']) ) 
                     ) {
                        $serendipity['POST']['noSidebar']  = true;
                        $serendipity['POST']['noBanner']   = true;
                        $serendipity['POST']['noFooter']   = true;
                        $serendipity['POST']['h5bp-style'] = true;
                    }*/
                    // Disable the use of Serendipity JQuery in Backend - remember if having it disabled in template....
                    // also either make sure this dashboard is for 1.6 up only or construct a fallback to google 
                    $serendipity['capabilities']['jquery'] = false;

                    /* get the dashboard template file */
                    #echo $this->fetchTemplatePath('admin_index.tpl'); //old

                    break;

                 case 'backend_header':
                    // here we go and and add or restruct the backend header ;-)
                    echo "\n\n";
                    if($serendipity['POST']['h5bp-style']) {
                        echo '        <link rel="stylesheet" href="' . DASHBOARD_PLUGINPATH . '/css/style.css" />'."\n";
                    }
                    echo '        <link rel="stylesheet" type="text/css" href="' . DASHBOARD_PLUGINPATH . '/css/dashboard.css" title="dashboard" style"  media="screen"/>'."\n\n";

                    echo '        <script src="' . DASHBOARD_PLUGINPATH . '/inc/modernizr-2.6.1.min.js" defer></script>'."\n";
                    echo '        <script src="' . DASHBOARD_PLUGINPATH . '/inc/jquery-1.8.0.min.js" defer></script>'."\n";
                    echo '        <script src="' . DASHBOARD_PLUGINPATH . '/inc/jquery-ui-1.8.22.custom.min.js" defer></script>'."\n";
                    echo '        <script src="' . DASHBOARD_PLUGINPATH . '/inc/jquery.cookie.min.js" defer></script>'."\n";
                    echo '        <script src="' . DASHBOARD_PLUGINPATH . '/inc/jquery.mb.containerPlus.js" defer></script>'."\n\n";

                    #echo '<script type="text/javascript"> jQuery.noConflict(); </script>'."\n";

                    echo '        <script src="' . DASHBOARD_PLUGINPATH . '/inc/ajax-dashboard.js" defer></script>'."\n";
                    echo '        <script src="' . DASHBOARD_PLUGINPATH . '/inc/jquery-dashboard.js" defer></script>'."\n";
                    // include spamblock_bayes js file - see bayes constant on top
                    if (defined('BAYES_INSTALLED')) {
                        echo '        <script type="text/javascript" src="' . BAYES_PLUGINPATH . '/bayes_commentlist.js"></script>'."\n";
                    }
                    // set some JS vars
                    echo '        <script type="text/javascript">
            var const_view   = \'' . VIEW_FULL . '\';
            var const_hide   = \'' . HIDE . '\';
            var img_plus     = \'' . serendipity_getTemplateFile("img/plus.png") . '\';
            var img_minus    = \'' . serendipity_getTemplateFile("img/minus.png") . '\';
            var img_help2    = \'' . DASHBOARD_PLUGINPATH . '/img/help_oran.png\';
            var img_help1    = \'' . DASHBOARD_PLUGINPATH . '/img/help_blue.png\';
            var img_slidein  = \'' . DASHBOARD_PLUGINPATH . '/img/fade-in.png\';
            var img_slideout = \'' . DASHBOARD_PLUGINPATH . '/img/fade-out.png\';';
if (defined('BAYES_INSTALLED')) { echo '
            var learncommentPath = \'' . $serendipity['baseURL'] . 'index.php?/plugin/learncomment\';
            var ratingPath   = \'' . $serendipity['baseURL'] . 'index.php?/plugin/getRating\';
            var bayesCharset = \'' . LANG_CHARSET . '\';
            var bayesDone    = \'' . DONE . '\';
            var bayesHelpImage = \'' . serendipity_getTemplateFile ('admin/img/admin_msg_note.png') . '\';
            var bayesHelpTitle = \'' . PLUGIN_EVENT_SPAMBLOCK_BAYES_RATING_EXPLANATION . '\';
            var bayesLoadIndicator = \'' . BAYES_PLUGINPATH . '/img/spamblock_bayes.load.gif\';';
} 
echo "\n        </script>\n\n";

echo '        <!--[if gte IE 9]>
          <style type="text/css">
            .gradient {
               filter: none;
            }
          </style>
        <![endif]-->

';

                    break;

                case 'external_plugin':
                    $db['jspost'] = explode('/', $eventData);

                    // [0]=modemaintence; [1]=setmoma [boolean]
                    if($db['jspost'][0] == 'modemaintence') {
                        $setmoma = isset($_POST['setmoma']) ? serendipity_db_bool($_POST['setmoma']) : false;
                        $this->s9y_maintenance_mode($setmoma);
                    }

                    // [0]=dbjsonsort; [1]=json [array];
                    if($db['jspost'][0] == 'dbjsonsort') {
                        // data was send by JSON.stringify() - decode to array
                        $pix = json_decode($_POST['json'], true);
                        // convert the POST array to a readable $meta-selector array
                        $selector = $pix[0]['selector'];
                        if($selector == '#meta-box-right' || $selector == '#meta-box-left') {
                            $metase = array($selector);
                            foreach ($pix AS $key => $val) {
                                if($key > 0) {
                                    foreach ($val AS $k => $v) {
                                        $metase[$key][] = $v;
                                    }
                                }
                            }
                        }
                        $emt = '';
                        foreach ($metase AS $ke => $va) { if ($ke > 0) { $emt .= $va[0].';'.$va[1].', '; } }

                        $emt = str_replace('e;, ','', $emt); // removes 0 = 'e;, ' if any
                        $setConfStr = $metase[0] . '|' . substr($emt, 0, -2); // removes last ', ' if any
                        $setConfStr = str_replace('#', '', $setConfStr); // removes all '#'
                        // give back the answer string to json jQuery.post
                        $postAnswer = 'metaset, ' . $setConfStr; // eg. metaset, meta-box-right|elem_4, elem_5, elem_6, elem_7, elem_1, elem_3
                        // set to config
                        $this->set_config('metaset', $setConfStr);
                        // give json answer
                        echo $postAnswer;
                    }
                    // free all used arrays and vars
                    unset($db);
                    unset($pix);
                    unset($selector);
                    unset($metase);
                    unset($emt);
                    unset($setConfStr);

                    break;

                 case 'backend_frontpage_display':
                    $elements = array();
                    $elements = explode(',', $this->get_config('sequence'));
                    if(!empty($elements)) {
                        $countmainelements = count(array_values($elements));
                        if (in_array("clean", $elements)) { $countmainelements = ($countmainelements-1); }
                    }
                    $metaset = ($this->get_config('metaset') ? $this->get_config('metaset') : array());
                    if(!empty($metaset) && !empty($elements)) {
                        $metaset = explode('|', $metaset);
                        $metaset = array($metaset[0], $metaset[1]);
                        $mix[] = explode(',', $metaset[1]);
                        foreach ($mix[0] AS $v) { $newmix[] = explode(';', trim($v)); }
                        // keep the block name in an array to sort out in tpl
                        // the compare to array
                        foreach ($newmix as $k => $val) $mixarr[] = $val[1];
                        $block_elements = array_diff($elements, $mixarr);
                        $metaset = array($metaset[0], $newmix);
                        unset($mix);
                        unset($newmix);
                        unset($mixarr);
                    }
                    // check dependency plugin availability
                    $dpdc_plugin_av = (!defined('AUTOUPDATE_INSTALLED') ? true : false);

                    $sysinfo = array();
                    /* we already have these infos - but will keep them here for future purposes */
                    #$is_logged_in = serendipity_userLoggedIn();
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
                    $sysinfo['theme'] = $serendipity['template'];
                    $sysinfo['widgets'] = $this->count_plugins(explode('|','hide|event|eventh'), true);

                    ob_start();
                    // include the POST % GET action file
                    include dirname(__FILE__) . '/' . 'dashboard_request_actions.inc.php';
                    $serendipity['smarty']->assign(
                                                array(  'start'          => $serendipity['GET']['adminModule'] == 'start' ? true : false,
                                                        'errormsg'       => $errormsg,
                                                        'dpdc_plugin_av' => $dpdc_plugin_av,
                                                        'elements'       => $elements,
                                                        'countelements'  => ($countmainelements / 2),
                                                        'block_elements' => $block_elements,
                                                        'metaset'        => $metaset,
                                                        'secgroupempty'  => ($this->get_config('sequence') ? false : true),
                                                        'moma'           => serendipity_db_bool($this->get_config('maintenance')),
                                                        'plugininstance' => $this->instance,
                                                        'thispath'       => DASHBOARD_PLUGINPATH,
                                                        'fullpath'       => dirname(__FILE__),
                                                        'antispam_hook'  => '',
                                                        'sysinfo'        => $sysinfo,
                                                        's9yheader'      => array($eventData),
                                                        'version'        => 'Serendipity ' . $serendipity['version'] . ' ['.$this->get_config('update').']'
                                                    )
                                                );

                    $eventData = null; // eventData holds the welcome User message and the link and bookmark box

                    #serendipity_plugin_api::hook_event('backend_comments_top', $comments);

                    // gather the data
                    if (is_array($elements) && !empty($elements) ) {
                        // include header 'clean'element, if
                        if(serendipity_db_bool($this->get_config('clean'))) $elements[] = 'clean';
                        foreach($elements AS $key => $e) {
                            //echo "$this->showElement($e, $key);";
                            $this->showElement($e, $key);
                        }
                    }

                    /* get the dashboard template file */
                    echo $this->parseTemplate('plugin_dashboard.tpl');

                    $dashboard = ob_get_contents();

                    ob_end_clean();

                    // this actually shows the dashboard
                    $eventData['more'] = $dashboard;
                    break;

            }
        }

        return true;
    }
}

/* vim: set sts=4 ts=4 expandtab : */
