{if $showElementComPend}
<section id="pending-comments">
    <div id="sort_{$commpen_block_id}" class="dashboard dashboard_comments_pending">
        <h3> {$CONST.COMMENTS_FILTER_NEED_APPROVAL} [ {$entry_Compendlist|@count} ]</h3>

        {if is_array($entry_Compendlist)}

        <form id="formMultiDeletePen" action="#" method="POST" name="formMultiDeletePen">
            {$formtoken}
            <input type="hidden" name="serendipity[formAction]" value="multiDelete" />

            {foreach from=$entry_Compendlist item=eclpen name='bar'}

            <div id="comment_{$eclpen.id}">

                <div id="cpl_{$eclpen.id}" class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"}{if $eclpen.status == 'pending' || $eclpen.status == 'confirm'} serendipity_admin_comment_pending{/if}">
                    <input id="multi-select-comment-{$eclpen.id}" class="input_checkbox" type="checkbox" name="serendipity[delete][{$eclpen.id}]" value="{$eclpen.entry_id}" onclick="toogle_checkbox('ckbx_{$eclpen.id}', this.checked)" tabindex="{$smarty.foreach.bar.iteration}" />
                    <div class="comment_titel">
                        <label for="multi-select-comment-{$eclpen.id}">{$CONST.INCLUDE_COMMENT_SELECTION|@sprintf:$CONST.COMMENT:$eclpen.id:$CONST.IN_SELECTION}</label> - 
                        <label for="multi-select-comment-{$eclpen.id}">{$CONST.IN_REPLY_TO}: <a href="{$eclpen.entry_url}">{$eclpen.title|truncate:48:"&hellip;"}</a>, <time datetime="{$eclpen.pubdate}" pubdate>{$CONST.ON} <img alt="time" src="{serendipity_getFile file="admin/img/clock.png"}" title="{$eclpen.timestamp|@formatTime:'%A, %e. %B %Y'}" /></time></label>
                    </div>
                    <div class="box-right"> <a href="#cl_{$eclpen.id}" class="button"><img src="{serendipity_getFile file="img/plus.png"}" id="option_{$smarty.foreach.bar.iteration}" class="wizard-img" alt="+/-" /> {$CONST.TOGGLE_OPTION}</a> </div>

                    <div id="cpt_{$eclpen.id}" class="comment_text eclpen_text">
                        <div class="summary">{$eclpen.fullBody|strip_tags|truncate:120:"&hellip;"}</div>
                        <div class="fulltxt visuallyhidden">{$eclpen.fullBody|nl2br}</div>
                    </div>

                    <div class="comment_boxed">

                        <ul class="comment_fields">
                            <li class="mod_author"><b>{$CONST.AUTHOR}:</b> {$eclpen.author|truncate:30:"&hellip;"} {$eclpen.action_author} </li>
                            <li class="mod_email"><b>{$CONST.EMAIL}:</b> <a href="mailto:{$eclpen.email}">{$eclpen.email|truncate:30:"&hellip;"|default:'N/A'}</a> </li>
                            <li class="mod_ip"><b>{$CONST.IP}:</b> {$eclpen.ip|default:'0.0.0.0'}</li>
                            <li class="mod_url"><b>{$CONST.URL}:</b> <a href="{$eclpen.url}">{$eclpen.url|truncate:30:"&hellip;"}</a> </li>
                            <li class="mod_referer"><b>{$CONST.REFERER}:</b> <a href="{$eclpen.referer}">{$eclpen.referer|truncate:30:"&hellip;"|default:'N/A'}</a></li>
                        </ul>

                        {if $spamblockbayes_hookin}
                        {** 
                         ** this is very very alpha, as I tried to rewrite things that are done via bayes_commentList.js **
                         ** this is working ~somehow~, except the rating, but errors naturally in the script itself **
                         **}
                        <ul class="mod_spam">
                            <li class="mod_antispam">
                                {* serendipity_hookPlugin hook="backend_view_comment" hookAll="true" *}
                                <a id="ham{$eclpen.id}" class="serendipityIconLink spamblockBayesControls" title="Spamschutz (Bayes): Valid" href="#ham{$eclpen.id}" onclick="ham({$eclpen.id})">
                                    <img alt="" src="{serendipity_getFile file="admin/img/accept.png"}" />
                                    Valid
                                </a>
                                <a id="spam{$eclpen.id}" class="serendipityIconLink spamblockBayesControls" title="Spamschutz (Bayes): Spam" href="#spam{$eclpen.id}" onclick="spam({$eclpen.id})">
                                    <img alt="" src="{$thispath}/../serendipity_event_spamblock_bayes/img/spamblock_bayes.spam.png" />
                                    Spam
                                </a>
                                <span class="spamblockBayesRating">
                                    <a href="serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=spamblock_bayes&amp;serendipity[comments][{$eclpen.id}]">
                                        <span id="{$eclpen.id}_rating">"0%-test"{$rating}</span>
                                    </a>
                                    <span class="serendipityIconLink spamblockBayesControls"><img title="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_RATING_EXPLANATION}" src="{serendipity_getFile file="admin/img/admin_msg_note.png"}" /></span>
                                </span>
                            </li>
                        </ul>
                        {/if}

                        <ul class="comment_admin">
                            <li class="mod_appmod">
                            {if ($eclpen.status == 'pending' || $eclpen.status == 'confirm') && !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=approve&amp;serendipity[id]={$eclpen.id}&amp;{$urltoken}" class="serendipityIconLink" title="{$CONST.APPROVE}"><img src="{serendipity_getFile file="admin/img/accept.png"}" alt="{$CONST.APPROVE}" />{$CONST.APPROVE}</a>
                            {elseif $eclpen.status == 'approved' && !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=pending&amp;serendipity[id]={$eclpen.id}&amp;{$urltoken}" class="serendipityIconLink" title="{$CONST.SET_TO_MODERATED}"><img src="{serendipity_getFile file="admin/img/clock.png"}" alt="{$CONST.SET_TO_MODERATED}" />{$CONST.SET_TO_MODERATED}</a>
                            {else}
                                <a href="#read_only" class="serendipityIconLink" title="{$CONST.READ_ONLY}"><img src="{$thispath}/img/readonly.png" alt="{$CONST.READ_ONLY}" />{$CONST.READ_ONLY}</a>
                            {/if}
                            </li>
                            {if $eclpen.excerpt}
                            <li class="mod_zoom">
                                <a href="#c{$eclpen.id}" title="{$CONST.VIEW}" class="serendipityIconLink toggle_text"><img src="{serendipity_getFile file="admin/img/zoom.png"}" alt="{$CONST.TOGGLE_OPTION}" /><span id="{$eclpen.id}_text" class="text">{$CONST.TOGGLE_OPTION}</span></a>
                            </li>
                            {/if}
                            <li class="mod_view">
                                <a target="_blank" href="{$eclpen.entrylink}" title="{$CONST.VIEW}" class="serendipityIconLink"><img src="{serendipity_getFile file="admin/img/zoom.png"}" alt="{$CONST.VIEW}" />{$CONST.VIEW}</a>
                            </li>
                            <li class="mod_edit">
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=edit&amp;serendipity[id]={$eclpen.id}&amp;serendipity[entry_id]={$eclpen.entry_id}&amp;{$urltoken}" title="{$CONST.EDIT}" class="serendipityIconLink"><img src="{serendipity_getFile file="admin/img/edit.png"}" alt="{$CONST.EDIT}" />{$CONST.EDIT}</a>
                            </li>
                            <li class="mod_delete">
                            {if !$read_only}
                                <a href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=delete&amp;serendipity[id]={$eclpen.id}&amp;serendipity[entry_id]={$eclpen.entry_id}&amp;{$urltoken}" onclick='return confirm("{$eclpen.delete_id}")' title="{$CONST.DELETE}" class="serendipityIconLink"><img src="{serendipity_getFile file="admin/img/delete.png"}" alt="{$CONST.DELETE}" />{$CONST.DELETE}</a>
                            {/if}
                            </li>
                            <li class="mod_reply">
                                <a target="_blank" onclick="cf = window.open(this.href, 'CommentForm', 'width=800,height=600,toolbar=no,scrollbars=1,scrollbars,resize=1,resizable=1'); cf.focus(); return false;" href="?serendipity[action]=admin&amp;serendipity[adminModule]=comments&amp;serendipity[adminAction]=reply&amp;serendipity[id]={$eclpen.id}&amp;serendipity[entry_id]={$eclpen.entry_id}&amp;serendipity[noBanner]=true&amp;serendipity[noSidebar]=true&amp;{$urltoken}" title="{$CONST.REPLY}" class="serendipityIconLink"><img src="{serendipity_getFile file="admin/img/user_editor.png"}" alt="{$CONST.REPLY}" />{$CONST.REPLY}</a>
                            </li>
                        </ul>
                    </div><!-- class comment_boxed end -->

                </div><!-- class serendipity_admin_list_item end -->
                  {$eclpen.action_more}
            </div><!-- #comment_{$eclpen.id} end -->

            {/foreach}

            <input type="button" onclick="invertSelectionPen()" value="{$CONST.INVERT_SELECTIONS}" name="toggle" class="serendipityPrettyButton input_button" />
            <input type="submit" name="toggle" value="{$CONST.DELETE_SELECTED_COMMENTS}" onclick="return confirm('{$CONST.COMMENTS_DELETE_CONFIRM}')" tabindex="{$smarty.foreach.bar.iteration+1}" class="serendipityPrettyButton input_button" />
            <input type="submit" name="serendipity[togglemoderate]" value="{$CONST.MODERATE_SELECTED_COMMENTS}" class="serendipityPrettyButton input_button" />
            {if $spamblockbayes_hookin}
            <span>Spamschutz (Bayes): </span>
            <input type="button" onclick="markAllHam()" name="toogle" value="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_HAMBUTTON}" class="serendipityPrettyButton input_button" />
            <input type="button" onclick="markAllSpam()" name="toogle" value="{$CONST.PLUGIN_EVENT_SPAMBLOCK_BAYES_SPAMBUTTON}" class="serendipityPrettyButton input_button" />
            {/if}
        </form>

        {/if}

    </div>
</section>
{/if}


