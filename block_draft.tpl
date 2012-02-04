{if $showElementDraft}
<div id="draft-entries" class="block-entries">
    <div id="sort_{$draft_block_id}" class="dashboard dashboard_draft">
        <h3> {$CONST.DRAFT} </h3>

        {foreach from=$draft_Entrylist item=edraft name='draft'}

        <div class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"} serendipity_admin_list_item_draft">

            <div id="cell_left">
                <h3>{$edraft.clock}<a href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$edraft.id}" title="#{$edraft.id}">{$edraft.title|truncate:50:"&hellip;"}</a></h3>
                <div>
                    <time datetime="2011-02-19T09:54:00">{$edraft.stime}</time>
                </div>
            </div>
            <div id="cell_right">
                <div>
                    <span>{$CONST.POSTED_BY} {$edraft.author} {if count($edraft.cats)}{$CONST.IN} {foreach from=$edraft.cats item=cats}{$cats}{/foreach}{/if}</span>
                </div>
                <ul>
                    {if $edraft.draft_pre}
                    <li class="mod_preview"><a href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=preview&amp;{$urltoken}&amp;serendipity[id]={$edraft.id}" title="{$CONST.PREVIEW} #{$edraft.id}" title="{$CONST.PREVIEW} #{$edraft.id}" class="serendipityIconLink"><button id="xopen" onclick="$('.containerPlusIF').mb_open();"><img src="{serendipity_getFile file="admin/img/zoom.png"}" alt="{$CONST.PREVIEW}" />{$CONST.PREVIEW}</button></a></li>
                    {else}
                    <li class="mod_view"><a target="_blank" href="{$edraft.link}" title="{$CONST.VIEW} #{$edraft.id}" class="serendipityIconLink"><img src="{serendipity_getFile file="admin/img/zoom.png"}" alt="{$CONST.VIEW}" />{$CONST.VIEW}</a></li>
                    {/if}
                    <li class="mod_edit"><a href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$edraft.id}" title="{$CONST.EDIT} #{$edraft.id}" class="serendipityIconLink"><button id="xopen" onclick="$('.containerPlusIF').mb_open();"><img src="{serendipity_getFile file="admin/img/edit.png"}" alt="{$CONST.EDIT}" />{$CONST.EDIT}</button></a></li>
                </ul>
            </div>

        </div>
            
        {/foreach}
        
   </div>
</div>
{/if}


