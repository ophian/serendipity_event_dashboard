{*** block_info.tpl - last modified 2012-09-03 ***}

{if $showElementInfo}
  <div id="info" class="block-infos block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$CONST.PLUGIN_DASHBOARD_INFO_HEADER}</span></h3>
    <div id="sort_{$info_block_id}" class="block-content block-content-info">
        <div class="table table_content">
            <p class="sub">{$CONST.PLUGIN_DASHBOARD_INFO_CONTENT}</p>
            <table>
                <tbody>
                <tr class="first">
                    <td class="first b b-posts"><a href="serendipity_admin.php?serendipity[adminModule]=entries&serendipity[adminAction]=editSelect"><span class="entry-count">{$infolist.total_entries|default:0}</span></a></td>
                    <td class="t posts"><a href="serendipity_admin.php?serendipity[adminModule]=entries&serendipity[adminAction]=editSelect">{$CONST.PLUGIN_DASHBOARD_INFO_ENTRIES}</a></td>
                </tr>
                <tr>
                    <td class="first b b-imgs"><a href="serendipity_admin.php?serendipity[adminModule]=media"><span class="img-count">{$infolist.total_imgs|default:0}</span></a></td>
                    <td class="t tags"><a href="serendipity_admin.php?serendipity[adminModule]=media">{$CONST.PLUGIN_GROUP_IMAGES}</a></td>
                </tr>
                <tr>
                    <td class="first b b-cats"><a href="serendipity_admin.php?serendipity[adminModule]=category&serendipity[adminAction]=view"><span class="cat-count">{$infolist.total_cats|default:0}</span></a></td>
                    <td class="t cats"><a href="serendipity_admin.php?serendipity[adminModule]=category&serendipity[adminAction]=view">{$CONST.CATEGORIES}</a></td>
                </tr>
                {if $is_freetag_installed}
                <tr>
                    <td class="first b b-tags"><a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=managetags"><span class="tag-count">{$infolist.total_tags|default:0}</span></a></td>
                    <td class="t tags"><a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=managetags">{$CONST.PLUGIN_DASHBOARD_INFO_FREETAGS}</a></td>
                </tr>
                {/if}
                </tbody>
            </table>
        </div>
        <div class="table table_discussion">
            <p class="sub">{$CONST.PLUGIN_DASHBOARD_INFO_DISCUSSION}</p>
            <table>
                <tbody>
                <tr class="first">
                    <td class="b b-comments"><a href="serendipity_admin.php?serendipity[adminModule]=comments"><span class="total-count">{$infolist.total_comts|default:0}</span></a></td>
                    <td class="last t comments"><a href="serendipity_admin.php?serendipity[adminModule]=comments">{$CONST.COMMENTS}</a></td>
                </tr>
                <tr>
                    <td class="b b_approved"><a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[page]=1&serendipity[filter][perpage]=all&serendipity[filter][show]=approved&submit=go"><span class="approved-count">{$infolist.app_comts|default:0}</span></a></td>
                    <td class="last t"><a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[page]=1&serendipity[filter][perpage]=all&serendipity[filter][show]=approved&submit=go" class="approved">{$CONST.PLUGIN_DASHBOARD_INFO_COMMENTS_APPROVED}</a></td>
                </tr>
                <tr>
                    <td class="b b-waiting"><a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[filter][perpage]=all&serendipity[filter][show]=pending&submit=go"><span class="pending-count">{$infolist.pen_comts|default:0}</span></a></td>
                    <td class="last t"><a href="serendipity_admin.php?serendipity[adminModule]=comments&serendipity[filter][perpage]=all&serendipity[filter][show]=pending&submit=go" class="waiting">{$CONST.PLUGIN_DASHBOARD_INFO_COMMENTS_PENDING}</a></td>
                </tr>
                {if $spamblockbayes_hookin}
                <tr>
                    <td class="b b-spam"><a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=spamblock_bayes&serendipity[subpage]=1"><span class="spam-count">{$infolist.total_spam|default:0}</span></a></td>
                    <td class="last t"><a href="serendipity_admin.php?serendipity[adminModule]=event_display&serendipity[adminAction]=spamblock_bayes&serendipity[subpage]=1" class="spam">Spam</a></td>
                </tr>
                {/if}
                </tbody>
            </table>
        </div>
        <div class="versions">
            <p>Theme <span class="b"><a href="serendipity_admin.php?serendipity[adminModule]=templates">"{$sysinfo.theme|upper}"</a></span> {$CONST.PLUGIN_DASHBOARD_INFO_WITH} <span class="b"><a href="serendipity_admin.php?serendipity[adminModule]=plugins">{$sysinfo.widgets} {$CONST.PLUGIN_DASHBOARD_INFO_WIDGETS}</a></span></p>
            <p id="s9y-version-message">{$CONST.PLUGIN_DASHBOARD_INFO_VERSION|sprintf:"<span class='b'>$version</span>."}</p>
            <br class="clear">
        </div>
    </div>
  </div>
{/if}

