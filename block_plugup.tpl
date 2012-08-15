{*** block_plugup.tpl - last modified 2012-08-15 ***}

{if $showElementPlugup}
  <div id="plugup" class="block-updates block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$CONST.PLUGIN_UPDATE_NOTIFIER}</span></h3>
    <div id="sort_{$plugup_block_id}" class="dashboard dashboard_plugup">
        {$plugup_hook_note|default:'<div id="notifier" class="single"><p> N/A </p></div>'}
    </div>
  </div>
{/if}

