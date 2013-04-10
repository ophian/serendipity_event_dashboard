{*** block_comapp.tpl - last modified 2012-12-20 ***}

{if $showElementComments}
<div id="comapp" class="block-comments block-box clearfix">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><span class="visuallyhidden">{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}</span><br></div>

    <h3 class="flipbox"><span>{$CONST.COMMENTS_FILTER_APPROVED_ONLY} {$CONST.COMMENTS} [ <span class="num">{$entry_Commentlist|@count}</span> ]</span></h3>

    <div id="sort_{$comments_block_id}" class="block-content block-content-comments">
    {if is_array($entry_Commentlist)}    
        <form id="formMultiDeleteApp" class="comment_toggleall" action="#" method="POST" name="formMultiDeleteApp">
            {$formtoken}
            <input type="hidden" name="serendipity[formAction]" value="multiDelete">
        {foreach from=$entry_Commentlist item=eclap name='foo'}
            <div id="comment_{$eclap.id}">
                <div id="colist_{$eclap.id}" class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"}{if $eclap.status == 'pending' || $eclap.status == 'confirm'} serendipity_admin_comment_pending{/if}">
                    <div id="comments_header_{$eclap.id}" class="comments_header">
                        <input id="multi-select-comment-{$eclap.id}" class="input_checkbox" type="checkbox" name="serendipity[delete][{$eclap.id}]" value="{$eclap.entry_id}" onclick="toggle_checkbox('ckbx_{$eclap.id}', this.checked)" tabindex="{$smarty.foreach.foo.iteration}">

                        <div class="comment_titel">
                            <label for="multi-select-comment-{$eclap.id}" class="num">{$CONST.PLUGIN_DASHBOARD_COMMENT_SELECTION_SHORT|@sprintf:$eclap.id} - 
                            {$CONST.IN_REPLY_TO}: <a href="{$eclap.entry_url}" title="{$eclap.title}">{$eclap.title|truncate:48:"&hellip;"}</a>, {$CONST.ON} </label>, 
                            <time datetime="{$eclap.pubdate}" pubdate><span class="icon-clock" title="{$eclap.timestamp|@formatTime:'%A, %e. %B %Y'}"></span><span class="visuallyhidden"> {$eclap.timestamp|@formatTime:'%A, %e. %B %Y'}</span></time>
                        </div>

                        <div class="box-right"> <span id="#cl_{$eclap.id}" class="button"><img src="{serendipity_getFile file='img/plus.png'}" id="option_{$smarty.foreach.foo.iteration}" class="wizard-img" alt="+/-" title="{$CONST.TOGGLE_OPTION}"></span></div>
                    </div>
                
                    <div id="ct_{$eclap.id}" class="comment_text eclap_text">
                        <div class="summary">{$eclap.fullBody|strip_tags|truncate:120:"&hellip;"}</div>
                        <div class="fulltxt visuallyhidden">{$eclap.fullBody|nl2br}</div>
                    </div>
                
                    <div class="comment_boxed">
                        <ul class="comment_fields horizontal">
                            <li class="mod_author"><b>{$CONST.AUTHOR}:</b> {$eclap.author|truncate:30:"&hellip;"} {$eclap.action_author}</li>
                            <li class="mod_email"><b>{$CONST.EMAIL}:</b> {if $eclap.email}<a href="mailto:{$eclap.email}">{$eclap.email|truncate:30:"&hellip;"}</a>{else}N/A{/if}</li>
                            <li class="mod_ip"><b>{$CONST.IP}:</b> {$eclap.ip|default:'0.0.0.0'}</li>
                            <li class="mod_url"><b>{$CONST.URL}:</b> {if $eclap.url}<a href="{$eclap.url}">{$eclap.url|truncate:30:"&hellip;"}</a>{else}N/A{/if}</li>
                            <li class="mod_referer"><b>{$CONST.REFERER}:</b> {if $eclap.referer}<a href="{$eclap.referer}">{$eclap.referer|truncate:30:"&hellip;"}</a>{else}N/A{/if}</li>
                        </ul>
                
                        <ul class="comment_admin horizontal">
                            <li class="mod_appmod">
                            {if ($eclap.status == 'pending' || $eclap.status == 'confirm') && !$read_only}
                                <a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=approve&amp;serendipity[id]={$eclap.id}&amp;{$urltoken}" title="{$CONST.APPROVE}"><span id="text_mod_{$eclap.id}" class="admin-mini-icon icon-ok-circle"></span><span class="visuallyhidden"> {$CONST.APPROVE}</span></a>
                            {elseif $eclap.status == 'approved' && !$read_only}
                                <a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=pending&amp;serendipity[id]={$eclap.id}&amp;{$urltoken}" title="{$CONST.SET_TO_MODERATED}"><span id="text_mod_{$eclap.id}" class="admin-mini-icon icon-cancel-circle"></span><span class="visuallyhidden"> {$CONST.SET_TO_MODERATED}</span></a>
                            {else}
                                <a class="icon_link" href="#read_only" title="{$CONST.READ_ONLY}"><span id="text_mod_{$eclap.id}" class="admin-mini-icon icon-file"></span><span class="visuallyhidden"> {$CONST.READ_ONLY}</span></a>
                            {/if}
                            </li>
                            {if $eclap.excerpt}
                            <li class="mod_zoom">
                                <a class="icon_link toggle_text" href="#c{$eclap.id}" title="{$CONST.PREVIEW}"><span id="text_zoom_{$eclap.id}" class="text toggle-icon icon-zoom-in"></span><span class="visuallyhidden"> {$CONST.TOGGLE_OPTION}</span></a>
                            </li>
                            {/if}
                            <li class="mod_view">
                                <a class="icon_link" target="_blank" href="{$eclap.entrylink}" title="{$CONST.VIEW}"><span id="text_view_{$eclap.id}" class="admin-mini-icon icon-eye"></span><span class="visuallyhidden"> {$CONST.VIEW}</span></a>
                            </li>
                            <li class="mod_edit">
                                <a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$eclap.id}&amp;serendipity[entry_id]={$eclap.entry_id}&amp;{$urltoken}" title="{$CONST.EDIT}"><span id="text_edit_{$eclap.id}" class="admin-mini-icon icon-edit"></span><span class="visuallyhidden"> {$CONST.EDIT}</span></a>
                            </li>
                            {if !$read_only}
                            <li class="mod_delete">
                                <a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=delete&amp;serendipity[id]={$eclap.id}&amp;serendipity[entry_id]={$eclap.entry_id}&amp;{$urltoken}" onclick='return confirm("{$eclap.delete_id}")' title="{$CONST.DELETE}"><span id="text_trash_{$eclap.id}" class="admin-mini-icon icon-trash"></span><span class="visuallyhidden"> {$CONST.DELETE}</span></a>
                            </li>
                            {/if}
                            <li class="mod_reply">
                                <a class="icon_link" target="_blank" onclick="cf = window.open(this.href, 'CommentForm', 'width=800,height=600,toolbar=no,scrollbars=1,scrollbars,resize=1,resizable=1'); cf.focus(); return false;" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=reply&amp;serendipity[id]={$eclap.id}&amp;serendipity[entry_id]={$eclap.entry_id}&amp;serendipity[noBanner]=true&amp;serendipity[noSidebar]=true&amp;{$urltoken}" title="{$CONST.REPLY}"><span id="text_reply_{$eclap.id}" class="admin-mini-icon icon-chat"></span><span class="visuallyhidden"> {$CONST.REPLY}</span></a>
                            </li>
                        </ul>
                    </div><!-- class comment_boxed end -->
                </div><!-- class serendipity_admin_list_item end -->
            </div><!-- // #comment_{$eclap.id} end -->
            {/foreach}
            <div class="input-boxed">
                <button id="ca-inv" type="button" name="toggle" onclick="invertSelectionApp()" class="none" title="{$CONST.INVERT_SELECTIONS}"><span class="icon-shuffle"></span><span class="visuallyhidden"> {$CONST.INVERT_SELECTIONS}</span></button>
                <button id="ca-del" type="submit" name="toggle" onclick="return confirm('{$CONST.COMMENTS_DELETE_CONFIRM}')" class="none" title="{$CONST.DELETE_SELECTED_COMMENTS}"><span class="icon-trash"></span><span class="visuallyhidden"> {$CONST.DELETE_SELECTED_COMMENTS}</span></button>
           </div>
        </form>
        {/if}
    </div>
  </div>
{/if}

