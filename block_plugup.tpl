{*** block_plugup.tpl - last modified 2012-06-22 ***}

{if $showElementPlugup}
<div id="s9y-plugup" class="block-updates block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$CONST.PLUGIN_UPDATE_NOTIFIER}</span></h3>
    <div id="sort_{$plugup_block_id}" class="dashboard dashboard_plugup">
        {$plugup_hook_note}
        {* serendipity_plugin_api::hook_event('backend_pluginlisting_header', $serendipity['eyecandy']) *}
    </div>
</div>
{/if}


