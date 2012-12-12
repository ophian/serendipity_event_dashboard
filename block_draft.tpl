{*** block_draft.tpl - last modified 2012-12-12 ***}

{if $showElementDraft}
  <div id="draft" class="block-entries block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$CONST.DRAFT} [ <span class="num">{$draft_Entrylist|@count}</span> ]</span></h3>
    <div id="sort_{$draft_block_id}" class="block-content block-content-draft">

        {foreach from=$draft_Entrylist item=edraft name='draft'}

        <div class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"} serendipity_admin_list_item_draft">

            <div id="cell_left" class="clmore">
                <h3>{$edraft.clock}<a class="plain_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$edraft.id}" title="#{$edraft.id}-{$edraft.title}">{$edraft.title|truncate:50:"&hellip;"}</a></h3>
                <div>
                    <time datetime="{$edraft.pubdate}">{$edraft.stime}</time>
                </div>
            </div>
            <div id="cell_right" class="txtrht">
                <div>
                    <span>{$CONST.POSTED_BY} {$edraft.author} {if count($edraft.cats)}{$CONST.IN} {foreach from=$edraft.cats item=cats}{$cats}{/foreach}{/if}</span>
                </div>
                <ul>
                    {if $edraft.draft_pre}
                    <li class="mod_preview"><a id="efp{$edraft.id}" class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=preview&amp;{$urltoken}&amp;serendipity[id]={$edraft.id}" title="{$CONST.PREVIEW} #{$edraft.id}" title="{$CONST.PREVIEW} #{$edraft.id}"><button id="xopen"><span class="icon-eye"></span><span class="visuallyhidden"> {$CONST.PREVIEW}</span></button></a></li>
                    {else}
                    <li class="mod_view"><a id="efv{$edraft.id}" class="icon_link" href="{$edraft.link}" title="{$CONST.VIEW} #{$edraft.id}" target="_blank"><button id="xopen"><span class="text icon-zoom-in"></span><span class="visuallyhidden"> {$CONST.VIEW}</span></button></a></li>
                    {/if}
                    <li class="mod_edit"><a id="efe{$edraft.id}" class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$edraft.id}" title="{$CONST.EDIT} #{$edraft.id}"><button id="xopen"><span class="icon-edit"></span><span class="visuallyhidden"> {$CONST.EDIT}</span></button></a></li>
					<li class="mod_delete"><a id="efd{$edraft.id}" class="icon_link" title="{$CONST.DELETE} #{$edraft.id}" href="?serendipity[action]=admin&amp;serendipity[adminModule]=entries&amp;serendipity[adminAction]=delete&amp;{$urltoken}&amp;serendipity[id]={$edraft.id}"><button id="xopen"><span class="icon-trash"></span><span class="visuallyhidden"> {$CONST.DELETE}</span></button></a></li>
                </ul>
            </div>

        </div>
            
        {/foreach}
        
   </div>
  </div>
{/if}

