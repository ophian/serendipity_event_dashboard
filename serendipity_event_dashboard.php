<?php # $Id$

// - last modified 2012-12-12

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
 /**
  * Class member instance attribute values
  * Members must be initialized with a constant expression (like a string constant, numeric literal, etc), not a dynamic expression!
  **/
define(DASHBOARD_PRESET_REMOTE_ADDR, $_SERVER['PHP_SELF']);
define(DASHBOARD_PRESET_MOMATXT, sprintf(PLUGIN_DASHBOARD_MAINTENANCE_TEXT, $serendipity['blogTitle']));


/**
 * Serendipity Backend Dashboard plug-in
 * 
 * @author Garvin Hicking
 * @author Ian
 */
 class serendipity_event_dashboard extends serendipity_event {

    /**
     * Declaration of the propery debug
     * @var boolean
     */
    protected $debug;

    /**
     * Declaration of the propery bayes_plugin to find Spamblock-bayes plugin
     * @var boolean
     */
    protected $bayes_plugin;

    /**
     * Access property title
     * As already used in class serendipity_event extends serendipity_plugin this needs to be public
     * @access public
     * @var string
     */
    public $title = PLUGIN_DASHBOARD_TITLE;

    /**
     * Access property autoupdateExistNote
     * Enable navigation button to show plugin dependency note
     * @var boolean
     */
    protected $autoupdateExistNote = true;

     /**
     * Access property autoupdateText
     * Set dependency autoupdate update element text
     * @var string (not in this plugins introspect_config_item!) - needs to be empty string, not null
     */
    protected $autoupdateText = '';

    /**
     * Access property blockFeedAuthor
     * Enable feed to show entry author
     * @var boolean
     */
    protected $blockFeedAuthor = true;

    /**
     * Access property blockFeedComments
     * Enable feed to show entry comments
     * @var boolean
     */
    protected $blockFeedComments = true;

    /**
     * Access property blockFeedContent
     * Enable feed to show entry content
     * @var boolean
     */
    protected $blockFeedContent = true;

    /**
     * Access property blockFeedTitle
     * Set S9y Blog Feed title
     * @var string
     */
    protected $blockFeedTitle = PLUGIN_DASHBOARD_FEED;

    /**
     * Access property blockFeedUrl
     * Set S9y Blog Feed RSS url
     * @var string
     */
    protected $blockFeedUrl = 'http://blog.s9y.org/feeds/index.rss2';

    /**
     * Access property blockLimitComments
     * Set show limit of approved comment entries
     * @var int
     */
    protected $blockLimitComments = 5;

    /**
     * Access property blockLimitCompen
     * Set show limit of pending comment entries
     * @var int
     */
    protected $blockLimitCompen = 5;

    /**
     * Access property blockLimitDraft
     * Set show limit of draft entries
     * @var int
     */
    protected $blockLimitDraft = 5;

    /**
     * Access property blockLimitFeed
     * Set show limit of S9y-Blog feed entries
     * @var int
     */
    protected $blockLimitFeed = 3;

    /**
     * Access property blockLimitFuture
     * Set show limit of future entries
     * @var int
     */
    protected $blockLimitFuture = 5;

    /**
     * Access property blockMaintenance
     * Enable Dashboard-UI maintenance mode button in update element
     * @var boolean
     */
    protected $blockMaintenance = false;

    /**
     * Access property cookieMetaset
     * Cookie element order string via Dashboard-UI
     * @var string (not in this plugins introspect_config_item!)
     */
    protected $cookieMetaset = null;

    /**
     * Access property defaultOrderString
     * Set sequence element order string via Dashboard config
     * @var string
     */
    protected $defaultOrderString = 'info,compen,future,draft,feed,comapp,update,plugup';

   /**
     * Access property extendToContainer
     * Enable containerized backend views
     * @var boolean (true = always, false = initial-tier, null = never)
     */
    protected $extendToContainer = false;

    /**
     * Access property lastUpdateDate
     * Set dependency autoupdate version date
     * @var string (not in this plugins introspect_config_item!)
     */
    protected $lastUpdateDate = null;

    /**
     * Access property lastVersionNumber
     * Set dependency autoupdate last version number
     * @var string (not in this plugins introspect_config_item!)
     */
    protected $lastVersionNumber = null;

    /**
     * Access property maintenanceText
     * Set Frontend maintenance mode text (set to pre-defined constant, as not allowed to use dynamic Serendipity array var)
     * @var string
     */
    protected $maintenanceText = DASHBOARD_PRESET_MOMATXT;

    /**
     * Access property pluginDashboardPath
     * Set this plugins plugin path (set to pre-defined constant, as not allowed to use dynamic Serendipity array var)
     * @var string
     */
    protected $pluginDashboardPath = DASHBOARD_PRESET_REMOTE_ADDR;

    /**
     * Access property readOnlyDashboard
     * Enable a read only Dashboard
     * @var boolean
     */
    protected $readOnlyDashboard = false;

    /**
     * Access property searchUpdateTree
     * Set dependency autoupdate update get github string
     * @var string
     */
    protected $searchUpdateTree = 'stable';

     /**
     * Access property smartyCleanCompDir
     * Enable navigation button to clean smarty template_c
     * @var boolean
     */
    protected $smartyCleanCompDir = true;

   /**
     * PHP5 Constructor. Initialize class variables from configuration
     * Set class members instance variables memory slots
     * @return void
     */
    public function __construct($instance) {
        global $serendipity;

        $this->instance             = $instance; // public var in class serendipity_event

        // initilize with this plugins db config settings, lastely stored in $serendipity[$name]
        $this->autoupdateExistNote  = serendipity_db_bool($this->get_config('dependencynote', 'true'));
        $this->autoupdateText       = (string) $this->get_config('update_text', '');  // AUTOUPDATE PLUGIN str (not in this plugins introspect_config_item!)
        $this->blockFeedAuthor      = serendipity_db_bool($this->get_config('feed_author', 'true'));
        $this->blockFeedComments    = serendipity_db_bool($this->get_config('feed_conum', 'true'));
        $this->blockFeedContent     = serendipity_db_bool($this->get_config('feed_content', 'true'));
        $this->blockFeedTitle       = (string) $this->get_config('feed_title', PLUGIN_DASHBOARD_FEED);
        $this->blockFeedUrl         = (string) $this->get_config('feed_url', 'http://blog.s9y.org/feeds/index.rss2');
        $this->blockLimitComments   = (int) $this->get_config('limit_comments', 5);
        $this->blockLimitCompen     = (int) $this->get_config('limit_compen', 5);
        $this->blockLimitDraft      = (int) $this->get_config('limit_draft', 5);
        $this->blockLimitFeed       = (int) $this->get_config('limit_feed', 3);
        $this->blockLimitFuture     = (int) $this->get_config('limit_future', 5);
        $this->blockMaintenance     = serendipity_db_bool($this->get_config('maintenance', 'false'));
        $this->cookieMetaset        = (string) $this->get_config('metaset', null); // (not in this plugins introspect_config_item!)
        $this->defaultOrderString   = (string) $this->get_config('sequence', 'info,compen,future,draft,feed,comapp,update,plugup');
        // do not type-cast extendToContainer since using 'boolean like' string values null false true
        $this->extendToContainer    = (string) $this->get_config('extend', 'false');
        $this->lastUpdateDate       = (string) $this->get_config('last_update', null);  // AUTOUPDATE PLUGIN str date (not in this plugins introspect_config_item!)
        $this->lastVersionNumber    = (string) $this->get_config('last_version', null); // AUTOUPDATE PLUGIN str (not in this plugins introspect_config_item!)
        $this->maintenanceText      = (string) $this->get_config('maintenancenote', sprintf(PLUGIN_DASHBOARD_MAINTENANCE_TEXT, $serendipity['blogTitle']));
        // do not name to 'pluginPath', since this is already used in class serendipity_event extends serendipity_plugin, which would override a set here
        $this->pluginDashboardPath  = (string) $this->get_config('path', $serendipity['serendipityHTTPPath'] . 'plugins/serendipity_event_dashboard');
        $this->readOnlyDashboard    = serendipity_db_bool($this->get_config('read_only', 'false'));
        $this->searchUpdateTree     = (string) $this->get_config('update', 'stable');
        $this->smartyCleanCompDir   = serendipity_db_bool($this->get_config('clean', 'true'));

    }

    /**
     * The introspection function to setup properties
     *
     * Called by serendipity when it wants to display information
     * about your plugin.
     *
     * @access    public
     * @param     object    A property bag object you can manipulate
     * @return    true
     */
    public function introspect(&$propbag) {
        global $serendipity;

        $propbag->add('name',          PLUGIN_DASHBOARD_TITLE);
        $propbag->add('description',   PLUGIN_DASHBOARD_DESC);
        $propbag->add('requirements',  array(
            'serendipity' => '1.9',
            'smarty'      => '3.1.0',
            'php'         => '5.2.6'
        ));

        $propbag->add('version',       '2.0.2');
        $propbag->add('author',        'Garvin Hicking, Ian');
        $propbag->add('stackable',     false);
        $propbag->add('configuration', array('read_only', 'path', 'limit_compen', 'limit_comments', 'limit_draft', 'limit_future', 'limit_feed', 'sequence', 'feed_url', 'feed_title', 'feed_content', 'feed_author', 'feed_conum', 'extend', 'dependencynote', 'maintenance', 'maintenancenote', 'update', 'clean'));
        $propbag->add('event_hooks',   array(
                                            'frontend_configure'            => true,
                                            'backend_configure'             => true,
                                            'backend_header'                => true,
                                            'external_plugin'               => true,
                                            'backend_frontpage_display'     => true
                                        )
        );
        $propbag->add('groups', array('BACKEND_FEATURES'));
        $propbag->add('config_groups', array(
            DASHBOARD_MAIN    => array('read_only', 'path', 'extend', 'dependencynote', 'clean'),
            DASHBOARD_LAYOUT  => array('sequence'),
            DASHBOARD_LIMITS  => array('limit_compen', 'limit_comments', 'limit_draft', 'limit_future', 'limit_feed'),
            DASHBOARD_FEED    => array('feed_url', 'feed_title', 'feed_content', 'feed_author', 'feed_conum'),
            DASHBOARD_UPDATE  => array('maintenance', 'maintenancenote', 'update')
        ));
    }

    /**
     * Introspection of this plugins configuration items
     *
     * Called by serendipity when it wants to display the configuration
     * editor for your plugin.
     *
     * @access    public
     * @param     string    Name of the config item
     * @param     object    A property bag object you can store the configuration in
     * @return
     */
    public function introspect_config_item($name, &$propbag) {
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

            case 'limit_compen':
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

            case 'extend':
                $propbag->add('type',        'radio');
                $propbag->add('name',        PLUGIN_DASHBOARD_EXTEND_NOTE);
                $propbag->add('description', PLUGIN_DASHBOARD_EXTEND_NOTE_DESC);
                $propbag->add('default',     'true');
                $propbag->add('radio', array(
                    'value' => array('true', 'false', 'null'),
                    'desc'  => array(YES, NO, PLUGIN_DASHBOARD_EXTEND_NEVER)
                ));
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
                    'plugup'     => array('display' => PLUGIN_DASHBOARD_PLUGUP)
                );
                $propbag->add('values',      $values);
                $propbag->add('default',     'info,compen,future,draft,feed,comapp,update,plugup');
                break;

            default:
                    return false;
        }
        return true;
    }

    /**
     * Set the plug-in title.
     *
     * @access    public
     * @param     string    $title
     */
    public function generate_content(&$title) {
        $title = PLUGIN_DASHBOARD_TITLE;
    }

    /**
     * Check if dependency plugin is available for install
     * 
     * @access    public
     * @param     string     pluginname
     * @return    boolean    true/false
     */
    public static function check_plugin_status($name='') {
        $plugins = serendipity_plugin_api::enum_plugins('*', false, $name);
        if(is_array($plugins) && !empty($plugins[0]['name'])) {
            return true;
        }
        return false;
    }

    /**
     * Load Bayes-Plug-in configured instance once, 
     * if the bayes plugin is onBoard and installed
     * 
     * @access    private
     * @return    string     instance
     */
    private function findBayes() {
        if (!isset($this->bayes_plugin)) {
            // find installed plugin 
            $plugins = serendipity_plugin_api::enum_plugins('*', false, 'serendipity_event_spamblock_bayes');

            $plugin_found = null;

            if (is_array($plugins) && !empty($plugins)) { 
                foreach($plugins as $plugin) {
                    // load instance
                    $plugin_found = serendipity_plugin_api::load_plugin($plugin['name']);
                    break;
                }
            }

            $this->bayes_plugin = $plugin_found;
        }
        return $this->bayes_plugin;
    }

    /**
     * return classify bayes rating by configured instance of bayes plugin, else return false
     * 
     * @access    private
     * @param     string     commentBody
     * @return    mixed      int classified / boolean false
     */
    private function classifyBayes($coBody) {
        $theBayesInstance = $this->findBayes();
        if (isset($theBayesInstance)) {
            return $theBayesInstance->classify($coBody, 'body');
        }
        return false;
    }

    /**
     * Clean up a multidimensional array which has empty values
     *
     * @access    private
     * @param     array    $metaset-array
     * @return    array    reset keys
     */
    private function array_cleanup($array) {
        foreach ($array as $key => $value) {
            if (is_array($value)) {
                if (empty($value[1])) {
                    unset($array[$key]);
                } else {
                    $array[$key] = $this->array_cleanup($array[$key]);
                }
            }
        }
        return $array_new_keys = array_values($array); // sorted by original key order
    }

    /**
     * Set None-IE9 'Dashboard Unavailable' Mode and provide some browsers upgrades and a dashboard uninstall link
     *
     * @access    private
     * @return
     */
    private static function checkBrowser() {
        global $serendipity;
        if(preg_match('/(?i)msie [1-8]/',$_SERVER['HTTP_USER_AGENT'])) {
            serendipity_die('
                <div style=" clear: both; text-align:center; position: relative;">
                    <h2>Sorry, no Dashboard support for your Browser!</h2>
                    <a href="http://windows.microsoft.com/en-US/internet-explorer/downloads/ie-9/worldwide-languages">
                        <img alt="Windows" width="120" height="26" src="' . DASHBOARD_PLUGINPATH . '/img/windows.png" style="border:0 none" border="0" />
                    </a>
                    <p>Please return to the: <a href="' . $serendipity['serendipityHTTPPath'] . 'serendipity_admin.php?serendipity[adminModule]=plugins">plugin installation dir</a>!</p>
                    <h3>Your browser is <em>ancient!</em></h3>
                    <p class="chromeframe"><a href="http://browsehappy.com/">Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p>
                </div>
            ');
        }
        return;
    }

    /**
     * Set Maintenance Mode header 505 Temporarily Unavailable
     *
     * @access    private
     * @return
     */
    private function service_mode() {
        $retry = 300; // seconds
        $protocol = $_SERVER["SERVER_PROTOCOL"];
        if ( 'HTTP/1.1' != $protocol && 'HTTP/1.0' != $protocol )
            $protocol = 'HTTP/1.0';
        serendipity_header( "$protocol 503 Service Temporarily Unavailable", true, 503 );
        serendipity_header( 'Status: 503 Service Temporarily Unavailable', true, 503 );
        serendipity_header( 'X-S9y-Maintenance: true' ); // Used for debugging detection
        serendipity_header( 'Content-Type: text/html; charset=utf-8' );
        serendipity_header( "Retry-After: $retry" );
        serendipity_die(nl2br("<h2>503 - SERENDIPITY SERVICE MODE</h2>\n".$this->maintenanceText));
        exit; // actually no need, but for secure reasons left alive
    }

    /**
     * Count the number of plugins to which the filter criteria matches
     *
     * @access    private
     * @param     array      The filter for plugins (left|right|hide|event|eventh) and even more
     * @param     boolean    If true, the filtering logic will be reversed and all plugins that are NOT part of the filter will be evaluated
     * @return    int        Number of plugins that were found.
     */
    private static function count_plugins($filter = array(), $negate = false) {
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
     * Select the RSS feed content
     * 
     * thanks to Stuart Herbert http://blog.stuartherbert.com/php/2007/01/07/using-simplexml-to-parse-rss-feeds/
     *
     * @access    private
     * @param     string     feedContent
     * @param     int        Limit entries
     * @return    array      articles
     **/
    private static function select_simple_xml($content, $num) {
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
            global $serendipity;
            //error handling in here 
            $articles[0]['content'] = 'There was an error fetching the Serendipity Blog RSS Feed. Try again later.';
            $serendipity['smarty']->assign('errormsg', $articles[0]['content']);
            return;
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
     * Read the RSS feed Content
     *
     * @access    private
     * @param     string     url
     * @return    array      get_url_contents
     */
    private static function get_url_contents($url) {
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
     * Set automatic strong cookie autologin if in maintenance mode
     *
     * @access    private
     * @param     boolean    set/unset
     */
    private static function service_autologin($set=null) {
        global $serendipity;

        if($set && !isset($serendipity['COOKIE']['author_information'])) {
            // set a global var to remember automatic autologin
            $serendipity['dashboard']['autologin'] = true;
            serendipity_setCookie('dashboard_autologin', 'true');
            // Set super-remember-me cookie while in maintenance mode.
            if( serendipity_authenticate_author($_SESSION['serendipityUser'], $_SESSION['serendipityPassword'], false, true) ) {
                if($_SESSION['serendipityAuthedUser'] == true) {
                    serendipity_issueAutologin(
                        array('username' => $_SESSION['serendipityUser'],
                              'password' => $_SESSION['serendipityPassword']
                        )
                    );
                    echo 'true'; // console or ajax post answer 
                }
            }
        }
        if (!$set && ($serendipity['dashboard']['autologin'] || isset($serendipity['COOKIE']['dashboard_autologin'])) ) {
            // automatic autologin logout
            $serendipity['dashboard']['autologin'] = false;
            serendipity_deleteCookie('dashboard_autologin');
            serendipity_deleteCookie('author_information');
            serendipity_deleteCookie('author_information_iv');
            echo 'false'; // console or ajax post answer 
        }
    }

    /**
     * Set upgraders maintenance mode
     *
     * @access    private
     * @param     boolean    set/unset
     */
    private function s9y_maintenance_mode($mode=false) {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers')) {
            return;
        }
        // return user to use the autologin cookie to stay logged-in while in service maintenance mode
        if ($mode) { $this->service_autologin(true); } else { $this->service_autologin(false); }

        $privateVariables = array();
        $privateVariables['maintenance'] = serendipity_db_bool($mode) ? 'true' : 'false'; // we cant write real booleans here, as the function does not provide it

        $r = serendipity_updateLocalConfig(
                $serendipity['dbName'],
                $serendipity['dbPrefix'],
                $serendipity['dbHost'],
                $serendipity['dbUser'],
                $serendipity['dbPass'],
                $serendipity['dbType'],
                $serendipity['dbPersistent'],
                $privateVariables
            );
        #echo serendipity_db_bool($mode) ? 'true' : 'false'; // ajax post answer to validate as string - see service_autologin echos
        return $r;
    }

    /**
     * Get the Element comments List (pending and approved)
     * 
     * @access    private
     * @param     string     SQL-where
     * @param     int        SQL-limit
     * @param     string     use_hook
     * @return    array      comments[comment]
     */
    private function showElementCommentlist($where, $limit, $use_hook = null) {
        global $serendipity;

        if (!serendipity_checkPermission('adminComments')) {
            return;
        }

        $summaryLength = 120;
        $i = 0;

        // we already use 1.6 and up with this dashboard
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
                        array(  'read_only' => $this->readOnlyDashboard,
                                'urltoken'  => serendipity_setFormToken('url'),
                                'formtoken' => serendipity_setFormToken()
                            ));
        return $comment;
    }

    /**
     * Get element Info Counter List
     * 
     * @access    private
     * @return    array      infoList
     */
    private static function showElementInfolist() {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers')) {
            $thisauthorid   = (int)$serendipity['authorid'];
            $entryauthors   = "FROM {$serendipity['dbPrefix']}entries e 
                               LEFT JOIN {$serendipity['dbPrefix']}authors a ON (e.authorid = a.authorid)";
            $commentauthors = "FROM {$serendipity['dbPrefix']}comments c 
                               LEFT JOIN {$serendipity['dbPrefix']}entries e ON (e.id = c.entry_id) 
                               LEFT JOIN {$serendipity['dbPrefix']}authors a ON (e.authorid = a.authorid)";
            $currentauthor  = "AND e.authorid = " . $thisauthorid;

            $infolist['total_count']      = serendipity_db_query("SELECT count(e.id) $entryauthors WHERE e.authorid = $thisauthorid", true);
            $infolist['draft_count']      = serendipity_db_query("SELECT count(e.id) {$entryauthors} WHERE e.isdraft = 'true' $currentauthor", true);
            $infolist['publish_count']    = serendipity_db_query("SELECT count(e.id) {$entryauthors} WHERE e.isdraft = 'false' $currentauthor", true);
            $infolist['category_count']   = serendipity_db_query("SELECT count(categoryid) FROM {$serendipity['dbPrefix']}category WHERE authorid = $thisauthorid OR authorid = 0", true);
            // being strict to user and do not check for 'ALL' permissions, is easier here.
            $infolist['image_count']      = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}images WHERE authorid = $thisauthorid OR authorid = 0", true);
            $infolist['comment_ct_all']   = serendipity_db_query("SELECT count(c.id) {$commentauthors} WHERE type = 'NORMAL' $currentauthor", true);
            $infolist['comment_ct_app']   = serendipity_db_query("SELECT count(c.id) {$commentauthors} WHERE type = 'NORMAL' $currentauthor AND c.status = 'approved'", true);
            $infolist['comment_ct_pen']   = serendipity_db_query("SELECT count(c.id) {$commentauthors} WHERE type = 'NORMAL' $currentauthor AND c.status = 'pending'", true);
        } else {
            // restrict count(all) informations to adminUsers only
            $infolist['total_count']      = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}entries", true);
            $infolist['draft_count']      = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}entries WHERE isdraft = 'true'", true);
            $infolist['publish_count']    = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}entries WHERE isdraft = 'false'", true);
            $infolist['category_count']   = serendipity_db_query("SELECT count(categoryid) FROM {$serendipity['dbPrefix']}category", true);
            $infolist['image_count']      = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}images", true);
            $infolist['comment_ct_all']   = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}comments WHERE type = 'NORMAL'", true);
            $infolist['comment_ct_app']   = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}comments WHERE type = 'NORMAL' AND status = 'approved'", true);
            $infolist['comment_ct_pen']   = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}comments WHERE type = 'NORMAL' AND status = 'pending'", true);
            if (defined('BAYES_INSTALLED')) {
                $infolist['total_spam']   = serendipity_db_query("SELECT count(id) FROM {$serendipity['dbPrefix']}spamblock_bayes_recycler", true, 'num');
            }
            if (defined('FREETAG_INSTALLED')) {
                $infolist['total_tags']   = count(serendipity_db_query("SELECT DISTINCT tag FROM {$serendipity['dbPrefix']}entrytags", false, 'num'));
                $serendipity['smarty']->assign('is_freetag_installed', true);
            }
        }
        return $infolist;
    }


    /**
     * Get Element Info Feed
     * 
     * @access    private
     * @return    string     XML-feed
     */
    private function showElementInfoFeed() {
        // read blog rss
        $s9yfeed = $this->get_url_contents($this->blockFeedUrl); // ToDo: cache this for a day.., see updater
        // select elements as array by limit
        $s9yblog = $this->select_simple_xml($s9yfeed, $this->blockLimitFeed);

        return $s9yblog;
    }


    /**
     * Get Element Entries List (draft and futures)
     * 
     * @access    private
     * @param     array      filter
     * @param     int        limit
     * @return    array      entries[entry]
     */
    private static function showElementEntrylist($filter = array(), $limit = 0) {
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
                $lm = LAST_UPDATED . ': ' . serendipity_formatTime(DATE_FORMAT_SHORT, $ey['last_modified']);
            } else {
                $lm = '';
            }

            if (!$serendipity['showFutureEntries'] && $ey['timestamp'] >= serendipity_serverOffsetHour()) {
                $entry_pre = ENTRY_PUBLISHED_FUTURE;
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
     * Check update, create config values and assign to Smarty
     * 
     * @access    private
     */
    private function CheckUpdate() {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers') || $this->searchUpdateTree == 'none') {
            return;
        }

        $updateURL = 'https://raw.github.com/s9y/Serendipity/master/docs/RELEASE';

        $file = fopen($updateURL, 'r');
        if (!$file) {
            echo "PLUGIN_DASHBOARD_ERROR_URL";
            return;
        }

        $version = $this->searchUpdateTree;

        while(!feof($file)){
            $line = fgets($file);

            if(preg_match('/^' . $version . ':(.+$)/', $line, $match)){
                $update_to_version = $match[1];
                $this->set_config('last_version', $update_to_version);

                $serendipity['smarty']->assign('showUpdateNotifier', true);

                if ($version == "stable"){
                    $url="http://prdownloads.sourceforge.net/php-blog/serendipity-" . $update_to_version . ".zip";
                }
                if ( version_compare($update_to_version, $serendipity['version'], '>') ) {
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
     * 
     * @access    private
     * @param     int        sortIndex
     */
    private function showElementDraft($sort_id) {
        global $serendipity;

        if ($this->blockLimitDraft < 1) return;

        $serendipity['smarty']->assign('showElementDraft', true);
        $serendipity['smarty']->assign('draft_block_id', $sort_id);
        $serendipity['smarty']->assign('draft_Entrylist', $this->showElementEntrylist(array("e.isdraft = 'true'"), $this->blockLimitDraft));
    }

    /**
     * Create comapp element
     * 
     * @access    private
     * @param     int        sortIndex
     */
    private function showElementComments($sort_id) {
        global $serendipity;

        if ($this->blockLimitComments < 1) return;

        $serendipity['smarty']->assign('showElementComments', true);
        $serendipity['smarty']->assign('comments_block_id', $sort_id);
        $serendipity['smarty']->assign('entry_Commentlist', $this->showElementCommentlist("AND status = 'approved'", $this->blockLimitComments));
    }

    /**
     * Create compen element
     * 
     * @access    private
     * @param     int        sortIndex
     */
    private function showElementCommentsPending($sort_id) {
        global $serendipity;

        static $hookin = null;

        if ($this->blockLimitCompen < 1) return;

        if (defined('BAYES_INSTALLED')) { $hookin = 'antispam'; }
        $serendipity['smarty']->assign('showElementComPend', true);
        $serendipity['smarty']->assign('compen_block_id', $sort_id);
        $serendipity['smarty']->assign('entry_Compendlist', $this->showElementCommentlist("AND status IN ('pending','confirm')", $this->blockLimitCompen, $hookin));
    }

    /**
     * Create plugup element
     * 
     * @access    private
     * @param     int        sortIndex
     */
    private static function showPluginNotifier($sort_id) {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers')) {
            return;
        }

        $serendipity['smarty']->assign('showElementPlugup', true);
        ob_start();
        // ToDo: ask /serendipity_admin.php?serendipity[adminModule]=plugins&serendipity[adminAction]=addnew&serendipity[only_group]=UPGRADE&serendipity[type]=event
        //       if there is a upgrade plugin array available and not empty...
        serendipity_plugin_api::hook_event('backend_pluginlisting_header', $serendipity['eyecandy']);
        $candy = ob_get_contents();
        ob_end_clean();
        $plugupnote = str_replace('<br />', '', $candy); // prior 1.7

        $serendipity['smarty']->assign('plugup_hook_note', (!empty($plugupnote) ? $plugupnote : ''));
        $serendipity['smarty']->assign('plugup_block_id', $sort_id);
        if (!isset($serendipity['eyecandy']) || serendipity_db_bool($serendipity['eyecandy'])) {
            // use_js_dragdrop ... no need actually
            $serendipity['smarty']->assign(array('use_js_dragdrop' => true, 'eyecandy' => $serendipity['eyecandy']));
        }
    }

    /**
     * Create update element, check update, assign to Smarty and set eventData
     * 
     * @access    private
     * @param     int        sortIndex
     * @return    mixed      eventData
     */
    private function showUpdateNotifier($sort_id) {
        global $serendipity;

        if (!serendipity_checkPermission('adminUsers') || $this->searchUpdateTree == 'none') {
            return;
        }

        // If we didn't check today, do it now and remember, that we did.
        if (($this->lastUpdateDate != date('Ymd'))){
            $this->set_config('last_update', date('Ymd'));
            $this->CheckUpdate(); // this will fill all needed config values
        }

        $update_form = '';
        $newVersion  = $this->lastVersionNumber;
        $momabutton  = $this->blockMaintenance ? '<button id="moma" class="button">' . PLUGIN_DASHBOARD_MAINTENANCE_MODE . '</button>' : '';

        // Compare last found update version to current Serendipity version
        if ( version_compare($newVersion, $serendipity['version'], '>') ) {
            $eventData = '';
            serendipity_plugin_api::hook_event('plugin_dashboard_updater', $eventData, $newVersion);
            $eventData   = str_replace('Update now automatically', PLUGIN_DASHBOARD_UPDATE_BUTTON_TEXT, $eventData);
            $update_form = $eventData;
        }
        $serendipity['smarty']->assign(
                        array( 'update_block_id'   => $sort_id,
                               'showElementUpdate' => true,
                               'update_text'       => $this->autoupdateText,
                               'update_form'       => $update_form,
                               'service_mode'      => $momabutton )
                        );
    }

    /**
     * Create future element
     * 
     * @access    private
     * @param     int        sortIndex
     */
    private function showElementFuture($sort_id) {
        global $serendipity;

        if ($this->blockLimitFuture < 1) return;

        $serendipity['smarty']->assign('showElementFuture', true);
        $serendipity['smarty']->assign('future_block_id', $sort_id);
        $serendipity['smarty']->assign('entry_future', $this->showElementEntrylist(array("e.isdraft != 'true' AND e.timestamp >= " . serendipity_serverOffsetHour()), $this->blockLimitFuture));
    }

    /**
     * Create clean element
     * 
     * @access    private
     * @param     int        sortIndex
     */
    private function showElementClean($sort_id) {
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
                       'urltoken'          => serendipity_setFormToken('url'),
                       'plugininstance'    => $this->instance
                     )
                );
        // cleanup post requests moved into dashboard_request_actions.inc.php
    }

    /**
     * Create info element
     * 
     * @access    private
     * @param     int        sortIndex
     */
    private function showElementInfo($sort_id) {
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
     * 
     * @access    private
     * @param     int        sortIndex
     */
    private function showElementFeed($sort_id) {
        global $serendipity;

        $serendipity['smarty']->assign('showElementFeed', true);

        // gather the rss-data
        $s9yblog = $this->showElementInfoFeed();

        if ( is_array($s9yblog) && !empty($s9yblog) ) {
            $serendipity['smarty']->assign(
                    array(
                        'feed_block_id'     => $sort_id,
                        's9yblogfeed'       => $s9yblog,
                        'feed_header'       => $this->blockFeedTitle,
                        'show_feedcontent'  => $this->blockFeedContent,
                        'show_feedauthor'   => $this->blockFeedAuthor,
                        'show_feedconum'    => $this->blockFeedComments
                    )
            );
        }
    }

    /**
     * Switch show element sorted by default configuration 
     * 
     * @access    private
     * @param     array      elements
     * @param     int        sortIndex
     * @return    boolean    true
     */
     private function showElement($element, $sortindex) {
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

    /**
     * Hook for Serendipity events, initialize plug-in "listen" to an event
     *
     * This method is called by the main plugin API for every event, that is executed.
     * You need to implement each actions that shall be performed by your plugin here.
     *
     * @access    public
     * @param     string    The name of the executed event
     * @param     object    A property bag for the current plugin
     * @param     mixed     Any referenced event data from the serendipity_plugin_api::hook_event() function
     * @param     mixed     Any additional data from the hook_event call
     * @return    true
     */
    public function event_hook($event, &$bag, &$eventData, $addData = null) {
        global $serendipity;

        $hooks = &$bag->get('event_hooks');

        $serendipity['plugin_dashboard_version'] = &$bag->get('version');
        // deny automatic autologin by default
        $serendipity['dashboard']['autologin'] = false;

        /* set global plugin path setting, to avoid different pluginpath '/plugins/', while some people use symlinked plugins dirs */
        if (!defined('DASHBOARD_PLUGINPATH')) {
            @define('DASHBOARD_PLUGINPATH',  $this->pluginDashboardPath);
        }
        if (defined('BAYES_INSTALLED') && !defined('BAYES_PLUGINPATH')) {
            @define('BAYES_PLUGINPATH',  str_replace('/serendipity_event_dashboard', '/serendipity_event_spamblock_bayes', $this->pluginDashboardPath));
        }

        if (isset($hooks[$event])) {
            switch($event) {
                case 'frontend_configure':
                    // If the Browser was closed without unset maintenance mode,
                    // check dashboards autologin cookie to be able to return to login page at least w/o the 503 unavailable mode page
                    if (isset($serendipity['COOKIE']['dashboard_autologin'])) {
                        $superuser = true;
                    } else {
                        $superuser = false;
                    }

                    // This will stop serendipity immediately throwing a '503 Service Temporarily Unavailable' maintenance message,
                    // if var is set to true and user is not authenticated and logged into admin users.
                    // This $serendipity['maintenance'] var is stored in serendipity_config_local.inc file!
                    if (!$superuser && !serendipity_checkPermission('adminUsers') && serendipity_db_bool($serendipity['maintenance']) ) {
                        $this->service_mode();
                    }

                    break;

                case 'backend_configure':
                    // here we go and overwrite the fetch backend structure on demand
                    if( $serendipity['GET']['noHeading'] ) {
                        $serendipity['POST']['noSidebar']  = true;
                        $serendipity['POST']['noBanner']   = true;
                        $serendipity['POST']['noFooter']   = true;
                    }
                    if (!is_object($serendipity['smarty'])) {
                        serendipity_smarty_init(); // if not set, start Smarty templating to avoid member function assign() on a non-object error
                    }

                    /* get the dashboard default admin index template file */
                    $servicehook = NULL;

                    // read already set $serendipity['maintenance'], stored in serendipity_config_local.inc file
                    if (isset($serendipity['maintenance']) && !empty($serendipity['maintenance'])) $servicehook = $serendipity['maintenance']; // [booleanize!]

                    // containerized backend calls send an ajax noHeading request which passes all smarty and web request into cloned default template
                    if ( ( ( !isset($serendipity['GET']['adminModule']) || empty($serendipity['GET']['adminModule']) ) &&
                           ( !isset($serendipity['POST']['adminModule']) || empty($serendipity['POST']['adminModule']) )
                         ) || $serendipity['GET']['noHeading']) {

                        // Disable the use of Serendipity JQuery in Dashboard Backend views - remember if having it disabled in template....
                        $serendipity['capabilities']['jquery'] = false;

                        $serendipity['smarty']->security = false;
                        $serendipity['templatePath'] = 'plugins/';
                        $serendipity['template'] = 'serendipity_event_dashboard/default';

                        // assign some head vars to smarty and the new index.tpl file 
                        // - is maintenance mode allowed
                        // - is set servicehook 
                        // - allow the use of containerized backend views null = never, false = initial-tier (mainly via nav- & selectbar), true = follow links, forms, etc.
                        $serendipity['smarty']->assign(
                            array(
                                'head_maintenance' => $this->blockMaintenance,
                                'head_servicehook' => ($this->blockMaintenance && serendipity_db_bool($servicehook)) ? 'true' : 'false',
                                'head_extend2Cont' => $this->extendToContainer === 'null' ? 'null' : (serendipity_db_bool($this->extendToContainer) ? 'true' : 'false'),
                                'smarty_dashpath'  => DASHBOARD_PLUGINPATH.'/'
                            )
                        );
                    }

                    break;

                case 'backend_header':
                    // Set backend_header hook content to be appended to head of standard templates/default/admin/index.tpl in sidebar mode backend views
                    // In case of sidebar serendipty_admin.php startpage is dashboard and dasboard full view, we take our own default admin template
                    if ( ( ( isset($serendipity['GET']['adminModule']) && !empty($serendipity['GET']['adminModule']) ) ||
                           ( isset($serendipity['POST']['adminModule']) && !empty($serendipity['POST']['adminModule']) )
                         ) && !$serendipity['GET']['noHeading']) {

                        // here we go and and add or restruct the backend header ;-)
                        echo "\n\n";
                        if($serendipity['POST']['h5bp-style']) {
                            echo '        <link rel="stylesheet" href="' . DASHBOARD_PLUGINPATH . '/css/style.css" type="text/css" media="screen"/>'."\n";
                        }
                        echo '        <link rel="stylesheet" href="' . DASHBOARD_PLUGINPATH . '/css/dashboard.css" type="text/css" media="screen"/>'."\n\n";
                        echo '        <!--[if gte IE 9]> <style type="text/css"> .gradient { filter: none; } </style> <![endif]-->';
                        echo "\n\n";
                        echo '        <script type="text/javascript"> var dashpath = \'' . DASHBOARD_PLUGINPATH . '/\'; </script>'."\n\n";

                    } // view un-containerized end

                    break;

                case 'external_plugin':
                    $db['jspost'] = explode('/', $eventData);
                    $userlevel = USERLEVEL_ADMIN;

                    // [0]=modemaintence; [1]=setmoma [boolean]
                    if($db['jspost'][0] == 'modemaintence') {
                        $setmoma = isset($_POST['setmoma']) ? serendipity_db_bool($_POST['setmoma']) : false;
                        $this->s9y_maintenance_mode($setmoma);
                        unset($setmoma);
                    }

                    // [0]=dbjsonsort; [1]=json [array];
                    if($db['jspost'][0] == 'dbjsonsort') {
                        // data was send by JSON.stringify() - decode to array
                        $pix = json_decode($_POST['json'], true);
                        $emt = '';
                        foreach ($pix AS $ke => $va) {
                            if ($ke > 0) {
                                $emt .= trim($va[0]).';'.trim($va[1]).', '; 
                            }
                        }
                        $setConfStr = trim($pix[0]) . '|' . substr($emt, 0, -2); // removes last ', '

                        // set to config or cookie depending Userlevel
                        if ((int)$serendipity['serendipityUserlevel'] < (int)USERLEVEL_ADMIN) {
                            // remove empty elements block name from string, as user has not admin user level
                            // also see array_cleanup() double check securing, when fetching metaset again for output
                            $setConfStr = preg_replace('{(?P<name>\w+);([,])\s}', '', $setConfStr); // ie. 'elem_6;, '
                            // using multidimensional cookie arrays was sadly denied by Chrome and IE browser - so back to flat
                            $name = 'dashboard_metaset_' . (int)$serendipity['serendipityUserlevel'];
                            // set http cookie for non admin users
                            serendipity_setCookie("$name", serialize($setConfStr));
                            // ie. serendipity[dashboard_metaset_0] = meta-box-right|elem_4;feed, elem_5;comapp, elem_2;future, elem_3;draft, elem_1;compen and (cookie: expires 180 days; path; this domain)
                        } else {
                            $this->set_config('metaset', $setConfStr);
                        }

                        // give back the answer string to json jQuery.post
                        $postAnswer = 'metaset, ' . $setConfStr; // eg. metaset, meta-box-right|elem_4;feed, elem_5;comapp, elem_6;update, elem_7;plugup, elem_2;future, elem_3;draft, elem_1;compen
                        echo $postAnswer; // console or ajax post answer 
                        // free all temporary used arrays and vars
                        unset($pix);
                        unset($emt);
                        unset($setConfStr);
                        unset($name);
                    }
                    
                    unset($db);

                    break;

                case 'backend_frontpage_display':
                    // redirect <= IE8 Browsers - no support!
                    $this->checkBrowser();

                    $elements = array();
                    $elements = explode(',', $this->defaultOrderString);
                    if(!empty($elements)) {
                        $countmainelements = count(array_values($elements));
                        if (in_array("clean", $elements)) { $countmainelements = ($countmainelements-1); }
                    }
                    // read the metaset array by admin from config, or user from cookie
                    if ( ((int)$serendipity['serendipityUserlevel'] < (int)USERLEVEL_ADMIN) 
                      && isset($serendipity['COOKIE']['dashboard_metaset_'.(int)$serendipity['serendipityUserlevel']]) ) {
                        if ($serendipity['expose_s9y']) serendipity_header('X-Serendipity-MetasetClientRestore: Cookie');
                        $metaset = unserialize($serendipity['COOKIE']['dashboard_metaset_'.(int)$serendipity['serendipityUserlevel']]);
                    } else {
                        $metaset = false;
                    }

                    $conf_metaset = $this->cookieMetaset;

                    // temporary bugfix while there may be a possible cookie and storing missmatch from 0.9.6.(1) to 0.9.7 in $metaset and $conf_metaset
                    if ($metaset == '|') $metaset = false;
                    if ($conf_metaset == '|') $conf_metaset = 'meta-box-right|elem_4;feed, elem_5;comapp, elem_6;update, elem_2;future, elem_3;draft, elem_1;compen, elem_7;plugup';

                    if (!$metaset) $metaset = ((isset($conf_metaset) && !empty($conf_metaset)) ? $conf_metaset : array());

                    if( !empty($metaset) && !empty($elements) ) {
                        $metaset = explode('|', $metaset);
                        $metaset = array($metaset[0], $metaset[1]);
                        $mix[] = explode(',', $metaset[1]);
                        foreach ($mix[0] AS $v) { $newmix[] = explode(';', trim($v)); }
                        // output double check this array, to avoid non-valid - say empty - key/value pairs
                        $newmix = $this->array_cleanup($newmix);
                        // keep the block name in the array to sort out in tpl later on
                        foreach ($newmix as $k => $val) { $mixarr[] = $val[1]; }
                        // the compare-to $elements array $mixarr
                        $block_elements = array_diff($elements, $mixarr);
                        $metaset = array($metaset[0], $newmix);
                        // free temporary arrays
                        unset($mix);
                        unset($newmix);
                        unset($mixarr);
                    }
                    // check dependency plugin availability
                    $dpdc_plugin_av = !defined('AUTOUPDATE_INSTALLED') ? true : false;

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
                    // return to real template name in case of containerized changed template path
                    if( $serendipity['template'] == 'serendipity_event_dashboard/default' ) {
                        $template_array = serendipity_db_query("SELECT value FROM {$serendipity['dbPrefix']}config WHERE `name` = 'template' AND (authorid = {$serendipity['authorid']} OR authorid = 0) LIMIT 1", true);
                    }

                    $sysinfo['intitle']  = ADMIN_FRONTPAGE;
                    $sysinfo['this_v']   = $serendipity['plugin_dashboard_version'];
                    $sysinfo['title']    = PLUGIN_DASHBOARD_TITLE;
                    $sysinfo['user']     = htmlspecialchars($serendipity['serendipityUser']);
                    $sysinfo['perm']     = $serendipity['permissionLevels'][$serendipity['serendipityUserlevel']];
                    $sysinfo['theme']    = is_array($template_array) ? $template_array['value'] : $serendipity['template'];
                    $sysinfo['widgets']  = $this->count_plugins(explode('|','hide|event|eventh'), true);

                    ob_start();
                    // include the POST % GET action file
                    include dirname(__FILE__) . '/' . 'dashboard_request_actions.inc.php';
                    // now assign all needed data to smarty
                    $serendipity['smarty']->assign(
                                                array(  'start'          => $serendipity['GET']['adminModule'] == 'start' ? true : false,
                                                        'errormsg'       => $errormsg,
                                                        'dpdc_plugin_av' => $dpdc_plugin_av,
                                                        'show_dpdc_note' => $this->autoupdateExistNote,
                                                        'elements'       => $elements,
                                                        'countelements'  => ($countmainelements / 2),
                                                        'block_elements' => $block_elements,
                                                        'metaset'        => $metaset,
                                                        'secgroupempty'  => ($this->defaultOrderString ? false : true),
                                                        'moma'           => $this->blockMaintenance,
                                                        'plugininstance' => $this->instance,
                                                        'thispath'       => DASHBOARD_PLUGINPATH,
                                                        'fullpath'       => dirname(__FILE__),
                                                        'antispam_hook'  => '',
                                                        'sysinfo'        => $sysinfo,
                                                        's9yheader'      => array($eventData),
                                                        'version'        => 'Serendipity ' . $serendipity['version'] . ' ['.$this->searchUpdateTree.']'
                                                    )
                                                );

                    $eventData = null; // eventData holds the welcome User message and the link and bookmark box

                    #serendipity_plugin_api::hook_event('backend_comments_top', $comments);

                    // gather the elements block data
                    if (is_array($elements) && !empty($elements) ) {
                        // include header 'clean'element, if set
                        if ( $this->smartyCleanCompDir ) $elements[] = 'clean';
                        foreach($elements AS $key => $e) {
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
