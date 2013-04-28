{*** plugin_dashboard.tpl - last modified 2013-04-28 ***}
{*** debug ***}

<div id="dashboard" class="maincontent">

{include file="$fullpath/header_embed.tpl" title="Dashboard Embedded Header"}

{if !empty($errormsg)}
    <section id="s9y-error">
        <div class="dashboard dashboard_error">
            <p class="serendipityAdminMsgError serendipity_backend_msg_notice"><img class="attention" src="{serendipity_getFile file='admin/img/admin_msg_note.png'}" alt="" />{$errormsg}</p>
        </div>
    </section>
{/if}

{if !$secgroupempty}
<section id="layout" class="overlay">

<ul id="meta-box-left" class="boxed-left meta-box">
{* show UI-preset values in meta-box-left, else show rest elements compared to block-right *}
{if $metaset[0] == 'meta-box-left'}
  {foreach from=$metaset[1] key=keyle item="lelem" name="metaset_left"}
    {foreach from=$lelem key=key item=val name="block_element_left"}
      {if ($key === 0)}{assign var="element" value=$val}{/if}
      {if ($key === 1)}{assign var="blockname" value=$val}{/if}
      {if $smarty.foreach.block_element_left.last && !empty($blockname)}

  <li id="{$element}" class="flipflop">{include file="$fullpath/block_$blockname.tpl" title="Dashboard $blockname Notifier"}</li>

      {/if}
    {/foreach}
  {/foreach}
{else}
  {foreach from=$block_elements key=lkey item=lvalue name=block_elements_left}

  <li id="elem_{$lkey}" class="flipflop php-left-sort_{$lkey}">{include file="$fullpath/block_$lvalue.tpl" title="Dashboard $lvalue Notifier"}</li>

  {/foreach}
{/if}
{* ON START show elements - grouped by element / 2 - left group *}
{if !is_array($metaset) || empty($metaset)}
  {foreach from=$elements key=lkey item=lvalue name=elements_left}
    {if $lkey < $countelements}

  <li id="elem_{$lkey}" class="flipflop php-element-sort_{$lkey}">{include file="$fullpath/block_$lvalue.tpl" title="Dashboard $lvalue Notifier"}</li>

    {/if}
  {/foreach}
{/if}

</ul>

<ul id="meta-box-right" class="boxed-right meta-box">
{* show UI-preset values in meta-box-right, else show rest elements compared to block-leftt *}
{if $metaset[0] == 'meta-box-right'}
  {foreach from=$metaset[1] key=keyre item="relem" name="metaset_right"}
    {foreach from=$relem key=key item=val name="block_element_right"}
      {if ($key === 0)}{assign var="element" value=$val}{/if}
      {if ($key === 1)}{assign var="blockname" value=$val}{/if}
      {if $smarty.foreach.block_element_right.last && !empty($blockname)}

  <li id="{$element}" class="flipflop">{include file="$fullpath/block_$blockname.tpl" title="Dashboard $blockname Notifier"}</li>

      {/if}
    {/foreach}
  {/foreach}
{else}
  {foreach from=$block_elements key=rkey item=rvalue name=block_elements_right}

  <li id="elem_{$rkey}" class="flipflop php-right-sort_{$rkey}">{include file="$fullpath/block_$rvalue.tpl" title="Dashboard $rvalue Notifier"}</li>

  {/foreach}
{/if}
{* ON START show elements - grouped by element / 2 - right group *}
{if !is_array($metaset) || empty($metaset)}
  {foreach from=$elements key=rkey item=rvalue name=elements_right}
    {if $rkey >= $countelements}

  <li id="elem_{$rkey}" class="flipflop php-element-sort_{$rkey}">{include file="$fullpath/block_$rvalue.tpl" title="Dashboard $rvalue Notifier"}</li>

    {/if}
  {/foreach}
{/if}

</ul>

</section>
{/if}

{if $secgroupempty}
<section id="s9y-error">
    <div class="dashboard dashboard_error">
        <p class="serendipity_backend_msg_notice">{$CONST.PLUGIN_DASHBOARD_MARK}</p>
    </div>
