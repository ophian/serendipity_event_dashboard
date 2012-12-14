{*** plugin_dashboard.tpl - last modified 2012-09-21 ***}
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

  <div id="cont1" class="container" style="top: 240px; left: 240px; width: 800px; height: 400px;" data-collapse=true data-close=true data-containment="document" data-modal=true data-getdata=true>
    <h2><img class="icon" src="{$thispath}/img/s9y4.png"> Serendipity Dashboard [v.{$sysinfo.this_v}] Development Gazette!</h2>
  </div> <!-- //#id: cont1 end -->

  <div id="cont2" class="container" style="top: 240px; left: 240px; width: 800px; height: 600px;" data-collapse=true data-close=true data-containment="document" data-modal=true>
    <h2><img class="icon" src="{$thispath}/img/s9y4.png"> Serendipity Dashboard [v.{$sysinfo.this_v}] Development - Backend Container!</h2>
  </div> <!-- //#id: cont2 end -->

  <div id="dock"></div>

 </div> <!-- //#id: mbc_wrapper end -->

</div> <!-- //#id: dashboard end -->
