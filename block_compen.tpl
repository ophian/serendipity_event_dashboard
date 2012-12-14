{*** block_compen.tpl - last modified 2012-12-15 ***}

{if $showElementComPend}
  <div id="compen" class="block-comments block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$CONST.COMMENTS_FILTER_NEED_APPROVAL} {$CONST.COMMENTS} [ <span class="num">{$entry_Compendlist|@count}</span> ]</span></h3>
    <div id="sort_{$compen_block_id}" class="block-content block-content-comments-pending">

        {if is_array($entry_Compendlist)}
        
        <form id="formMultiDeletePen" action="#" method="POST" name="formMultiDeletePen">
            {$formtoken}
            <input type="hidden" name="serendipity[formAction]" value="multiDelete" />

            {foreach from=$entry_Compendlist item=eclpen name='bar'}

            <div id="comment_{$eclpen.id}">
                
                <div id="cpl_{$eclpen.id}" class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"}{if $eclpen.status == 'pending' || $eclpen.status == 'confirm'} serendipity_admin_comment_pending{/if}">
                    <div id="comments_header_{$eclpen.id}" class="comments_header">
                        <input id="multi-select-comment-{$eclpen.id}" class="input_checkbox" type="checkbox" name="serendipity[delete][{$eclpen.id}]" value="{$eclpen.entry_id}" onclick="toggle_checkbox('ckbx_{$eclpen.id}', this.checked)" tabindex="{$smarty.foreach.bar.iteration}" />
                        <div class="comment_titel">
                            <label for="multi-select-comment-{$eclpen.id}" class="num">{$CONST.PLUGIN_DASHBOARD_COMMENT_SELECTION_SHORT|@sprintf:$eclpen.id}</label> - 
                            <label for="multi-select-comment-{$eclpen.id}">{$CONST.IN_REPLY_TO}: <a href="{$eclpen.entry_url}" title="{$eclpen.title}">{$eclpen.title|truncate:48:"&hellip;"}</a>, <time datetime="{$eclpen.pubdate}" pubdate>{$CONST.ON} <img alt="[clock]" src="{serendipity_getFile file='admin/img/clock.png'}" title="{$eclpen.timestamp|@formatTime:'%A, %e. %B %Y'}" /></time></label>
                        </div>
                        <div class="box-right"> <a href="#cl_{$eclpen.id}" class="button"><img src="{serendipity_getFile file='img/plus.png'}" id="option_{$smarty.foreach.bar.iteration}" class="wizard-img" alt="+/-" title="{$CONST.TOGGLE_OPTION}" /> </a> </div>
                    </div>

                    <div id="cpt_{$eclpen.id}" class="comment_text eclpen_text">
                        <div class="summary">{$eclpen.fullBody|strip_tags|truncate:120:"&hellip;"}</div>
                        <div class="fulltxt visuallyhidden">{$eclpen.fullBody|nl2br}</div>
                    </div>
                
                    <div class="comment_boxed">

                        <ul class="comment_fields">
                            <li class="mod_author"><b>{$CONST.AUTHOR}:</b> {$eclpen.author|truncate:30:"&hellip;"} {$eclpen.action_author} </li>
                            <li class="mod_email"><b>{$CONST.EMAIL}:</b> {if $eclpen.email}<a href="mailto:{$eclpen.email}">{$eclpen.email|truncate:30:"&hellip;"}</a>{else}N/A{/if} </li>
                            <li class="mod_ip"><b>{$CONST.IP}:</b> {$eclpen.ip|default:'0.0.0.0'}</li>
                            <li class="mod_url"><b>{$CONST.URL}:</b> {if $eclpen.url}<a href="{$eclpen.url}">{$eclpen.url|truncate:30:"&hellip;"}</a>{else}N/A{/if} </li>
                            <li class="mod_referer"><b>{$CONST.REFERER}:</b> {if $eclpen.referer}<a href="{$eclpen.referer}">{$eclpen.referer|truncate:30:"&hellip;"}</a>{else}N/A{/if} </li>
                        </ul>
                
                        <ul class="comment_admin">
                            <li class="mod_appmod">
                            {if ($eclpen.status == 'pending' || $eclpen.status == 'confirm') && !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=approve&amp;serendipity[id]={$eclpen.id}&amp;{$urltoken}" class="serendipityIconLink" title="{$CONST.APPROVE}"><span id="text_{$eclpen.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/accept.png'}" title="{$CONST.APPROVE}" alt="[approve]" /></span></a>
                            {elseif $eclpen.status == 'approved' && !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=pending&amp;serendipity[id]={$eclpen.id}&amp;{$urltoken}" class="serendipityIconLink" title="{$CONST.SET_TO_MODERATED}"><span id="text_{$eclpen.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/clock.png'}" title="{$CONST.SET_TO_MODERATED}" alt="[set2moderate]" /></span></a>
                            {else}
                                <a href="#read_only" class="serendipityIconLink" title="{$CONST.READ_ONLY}"><span id="text_{$eclpen.id}" class="admin-mini-icon"><img src="{$thispath}/img/readonly.png" title="{$CONST.READ_ONLY}" alt="[readonly]" /></span></a>
                            {/if}
                            </li>
                            {if $eclpen.excerpt}
                            <li class="mod_zoom">
                                <a href="#c{$eclpen.id}" title="{$CONST.VIEW}" class="serendipityIconLink toggle_text"><span id="text_{$eclpen.id}" class="text toggle-icon"><img src="{serendipity_getFile file='admin/img/uparrow.png'}" title="{$CONST.TOGGLE_OPTION}" alt="[Zoom]" /></span></a>
                            </li>
                            {/if}{* this is useless pointing to the frontend...
                            <li class="mod_view">
                                <a target="_blank" href="{$eclpen.entrylink}" title="{$CONST.VIEW}" class="serendipityIconLink"><span id="text_{$eclpen.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/zoom.png'}" title="{$CONST.VIEW}" alt="[view]" /></span></a>
                            </li> *}
                            <li class="mod_edit">
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$eclpen.id}&amp;serendipity[entry_id]={$eclpen.entry_id}&amp;{$urltoken}" title="{$CONST.EDIT}" class="serendipityIconLink"><span id="text_{$eclpen.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/edit.png'}" title="{$CONST.EDIT}" alt="[edit]" /></span></a>
                            </li>
                            <li class="mod_delete">
                            {if !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=delete&amp;serendipity[id]={$eclpen.id}&amp;serendipity[entry_id]={$eclpen.entry_id}&amp;{$urltoken}" onclick='return confirm("{$eclpen.delete_id}")' title="{$CONST.DELETE}" class="serendipityIconLink"><span id="text_{$eclpen.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/delete.png'}" title="{$CONST.DELETE}" alt="[delete]" /></span></a>
                            {/if}
                            </li>
                            <li class="mod_reply">
                                <a target="_blank" onclick="cf=window.open(this.href, 'CommentForm', 'width=800,height=600,toolbar=no,scrollbars=1,scrollbars,resize=1,resizable=1'); cf.focus(); return false;" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=reply&amp;serendipity[id]={$eclpen.id}&amp;serendipity[entry_id]={$eclpen.entry_id}&amp;serendipity[noBanner]=true&amp;serendipity[noSidebar]=true&amp;{$urltoken}" title="{$CONST.REPLY}" class="serendipityIconLink"><span id="text_{$eclpen.id}" class="admin-mini-icon"><img src="{serendipity_getFile file='admin/img/user_editor.png'}" title="{$CONST.REPLY}" alt="[reply]" /></span></a>
                            </li>
                            {if $spamblockbayes_hookin}
                            <li class="mod_bayes">
                                <ul>
                                    <li class="mod_ham" title="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_NAME}: {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_HAM}">
                                        <a id="ham{$eclpen.id}" class="serendipityIconLink spamblockBayesControls" onclick="return ham({$eclpen.id})" href="{$serendipityBaseURL}index.php?/plugin/learnAction&amp;action=approve&amp;category=ham&amp;id={$eclpen.id}&amp;entry_id={$eclpen.entry_id}">
                                            <img src="{serendipity_getFile file='admin/img/accept.png'}" alt="" />
                                            {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_HAM}
                                        </a> 
                                    </li>
                                    <li class="mod_spam" title="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_NAME}: {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_SPAM}">
                                        <a id="spam{$eclpen.id}" class="serendipityIconLink spamblockBayesControls" onclick="return spam({$eclpen.id})" href="{$serendipityBaseURL}index.php?/plugin/learnAction&amp;action=delete&amp;category=spam&amp;id={$eclpen.id}&amp;entry_id={$eclpen.entry_id}">
                                            <img src="{$thispath}/img/spamblock_bayes.spam.png" alt="" />
                                            {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_SPAM}
                                        </a>
                                    </li>
                                    <li class="mod_rating">
                                        <span class="spamblockBayesRating" title="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_RATING_EXPLANATION}">
                                            <a href="?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=spamblock_bayes&amp;serendipity[subpage]=4&amp;serendipity[comments][{$eclpen.id}]">
                                                <span id="{$eclpen.id}_rating">{$eclpen.cID}%</span>
                                            </a>
                                            <img src="{serendipity_getFile file='admin/img/admin_msg_note.png'}" alt="[rating]" />
                                        </span>
                                    </li>
                                </ul>
                            </li>
                            {/if}
                        </ul>
                    </div><!-- class comment_boxed end -->
                    
                </div><!-- class serendipity_admin_list_item end -->
            </div><!-- // #comment_{$eclpen.id} end -->
            
            {/foreach}

            <div class="input-boxed">
                <span class="inputtype"><img src="{$thispath}/img/invert.png" alt="" /><input type="button" name="toggle" value="{$CONST.INVERT_SELECTIONS}" onclick="invertSelectionPen()" class="none" /></span>
                <span class="inputtype"><img src="{$thispath}/img/remove.png" alt="" /><input type="submit" name="toggle" value="{$CONST.PLUGIN_DASHBOARD_DELETE_SELECTED}" onclick="return confirm('{$CONST.COMMENTS_DELETE_CONFIRM}')" class="none" /></span>
                <span class="inputtype"><img src="{$thispath}/img/approve.png" alt="" /><input type="submit" name="serendipity[togglemoderate]" value="{$CONST.PLUGIN_DASHBOARD_MODERATE_SELECTED}" class="none" /></span>
            </div>

            {if $spamblockbayes_hookin}
            <div><span>Spamschutz (Bayes): </span></div>
            <div class="bayes-boxed">
                <span class="inputtype"><img src="{serendipity_getFile file='admin/img/accept.png'}" alt="" /><input type="button" onclick="markAllHam()" name="toggle" value="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_HAMBUTTON}" class="none" /></span>
                <span class="inputtype"><img src="{$thispath}/img/spamblock_bayes.spam.png" alt="" /><input type="button" onclick="markAllSpam()" name="toggle" value="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_SPAMBUTTON}" class="none" /></span>
            </div>
            {/if}
        </form>
        
        {/if}
        
   </div>
  </div>
{/if}

