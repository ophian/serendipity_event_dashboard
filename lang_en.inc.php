<?php
/* last modified - 2012-08-14 */
@define('PLUGIN_DASHBOARD_TITLE', 'Dashboard');
@define('PLUGIN_DASHBOARD_DESC', 'Shows some summary information on the backend frontpage');

@define('PLUGIN_DASHBOARD_LIMIT_DRAFT', 'Number of draft entries to show');
@define('PLUGIN_DASHBOARD_LIMIT_COMMENTS', 'Number of comments to show');
@define('PLUGIN_DASHBOARD_LIMIT_FUTURE', 'Number of upcoming entries (by publish date) to show');

@define('PLUGIN_DASHBOARD_SEQUENCE', 'Element order');
@define('PLUGIN_DASHBOARD_SEQUENCE_DESC', 'Here you can arrange how the different types of information shall be arranged.<p>Further positions may be made in succession in the Dashboard UI itself!</p>');

@define('PLUGIN_DASHBOARD_FUTURE', 'Upcoming entries');

@define('PLUGIN_DASHBOARD_LIMIT_COMMENTS_PENDING', 'Number of pending comments to show');
@define('PLUGIN_DASHBOARD_COMMENTS_PENDING', 'Pending comments');

@define('PLUGIN_DASHBOARD_READONLY', 'Read-only Dashboard?');
@define('PLUGIN_DASHBOARD_READONLY_DESC', 'If enabled, the dashboard will not be able to perform actual actions on its output, so that you cannot accidentally perform an action like deleting or approving comments.');

@define('PLUGIN_DASHBOARD_UPDATE', 'Check for Serendipity Update');
@define('PLUGIN_DASHBOARD_UPDATE_DESC', 'Whether to check for a new stable release of Serendipity, or for a new available beta version, or no check.');
@define('PLUGIN_DASHBOARD_STABLE', 'stable');
@define('PLUGIN_DASHBOARD_UNSTABLE', 'beta');
@define('PLUGIN_DASHBOARD_NONE', 'off');
@define('PLUGIN_DASHBOARD_ERROR_URL', 'Error when trying to check for new Serendipity Version. Could not open URL');
@define('UPDATE', 'Update notifier');
@define('PLUGIN_DASHBOARD_UPDATE_TITLE', 'Serendipity Update');
@define('PLUGIN_DASHBOARD_UPDATE_NOTIFIER', '<strong>A new Serendipity Version is available.</strong><br>You can just download the new version manually here: %s'); // Please consider upgrading to the newest release
@define('PLUGIN_DASHBOARD_UPDATE_NOTIFIER_AUTOADD', ', or use:');
@define('PLUGIN_DASHBOARD_CLEANUP_CONFIRM', 'Shall all compiled Smarty template files (except the dashboard ones) get erased completely? Usually this is not necessary as long everything is working well!');

@define('PLUGUP', 'Plugin Update Notificator');
@define('PLUGIN_UPDATE_NOTIFIER', 'Plugin Update available');
@define('INCLUDE_COMMENT_SELECTION', 'Add %s #%s %s');
@define('IN_SELECTION', 'to selection');
@define('READ_ONLY', 'Inactive');

@define('PLUGIN_DASHBOARD_CLEAN', 'Enable Button: \'Clean all compiled templates\' in Dashboard Header?');
@define('PLUGIN_DASHBOARD_SYS', 'Dashboard System');
@define('PLUGIN_DASHBOARD_CLEANSMARTY', 'Cleanup Smarty\'s compiled templates');
@define('PLUGIN_DASHBOARD_NA', '<b>N/A</b> [<em>%s, %s</em>] <sup class="note">(activate in config)</sup>');
@define('PLUGIN_DASHBOARD_MARK', 'Please do not un-mark all dashboard elements at once! Return to config!');
@define('PLUGIN_DASHBOARD_AUTOUPDATE_NOTE', 'This Dashboard may use an available dependency Plugin: \'serendipity_event_autoupdate\'!<br />To run a pronounced Serendipity Core update without any need to further manual processing, please additional install this plugin first via Spartacus.');
@define('PLUGIN_DASHBOARD_PATH', 'Image and Script HTTP path');
@define('PLUGIN_DASHBOARD_PATH_DESC', 'Enter the full HTTP path (everything after your domain name) that leads to this plugin\'s directory.');
@define('PLUGIN_DASHBOARD_FLIPNOTE', 'Click to swap');
@define('PLUGIN_DASHBOARD_COMMENT_SELECTION_SHORT', '#%s');
@define('PLUGIN_DASHBOARD_DELETE_SELECTED', 'Delete selected');
@define('PLUGIN_DASHBOARD_MODERATE_SELECTED', 'Approve selected');

@define('PLUGIN_DASHBOARD_INFO', 'Info Box');
@define('PLUGIN_DASHBOARD_INFO_HEADER', 'Overview');
@define('PLUGIN_DASHBOARD_INFO_CONTENT', 'Content');
@define('PLUGIN_DASHBOARD_INFO_DISCUSSION', 'Discussion');
@define('PLUGIN_DASHBOARD_INFO_ENTRIES', 'Entries');
@define('PLUGIN_DASHBOARD_INFO_FREETAGS', 'Freetags');
@define('PLUGIN_DASHBOARD_INFO_COMMENTS_APPROVED', 'Approved');
@define('PLUGIN_DASHBOARD_INFO_COMMENTS_PENDING', 'Open');
@define('PLUGIN_DASHBOARD_INFO_WIDGETS', 'Sidebar Plugins [Widgets]');
@define('PLUGIN_DASHBOARD_INFO_VERSION', 'You are using: %s');
@define('PLUGIN_DASHBOARD_INFO_WITH', 'with');

@define('PLUGIN_DASHBOARD_DEPENDENCY_NOTE', 'Enable Plugin-Dependency note in Dashboard header?');
@define('PLUGIN_DASHBOARD_DEPENDENCY_NOTE_DESC', '');
@define('PLUGIN_DASHBOARD_MAINTENANCE', 'Enable Button: \'Upgrade Maintenance Mode\' in the Dashboards Update-Block Element?');
@define('PLUGIN_DASHBOARD_MAINTENANCE_NOTE', 'Maintenance Mode Text Splash Screen');
@define('PLUGIN_DASHBOARD_MAINTENANCE_TEXT', 'The Blog <%s> is in maintenance mode. This Blog will be back online shortly.');

@define('PLUGIN_DASHBOARD_LIMIT_FEED', 'Number of feed entries to show');

@define('PLUGIN_DASHBOARD_FEED', 'Serendipity (s9y.org) Blog Feed');
@define('PLUGIN_DASHBOARD_FEED_URL', 'RSS-Feed URL');
@define('PLUGIN_DASHBOARD_FEED_TITLE', 'The Feeds block title');
@define('PLUGIN_DASHBOARD_FEED_CONTENT', 'Show feed Article Content?');
@define('PLUGIN_DASHBOARD_FEED_AUTHOR', 'Show Feed Article Author?');
@define('PLUGIN_DASHBOARD_FEED_CONUM', 'Refer to Feed Article Comments?');
