    {** actually not really in use for now **}
    <header role="banner">
        <div class="clearfix">
            <div id="head">
                <h1>The Serendipity Backend {$CONST.PLUGIN_DASHBOARD_TITLE} </h1>
                <h2>{$sysinfo.self_info} </h2>
            </div>
            
            <nav id="user-menu-user-welcome" role="navigation">
                <h2><span>{$s9yheader.0.welcome}</span></h2>

                <div id="nav-frontpage">
                    <div id="start_1" class="dashboard dashboard_personal">
                        <ul class="clearfix">
                            <li><a id="menu-001" href="?serendipity[adminModule]=start">{$CONST.ADMIN_FRONTPAGE} {$CONST.PLUGIN_DASHBOARD_TITLE}</a>{** v.[{$sysinfo.dashboard_version}] **}</li>
                            <li><a id="menu-002" href="serendipity_admin.php?serendipity[adminModule]=personal">{$CONST.PERSONAL_SETTINGS}{** [{$sysinfo.user} ({$sysinfo.perm})] **}</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <nav id="user-menu-user-navigation" role="navigation">

                <button id="iopen" class="navi"><span class="inline"><img src="{serendipity_getFile file='img/plus.png'}" id="nav_1" class="wizard-img" alt="+/-" /></span>  Navigation </button>
                <button id="iopen" class="help" onclick="$('.containerPlus').mb_open();"><img src="{$thispath}/img/help_blue.png" alt="help" /></button>

                {include file="$fullpath/dashboard_sidebar_nav.tpl" title="Dashboard Sample Navigation"}
                
                <h2><span>{$CONST.PLUGIN_DASHBOARD_SYS}</span></h2>

                {if $showCleanupSmarty}
                <div id="nav-cleanup">
                    <div id="sort_{$cleanup_block_id}" class="dashboard dashboard_cleansmarty">

                        <ul class="clearfix{* onebox *}">
                            <li><a href="?serendipity[noSidebar]=1&amp;serendipity[noBanner]=1&amp;serendipity[action]=admin&amp;serendipity[dashboard_event]=capct&amp;{$urltoken}" onclick="return confirm('{$CONST.PLUGIN_DASHBOARD_CLEANUP_CONFIRM}')"> {$CONST.PLUGIN_DASHBOARD_CLEANSMARTY} </a> [<span class="small">{$CONST.PATH_SMARTY_COMPILE}</span>]</li>
                            <li><a href="?serendipity[adminModule]=plugins&amp;serendipity[plugin_to_conf]={$plugininstance}" class="pluginmanager_configure"><img alt="[C]" src="{serendipity_getFile file='admin/img/configure.png'}" /> {$sysinfo.title} Plugin [<span class="small">{$sysinfo.dashboard_version}</span>]</a></li>
                        </ul>

                    </div>
                </div>
                {/if}

            </nav>

            <nav id="user-menu-user-linkbox" role="navigation">
                <h3> Serendipity </h3>
                <ul class="clearfix">
                    <li><span id="out"><a href="serendipity_admin.php?serendipity[adminModule]=logout">{$CONST.LOGOUT}</a></span></li>
                    <li><span id="btb"><a href="{$serendipityBaseURL}">{$CONST.BACK_TO_BLOG}</a></span></li>
                </ul>
                
                {if $s9yheader.0.show_links}
                <h4>{$s9yheader.0.links_title}</h4>
                <ul class="clearfix s9yheader">
                {foreach from=$s9yheader.0.links item=linkbox name=dshlink}
                    <li>{$linkbox}</li>
                {/foreach}
                </ul>
                {/if}
                {$s9yheader.0.more}
            </nav>

            </div>
    </header>
