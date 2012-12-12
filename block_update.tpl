{*** block_update.tpl - last modified 2012-12-12 ***}

{if $showElementUpdate}
  <div id="update" class="block-updates block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$CONST.PLUGIN_DASHBOARD_UPDATE_TITLE} ?</span></h3>
    <div id="sort_{$update_block_id}" class="block-content block-content-update">

        <div class="serendipity_admin_list_item serendipity_admin_list_item_even">
            <div id="notifier">
                {$update_text|default:"<p> N/A </p>"}
            </div>
            <div id="notifierform">
                <div id="cell_left">{$update_form|default:"<p> $version is up to date! </p>"}</div>
                <div id="cell_right" class="txtrht">{$service_mode}</div>
            </div>
        </div>
        
    </div>
  </div>
{/if}

