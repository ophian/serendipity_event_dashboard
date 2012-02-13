{*** plugin_dashboard.tpl 2011-03-25 - last modified 2012-02-13 ***}
{*** debug ***}

<div id="dashboard" class="clearfix maincontent">

{if NOT $start}
    {** actually not really in use for now **}
	{include file="$fullpath/header_full.tpl" title="Dashboard Embedded Header"}
{else}
    {include file="$fullpath/header_embed.tpl" title="Dashboard Embedded Header"}
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
      <h3>The Serendipity Dashboard Help Container ()!</h3>

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
            <li class="checked">Let Smarty do the entry|truncating. Do not assign entries doubled! Hide fulltext by default</li>
            <li class="checked">CSS add :focus</li>
            <li class="checked">Header Comment line have more truncation or how to reap for smaller screens (?)</li>
            <li class="checked">Comment entry shadow for IE!</li>
            <li class="checked">Rename CSS ids & classes to be semantic, not as positional names, if possible ['not sure about these nav ones']...!</li>
            <li class="checked">Better comment constant titles</li>
            <li class="checked">Convert serendipityPrettyButtons to real (looking) buttons including images (?)</li>
            <li class="checked">Convert sidebar / popout-on-click / to dropdown selectboxes & moved help as Proof-of-Concept</li>
            <li class="checked">New embed mode including navigation switch</li>
            <li class="checked">Header links to buttons, as new default design embed quicklink box - without old link and bookmark box content</li>
            <li></li>
            <li>Include old link and bookmark box content to select box, when opening selectbox navigation?</li>
            <li>Move help box button into embed mode design bar?</li>
            <li>Finish embed design mode to be compat with old admin theme.</li>
            <li>Finish bayes plugin hook engineering, if possible. There is a bug concerning the old bayes js! <br />What about covering bayes for other sections too?</li>
            <li>Build poping up multiple help screens to differend themes, or one big main, seperated by columns (?)</li>
            <li>Make CSS really have fluid grid layout!</li>
            <li>General code and CSS cleanup!</li>
            <li></li>
            <li>ToDo: next release, open (some) "edit-entry-links" inside the dashboard via modalContainer... (?)</li>
            <li>ToDo: next release, make dashboard css color customizing navbar tool ... (?)</li>
            <li>ToDo: next release, make all boxes jquery mbContainer like... (?)</li>
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
