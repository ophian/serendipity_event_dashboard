{*** plugin_dashboard.tpl - last modified 2013-01-18 ***}
{*** debug ***}
{* $smarty.request|print_r *}
<article id="dashboard" class="maincontent clearfix">
    {include file="$fullpath/header_embed.tpl" title="Dashboard Embedded Header"}

{if !empty($errormsg)}
    <div id="s9y-error">
        <div class="dashboard dashboard_error">
            <span class="msg_notice icon-attention-circle"> {$errormsg}</span>
        </div>
    </div>
{/if}

{if !$secgroupempty}
    <div id="layout" class="overlay">
        <div id="meta-box-left" class="boxed-left meta-box">
        {* show UI-preset values in meta-box-left, else show rest elements compared to block-right *}
    {if $metaset[0] == 'meta-box-left'}
        {foreach from=$metaset[1] key=keyle item="lelem" name="metaset_left"}
            {foreach from=$lelem key=key item=val name="block_element_left"}
            {if ($key === 0)}{assign var="element" value=$val}{/if}
            {if ($key === 1)}{assign var="blockname" value=$val}{/if}
            {if $smarty.foreach.block_element_left.last && !empty($blockname)}
            <section id="{$element}" class="flipflop">
            {include file="$fullpath/block_$blockname.tpl" title="Dashboard $blockname Notifier"}
            </section>
            {/if}
            {/foreach}
        {/foreach}
    {else}
        {foreach from=$block_elements key=lkey item=lvalue name=block_elements_left}
            <section id="elem_{$lkey}" class="flipflop php-left-sort_{$lkey}">
            {include file="$fullpath/block_$lvalue.tpl" title="Dashboard $lvalue Notifier"}
            </section>
        {/foreach}
    {/if}
    {* ON START show elements - grouped by element / 2 - left group *}
    {if !is_array($metaset) || empty($metaset)}
        {foreach from=$elements key=lkey item=lvalue name=elements_left}
            {if $lkey < $countelements}
            <section id="elem_{$lkey}" class="flipflop php-element-sort_{$lkey}">
            {include file="$fullpath/block_$lvalue.tpl" title="Dashboard $lvalue Notifier"}
            </section>
            {/if}
        {/foreach}
    {/if}
        </div><!-- //#id: meta-box-left end -->

        <div id="meta-box-right" class="boxed-right meta-box">
        {* show UI-preset values in meta-box-right, else show rest elements compared to block-leftt *}
    {if $metaset[0] == 'meta-box-right'}
        {foreach from=$metaset[1] key=keyre item="relem" name="metaset_right"}
            {foreach from=$relem key=key item=val name="block_element_right"}
            {if ($key === 0)}{assign var="element" value=$val}{/if}
            {if ($key === 1)}{assign var="blockname" value=$val}{/if}
            {if $smarty.foreach.block_element_right.last && !empty($blockname)}
            <section id="{$element}" class="flipflop">
            {include file="$fullpath/block_$blockname.tpl" title="Dashboard $blockname Notifier"}
            </section>
            {/if}
            {/foreach}
        {/foreach}
    {else}
        {foreach from=$block_elements key=rkey item=rvalue name=block_elements_right}
            <section id="elem_{$rkey}" class="flipflop php-right-sort_{$rkey}">
            {include file="$fullpath/block_$rvalue.tpl" title="Dashboard $rvalue Notifier"}
            </section>
        {/foreach}
    {/if}
    {* ON START show elements - grouped by element / 2 - right group *}
    {if !is_array($metaset) || empty($metaset)}
        {foreach from=$elements key=rkey item=rvalue name=elements_right}
            {if $rkey >= $countelements}
            <section id="elem_{$rkey}" class="flipflop php-element-sort_{$rkey}">
            {include file="$fullpath/block_$rvalue.tpl" title="Dashboard $rvalue Notifier"}
            </section>
            {/if}
        {/foreach}
    {/if}{* <section id="elem_9" class="flipflop php-element-sort_9">{include file="$fullpath/block_test.tpl" title="Dashboard test Notifier"}</section> *}
        </div><!-- //#id: meta-box-right end -->
    </div><!-- //#id: layout end -->
{/if}
{if $secgroupempty}
    <div id="s9y-error">
        <div class="dashboard dashboard_error">
            <span class="dashboard_msg_notice">{$CONST.PLUGIN_DASHBOARD_MARK}</span>
        </div>
    </div>
{/if}
    <div id="mbc_wrapper" class="helpwrapper">
        <div id="cont1" class="container" data-collapse=true data-close=true data-containment="document" data-modal=true>{*  data-getdata=true *}
            <h2><img class="icon" src="{$thispath}/img/s9y4.png"> Serendipity Dashboard [v.{$sysinfo.this_v}] Development Gazette!</h2>
            {include "./dashboard_gazette.html" cache_lifetime=86400} {*** one day: 60x60x24 ***}
        </div>

        <div id="cont2" class="container" data-collapse=true data-close=true data-containment="document" data-modal=true>
            <h2><img class="icon" src="{$thispath}/img/s9y4.png"> Serendipity Dashboard [v.{$sysinfo.this_v}] Development - Backend Container!</h2>
        </div>

        <div id="cont3" class="container" data-collapse=true data-close=true data-containment="document" data-modal=true>{*  data-getdata=true *}
            <h2><img class="icon" src="{$thispath}/img/s9y4.png"> Serendipity Dashboard Short Guide!</h2>
            <div class="autojs">{include "./ihelp.html" cache_lifetime=86400} {*** one day: 60x60x24 ***}</div>
        </div>

        <div id="dock"></div>
    </div>
</article> <!-- //#id: dashboard end -->
