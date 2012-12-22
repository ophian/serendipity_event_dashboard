{*** block_info.tpl - last modified 2012-12-16 ***}

{if $showElementInfo}
<div id="info" class="block-infos block-box clearfix">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><span class="visuallyhidden">{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}</span><br></div>

    <h3 class="flipbox"><span>{$CONST.PLUGIN_DASHBOARD_INFO_HEADER}</span></h3>

    <div id="sort_{$info_block_id}" class="block-content block-content-info clearfix">
        <div class="table table_content">
            <h4 class="sub">{$CONST.PLUGIN_DASHBOARD_INFO_CONTENT}</h4>

            <ul class="plainList">
                <li class="first">
                    <a href="serendipity_admin.php?serendipity[adminModule]=entries&serendipity[adminAction]=editSelect">
                        <span class="first b b-posts"><span class="entry-count">{$infolist.total_entries|default:0}</span></span>
                        <span class="t posts">{$CONST.PLUGIN_DASHBOARD_INFO_ENTRIES}</span>
                    </a>
                </li>
                <li>
                    <a href="serendipity_admin.php?serendipity[adminModule]=media">
                        <span class="first b b-imgs"><span class="img-count">{$infolist.total_imgs|default:0}</span></span>
                        <span class="t tags">{$CONST.PLUGIN_GROUP_IMAGES}</span>
                    </a>
                </li>
                <li>
                    <a href="serendipity_admin.php?serendipity[adminModule]=category&serendipity[adminAction]=view">
                        <span class="first b b-cats"><span class="cat-count">{$infolist.total_cats|default:0}</span></span>
                        <span class="t cats">{$CONST.CATEGORIES}</span>
                    </a>
                </li>
            {if $is_freetag_installed}
                <li>
                    <a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=managetags">
                        <span class="first b b-tags"><span class="tag-count">{$infolist.total_tags|default:0}</span></span>
                        <span class="t tags">{$CONST.PLUGIN_DASHBOARD_INFO_FREETAGS}</span>
                    </a>
                </li>
            {/if}
            </ul>
        </div>

        <div class="table table_discussion">
            <h4 class="sub">{$CONST.PLUGIN_DASHBOARD_INFO_DISCUSSION}</h4>

            <ul class="plainList">
                <li class="first">
                    <a href="serendipity_admin.php?serendipity[adminModule]=comments">
                        <span class="b b-comments"><span class="total-count">{$infolist.total_comts|default:0}</span></span>
                        <span class="last t comments">{$CONST.COMMENTS}</span>
                    </a>
                </li>
                <li>
                    <a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[page]=1&serendipity[filter][perpage]=all&serendipity[filter][show]=approved&submit=go">
                        <span class="b b_approved"><span class="approved-count">{$infolist.app_comts|default:0}</span></span>
                        <span class="last t">{$CONST.PLUGIN_DASHBOARD_INFO_COMMENTS_APPROVED}</span>
                    </a>
                </li>
                <li>
                    <a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[filter][perpage]=all&serendipity[filter][show]=pending&submit=go">
                        <span class="b b-waiting"><span class="pending-count">{$infolist.pen_comts|default:0}</span></span>
                        <span class="last t">{$CONST.PLUGIN_DASHBOARD_INFO_COMMENTS_PENDING}</span>
                    </a>
                </li>
                {if $spamblockbayes_hookin}
                <li>
                    <a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=spamblock_bayes&serendipity[subpage]=1">
                        <span class="b b-spam"><span class="spam-count">{$infolist.total_spam|default:0}</span></span>
                        <span class="last t">Spam</span> {* i18n *}
                    </a>
                </li>
                {/if}
            </ul>
        </div>

        <ul class="versions plainList">
            <li>Theme <span class="b"><a href="serendipity_admin.php?serendipity[adminModule]=templates">"{$sysinfo.theme|upper}"</a></span> {$CONST.PLUGIN_DASHBOARD_INFO_WITH} <span class="b"><a href="serendipity_admin.php?serendipity[adminModule]=plugins">{$sysinfo.widgets} {$CONST.PLUGIN_DASHBOARD_INFO_WIDGETS}</a></span></li>
            <li id="s9y-version-message">{$CONST.PLUGIN_DASHBOARD_INFO_VERSION|sprintf:"<span class='b'>$version</span>."}</li>
        </ul>
    </div>
</div>
{/if}
