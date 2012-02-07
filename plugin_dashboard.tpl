{*** plugin_dashboard.tpl 2011-03-25 - last modified 2012-02-06 ***}
{*** debug ***}

<div id="dashboard" class="clearfix maincontent">

{if NOT $start}
    <header role="banner">
        <div class="clearfix">
            <div id="head">
                <h1>The Serendipity Backend {$CONST.PLUGIN_DASHBOARD_TITLE} </h1>
                <h2>{$sysinfo.self_info} </h2>
            </div>
            
            <nav id="user-menu-left" role="navigation">
                <h2><span>{$s9yheader.0.welcome}</span></h2>

                <div id="nav-frontpage">
                    <div id="start_1" class="dashboard dashboard_personal">
                        <ul class="clearfix">
                            <li><a id="menu-001" href="?serendipity[adminModule]=start">{$CONST.ADMIN_FRONTPAGE} {$CONST.PLUGIN_DASHBOARD_TITLE}</a></li>
                            <li><a id="menu-002" href="serendipity_admin.php?serendipity[adminModule]=personal">{$CONST.PERSONAL_SETTINGS}</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <nav id="user-menu-left-bottom" role="navigation">

                <button id="iopen" class="navi"><span class="inline"><img src="{serendipity_getFile file="img/plus.png"}" id="nav_1" class="wizard-img" alt="+/-" /></span>  Navigation </button>
                <button id="iopen" class="help" onclick="$('.containerPlus').mb_open();"><img src="{$thispath}/img/help_blue.png" alt="help" /></button>

                {include file="$fullpath/dashboard_sidebar_nav.tpl" title="Dashboard Sample Navigation"}
                
                <h2><span>{$CONST.PLUGIN_DASHBOARD_SYS}</span></h2>

                {if $showCleanupSmarty}
                <div id="nav-cleanup">
                    <div id="sort_{$cleanup_block_id}" class="dashboard dashboard_cleansmarty">

                        <ul class="clearfix">
                            <li><a href="?serendipity[noSidebar]=1&amp;serendipity[noBanner]=1&amp;serendipity[action]=admin&amp;serendipity[dashboard_event]=capct&amp;{$urltoken}" onclick="return confirm('{$CONST.PLUGIN_DASHBOARD_CLEANUP_CONFIRM}')"> {$CONST.PLUGIN_DASHBOARD_CLEANSMARTY} </a> [<span class="small">{$CONST.PATH_SMARTY_COMPILE}</span>]</li>
                            <li><a href="?serendipity[adminModule]=plugins&amp;serendipity[plugin_to_conf]={$plugininstance}" class="pluginmanager_configure"><img alt="[C]" src="{serendipity_getFile file="admin/img/configure.png"}" /> {$sysinfo.title} Plugin [<span class="small">{$sysinfo.dashboard_version}</span>]</a></li>
                        </ul>

                    </div>
                </div>
                {/if}

            </nav>

            <nav id="user-menu-right" role="navigation">
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
{/if}

{if !empty($errormsg)}
    <section id="s9y-error">
        <div class="dashboard dashboard_error">
            <p class="serendipityAdminMsgError serendipity_backend_msg_notice"><img class="attention" src="{serendipity_getFile file="admin/img/admin_msg_note.png"}" alt="" />{$errormsg}</p>
        </div>
    </section>
{/if}
    
{foreach from=$elements key="k" item="v" name=elecom}
    {if $v != 'draft' AND $v != 'future' AND $v != 'update' AND $v != 'plugup' AND $v != 'clean'}
    {include file="$fullpath/block_$v.tpl" title="Dashboard $v Notifier"}
    {/if}
{/foreach}

    <section id="entries" class="block-entries-main">
{foreach from=$elements key="k" item="v" name=eleent}
    {if $v == 'draft' OR $v == 'future'}
    {include file="$fullpath/block_$v.tpl" title="Dashboard $v Notifier"}
    {/if}
{/foreach}
    </section>

    <section id="updates" class="block-updates-main">
{foreach from=$elements key="k" item="v" name=eleupd}
    {if $v == 'update' OR $v == 'plugup'}
    {include file="$fullpath/block_$v.tpl" title="Dashboard $v Notifier"}
    {/if}
{/foreach}
    </section>

