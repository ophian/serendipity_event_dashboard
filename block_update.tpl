{*** block_update.tpl - last modified 2012-06-22 ***}

{if $showElementUpdate}
<div id="s9y-update" class="block-updates block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$CONST.PLUGIN_DASHBOARD_UPD}</span></h3>
    <div id="sort_{$update_block_id}" class="dashboard dashboard_update">

        <div class="serendipity_admin_list_item serendipity_admin_list_item_even">
            <div id="notifier">
                {$update_text|default:"<p> N/A </p>"}
            </div>
            <div id="notifierform">
                {$update_form|default:"<p> $version is up to date! </p>"}
            </div>
        </div>
        
    </div>
</div>
{/if}


