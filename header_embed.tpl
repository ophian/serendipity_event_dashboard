{*** header_embed.tpl - last modified 2012-12-16 ***}
    <header>
        <div class="dashboard_header">
            <div id="nav-welcome">
                <h2><span><img src="{$thispath}/img/s9y4.png" alt="s9y">{$s9yheader.0.welcome}</span></h2>

                <div id="nav-info" class="visuallyhidden">
                    <span class="msg_notice"><span class="icon-info-circle"></span> {$CONST.PLUGIN_DASHBOARD_AUTOUPDATE_NOTE}</span>
                </div>
            </div>

            <div id="nav-embed-switch">
                <ul class="clearfix horizontal">
                {if $dpdc_plugin_av && $showElementUpdate && $show_dpdc_note}
                    <li><span id="menu-autoupdate" class="text-icon" title="Click: Important Info!"><span class="icon-info-circle"></span><span class="visuallyhidden"> Click: Important Info!</span></span></li> {* i18n *}
                {/if}
                    <li><span id="menu-fadenav" class="text-icon slidenav" title="{$CONST.ADMIN_FRONTPAGE} {$CONST.PLUGIN_DASHBOARD_TITLE}"><span class="icon-resize-full-alt"></span><span class="visuallyhidden"> {$CONST.ADMIN_FRONTPAGE} {$CONST.PLUGIN_DASHBOARD_TITLE}</span></span>
                        {* <img id="menu-fadenav" class="slidenav" src="{$thispath}/img/switch128.png" width="64" height="64" alt="slidenav" title="{$CONST.ADMIN_FRONTPAGE} {$CONST.PLUGIN_DASHBOARD_TITLE}"> *}
                    </li>
                </ul>
            </div>

            <div id="nav-navigation-select" class="visuallyhidden">
                <form id="select-form-navigation" class="select-navigation" method="post" action="{$serendipityBaseURL}">
                    <div id="indent-navigation">
                    {include file="$fullpath/dashboard_sidebar_nav.tpl" title="Dashboard Navigation"}
                    </div>
                </form>
                {** Better use this independent div here, instead of a li, which interfers badly with the mbContainer js **}
                <div class="main-help">
                    <button id="iopen" class="help" onclick='if($("#cont1").get(0).isClosed) $("#cont1").containerize("open",500); else $("#cont1").containerize("close",500);'><span class="icon-help-circle"></span><span class="visuallyhidden">Help</span></button>{* i18n *}
                </div>
            </div>
        </div>
    </header>
