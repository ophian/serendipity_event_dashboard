{*** block_future.tpl - last modified 2012-12-12 ***}

{if $showElementFuture}
<div id="future" class="block-entries block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><span class="visuallyhidden">{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}</span><br></div>

    <h3 class="flipbox"><span>{$CONST.PLUGIN_DASHBOARD_FUTURE} [ <span class="num">{$entry_future|@count}</span> ]</span></h3>

    <div id="sort_{$future_block_id}" class="block-content block-content-future">
    {foreach from=$entry_future item=efuture name='future'}
        <div class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"} serendipity_admin_list_item_future">
            <div id="cell_left" class="clmore">
                <h4><a href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$efuture.id}" title="#{$efuture.id}-{$efuture.title}">{$efuture.title|truncate:50:"&hellip;"}</a><span class="icon-clock" title="{$efuture.clock}"></span><span class="visuallyhidden"> {$efuture.clock}</span></h4>
                <div><time datetime="{$efuture.pubdate}">{$efuture.stime}</time></div>
            </div>

            <div id="cell_right" class="txtrht">
                <div><span>{$CONST.POSTED_BY} {$efuture.author} {if count($efuture.cats)}{$CONST.IN} {foreach from=$efuture.cats item=cats}{$cats}{/foreach}{/if}</span></div>

                <ul>
                {if $efuture.draft_pre}
                    <li class="mod_view"><a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=preview&amp;{$urltoken}&amp;serendipity[id]={$efuture.id}" title="{$CONST.PREVIEW} #{$efuture.id}"><button id="xopen"><span class="icon-eye" title="{$CONST.PREVIEW}"></span><span class="visuallyhidden"> {$CONST.PREVIEW}</span></button></a></li>
                {else}
                    <li class="mod_preview"><a class="icon_link" target="_blank" href="{$efuture.link}" onclick="document.forms['serendipityEntry'].elements['serendipity[preview]'].value='true';" title="{$CONST.VIEW} #{$efuture.id}"><span class="icon-eye" title="{$CONST.VIEW}"></span><span class="visuallyhidden"> {$CONST.VIEW}</span></a></li>
                {/if}
                    <li class="mod_edit"><a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$efuture.id}" title="{$CONST.EDIT} #{$efuture.id}"><button id="xopen"><span class="icon-edit" title="{$CONST.EDIT}"></span><span class="visuallyhidden"> {$CONST.EDIT}</span></button></a></li>
                </ul>
            </div>
        </div>
    {/foreach}    
    </div>
</div>
{/if}
