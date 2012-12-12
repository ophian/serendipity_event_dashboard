{*** header_embed.tpl - last modified 2012-12-12 ***}

    <header role="banner">
        <div class="dashboard_header">
            <nav id="nav-welcome" role="navigation">
                <h2><span><img src="{$thispath}/img/s9y4.png" alt="logo">{$s9yheader.0.welcome}</span></h2>

                <div id="boxed_autoupdate" class="visuallyhidden"><p><img class="attention" src="{serendipity_getFile file='admin/img/admin_msg_note.png'}" alt="" /> {$CONST.PLUGIN_DASHBOARD_AUTOUPDATE_NOTE}</p></div>
            </nav>

            <nav id="nav-embed-switch" role="navigation">
                 <ul class="clearfix">
                {if $dpdc_plugin_av && $showElementUpdate && $show_dpdc_note}
                   <li><span id="menu-autoupdate" class="text-icon text-icon-notifications" alt="[U]" title=" &#187; click: Important Info! &#171; "></span></li>
                {/if}
                   <li><img id="menu-fadenav" class="slidenav" src="{$thispath}/img/switch128.png" width="64" height="64" alt="slidenav" title="{$CONST.ADMIN_FRONTPAGE} {$CONST.PLUGIN_DASHBOARD_TITLE}" /></li>
                </ul>
            </nav>

            <nav id="nav-navigation-select" class="visuallyhidden" role="navigation">

                <form method="post" action="{$serendipityBaseURL}" id="select-form-navigation" class="select-navigation">
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