{if NOT $start}
    <footer role="footer">
        <div class="clearfix"> <h1> <small>{$smarty.now|date_format} - {$sysinfo.version_info}</small> </h1> </div>
    </footer>
{/if}
    
<div class="helpwrapper">
  <div id="modalContainer" class="containerPlus draggable {ldelim}buttons:'c', skin:'white', width:'900', height:'450', closed:'true', title:'dashboard premier help container'{rdelim}" style="margin: auto;">
    <div class="evidence">
      <h3>Serendipity Dashboard Help Container ()!</h3>

        <ul><strong>ToDo: </strong>
            <li class="checked">nav button with plus/minus img!</li>
            <li class="checked">Check $admin_vars to be readable by dashbords side-navbar! This is necessary in different perms!</li>
            <li class="checked">Check dashboard elements show up by permission only!</li>
            <li class="checked">Make sequence order change fit into rows and cells!</li>
            <li class="checked">Build & rewrite the halfbox sections to divs, to stick to a certain Layout!</li>
            <li class="checked">What happens if having differing total halfbox divs?</li>
            <li class="checked">Build real cleanup (compiled templates) function & link with questionaire!</li>
            <li class="checked">Some more sysinfo?, or what to do with left-menu-bottom-space?</li>
            <li class="checked">Reengineer Bayes Plugin hook via js for pending comments - AFAP</li>
            <li class="checked">Let Smarty do the entry|truncating. Do not assign entries doubled!</li>
            <li></li>
            <li>Comment entry shadow for IE!</li>
            <li>Header Comment line have more truncation or how to reap for smaller screens.</li>
            <li>Convert serendipityPrettyButtons to real buttons?</li>
            <li>Finish bayes plugin hook engineering if possible. There is a bug concerning the old bayes js! <br />What about covering bayes for other sections too?</li>
            <li>Build poping up multiple help screens to differend themes, or one big main, seperated by columns?</li>
            <li>Make CSS really have fluid grid layout!</li>
            <li>General code and CSS cleanup! (add :focus, rename ids & classes to semantic, not positional names, ...)</li>
            <li></li>
            <li>ToDo: next release, open (some) "edit-entry-links" inside the dashboard via modalContainer....?</li>
            <li>ToDo: (?) make dashboard css color customizing navbar tool ....?</li>
            <li>ToDo: next release, make all boxes jquery mbContainer like....?</li>
            <li>React on full dashboard and framed dashboard (see first link); Build option if done! (?)</li>
        </ul>

    </div>
    
    <p>Maybe use div {ldelim} column-width: 26em; column-gap: 1.6em; column-rule: thin dotted black; {rdelim} ... to have multiple Infos ordered in cells ...</p>
    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Cras metus. Maecenas justo elit, lacinia sit amet, cursus ut, sagittis sed, eros. Suspendisse potenti. Maecenas nec nisi. Donec vestibulum sollicitudin tellus. Sed consequat pellentesque ante. Vestibulum turpis quam, vulputate nec, nonummy convallis, ultrices congue, ligula. Ut rutrum leo et orci. Proin pharetra. Nam non sem ut eros fringilla ornare. In ullamcorper lorem eget ipsum. Suspendisse semper enim in arcu cursus consectetuer. Suspendisse potenti. Proin libero eros, adipiscing quis, volutpat in, ultrices ut, lacus.</p>
    <p>Nulla facilisi. Vestibulum vel magna in ante lobortis semper. Integer posuere justo et urna. Vestibulum sit amet sapien ut quam tempor fringilla. Fusce a neque a enim mattis dapibus. Ends with a paragraph element!</p>

    <div style="text-align:right; width:100%; margin-top:20px;"><button id="close" onclick="$('#modalContainer').mb_close();">close</button></div>

  </div>
</div>

</div><!-- //#id: dashboard end -->
