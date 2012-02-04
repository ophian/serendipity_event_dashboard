{if $showElementPlugup}
<div id="s9y-plugup" class="block-updates">
    <div id="sort_{$plugup_block_id}" class="dashboard dashboard_plugup">
        <h3> {$CONST.PLUGIN_UPDATE_NOTIFIER} </h3>
        {serendipity_hookPlugin hook="backend_pluginlisting_header" hookAll="true" eyecandy=$eyecandy}
    </div>
</div>
{/if}


