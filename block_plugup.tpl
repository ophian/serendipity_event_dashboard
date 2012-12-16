{*** block_plugup.tpl - last modified 2012-12-16 ***}

{if $showElementPlugup}
<div id="plugup" class="block-updates block-box clearfix">
	<div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><span class="visuallyhidden">{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}</span><br></div>

    <h3 class="flipbox"><span>{$CONST.PLUGIN_DASHBOARD_UPDATE_BLOCKTITLE} ?</span></h3>

    <div id="sort_{$plugup_block_id}" class="block-content block-content-plugup">
    {$plugup_hook_note|default:'<div id="notifier" class="single"><p> N/A </p></div>'}
    </div>
</div>
{/if}