</section>

{/if}

 <div id="mbc_wrapper" class="helpwrapper">

  <div id="cont1" class="container" style="top: 240px; left: 240px; width: 800px; height: 400px;" data-drag=true data-collapse=true data-close=true data-containment="document" data-modal=true>
    <h2><img class="icon" src="{$thispath}/img/s9y4.png"> Serendipity Dashboard [v.{$sysinfo.this_v}] Development Gazette!</h2>

    <p>This is a "<em>proof of concept</em>" Dashboard screen for your Serendipity blog backend section. All editable links, as of now, are passed to their original target, as long as this is just a an experimental welcome and information screen. Please pass your suggestions and experiences to the <a href="http://board.s9y.org/viewtopic.php?f=4&t=18863" target="_blank">serendipity forum</a>.</p>
    <p style="font: italic normal lighter 0.9em/1.2em 'Courier New','DejaVu Sans Mono','Bitstream Vera Sans Mono',monospace;">If you ever experience weired screen layout issues or discover some other unwanted scripting behaviour, do a [Shift] + [Strg] + [r] or [Strg] + [F5] first, to avoid caching or loading issues.

    <ul><strong>ToDo: </strong>
        <li class="checked">nav button with plus/minus img! </li>
        <li class="checked">Check $admin_vars to be readable by dashboards side-navbar! This is necessary in different perms! </li>
        <li class="checked">Check dashboard elements show up by permission only! </li>
        <li class="checked">Make sequence order change fit into rows and cells! </li>
        <li class="checked">Build & rewrite the halfbox sections to divs, to stick to a certain Layout! </li>
        <li class="checked">What happens if having differing total halfbox divs? </li>
        <li class="checked">Build real cleanup (compiled templates) function & link with questionaire! </li>
        <li class="checked">Some more sysinfo?, or what to do with left-menu-bottom-space? </li>
        <li class="checked">Reengineer Bayes Plugin hook via js for pending comments - AFAP </li>
        <li class="checked">Let Smarty do the entry|truncating. Do not assign entries doubled! Hide fulltext by default </li>
        <li class="checked">CSS add :focus </li>
        <li class="checked">Header Comment line have more truncation or how to reap for smaller screens (?) </li>
        <li class="checked">Comment entry shadow for IE! </li>
        <li class="checked">Rename CSS ids & classes to be semantic, not as positional names, if possible ['not sure about these nav ones']...! </li>
        <li class="checked">Better comment constant titles </li>
        <li class="checked">Convert serendipityPrettyButtons to real (looking) buttons including images (?) </li>
        <li class="checked">Convert sidebar / popout-on-click / to dropdown selectboxes & moved help as Proof-of-Concept </li>
        <li class="checked">New embed mode including navigation switch </li>
        <li class="checked">Header links to buttons, as new default design embed quicklink box - without old link and bookmark box content </li>
        <li class="checked">Finish bayes plugin hook engineering, if possible. Depends on bayes v. 0.4.7! </li>
        <li class="checked">Check if bayes is installed, before include js and vars and assign to </li>
        <li class="checked">Change fetchTemplatePath() to native parseTemplate() (needs s9y v. to be >= 1.3, but we are 1.6 already) </li>
        <li class="checked">Fixed and changed VersionCompare to native version_compare() </li>
        <li class="checked">Added some Constants, replaced logoff GUI-button and minors  </li>
        <li class="checked">Fixed plugininstance non object error in case of disabled CleanCompiles Sec </li>
        <li class="checked">Fixed sequence elements be still marked if un-marked and submit all elements in config </li>
        <li class="checked">Fixed N/A notices in case of missing blocks </li>
        <li class="checked">Added JQuery.cookie support for sidebar/selectbar as session cookie </li>
        <li class="checked">Update to modernizr-2.5.3.custom.min.js and JQuery-1.7.2.min.js </li>
        <li class="checked">Use async attribute for the script tags in HTML5, optimized script loading sort (hopefully) </li>
        <li class="checked">Update to JQuery-ui-1.8.21.custom.min.js and minified mbContainer.min.js </li>
        <li class="checked">Added note for available dependency event plugin autoupdate </li>
        <li class="checked">Changed comments header in markup, CSS, JQuery to fit the toggling to new markup - opacity to comments colours </li>
        <li class="checked">Plastined iconbar css and changed last added icon for the Plugin availability note </li>
        <li class="checked">Enhanced path includement setting </li>
        <li class="checked">Fixed wrong constant if(), removed fullpath option and minor tweaks </li>
        <li class="checked">Added info-box-screen as an overview - depending also on freetag and the bayes plugins - default to show true</li>
        <li class="checked">Boxed pending and approved comments into the 2-Column layout </li>
        <li class="checked">Added all flip box button in box header via JQuery/CSS </li>
        <li class="checked">Improved box and CSS layout - mainly in comments </li>
        <li class="checked">Added Bayes rating to pending comments </li>
        <li class="checked">Added config option to disable update plugin availability note - default to show true </li>
        <li class="checked">Consistently Constant PLUGIN_DASHBOARD_* use - except core constants </li>
        <li class="checked">Added s9y.org Blog Feed Info box screen - default to show true </li>
        <li class="checked">Added frontend 'maintenance mode' on core updates - unfinished </li>
        <li class="checked">Added UI custom titles and support drag changes </li>
        <li class="checked">Added UI to support draggable(), droppable(), sortable() directly </li>
        <li class="checked">Holds UI-dragged, UI-dropped and UI-sorted item settings on page return </li>
        <li class="checked">Holds toggle state of block items on page return by cookie </li>
        <li class="checked">Update to modernizr-2.6.1 and developer version of mb.containerPlus 3.0 (mid July'12) </li>
        <li class="checked">Moved all relevant Constants to &lt;en&gt; and &lt;de&gt; lang files </li>
        <li class="checked">Update to JQuery 1.8.0 and JQuery-ui-1.8.22 </li>
        <li class="checked">Removed 'Beta' from autoupdate, as not provided any more.... (we never did, but we had nighlies...) </li>
        <li class="checked">Simplified element blocks to all moveable blocks only and moved clean(up) to seperate in config </li>
        <li class="checked">To avoid heavy load in dynamic serendipity_admin.css, I removed the dashboard css to a fixed version. </li>
        <li class="checked">Removed metadata.js and changed HTML5 async to defer load </li>
        <li class="checked">Fixed version_compare() update check to alert on new version only </li>
        <li class="checked">Added some PHPDoc documentary </li>
        <li class="checked">Some code and CSS cleanup and js event finetuning </li>
        <li class="checked">Make CSS really have fluid grid layout! </li> 
        <li class="checked">CSS small tablet portrait Mode (600x800) should work by default. All underneath is mobile view! </li>
        <li class="checked">Added some Mobile portrait (320x480) and Mobile landscape (max width 450) Media Queries w/o finetuning </li>
        <li class="checked">Finished service Maintenance Mode and set strong remember-me cookie, while in set </li>
        <li class="checked">Get some structure into lang files </li>
        <li class="checked">Added .htaccess file with rewrite rule to view documentation_&lsaquo;lang&rsaquo;.html file, if any </li>
        <li class="checked">Added UTF-8 &lsaquo;en&rsaquo; lang file </li>
        <li class="checked">Some IE9 fixes (CSS, JS, fetch references) and finally dropped support for everything less than IE9 </li>
        <li class="checked">For User Level Dashboards UI, the drag and drop storing has changed to support cookie values by Userlevel client </li>
        <li class="checked">Fixing jQuery Cookies to be more specific </li>
        <li class="checked">Fixing Cookies back to flat array string[], as Chrome and IE9 denied supporting multidimensional array cookies </li>
        <li class="checked">Some more Chrome and small IE9 fixes </li>
        <li class="checked">Better secured Maintenance Mode and animated Button blink, if set true (FF only to now) </li>
        <li class="checked">Update to jquery-ui-1.8.23.custom.min.js and jquery-1.8.1.min.js </li>
        <li class="checked">Added CSS body max-width: 1280px; </li>
        <li class="checked">Fixed PHP browser close, while in maintenance mode, did not allow to log-in again </li>
        <li class="checked">Fixed CSS font size issue in normal backend pages and did some selector renaming </li>
        <li class="checked">Fixed JS issue after drag&drop and tooltip by first element, hovering scrollbar flip until reload </li>
        <li class="checked">Added all browser non-noisy animation to button maintenance mode, if set to true </li>
        <li class="checked">Fixed Chrome browser select/option function - this entails the navigation selects to have an empty start option field ... </li>
        <li class="checked">The Info Box now shows a count(all) to adminUsers only, else the count is strict done by userid </li>
        <li class="checked">Fixed Maintenance Mode Super-Cookie to survive a browser close </li>
        <li class="checked">Reduced clear compiled templates function to clear $serendipity['template'] only, as the following recompile could cause a servers memory exhaustment in case of installed gravatar event plugin cache </li>
        <li></li>
        <li>Add some more maintenance, like size of spamblock log, or hint to install DBClean plugin (?) </li>
        <li>Move help box button into embed mode navigation bar or design box (?) </li>
        <li>Build poping up multiple help screens to different help content, or one big main, seperated by columns (?) </li>
        <li>Write help screen(s) content! </li>
        <li class="discard">Shall the overview box only show information amounts by user (?) </li>
        <li class="discard">Include old link and bookmark box content to select box, when opening selectbox navigation (?) </li>
        <li class="discard">Move Meta-Box-Left Boxes to Mobile-1-Column Layout via JQuery (?) </li>
        <li class="discard">Add Multi Browser support. At the moment this is designed with current FF only... </li>
        <li></li>
        <li>ToDo: Add flexible hook-in box (event hook) ability by Plugins! </li>
        <li>ToDo: Set remember-me cookie while in maintenance mode to be kept over browser close, as the original function does! </li>
        <li>ToDo: Ask Spartacus Plugup functions, if there is an upgrade plugin array available and not empty...! </li>
        <li>ToDo: Rewrite for Smarty3 and S9y 1.7! </li>
        <li>ToDo: Bind select navigation to JQuery-UI - (js-navigation, ui-customizable, flexible) (?) </li>
        <li>ToDo: Bind autoupdate plugin to dashboard and write a install GUI if possible (?) </li>
        <li>ToDo: Hold feed cached for one day... (?) </li>
        <li>ToDo: Open (some) "common edit-entry-links" inside the dashboard via modalContainer... (?) </li>
        <li>ToDo: Make a dashboard css color customizing navbar tool ... (?) </li>
        <li>ToDo: Rewrite with new backend (2.0) smartification (some day) </li>
    </ul>

    <p>Maybe use div {ldelim} column-width: 26em; column-gap: 1.6em; column-rule: thin dotted black; {rdelim} ... to have multiple Infos ordered in cells ...</p>
    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Cras metus. Maecenas justo elit, lacinia sit amet, cursus ut, sagittis sed, eros. Suspendisse potenti. Maecenas nec nisi. Donec vestibulum sollicitudin tellus. Sed consequat pellentesque ante. Vestibulum turpis quam, vulputate nec, nonummy convallis, ultrices congue, ligula. Ut rutrum leo et orci. Proin pharetra. Nam non sem ut eros fringilla ornare. In ullamcorper lorem eget ipsum. Suspendisse semper enim in arcu cursus consectetuer. Suspendisse potenti. Proin libero eros, adipiscing quis, volutpat in, ultrices ut, lacus.</p>
    <p>Nulla facilisi. Vestibulum vel magna in ante lobortis semper. Integer posuere justo et urna. Vestibulum sit amet sapien ut quam tempor fringilla. Fusce a neque a enim mattis dapibus. Ends with a paragraph element!</p>
    
    <p>Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. </p>
    <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Aenean lacinia bibendum nulla sed consectetur. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue. </p>
    <p>Maecenas sed diam eget risus varius blandit sit amet non magna. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. </p>
    
  </div><!-- //#id: cont1 end -->

  <div id="dock"></div>
  
 </div><!-- //#id: mbc_wrapper end -->

</div><!-- //#id: dashboard end -->
