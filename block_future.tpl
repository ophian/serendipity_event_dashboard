{*** block_future.tpl - last modified 2012-08-31 ***}

{if $showElementFuture}
  <div id="future" class="block-entries block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$CONST.PLUGIN_DASHBOARD_FUTURE} [ <span class="num">{$entry_future|@count}</span> ]</span></h3>
    <div id="sort_{$future_block_id}" class="block-content block-content-future">

        {foreach from=$entry_future item=efuture name='future'}

        <div class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"} serendipity_admin_list_item_future">

            <div id="cell_left" class="clmore">
                <h3>{$efuture.clock}<a href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$efuture.id}" title="#{$efuture.id}-{$efuture.title}">{$efuture.title|truncate:50:"&hellip;"}</a></h3>
                <div>
                    <time datetime="{$efuture.pubdate}">{$efuture.stime}</time>
                </div>
            </div>
            <div id="cell_right" class="txtrht">
                <div>
                    <span>{$CONST.POSTED_BY} {$efuture.author} {if count($efuture.cats)}{$CONST.IN} {foreach from=$efuture.cats item=cats}{$cats}{/foreach}{/if}</span>
                </div>
                <ul>
                    {if $efuture.draft_pre}
                    <li class="mod_preview"><a href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=preview&amp;{$urltoken}&amp;serendipity[id]={$efuture.id}" title="{$CONST.PREVIEW} #{$efuture.id}" class="serendipityIconLink"><button id="xopen" onclick="$('.containerPlusIF').mb_open();"><img src="{serendipity_getFile file='admin/img/zoom.png'}" alt="{$CONST.PREVIEW}" />{$CONST.PREVIEW}</button></a></li>
                    {else}
                    <li class="mod_view"><a target="_blank" href="{$efuture.link}" onclick="document.forms['serendipityEntry'].elements['serendipity[preview]'].value='true';" title="{$CONST.VIEW} #{$efuture.id}" class="serendipityIconLink"><img src="{serendipity_getFile file='admin/img/zoom.png'}" alt="{$CONST.VIEW}" />{$CONST.VIEW}</a></li>
                    {/if}
                    <li class="mod_edit"><a href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$efuture.id}" title="{$CONST.EDIT} #{$efuture.id}" class="serendipityIconLink"><button id="xopen" onclick="$('.containerPlusIF').mb_open();"><img src="{serendipity_getFile file='admin/img/edit.png'}" alt="{$CONST.EDIT}" />{$CONST.EDIT}</button></a></li>
                </ul>
            </div>

        </div>
            
        {/foreach}
        
   </div>
  </div>
{/if}

