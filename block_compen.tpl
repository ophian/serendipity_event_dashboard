{*** block_compen.tpl - last modified 2013-01-14 ***}

{if $showElementComPend}
<div id="compen" class="block-comments block-box clearfix">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><span class="visuallyhidden">{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}</span><br></div>

    <h3 class="flipbox"><span>{$CONST.COMMENTS_FILTER_NEED_APPROVAL} {$CONST.COMMENTS} [ <span class="num">{$entry_Compendlist|@count}</span> ]</span></h3>

    <div id="sort_{$compen_block_id}" class="block-content block-content-comments-pending">
    {if is_array($entry_Compendlist)}    
        <form id="formMultiDeletePen" action="#" method="POST" name="formMultiDeletePen">
            {$formtoken}
            <input type="hidden" name="serendipity[formAction]" value="multiDelete">
            {foreach from=$entry_Compendlist item=eclpen name='bar'}
            <div id="comment_{$eclpen.id}">
                <div id="cpl_{$eclpen.id}" class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"}{if $eclpen.status == 'pending' || $eclpen.status == 'confirm'} serendipity_admin_comment_pending{/if}">
                    <div id="comments_header_{$eclpen.id}" class="comments_header">
                        <input id="multi-select-comment-{$eclpen.id}" class="input_checkbox" type="checkbox" name="serendipity[delete][{$eclpen.id}]" value="{$eclpen.entry_id}" onclick="toggle_checkbox('ckbx_{$eclpen.id}', this.checked)" tabindex="{$smarty.foreach.bar.iteration}" />
                        <div class="comment_titel">
                            <label for="multi-select-comment-{$eclpen.id}" class="num">{$CONST.PLUGIN_DASHBOARD_COMMENT_SELECTION_SHORT|@sprintf:$eclpen.id} - 
                            {$CONST.IN_REPLY_TO}: <a href="{$eclpen.entry_url}" title="{$eclpen.title}">{$eclpen.title|truncate:48:"&hellip;"}</a>, {$CONST.ON} </label><time datetime="{$eclpen.pubdate}" pubdate><span class="icon-clock" title="{$eclpen.timestamp|@formatTime:'%A, %e. %B %Y'}"></span><span class="visuallyhidden"> {$eclpen.timestamp|@formatTime:'%A, %e. %B %Y'}</span></time>
                        </div>

                        <div class="box-right"> <span id="#cl_{$eclpen.id}" class="button"><img src="{serendipity_getFile file='img/plus.png'}" id="option_{$smarty.foreach.bar.iteration}" class="wizard-img" alt="+/-" title="{$CONST.TOGGLE_OPTION}"> </span> </div>
                    </div>

                    <div id="cpt_{$eclpen.id}" class="comment_text eclpen_text">
                        <div class="summary">{$eclpen.fullBody|strip_tags|truncate:120:"&hellip;"}</div>
                        <div class="fulltxt visuallyhidden">{$eclpen.fullBody|nl2br}</div>
                    </div>
                
                    <div class="comment_boxed">
                        <ul class="comment_fields horizontal">
                            <li class="mod_author"><b>{$CONST.AUTHOR}:</b> {$eclpen.author|truncate:30:"&hellip;"} {$eclpen.action_author}</li>
                            <li class="mod_email"><b>{$CONST.EMAIL}:</b> {if $eclpen.email}<a href="mailto:{$eclpen.email}">{$eclpen.email|truncate:30:"&hellip;"}</a>{else}N/A{/if}</li>
                            <li class="mod_ip"><b>{$CONST.IP}:</b> {$eclpen.ip|default:'0.0.0.0'}</li>
                            <li class="mod_url"><b>{$CONST.URL}:</b> {if $eclpen.url}<a href="{$eclpen.url}">{$eclpen.url|truncate:30:"&hellip;"}</a>{else}N/A{/if}</li>
                            <li class="mod_referer"><b>{$CONST.REFERER}:</b> {if $eclpen.referer}<a href="{$eclpen.referer}">{$eclpen.referer|truncate:30:"&hellip;"}</a>{else}N/A{/if}</li>
                        </ul>
                
                        <ul class="comment_admin horizontal">
                            <li class="mod_appmod">
                            {if ($eclpen.status == 'pending' || $eclpen.status == 'confirm') && !$read_only}
                                <a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=approve&amp;serendipity[id]={$eclpen.id}&amp;{$urltoken}" title="{$CONST.APPROVE}"><span id="text_mod_{$eclpen.id}" class="admin-mini-icon icon-ok-circle"></span><span class="visuallyhidden"> {$CONST.APPROVE}</span></a>
                            {elseif $eclpen.status == 'approved' && !$read_only}
                                <a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=pending&amp;serendipity[id]={$eclpen.id}&amp;{$urltoken}" title="{$CONST.SET_TO_MODERATED}"><span id="text_mod_{$eclpen.id}" class="admin-mini-icon icon-cancel-circle"></span><span class="visuallyhidden"> {$CONST.SET_TO_MODERATED}</span></a>
                            {else}
                                <a class="icon_link" href="#read_only" title="{$CONST.READ_ONLY}"><span id="text_mod_{$eclpen.id}" class="admin-mini-icon icon-file"></span><span class="visuallyhidden"> {$CONST.READ_ONLY}</span></a>
                            {/if}
                            </li>
                            {if $eclpen.excerpt}
                            <li class="mod_zoom">
                                <a class="icon_link toggle_text" href="#c{$eclpen.id}" title="{$CONST.PREVIEW}"><span id="text_zoom_{$eclpen.id}" class="text toggle-icon icon-zoom-in"></span><span class="visuallyhidden"> {$CONST.TOGGLE_OPTION}</span></a>
                            </li>
                            {/if}
                            <li class="mod_edit">
                                <a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$eclpen.id}&amp;serendipity[entry_id]={$eclpen.entry_id}&amp;{$urltoken}" title="{$CONST.EDIT}"><span id="text_edit_{$eclpen.id}" class="admin-mini-icon icon-edit"></span><span class="visuallyhidden"> {$CONST.EDIT}</span></a>
                            </li>
                            {if !$read_only}
                            <li class="mod_delete">
                                <a class="icon_link" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=delete&amp;serendipity[id]={$eclpen.id}&amp;serendipity[entry_id]={$eclpen.entry_id}&amp;{$urltoken}" onclick='return confirm("{$eclpen.delete_id}")' title="{$CONST.DELETE}"><span id="text_trash_{$eclpen.id}" class="admin-mini-icon icon-trash"></span><span class="visuallyhidden"> {$CONST.DELETE}</span></a>
                            </li>
                            {/if}
                            <li class="mod_reply">
                                <a class="icon_link" target="_blank" onclick="cf=window.open(this.href, 'CommentForm', 'width=800,height=600,toolbar=no,scrollbars=1,scrollbars,resize=1,resizable=1'); cf.focus(); return false;" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=reply&amp;serendipity[id]={$eclpen.id}&amp;serendipity[entry_id]={$eclpen.entry_id}&amp;serendipity[noBanner]=true&amp;serendipity[noSidebar]=true&amp;{$urltoken}" title="{$CONST.REPLY}"><span id="text_reply_{$eclpen.id}" class="admin-mini-icon icon-chat"></span><span class="visuallyhidden"> {$CONST.REPLY}</span></a>
                            </li>
                            {* if $spamblockbayes_hookin}
                            <li class="mod_bayes">
                                <ul class="horizontal">
                                    <li class="mod_ham" title="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_NAME}: {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_HAM}">
                                        <a id="ham{$eclpen.id}" class="icon_link spamblockBayesControls" onclick="return ham({$eclpen.id})" href="{$serendipityBaseURL}index.php?/plugin/learnAction&amp;action=approve&amp;category=ham&amp;id={$eclpen.id}&amp;entry_id={$eclpen.entry_id}">
                                            <span class="icon-ok-circle"></span><span class="visuallyhidden"> {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_HAM}</span>
                                        </a> 
                                    </li>
                                    <li class="mod_spam" title="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_NAME}: {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_SPAM}">
                                        <a id="spam{$eclpen.id}" class="icon_link spamblockBayesControls" onclick="return spam({$eclpen.id})" href="{$serendipityBaseURL}index.php?/plugin/learnAction&amp;action=delete&amp;category=spam&amp;id={$eclpen.id}&amp;entry_id={$eclpen.entry_id}">
                                            <span class="icon-cancel-circle"></span><span class="visuallyhidden"> {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_SPAM}</span>
                                        </a>
                                    </li>
                                    <li class="mod_rating" title="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_RATING_EXPLANATION}">
                                            <a id="rate{$eclpen.id}" class="icon_link spamblockBayesControls" href="?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=spamblock_bayes&amp;serendipity[subpage]=4&amp;serendipity[comments][{$eclpen.id}]">
                                                <span class="icon-attention-circle"> {$eclpen.cID}%</span><span class="visuallyhidden"> {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_RATING_EXPLANATION}</span>
                                            </a>
                                    </li>
                                </ul>
                            </li>
                            {/if *}
                        </ul>
                    </div><!-- class comment_boxed end -->
                </div><!-- class serendipity_admin_list_item end -->
            </div><!-- // #comment_{$eclpen.id} end -->
            {/foreach}

            <div class="input-boxed">
                <button id="cp-inv" type="button" name="toggle" onclick="invertSelectionPen()" class="none" title="{$CONST.INVERT_SELECTIONS}"><span class="icon-shuffle"></span><span class="visuallyhidden"> {$CONST.INVERT_SELECTIONS}</span></button>
                <button id="cp-del" type="submit" name="toggle" onclick="return confirm('{$CONST.COMMENTS_DELETE_CONFIRM}')" class="none" title="{$CONST.DELETE_SELECTED_COMMENTS}"><span class="icon-trash"></span><span class="visuallyhidden"> {$CONST.DELETE_SELECTED_COMMENTS}</span></button>
                <button id="cp-ok" type="submit" name="serendipity[togglemoderate]" class="none" title="{$CONST.PLUGIN_DASHBOARD_MODERATE_SELECTED}"><span class="icon-ok-circle"></span><span class="visuallyhidden"> {$CONST.PLUGIN_DASHBOARD_MODERATE_SELECTED}</span></button>
        {* if $spamblockbayes_hookin} - // markAllHam hat gelöscht!
                <button id="bayes-ham" class="bayes-button" name="toggle" onclick="markAllHam()" title="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_NAME}: {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_HAMBUTTON}"><span class="icon-ok-circle"></span><span class="visuallyhidden"> {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_HAMBUTTON}</span></button>
                <button id="bayes-spam" class="bayes-button" name="toggle" onclick="markAllSpam()" title="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_NAME}: {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_SPAMBUTTON}"><span class="icon-cancel-circle"></span><span class="visuallyhidden"> {$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_SPAMBUTTON}</span></button>
        {/if *}
            </div>
        </form>    
    {/if}    
    </div>
</div>
{/if}
