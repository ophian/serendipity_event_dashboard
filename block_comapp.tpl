{*** block_comapp.tpl - last modified 2012-08-27 ***}

{if $showElementComments}
  <div id="comapp" class="block-comments block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$CONST.COMMENTS_FILTER_APPROVED_ONLY} {$CONST.COMMENTS} [ <span class="num">{$entry_Commentlist|@count}</span> ]</span></h3>
    <div id="sort_{$comments_block_id}" class="dashboard dashboard_comments">

        {if is_array($entry_Commentlist)}
        
        <form id="formMultiDeleteApp" action="#" method="POST" name="formMultiDeleteApp" class="comment_toggleall">
            {$formtoken}
            <input type="hidden" name="serendipity[formAction]" value="multiDelete" />

            {foreach from=$entry_Commentlist item=eclap name='foo'}
            
            <div id="comment_{$eclap.id}">
                
                <div id="colist_{$eclap.id}" class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"}{if $eclap.status == 'pending' || $eclap.status == 'confirm'} serendipity_admin_comment_pending{/if}">
                    <div id="comments_header_{$eclap.id}" class="comments_header">
                        <input id="multi-select-comment-{$eclap.id}" class="input_checkbox" type="checkbox" name="serendipity[delete][{$eclap.id}]" value="{$eclap.entry_id}" onclick="toggle_checkbox('ckbx_{$eclap.id}', this.checked)" tabindex="{$smarty.foreach.foo.iteration}" />
                        <div class="comment_titel">
                            <label for="multi-select-comment-{$eclap.id}" class="num">{$CONST.PLUGIN_DASHBOARD_COMMENT_SELECTION_SHORT|@sprintf:$eclap.id}</label> - 
                            <label for="multi-select-comment-{$eclap.id}">{$CONST.IN_REPLY_TO}: <a href="{$eclap.entry_url}" title="{$eclap.title}">{$eclap.title|truncate:48:"&hellip;"}</a>, <time datetime="{$eclap.pubdate}" pubdate>{$CONST.ON} <img alt="*" src="{serendipity_getFile file='admin/img/clock.png'}" title="{$eclap.timestamp|@formatTime:'%A, %e. %B %Y'}" /></time></label>
                        </div>
                        <div class="box-right"> <a href="#cl_{$eclap.id}" class="button"><img src="{serendipity_getFile file='img/plus.png'}" id="option_{$smarty.foreach.foo.iteration}" class="wizard-img" alt="+/-" title="{$CONST.TOGGLE_OPTION}" /> </a> </div>
                    </div>
                
                    <div id="ct_{$eclap.id}" class="comment_text eclap_text">
                        <div class="summary">{$eclap.fullBody|strip_tags|truncate:120:"&hellip;"}</div>
                        <div class="fulltxt visuallyhidden">{$eclap.fullBody|nl2br}</div>
                    </div>
                
                    <div class="comment_boxed">

                        <ul class="comment_fields">
                            <li class="mod_author"><b>{$CONST.AUTHOR}:</b> {$eclap.author|truncate:30:"&hellip;"} {$eclap.action_author} </li>
                            <li class="mod_email"><b>{$CONST.EMAIL}:</b> {if $eclap.email}<a href="mailto:{$eclap.email}">{$eclap.email|truncate:30:"&hellip;"}</a>{else}N/A{/if} </li>
                            <li class="mod_ip"><b>{$CONST.IP}:</b> {$eclap.ip|default:'0.0.0.0'}</li>
                            <li class="mod_url"><b>{$CONST.URL}:</b> {if $eclap.url}<a href="{$eclap.url}">{$eclap.url|truncate:30:"&hellip;"}</a>{else}N/A{/if} </li>
                            <li class="mod_referer"><b>{$CONST.REFERER}:</b> {if $eclap.referer}<a href="{$eclap.referer}">{$eclap.referer|truncate:30:"&hellip;"}</a>{else}N/A{/if} </li>
                        </ul>
                
                        <ul class="comment_admin">
                            <li class="mod_appmod">
                            {if ($eclap.status == 'pending' || $eclap.status == 'confirm') && !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=approve&amp;serendipity[id]={$eclap.id}&amp;{$urltoken}" class="serendipityIconLink" title="{$CONST.APPROVE}"><span id="text_{$eclap.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/accept.png'}" title="{$CONST.APPROVE}" alt="[approve]" /></span></a>
                            {elseif $eclap.status == 'approved' && !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=pending&amp;serendipity[id]={$eclap.id}&amp;{$urltoken}" class="serendipityIconLink" title="{$CONST.SET_TO_MODERATED}"><span id="text_{$eclap.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/clock.png'}" title="{$CONST.SET_TO_MODERATED}" alt="[set2moderate]" /></span></a>
                            {else}
                                <a href="#read_only" class="serendipityIconLink" title="{$CONST.READ_ONLY}"><span id="text_{$eclap.id}" class="admin-mini-icon"><img src="{$thispath}/img/readonly.png" title="{$CONST.READ_ONLY}" alt="[readonly]" /></span></a>
                            {/if}
                            </li>
                            <li class="mod_zoom">
                            {if $eclap.excerpt}
                                <a href="#c{$eclap.id}" class="serendipityIconLink toggle_text"><span id="text_{$eclap.id}" class="text"><img src="{serendipity_getFile file='admin/img/zoom.png'}" title="{$CONST.TOGGLE_OPTION}" alt="[Zoom]" /></span></a>
                            {/if}
                            </li>
                            <li class="mod_view">
                                <a target="_blank" href="{$eclap.entrylink}" title="{$CONST.VIEW}" class="serendipityIconLink"><span id="text_{$eclap.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/zoom.png'}" title="{$CONST.VIEW}" alt="[view]" /></span></a>
                            </li>
                            <li class="mod_edit">
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$eclap.id}&amp;serendipity[entry_id]={$eclap.entry_id}&amp;{$urltoken}" title="{$CONST.EDIT}" class="serendipityIconLink"><span id="text_{$eclap.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/edit.png'}" title="{$CONST.EDIT}" alt="[edit]" /></span></a>
                            </li>
                            <li class="mod_delete">
                            {if !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=delete&amp;serendipity[id]={$eclap.id}&amp;serendipity[entry_id]={$eclap.entry_id}&amp;{$urltoken}" onclick='return confirm("{$eclap.delete_id}")' title="{$CONST.DELETE}" class="serendipityIconLink"><span id="text_{$eclap.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/delete.png'}" title="{$CONST.DELETE}" alt="[delete]" /></span></a>
                            {/if}
                            </li>
                            <li class="mod_reply">
                                <a target="_blank" onclick="cf = window.open(this.href, 'CommentForm', 'width=800,height=600,toolbar=no,scrollbars=1,scrollbars,resize=1,resizable=1'); cf.focus(); return false;" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=reply&amp;serendipity[id]={$eclap.id}&amp;serendipity[entry_id]={$eclap.entry_id}&amp;serendipity[noBanner]=true&amp;serendipity[noSidebar]=true&amp;{$urltoken}" title="{$CONST.REPLY}" class="serendipityIconLink"><span id="text_{$eclap.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/user_editor.png'}" title="{$CONST.REPLY}" alt="[reply]" /></span></a>
                            </li>
                        </ul>
                    </div><!-- class comment_boxed end -->
                    
                </div><!-- class serendipity_admin_list_item end -->
            </div><!-- // #comment_{$eclap.id} end -->

            {/foreach}
            <div class="input-boxed">
                <span class="inputtype"><img src="{$thispath}/img/invert.png" alt="" /><input type="button" name="toggle" value="{$CONST.INVERT_SELECTIONS}" onclick="invertSelectionApp()" class="none" /></span>
                <span class="inputtype"><img src="{$thispath}/img/remove.png" alt="" /><input type="submit" name="toggle" value="{$CONST.DELETE_SELECTED_COMMENTS}" onclick="return confirm('{$CONST.COMMENTS_DELETE_CONFIRM}')" class="none" /></span>
            </div>
        </form>

        {/if}
    </div>
  </div>
{/if}

