{if $showElementComments}
<section id="recent-comments">
    <div id="sort_{$comments_block_id}" class="dashboard dashboard_comments">
        <div class="all-box-right"> <a href="#ta_{$comments_block_id}" class="button serendipityIconLink"><button id="openall_{$comments_block_id}" class="openall"><img src="{serendipity_getFile file="img/plus.png"}" id="option_{$comments_block_id}" class="wizard-img" alt="+/-" /> Toggle all</button></a> </div> 
        <h3> {$CONST.COMMENT} [ {$entry_Commentlist|@count} ] </h3>
        
        <div id="antispam">
            {$antispam_hook}
        </div>

        {if is_array($entry_Commentlist)}
        
        <form id="formMultiDeleteApp" action="#" method="POST" name="formMultiDeleteApp" class="comment_toggleall">
            {$formtoken}
            <input type="hidden" name="serendipity[formAction]" value="multiDelete" />

            {foreach from=$entry_Commentlist item=eclap name='foo'}
            
            <div id="comment_{$eclap.id}">
                
                <div id="colist_{$eclap.id}" class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"}{if $eclap.status == 'pending' || $eclap.status == 'confirm'} serendipity_admin_comment_pending{/if}">
                    <input id="multi-select-comment-{$eclap.id}" class="input_checkbox" type="checkbox" name="serendipity[delete][{$eclap.id}]" value="{$eclap.entry_id}" onclick="toogle_checkbox('ckbx_{$eclap.id}', this.checked)" tabindex="{$smarty.foreach.foo.iteration}" />
                    <div class="comment_titel">
                        <label for="multi-select-comment-{$eclap.id}">{$CONST.INCLUDE_COMMENT_SELECTION|@sprintf:$CONST.COMMENT:$eclap.id:$CONST.IN_SELECTION}</label> - 
                        <label for="multi-select-comment-{$eclap.id}">{$CONST.IN_REPLY_TO}: <a href="{$eclap.entry_url}">{$eclap.title|truncate:48:"&hellip;"}</a>, <time datetime="{$eclap.pubdate}" pubdate>{$CONST.ON} {$eclap.timestamp|@formatTime:'%A, %e. %B %Y'}</time></label>
                    </div>
                    <div class="box-right"> <a href="#cl_{$eclap.id}" class="button"><img src="{serendipity_getFile file="img/plus.png"}" id="option_{$smarty.foreach.foo.iteration}" class="wizard-img" alt="+/-" /> {$CONST.TOGGLE_OPTION}</a> </div>
                
                    <div id="ct_{$eclap.id}" class="comment_text eclap_text">
                        <div class="summary">{$eclap.summary|truncate:120:"&hellip;"}</div>
                        <div class="fulltxt">{$eclap.fullBody|nl2br}</div>
                    </div>
                
                    <div class="comment_boxed">

                        <ul class="comment_fields">
                            <li class="mod_author"><b>{$CONST.AUTHOR}:</b> {$eclap.author|truncate:30:"&hellip;"} {$eclap.action_author} </li>
                            <li class="mod_email"><b>{$CONST.EMAIL}:</b> <a href="mailto:{$eclap.email}">{$eclap.email|truncate:30:"&hellip;"|default:'N/A'}</a> </li>
                            <li class="mod_ip"><b>{$CONST.IP}:</b> {$eclap.ip|default:'0.0.0.0'}</li>
                            <li class="mod_url"><b>{$CONST.URL}:</b> <a href="{$eclap.url}">{$eclap.url|truncate:30:"&hellip;"}</a> </li>
                            <li class="mod_referer"><b>{$CONST.REFERER}:</b> <a href="{$eclap.referer}">{$eclap.referer|truncate:30:"&hellip;"|default:'N/A'}</a></li>
                        </ul>
                
                        <ul class="comment_admin">
                            <li class="mod_appmod">
                            {if ($eclap.status == 'pending' || $eclap.status == 'confirm') && !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=approve&amp;serendipity[id]={$eclap.id}&amp;{$urltoken}" class="serendipityIconLink" title="{$CONST.APPROVE}"><img src="{serendipity_getFile file="admin/img/accept.png"}" alt="{$CONST.APPROVE}" />{$CONST.APPROVE}</a>
                            {elseif $eclap.status == 'approved' && !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=pending&amp;serendipity[id]={$eclap.id}&amp;{$urltoken}" class="serendipityIconLink" title="{$CONST.SET_TO_MODERATED}"><img src="{serendipity_getFile file="admin/img/clock.png"}" alt="{$CONST.SET_TO_MODERATED}" />{$CONST.SET_TO_MODERATED}</a>
                            {else}
                                <a href="#read_only" class="serendipityIconLink" title="{$CONST.READ_ONLY}"><img src="{$thispath}/img/readonly.png" alt="{$CONST.READ_ONLY}" />{$CONST.READ_ONLY}</a>
                            {/if}
                            </li>
                            <li class="mod_zoom">
                            {if $eclap.excerpt}
                                <a href="#c{$eclap.id}" class="serendipityIconLink toggle_text"><img src="{serendipity_getFile file="admin/img/zoom.png"}" alt="{$CONST.TOGGLE_OPTION}" /><span class="text">{$CONST.TOGGLE_OPTION}</span></a>
                            {/if}
                            </li>
                            <li class="mod_view">
                                <a target="_blank" href="{$eclap.entrylink}" title="{$CONST.VIEW}" class="serendipityIconLink"><img src="{serendipity_getFile file="admin/img/zoom.png"}" alt="{$CONST.VIEW}" />{$CONST.VIEW}</a>
                            </li>
                            <li class="mod_edit">
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$eclap.id}&amp;serendipity[entry_id]={$eclap.entry_id}&amp;{$urltoken}" title="{$CONST.EDIT}" class="serendipityIconLink"><img src="{serendipity_getFile file="admin/img/edit.png"}" alt="{$CONST.EDIT}" />{$CONST.EDIT}</a>
                            </li>
                            <li class="mod_delete">
                            {if !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=delete&amp;serendipity[id]={$eclap.id}&amp;serendipity[entry_id]={$eclap.entry_id}&amp;{$urltoken}" onclick='return confirm("{$eclap.delete_id}")' title="{$CONST.DELETE}" class="serendipityIconLink"><img src="{serendipity_getFile file="admin/img/delete.png"}" alt="{$CONST.DELETE}" />{$CONST.DELETE}</a>
                            {/if}
                            </li>
                            <li class="mod_reply">
                                <a target="_blank" onclick="cf = window.open(this.href, 'CommentForm', 'width=800,height=600,toolbar=no,scrollbars=1,scrollbars,resize=1,resizable=1'); cf.focus(); return false;" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=reply&amp;serendipity[id]={$eclap.id}&amp;serendipity[entry_id]={$eclap.entry_id}&amp;serendipity[noBanner]=true&amp;serendipity[noSidebar]=true&amp;{$urltoken}" title="{$CONST.REPLY}" class="serendipityIconLink"><img src="{serendipity_getFile file="admin/img/user_editor.png"}" alt="{$CONST.REPLY}" />{$CONST.REPLY}</a>
                            </li>
                        </ul>
                    </div><!-- class comment_boxed end -->
                    
                </div><!-- class serendipity_admin_list_item end -->
                  {* $eclap.action_more *}
            </div><!-- #comment_{$eclap.id} end -->

            {/foreach}
            
            <input type="button" name="toggle" value="{$CONST.INVERT_SELECTIONS}" onclick="invertSelectionApp()" class="serendipityPrettyButton input_button" />
            <input type="submit" name="toggle" value="{$CONST.DELETE_SELECTED_COMMENTS}" onclick="return confirm('{$CONST.COMMENTS_DELETE_CONFIRM}')" tabindex="{$smarty.foreach.foo.iteration+1}" class="serendipityPrettyButton input_button" />
            
        </form>

        {/if}
        
    </div>
</section>
{/if}


