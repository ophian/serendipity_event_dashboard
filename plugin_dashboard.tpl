{*** plugin_dashboard.tpl - last modified 2012-06-10 ***}
{*** debug ***}

<!--[if gte IE 9]>
  <style type="text/css">
    .gradient {ldelim}
       filter: none;
    {rdelim}
  </style>
<![endif]-->

<div id="dashboard" class="clearfix maincontent">

{if NOT $start}
    {** fullview temporary disabled, until future purposes... **}
    {** include file="$fullpath/header_full.tpl" title="Dashboard Full Header" **}
    {include file="$fullpath/header_embed.tpl" title="Dashboard Embedded Header"}
{else}
    {include file="$fullpath/header_embed.tpl" title="Dashboard Embedded Header"}
{/if}


{if !empty($errormsg)}
    <section id="s9y-error">
        <div class="dashboard dashboard_error">
            <p class="serendipityAdminMsgError serendipity_backend_msg_notice"><img class="attention" src="{serendipity_getFile file='admin/img/admin_msg_note.png'}" alt="" />{$errormsg}</p>
        </div>
    </section>
{/if}
    
{assign var="empty_comments" value=true}
{assign var="empty_entries" value=true}
{assign var="empty_updates" value=true}

{foreach from=$elements item="element" name="block_element"}
    {foreach from=$block_elements.comments item="comment" name="bco"}
        {if $comment == $element}
            {include file="$fullpath/block_$element.tpl" title="Dashboard $element Notifier"}
            {assign var="empty_comments" value=false}
        {/if}
    {/foreach}
    {if $empty_comments == true}
    {if $smarty.foreach.block_element.last && !$secgroupempty}<div class="empty_notice">{$CONST.PLUGIN_DASHBOARD_NA|sprintf:"comment_pending":"comments"}</div>{/if}
    {/if}
{/foreach}

    <section id="entries" class="block-entries-main">
{foreach from=$elements item="element" name="block_element"}
    {foreach from=$block_elements.entries item="entry" name="ben"}
        {if $entry == $element}
            {include file="$fullpath/block_$element.tpl" title="Dashboard $element Notifier"}
            {assign var="empty_entries" value=false}
        {/if}
    {/foreach}
    {if $empty_entries == true}
    {if $smarty.foreach.block_element.last && !$secgroupempty}{$CONST.PLUGIN_DASHBOARD_NA|sprintf:"draft":"future"}{/if}
    {/if}
{/foreach}
    </section>

    <section id="updates" class="block-updates-main">
{foreach from=$elements item="element" name="block_element"}
    {foreach from=$block_elements.updates item="update" name="bup"}
        {if $update == $element}
            {include file="$fullpath/block_$element.tpl" title="Dashboard $element Notifier"}
            {assign var="empty_updates" value=false}
        {/if}
    {/foreach}
    {if $empty_updates == true}
    {if $smarty.foreach.block_element.last && !$secgroupempty}{$CONST.PLUGIN_DASHBOARD_NA|sprintf:"update":"plugup"}{/if}
    {/if}
{/foreach}
    </section>

{if $secgroupempty}
    <div class="serendipity_backend_msg_notice">{$CONST.PLUGIN_DASHBOARD_MARK}</div>
{/if}

{** if NOT $start}
    // fullview temporary disabled, until future purposes...
    <footer role="footer">
        <div class="clearfix"> <h1> <small>{$smarty.now|date_format} - {$sysinfo.version_info}</small> </h1> </div>
    </footer>
{/if **}
    
<div class="helpwrapper">
  <div id="modalContainer" class="containerPlus draggable {ldelim}buttons:'c', skin:'white', width:'900', height:'450', closed:'true', title:'dashboard 0.7 (proof of concept) help container'{rdelim}" style="margin: auto;">
    <div class="evidence">
      <h3>The Serendipity Dashboard Help Container ()!</h3>

        <p>This is a "<em>proof of concept</em>" Dashboard screen for your Serendipity blog backend section. All editable links are passed to their original target, as long this is just a an experimental welcome and information screen. Please pass your suggestions and experiences to the <a href="http://board.s9y.org/viewtopic.php?f=10&t=18370" target="_blank">serendipity forum</a>, which excepts english too.</p>
        <p>Info: Dashboards's Bayes plugin buttons are still experimental, as long as not using the hook, which will need a new and compatible backend markup</p>

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
            <li class="checked">Finish bayes plugin hook engineering, if possible. Depends on bayes v. 0.4.7!</li>
            <li class="checked">Check if bayes is installed, before include js and vars and assign to</li>
            <li class="checked">Change fetchTemplatePath() to native parseTemplate() (needs s9y v. to be >= 1.3, but we are 1.6 already) </li>
            <li class="checked">Fixed and changed VersionCompare to native version_compare() </li>
            <li class="checked">Added some Constants, replaced logoff GUI-button and minors  </li>
            <li class="checked">Fixed plugininstance non object error in case of disabled CleanCompiles Sec </li>
            <li class="checked">Fixed sequence elements be still marked if un-marked and submit all elements in config </li>
            <li class="checked">Fixed N/A notices in case of missing blocks </li>
            <li></li>
            <li>Include old link and bookmark box content to select box, when opening selectbox navigation?</li>
            <li>Move help box button into embed mode design bar?</li>
            <li>Finish embed design mode to be compat with old admin theme?</li>
            <li>Build poping up multiple help screens to differend help content, or one big main, seperated by columns (?)</li>
            <li>Write help screen(s) content!</li>
            <li>Make CSS really have fluid grid layout!</li>
            <li>General code and CSS cleanup!</li>
            <li></li>
            <li>ToDo: next release, open (some) "edit-entry-links" inside the dashboard via modalContainer... (?)</li>
            <li>ToDo: next release, make dashboard css color customizing navbar tool ... (?)</li>
            <li>ToDo: next release, make all boxes jquery mbContainer like... (?)</li>
            <li>React on full dashboard and framed dashboard (see first link); Build option if done! (?)</li>
            <li>ToDo: rewrite with new backend smartification</li>
        </ul>

    </div>
    
    <p>Maybe use div {ldelim} column-width: 26em; column-gap: 1.6em; column-rule: thin dotted black; {rdelim} ... to have multiple Infos ordered in cells ...</p>
    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Cras metus. Maecenas justo elit, lacinia sit amet, cursus ut, sagittis sed, eros. Suspendisse potenti. Maecenas nec nisi. Donec vestibulum sollicitudin tellus. Sed consequat pellentesque ante. Vestibulum turpis quam, vulputate nec, nonummy convallis, ultrices congue, ligula. Ut rutrum leo et orci. Proin pharetra. Nam non sem ut eros fringilla ornare. In ullamcorper lorem eget ipsum. Suspendisse semper enim in arcu cursus consectetuer. Suspendisse potenti. Proin libero eros, adipiscing quis, volutpat in, ultrices ut, lacus.</p>
    <p>Nulla facilisi. Vestibulum vel magna in ante lobortis semper. Integer posuere justo et urna. Vestibulum sit amet sapien ut quam tempor fringilla. Fusce a neque a enim mattis dapibus. Ends with a paragraph element!</p>

    <div style="text-align:right; width:100%; margin-top:20px;"><button id="close" onclick="$('#modalContainer').mb_close();">close</button></div>

  </div>
</div>

</div><!-- //#id: dashboard end -->
