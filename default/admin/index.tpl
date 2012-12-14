<!DOCTYPE html>
<html>
    <head>
<!-- DASHBOARD ADMIN-ENTRY TEMPLATE: index.tpl START -->
        <base target="_self"/>
        <title>{$admin_vars.title} - {$CONST.SERENDIPITY_ADMIN_SUITE}</title>
        <meta http-equiv="Content-Type" content="text/html; charset={$CONST.LANG_CHARSET}">
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
        <table cellspacing="0" cellpadding="0" border="0" id="serendipityAdminFrame">

{*** DASHBOARD BANNER START ***}
        {if NOT $admin_vars.no_banner}
            <tr>
                <td colspan="2" id="serendipityAdminBanner">
                {if $admin_vars.admin_installed}
                    <h1>{$CONST.SERENDIPITY_ADMIN_SUITE}</h1>
                    <h2>{$blogTitle}</h2>
                {else}
                    <h1>{$CONST.SERENDIPITY_INSTALLATION}</h1>
                {/if}
                </td>
            </tr>
            <tr>
                <td colspan="2" id="serendipityAdminInfopane">
                    {if $admin_vars.is_logged_in}
                        <span>{$admin_vars.self_info}</span>
                    {/if}
                </td>
            </tr>
        {/if}
{*** DASHBOARD BANNER END ***}

            <tr valign="top">
{if NOT $admin_vars.is_logged_in}
{*** DASHBOARD LOGIN-AREA START ***}

    {$admin_vars.out|@serendipity_refhookPlugin:'backend_login_page'}
                <td colspan="2" class="serendipityAdminContent">
                    <div id="serendipityAdminWelcome" align="center">
                        <h2>{$CONST.WELCOME_TO_ADMIN}</h2>
                        <h3>{$CONST.PLEASE_ENTER_CREDENTIALS}</h3>
                        {$admin_vars.out.header}
                    </div>
                    {if $admin_vars.post_action != '' AND NOT $admin_vars.is_logged_in}
                        <div class="serendipityAdminMsgError"><img width="22px" height="22px" style="border: 0px; padding-right: 2px; vertical-align: middle" src="{serendipity_getFile file='admin/img/admin_msg_error.png'}" alt="" />{$CONST.WRONG_USERNAME_OR_PASSWORD}</div>
                    {/if}
                    <form action="serendipity_admin.php" method="post">
                        <input type="hidden" name="serendipity[action]" value="admin" />
                        <table id="serendipityAdminCredentials" cellspacing="10" cellpadding="0" border="0" align="center">
                            <tr>
                                <td>{$CONST.USERNAME}</td>
                                <td><input class="input_textbox" type="text" name="serendipity[user]" /></td>
                            </tr>
                            <tr>
                                <td>{$CONST.PASSWORD}</td>
                                <td><input class="input_textbox" type="password" name="serendipity[pass]" /></td>
                            </tr>
                            <tr>
                                <td colspan="2"><input class="input_checkbox" id="autologin" type="checkbox" name="serendipity[auto]" /><label for="autologin"> {$CONST.AUTOMATIC_LOGIN}</label></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right"><input type="submit" name="submit" value="{$CONST.LOGIN} &gt;" class="input_button serendipityPrettyButton" /></td>
                            </tr>
                            {$admin_vars.out.table}
                        </table>
                    </form>
                    {$admin_vars.out.footer}
                    <p id="serendipityBackToBlog"><a href="{$serendipityHTTPPath}">{$CONST.BACK_TO_BLOG}</a></p>
{*** DASHBOARD LOGIN-AREA END ***}
{else}
{*** DASHBOARD SIDEBAR-MENU START ***}
    {if NOT $admin_vars.no_sidebar}
                <td id="serendipitySideBar">

    {*** DASHBOARD MAIN LINKS START ***}
                    <ul class="serendipitySideBarMenu serendipitySideBarMenuMain">
                        <li class="serendipitySideBarMenuHead serendipitySideBarMenuMainLinks" style="display:none"></li>
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuMainLinks serendipitySideBarMenuMainFrontpage"><a href="serendipity_admin.php">{$CONST.ADMIN_FRONTPAGE}</a></li>
                        {if 'personalConfiguration'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuMainLinks serendipitySideBarMenuMainPersonal"><a href="serendipity_admin.php?serendipity[adminModule]=personal">{$CONST.PERSONAL_SETTINGS}</a></li>
                        {/if}
                        <li class="serendipitySideBarMenuFoot serendipitySideBarMenuMainLinks" style="display:none"></li>
                    </ul>
                    <br class="serendipitySideBarMenuSpacer" />                                                                                             
    {*** DASHBOARD MAIN LINKS END ***}

    {*** DASHBOARD ENTRY LINKS START ***}
                    {if 'adminEntries'|checkPermission OR 'adminEntriesPlugins'|checkPermission}
                    <ul class="serendipitySideBarMenu serendipitySideBarMenuEntry">
                        <li class="serendipitySideBarMenuHead serendipitySideBarMenuEntryLinks">{$CONST.ADMIN_ENTRIES}</li>
                        {if 'adminEntries'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=entries&amp;serendipity[adminAction]=new">{$CONST.NEW_ENTRY}</a></li>
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=entries&amp;serendipity[adminAction]=editSelect">{$CONST.EDIT_ENTRIES}</a></li>
                        {/if}

                        {if 'adminComments'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=comments">{$CONST.COMMENTS}</a></li>
                        {/if}

                        {if 'adminCategories'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=category&amp;serendipity[adminAction]=view">{$CONST.CATEGORIES}</a></li>
                        {/if}

                        {if 'adminEntries'|checkPermission OR 'adminEntriesPlugins'|checkPermission}
                        {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_entries" hookAll="true"}{/if}
                        {/if}
                        <li class="serendipitySideBarMenuFoot serendipitySideBarMenuEntryLinks" style="display:none"></li>
                    </ul>
                    {/if}
                    {*** ENTRY LINKS END ***}

    {*** DASHBOARD MEDIA LINKS START ***}
        {if 'adminImages'|checkPermission}
                    <ul class="serendipitySideBarMenu serendipitySideBarMenuMedia">
                        <li class="serendipitySideBarMenuHead serendipitySideBarMenuMediaLinks">{$CONST.MEDIA}</li>
                        {if 'adminImagesAdd'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=addSelect">{$CONST.ADD_MEDIA}</a></li>
                        {/if}
                        {if 'adminImagesView'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media">{$CONST.MEDIA_LIBRARY}</a></li>
                        {/if}
                        {if 'adminImagesDirectories'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=directorySelect">{$CONST.MANAGE_DIRECTORIES}</a></li>
                        {/if}
                        {if 'adminImagesSync'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=sync" onclick="return confirm('{$CONST.WARNING_THIS_BLAHBLAH}');">{$CONST.CREATE_THUMBS}</a></li>
                        {/if}
                        {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_entries_images" hookAll="true"}{/if}
                        <li class="serendipitySideBarMenuFoot serendipitySideBarMenuMediaLinks" style="display:none"></li>
                    </ul>
        {/if}
    {*** DASHBOARD MEDIA LINKS END ***}

    {*** DASHBOARD APPEARANCE START ***}
        {if 'adminTemplates'|checkPermission OR 'adminPlugins'|checkPermission}
                    <ul class="serendipitySideBarMenu serendipitySideBarMenuAppearance">
                        <li class="serendipitySideBarMenuHead serendipitySideBarMenuAppearanceLinks">{$CONST.APPEARANCE}</li>
                        {if 'adminTemplates'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuAppearanceLinks"><a href="serendipity_admin.php?serendipity[adminModule]=templates">{$CONST.MANAGE_STYLES}</a></li>
                        {/if}
                        {if 'adminPlugins'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuAppearanceLinks"><a href="serendipity_admin.php?serendipity[adminModule]=plugins">{$CONST.CONFIGURE_PLUGINS}</a></li>
                        {/if}
                        {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_admin_appearance" hookAll="true"}{/if}
                        <li class="serendipitySideBarMenuFoot serendipitySideBarMenuAppearance" style="display:none"></li>
                    </ul>
        {/if}
    {*** DASHBOARD APPEARANCE END ***}

    {*** DASHBOARD USER MANAGEMENT START ***}
        {if 'adminUsersGroups'|checkPermission OR 'adminImport'|checkPermission OR 'siteConfiguration'|checkPermission OR 'blogConfiguration'|checkPermission OR 'adminUsers'|checkPermission}
                    <ul class="serendipitySideBarMenu serendipitySideBarMenuUserManagement">
                        <li class="serendipitySideBarMenuHead serendipitySideBarMenuUserManagementLinks">{$CONST.ADMIN}</li>
                        {if 'siteConfiguration'|checkPermission OR 'blogConfiguration'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=configuration">{$CONST.CONFIGURATION}</a></li>
                        {/if}
                        {if 'adminUsers'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=users">{$CONST.MANAGE_USERS}</a></li>
                        {/if}
                        {if 'adminUsersGroups'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=groups">{$CONST.MANAGE_GROUPS}</a></li>
                        {/if}
                        {if 'adminImport'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=import">{$CONST.IMPORT_ENTRIES}</a></li>
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=export">{$CONST.EXPORT_ENTRIES}</a></li>
                        {/if}
                        {if 'siteConfiguration'|checkPermission || 'blogConfiguration'|checkPermission}
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=integrity">{$CONST.INTEGRITY}</a></li>
                        {/if}
                        {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_admin" hookAll="true"}{/if}
                        <li class="serendipitySideBarMenuFoot serendipitySideBarMenuUserManagement" style="display:none"></li>
                    </ul>
        {/if}
    {*** DASHBOARD USER MANAGEMENT END ***}

    {*** DASHBOARD LOGOUT START ***}
                    <br class="serendipitySideBarMenuSpacer" />                                                                                             
                    <ul class="serendipitySideBarMenu serendipitySideBarMenuLogout">
                        <li class="serendipitySideBarMenuHead serendipitySideBarMenuLogoutLinks" style="display:none"></li>
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuLogoutLinks serendipitySideBarMenuLogoutWeblog"><a href="{$serendipityBaseURL}">{$CONST.BACK_TO_BLOG}</a></li>
                        <li class="serendipitySideBarMenuLink serendipitySideBarMenuLogoutLinks serendipitySideBarMenuLogoutLogout"><a href="serendipity_admin.php?serendipity[adminModule]=logout">{$CONST.LOGOUT}</a></li>
                        <li class="serendipitySideBarMenuFoot serendipitySideBarMenuLogoutLinks" style="display:none"></li>
                    </ul>
    {*** DASHBOARD LOGOUT END ***}

                </td>
    {/if}
                <td class="serendipityAdminContent">

    {*** DASHBOARD MAIN CONTENT OF THE ADMIN INTERFACE START ***}
                    {$admin_vars.main_content}
    {*** DASHBOARD MAIN CONTENT OF THE ADMIN INTERFACE END ***}

{/if}
{*** DASHBOARD SIDEBAR-MENU END ***}
                </td>
            </tr>
        </table>
        <div class="serendipityAdminFooterSpacer">
            <br />
        </div>
        <div id="serendipityAdminFooter">
            <span>{$admin_vars.version_info}</span>
        </div>

        {** include all scripts waiting for DOM ready: DOMContentLoaded-Event (document.ready)
        <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/modernizr-2.6.2.cb.min.js" defer></script> **}
        <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery-1.8.3.min.js" defer></script>
        <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery-ui-1.8.23.custom.min.js" defer></script>
        <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery.cookie.min.js" defer></script>
        <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery.mb.containerPlus.js" defer></script>
        {* <script type="text/javascript"> jQuery.noConflict(); </script> *}
        <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/ajax-dashboard.js" defer></script>
        <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/jquery-dashboard.js" defer></script>
        {* <script type="text/javascript" language="JavaScript" src="/_php/div_tests/blogs/serendipity/templates/default/admin/category_selector.js"></script> *}
        {* <script src="serendipity_editor.js" defer></script> *}
        {* <script src="{$CONST.DASHBOARD_PLUGINPATH}/inc/category_selector.js" defer></script> *}

    </body>
<!-- DASHBOARD ADMIN-ENTRY TEMPLATE: index.tpl END -->
</html>
