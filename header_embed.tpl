{*** header_embed.tpl - last modified 2012-08-14 ***}

    <header role="banner">
        <div class="clearfix">
            <nav id="user-menu-user-welcome" role="navigation">
                <h2><span><img src="{$thispath}/img/s9y4.png" alt="logo">{$s9yheader.0.welcome}</span></h2>

                <div id="boxed_autoupdate" class="visuallyhidden"><p><img class="attention" src="{serendipity_getFile file='admin/img/admin_msg_note.png'}" alt="" /> {$CONST.PLUGIN_DASHBOARD_AUTOUPDATE_NOTE}</p></div>
            </nav>

            <nav id="user-menu-user-embed-iconset" role="navigation">
                <ul class="clearfix">
                    <li><a id="menu-logoff" href="serendipity_admin.php?serendipity[adminModule]=logout"><img src="{$thispath}/img/exitoctogone.png" width="36" height="36" alt="[LO]" title="{$CONST.LOGOUT}" /></a></li>
                    <li><a id="menu-perset" href="serendipity_admin.php?serendipity[adminModule]=personal"><img src="{$thispath}/img/user.png" alt="[PS]" title="{$CONST.PERSONAL_SETTINGS}" /></a></li>
                    {if $showCleanupSmarty}
                    <li><a id="menu-cleanup" href="?serendipity[action]=admin&amp;serendipity[dashboard_event]=capct&amp;{$urltoken}" onclick="return confirm('{$CONST.PLUGIN_DASHBOARD_CLEANUP_CONFIRM}')"><img src="{$thispath}/img/cleanup128.png" width="32" height="32" alt="[CP]" title="{$CONST.PLUGIN_DASHBOARD_CLEANSMARTY} [{$CONST.PATH_SMARTY_COMPILE}]" /></a></li>
                    {/if}
                    {if 'adminPlugins'|checkPermission}
                    <li><a id="menu-plugco" href="?serendipity[adminModule]=plugins&amp;serendipity[plugin_to_conf]={$plugininstance}" class="pluginmanager_configure"><img src="{$thispath}/img/dsbcon128.png" width="32" height="32" alt="[C]" title="{$sysinfo.title} Plugin [{$sysinfo.dashboard_version}]" /></a></li>
                    {/if}
                    <li><a id="menu-back2b" href="{$serendipityBaseURL}"><img src="{$thispath}/img/b2b128.png" width="32" height="32" alt="[B2B]" title="{$CONST.BACK_TO_BLOG}" /></a></li>
                </ul>
                
            </nav>

            <nav id="user-menu-user-embed-switch" role="navigation">
                 <ul class="clearfix">
                {if $dpdc_plugin_av && $showElementUpdate && $show_dependencynote} 
                   <li><span id="menu-autoupdate" class="text-icon text-icon-notifications" alt="[U]" title=" &#187; click: Important Info! &#171; "></span></li>
                {/if}
                   <li><img id="menu-fadenav" class="slidenav" src="{$thispath}/img/switch128.png" width="64" height="64" alt="slidenav" title="{$CONST.ADMIN_FRONTPAGE} {$CONST.PLUGIN_DASHBOARD_TITLE}" /></li>
                </ul>
            </nav>

            <nav id="user-menu-user-navigation-select" class="visuallyhidden" role="navigation">

                <form method="post" action="" id="select-form-navigation" class="select-navigation">
                    <ul id="indent-navigation">

                        <li>
                            {include file="$fullpath/dashboard_sidebar_nav.tpl" title="Dashboard Navigation"}
                        </li>

                    </ul>
                </form>

                {** Better use this independent div here, instead of a li, which interfers badly with the mbContainer js **}
                <div class="main-help">
                    <button id="iopen" class="help" onclick='if($("#cont1").get(0).isClosed) $("#cont1").containerize("open",500); else $("#cont1").containerize("close",500);'><img src="{$thispath}/img/help_blue.png" alt="help" /></button>
                </div>

            </nav>

        </div>
    </header>
