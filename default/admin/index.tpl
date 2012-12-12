{* HTML5: Yes *}
{* jQuery: No *}

<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="{$lang}"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="{$lang}"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="{$lang}"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="{$lang}"> <!--<![endif]-->
<head>
    <!-- DASHBOARD ADMIN-ENTRY TEMPLATE: index.tpl START -->
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset={$CONST.LANG_CHARSET}">
    <title>{if $admin_vars.title}{$admin_vars.title} | {/if}{$CONST.SERENDIPITY_ADMIN_SUITE}</title>
    <!-- Enable Mobile Internet Explorer ClearType Technology -->
    <meta http-equiv="cleartype" content="on">
    <!--[if IE 9]> <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> <![endif]-->
    <meta name="HandheldFriendly" content="True">
    <meta name="MobileOptimized" content="320">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <!-- For iOS web apps. Delete if not needed. https://github.com/h5bp/mobile-boilerplate/issues/94 -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="apple-mobile-web-app-title" content="Dashboard">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="/img/ico/apple-touch-icon-144-precomposed.png">
    <meta name="msapplication-TileColor" content="#222222">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="{$admin_vars.css_file}">
    <link rel="stylesheet" type="text/css" href="{$admin_vars.admin_css_file}">
    <!--[if gte IE 9]> <style type="text/css"> .gradient {ldelim} filter: none; {rdelim} </style> <![endif]-->
    <link rel="stylesheet" href="{$CONST.DASHBOARD_PLUGINPATH}/css/clean.css" type="text/css" media="screen">
    <link rel="stylesheet" href="{$CONST.DASHBOARD_PLUGINPATH}/css/animation.css" type="text/css" media="screen">{*  *}
    <link rel="stylesheet" href="{$CONST.DASHBOARD_PLUGINPATH}/css/dashboard.css" type="text/css" media="screen">

    <!-- Le fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/img/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/img/ico/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/img/ico/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="/img/ico/apple-touch-icon-57-precomposed.png">
                       <link rel="apple-touch-startup-image" href="/img/ico/splash.png">
                                   <link rel="shortcut icon" href="/img/ico/favicon.ico" type="image/x-icon">

    <!-- This script prevents links of bookmarked Apps from opening in Mobile Safari. https://gist.github.com/1042026 -->
    <script>{literal}(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d=d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone"){/literal}</script>

    <script type="text/javascript" language="JavaScript" src="{$CONST.DASHBOARD_PLUGINPATH}/inc/admin_container.js"></script>
    {* these 2 scripts have to load synchronously - they can't even use async load, which is loading without blocking the page content load - meaning: load in background - and execute to the possible unfinished DOM when ready *}
    {if $CONST.BAYES_INSTALLED === true}
    <script type="text/javascript" language="JavaScript" src="{$CONST.BAYES_PLUGINPATH}/bayes_commentlist.js"></script>
    {/if}

    <script type="text/javascript">
        var const_view         = '{$CONST.VIEW_FULL}';
        var const_hide         = '{$CONST.HIDE}';
        var dashpath           = '{$CONST.DASHBOARD_PLUGINPATH}/';
{if $CONST.BAYES_INSTALLED === true}
        var bayesCharset       = '{$CONST.LANG_CHARSET}';
        var bayesDone          = '{$CONST.DONE}';
        var bayesHelpTitle     = '{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_RATING_EXPLANATION}';
{/if}
{if $head_maintenance}
        var const_service      = '{$CONST.PLUGIN_DASHBOARD_MAINTENANCE_MODE_DESC}';
        var const_serv_active  = '{$CONST.PLUGIN_DASHBOARD_MAINTENANCE_MODE_ACTIVE}';
        var const_serv_origin  = '{$CONST.PLUGIN_DASHBOARD_MAINTENANCE_MODE}';
{/if}
        var extend2Cont        = {$head_extend2Cont};
{if $head_servicehook !== null}
        var servicehook        = {$head_servicehook};
{/if}
    </script>

{if $admin_vars.admin_installed}
    {serendipity_hookPlugin hook="backend_header" hookAll="true"}
{/if}
</head>
<body id="serendipity_admin_page" onload="spawn()">
{if NOT $admin_vars.no_banner}
    <header id="top">
        <div class="clearfix">
            <div id="banner{if not $admin_vars.is_logged_in}_install{/if}">
            {if $admin_vars.admin_installed}
                <h1><span class="visuallyhidden">{$CONST.SERENDIPITY_ADMIN_SUITE}: </span>{$blogTitle}</h1>
                {if $admin_vars.is_logged_in}
                <span class="block_level">{$admin_vars.self_info}</span>
                {/if}
            {else}
                <h1>{$CONST.SERENDIPITY_INSTALLATION}</h1>
            {/if}
            </div>
        {if $admin_vars.is_logged_in}
            <nav id="user_menu">
                <h2 class="visuallyhidden">User menu</h2> {* i18n *}

                <ul>
                    <li><a class="icon_link" href="serendipity_admin.php" title="{$CONST.ADMIN_FRONTPAGE}"><span class="icon-home"></span><span class="visuallyhidden"> {$CONST.ADMIN_FRONTPAGE}</span></a></li>
                {if 'personalConfiguration'|checkPermission}
                    <li><a id="menu-perset" class="icon_link" href="serendipity_admin.php?serendipity[adminModule]=personal" title="{$CONST.PERSONAL_SETTINGS}"><span class="icon-cog-alt"></span><span class="visuallyhidden"> {$CONST.PERSONAL_SETTINGS}</span></a></li>
                {/if}
                {if $showCleanupSmarty}
                    <li><a id="menu-cleanup" class="icon_link" href="?serendipity[action]=admin&amp;serendipity[dashboard_event]=capct&amp;{$urltoken}" title="{$CONST.PLUGIN_DASHBOARD_CLEANSMARTY} [{$CONST.PATH_SMARTY_COMPILE}]" onclick="return confirm('{$CONST.PLUGIN_DASHBOARD_CLEANUP_CONFIRM}')"><span class="icon-trash"></span><span class="visuallyhidden"> {$CONST.PLUGIN_DASHBOARD_CLEANSMARTY} [{$CONST.PATH_SMARTY_COMPILE}]</span></a></li>
                {/if}
                {if 'adminPlugins'|checkPermission}
                    <li><a id="menu-plugco" class="icon_link pluginmanager_configure" href="?serendipity[adminModule]=plugins&amp;serendipity[plugin_to_conf]={$plugininstance}" title="{$sysinfo.title} Plugin [{$sysinfo.this_v}]"><span class="icon-cog"></span><span class="visuallyhidden"> {$sysinfo.title} Plugin [{$sysinfo.this_v}]</span></a></li>
                {/if}
                    <li><a class="icon_link" href="{$serendipityBaseURL}" title="{$CONST.BACK_TO_BLOG}"><span class="icon-link-ext"></span><span class="visuallyhidden"> {$CONST.BACK_TO_BLOG}</span></a></li>
                    <li><a id="menu-logoff" class="icon_link" href="serendipity_admin.php?serendipity[adminModule]=logout" title="{$CONST.LOGOUT}"><span class="icon-off"></span><span class="visuallyhidden"> {$CONST.LOGOUT}</span></a></li>
                </ul>
            </nav>
        {/if}
        </div>
    </header>
{/if}
    <div id="main" class="clearfix">
    {if NOT $admin_vars.is_logged_in}
        {$admin_vars.out|@serendipity_refhookPlugin:'backend_login_page'}
        {* <div id="login_container"> *}
            {* <h2>{$CONST.WELCOME_TO_ADMIN}</h2> *}
            {$admin_vars.out.header}
        {if $admin_vars.post_action != '' AND NOT $admin_vars.is_logged_in}
            <span class="msg_error">{$CONST.WRONG_USERNAME_OR_PASSWORD}</span>
        {/if}
            <form id="login" class="clearfix" action="serendipity_admin.php" method="post">
                <input type="hidden" name="serendipity[action]" value="admin">
                <fieldset>
                    <legend class="visuallyhidden"><span>{$CONST.PLEASE_ENTER_CREDENTIALS}</span></legend>

                    <div class="form_field">
                        <label for="login_uid">{$CONST.USERNAME}</label>
                        <input id="login_uid" name="serendipity[user]" type="text">
                    </div>

                    <div class="form_field">
                        <label for="login_pwd">{$CONST.PASSWORD}</label>
                        <input id="login_pwd" name="serendipity[pass]" type="password">
                    </div>

                    <div class="form_check">
                        <input id="login_auto" name="serendipity[auto]" type="checkbox"><label for="login_auto">{$CONST.AUTOMATIC_LOGIN}</label>
                    </div>

                    <input id="login_send" name="submit" type="submit" value="{$CONST.LOGIN}">
                </fieldset>
                {$admin_vars.out.table}
            </form>
            <a id="back_to_blog" href="{$serendipityBaseURL}">{$CONST.BACK_TO_BLOG}</a>
            {$admin_vars.out.footer}
        {* </div> *}
    {else}
        <div id="content" class="clearfix">
        {$admin_vars.main_content}
        </div>
        {if NOT $admin_vars.no_sidebar}
        <nav id="main_menu">
            <h2 class="visuallyhidden">Main menu</h2> {* i18n *}

            <ul>
                {if 'adminEntries'|checkPermission OR 'adminEntriesPlugins'|checkPermission}
                <li><h3>{$CONST.ADMIN_ENTRIES}</h3>
                    <ul>
                    {if 'adminEntries'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=entries&amp;serendipity[adminAction]=new">{$CONST.NEW_ENTRY}</a></li>
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=entries&amp;serendipity[adminAction]=editSelect">{$CONST.EDIT_ENTRIES}</a></li>
                    {/if}
                    {if 'adminComments'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=comments">{$CONST.COMMENTS}</a></li>
                    {/if}
                    {if 'adminCategories'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=category&amp;serendipity[adminAction]=view">{$CONST.CATEGORIES}</a></li>
                    {/if}
                    {if 'adminEntries'|checkPermission OR 'adminEntriesPlugins'|checkPermission}
                        {if $admin_vars.no_create !== true}
                        {serendipity_hookPlugin hook="backend_sidebar_entries" hookAll="true"}
                        {/if}
                    {/if}
                    </ul>
                </li>
                {/if}
                {if 'adminImages'|checkPermission}
                <li><h3>{$CONST.MEDIA}</h3>
                    <ul>
                    {if 'adminImagesAdd'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=addSelect">{$CONST.ADD_MEDIA}</a></li>
                    {/if}
                    {if 'adminImagesView'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=media">{$CONST.MEDIA_LIBRARY}</a></li>
                    {/if}
                    {if 'adminImagesDirectories'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=directorySelect">{$CONST.MANAGE_DIRECTORIES}</a></li>
                    {/if}
                    {if 'adminImagesSync'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=sync" onclick="return confirm('{$CONST.WARNING_THIS_BLAHBLAH}');">{$CONST.CREATE_THUMBS}</a></li>
                    {/if}
                    {if $admin_vars.no_create !== true}
                        {serendipity_hookPlugin hook="backend_sidebar_entries_images" hookAll="true"}
                    {/if}
                    </ul>
                </li>
                {/if}
                {if 'adminTemplates'|checkPermission OR 'adminPlugins'|checkPermission}
                <li><h3>{$CONST.APPEARANCE}</h3>
                    <ul>
                    {if 'adminTemplates'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=templates">{$CONST.MANAGE_STYLES}</a></li>
                    {/if}
                    {if 'adminPlugins'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=plugins">{$CONST.CONFIGURE_PLUGINS}</a></li>
                    {/if}
                    {if $admin_vars.no_create !== true}
                        {serendipity_hookPlugin hook="backend_sidebar_admin_appearance" hookAll="true"}
                    {/if}
                    </ul>
                </li>
                {/if}
                {if 'adminUsersGroups'|checkPermission OR 'adminImport'|checkPermission OR 'siteConfiguration'|checkPermission OR 'blogConfiguration'|checkPermission OR 'adminUsers'|checkPermission}
                <li><h3>{$CONST.ADMIN}</h3>
                    <ul>
                    {if 'siteConfiguration'|checkPermission OR 'blogConfiguration'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=configuration">{$CONST.CONFIGURATION}</a></li>
                    {/if}
                    {if 'adminUsers'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=users">{$CONST.MANAGE_USERS}</a></li>
                    {/if}
                    {if 'adminUsersGroups'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=groups">{$CONST.MANAGE_GROUPS}</a></li>
                    {/if}
                    {if 'adminImport'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=import">{$CONST.IMPORT_ENTRIES}</a></li>
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=export">{$CONST.EXPORT_ENTRIES}</a></li>
                    {/if}
                    {if 'siteConfiguration'|checkPermission || 'blogConfiguration'|checkPermission}
                        <li><a href="serendipity_admin.php?serendipity[adminModule]=integrity">{$CONST.INTEGRITY}</a></li>
                    {/if}
                    {if $admin_vars.no_create !== true}
                        {serendipity_hookPlugin hook="backend_sidebar_admin" hookAll="true"}
                    {/if}
                    </ul>
                </li>
                {/if}
            </ul>
        </nav>
        {/if}
    {/if}
    </div>
{if NOT $admin_vars.no_footer}
    <footer id="meta">
        <small>{$admin_vars.version_info}</small>
    </footer>
{/if}
    {** include all scripts waiting for DOM ready: DOMContentLoaded-Event (document.ready)
    <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/modernizr-2.6.2.cb.min.js" defer></script> **}
    <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery-1.8.3.min.js" defer></script>
    <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery-ui-1.8.23.custom.min.js" defer></script>
    <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery.cookie.min.js" defer></script>
    <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery.mb.containerPlus.js" defer></script>
    <script src="serendipity_editor.js" defer></script>
    <script src="{serendipity_getFile file='admin/js/2k11.admin.js'}" defer></script>
    {* <script type="text/javascript"> jQuery.noConflict(); </script> *}
    <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/ajax-dashboard.js" defer></script>
    <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery-dashboard.js" defer></script>

    </body>
<!-- DASHBOARD ADMIN-ENTRY TEMPLATE: index.tpl END -->
</html>
