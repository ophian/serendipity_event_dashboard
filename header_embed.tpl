{*** header_embed.tpl - last modified 2012-06-22 ***}

    <header role="banner">
        <div class="clearfix">
            <nav id="user-menu-user-welcome" role="navigation">
                <h2><span><img src="{$thispath}/img/s9y4.png" alt="logo">{$s9yheader.0.welcome}</span></h2>

                <div id="boxed_autoupdate" class="visuallyhidden"><p><img class="attention" src="{serendipity_getFile file='admin/img/admin_msg_note.png'}" alt="" /> {$CONST.DASHBOARD_AUTOUPDATE_NOTE}</p></div>
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
                   <li><span id="menu-autoupdate" class="text-icon text-icon-notifications" alt="[U]" title=" &#187; click: Important Info! &#171; "></span>{* <img id="menu-autoupdate" class="autoupdate" src="{$thispath}/img/emarkred54.png" width="21" height="54" alt="[U]" title=" &#187; Click: Important Info! &#171; " /> *}</li>
                {/if}
                   <li><img id="menu-fadenav" class="slidenav" src="{$thispath}/img/switch128.png" width="64" height="64" alt="slidenav" title="{$CONST.ADMIN_FRONTPAGE} {$CONST.PLUGIN_DASHBOARD_TITLE}" /></li>
                </ul>
            </nav>

            <nav id="user-menu-user-navigation-select" class="visuallyhidden" role="navigation">

                <form method="post" action="" id="select-form-navigation" class="select-navigation">
                    <ul id="indent-navigation">

                        <li>
                        {*** ENTRY LINKS START ***}
                        {if 'adminEntries'|checkPermission OR 'adminEntriesPlugins'|checkPermission}

                            <h3>{$CONST.ADMIN_ENTRIES}</h3>
                            {include file="$fullpath/select_nav_entries.tpl" title="Dashboard Nav Entries"}

                        {/if}
                        {*** ENTRY LINKS END ***}
                        </li>

                        <li>
                        {*** MEDIA LINKS START ***}
                        {if 'adminImages'|checkPermission}

                            <h3>{$CONST.MEDIA}</h3>
                            {include file="$fullpath/select_nav_media.tpl" title="Dashboard Nav Media"}

                        {/if}

                        {*** MEDIA LINKS END ***}
                        </li>

                        <li>
                        {*** APPEARANCE START ***}
                        {if 'adminTemplates'|checkPermission OR 'adminPlugins'|checkPermission}

                            <h3>{$CONST.APPEARANCE}</h3>
                            {include file="$fullpath/select_nav_appearance.tpl" title="Dashboard Nav Appearance"}

                        {/if}
                        {*** APPEARANCE END ***}
                        </li>

                        <li>
                        {*** USER MANAGEMENT START ***}
                        {if 'adminUsersGroups'|checkPermission OR 'adminImport'|checkPermission OR 'siteConfiguration'|checkPermission OR 'blogConfiguration'|checkPermission OR 'adminUsers'|checkPermission}

                            <h3>{$CONST.ADMIN}</h3>
                            {include file="$fullpath/select_nav_usma.tpl" title="Dashboard Nav UserManagement"}

                        {/if}
                        {*** USER MANAGEMENT END ***}
                        </li>

                    </ul>
                </form>

                {** Better use this independent div floating right here, as a li, which interfers badly with the mbContainer js **}
                <div class="main-help">
                    <button id="iopen" class="help" onclick="$('.containerPlus').mb_open();"><img src="{$thispath}/img/help_blue.png" alt="help" /></button>
                </div>

            </nav>

        </div>
    </header>