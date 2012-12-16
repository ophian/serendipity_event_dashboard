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
                    <span class="first b b-posts"><a href="serendipity_admin.php?serendipity[adminModule]=entries&serendipity[adminAction]=editSelect"><span class="entry-count">{$infolist.total_entries|default:0}</span></a></span>
                    <span class="t posts"><a href="serendipity_admin.php?serendipity[adminModule]=entries&serendipity[adminAction]=editSelect">{$CONST.PLUGIN_DASHBOARD_INFO_ENTRIES}</a></span>
                </li>
                <li>
                    <span class="first b b-imgs"><a href="serendipity_admin.php?serendipity[adminModule]=media"><span class="img-count">{$infolist.total_imgs|default:0}</span></a></span>
                    <span class="t tags"><a href="serendipity_admin.php?serendipity[adminModule]=media">{$CONST.PLUGIN_GROUP_IMAGES}</a></span>
                </li>
                <li>
                    <span class="first b b-cats"><a href="serendipity_admin.php?serendipity[adminModule]=category&serendipity[adminAction]=view"><span class="cat-count">{$infolist.total_cats|default:0}</span></a></span>
                    <span class="t cats"><a href="serendipity_admin.php?serendipity[adminModule]=category&serendipity[adminAction]=view">{$CONST.CATEGORIES}</a></span>
                </li>
            {if $is_freetag_installed}
                <li>
                    <span class="first b b-tags"><a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=managetags"><span class="tag-count">{$infolist.total_tags|default:0}</span></a></span>
                    <span class="t tags"><a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=managetags">{$CONST.PLUGIN_DASHBOARD_INFO_FREETAGS}</a></span>
                </li>
            {/if}
            </ul>
        </div>

        <div class="table table_discussion">
            <h4 class="sub">{$CONST.PLUGIN_DASHBOARD_INFO_DISCUSSION}</h4>

            <ul class="plainList">
                <li class="first">
                    <span class="b b-comments"><a href="serendipity_admin.php?serendipity[adminModule]=comments"><span class="total-count">{$infolist.total_comts|default:0}</span></a></span>
                    <span class="last t comments"><a href="serendipity_admin.php?serendipity[adminModule]=comments">{$CONST.COMMENTS}</a></span>
                </li>
                <li>
                    <span class="b b_approved"><a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[page]=1&serendipity[filter][perpage]=all&serendipity[filter][show]=approved&submit=go"><span class="approved-count">{$infolist.app_comts|default:0}</span></a></span>
                    <span class="last t"><a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[page]=1&serendipity[filter][perpage]=all&serendipity[filter][show]=approved&submit=go" class="approved">{$CONST.PLUGIN_DASHBOARD_INFO_COMMENTS_APPROVED}</a></span>
                </li>
                <li>
                    <span class="b b-waiting"><a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[filter][perpage]=all&serendipity[filter][show]=pending&submit=go"><span class="pending-count">{$infolist.pen_comts|default:0}</span></a></span>
                    <span class="last t"><a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[filter][perpage]=all&serendipity[filter][show]=pending&submit=go" class="waiting">{$CONST.PLUGIN_DASHBOARD_INFO_COMMENTS_PENDING}</a></span>
                </li>
                {if $spamblockbayes_hookin}
                <li>
                    <span class="b b-spam"><a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=spamblock_bayes&serendipity[subpage]=1"><span class="spam-count">{$infolist.total_spam|default:0}</span></a></span>
                    <span class="last t"><a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=spamblock_bayes&serendipity[subpage]=1" class="spam">Spam</a></span>
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
