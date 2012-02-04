{if $showElementUpdate}
<div id="s9y-update" class="block-updates">
    <div id="sort_{$update_block_id}" class="dashboard dashboard_update">
        <h3> {$CONST.PLUGIN_DASHBOARD_UPD}</h3>

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


