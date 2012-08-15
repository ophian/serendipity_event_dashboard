{*** block_feed.tpl - last modified 2012-08-14 ***}

{if $showElementFeed}
  <div id="feed" class="block-infos block-box">
    <div class="flip" title="{$CONST.PLUGIN_DASHBOARD_FLIPNOTE}"><br></div>
    <h3 class="flipbox"><span>{$feed_header}</span></h3>
    <div id="sort_{$feed_block_id}" class="dashboard dashboard_feed">
            {foreach from=$s9yblogfeed item=feed name='rssblogfeed'}
            
            <div id="feed_{$smarty.foreach.rssblogfeed.iteration}">
                
                <div id="feedlist_{$smarty.foreach.rssblogfeed.iteration}" class="serendipity_admin_list_item serendipity_admin_list_item_{cycle values="even,uneven"}">
                    <div id="feed_header_{$smarty.foreach.rssblogfeed.iteration}" class="feed_header">
                        <div class="feed_title">
                            <label for="multi-select-feed-{$smarty.foreach.rssblogfeed.iteration}" class="num">{$CONST.PLUGIN_DASHBOARD_COMMENT_SELECTION_SHORT|@sprintf:$smarty.foreach.rssblogfeed.iteration}</label>
                            <label for="multi-select-feed-{$smarty.foreach.rssblogfeed.iteration}"><span title="{$feed.timestamp|@formatTime:'%Y-%m-%d'}"> [{$feed.timestamp|@formatTime:'%Y-%m-%d'}]</span> - <a href="{$feed.link}" title="{$feed.title}">{$feed.title|truncate:58:"&hellip;"}</a> <time datetime="{$feed.pubDate}" pubdate></time></label>
                        </div>
                    </div>
                    {if $show_feedcontent}
                    <div id="ft_{$smarty.foreach.rssblogfeed.iteration}" class="comment_text feed_text">
                        <div class="summary">{$feed.content|strip_tags|truncate:180:"&hellip;"}</div>
                        <div class="fulltxt visuallyhidden">{$feed.content}</div>
                    </div>
                    {/if}
                    <div class="feed_boxed">

                        <ul class="feed_fields">
						    {if $show_feedcontent}
                            <li class="mod_zoom">
                                <a href="#f{$smarty.foreach.rssblogfeed.iteration}" title="{$CONST.VIEW}" class="serendipityIconLink toggle_text"><span id="text_{$smarty.foreach.rssblogfeed.iteration}" class="text toggle-icon"><img src="{serendipity_getFile file='admin/img/uparrow.png'}" title="{$CONST.TOGGLE_OPTION}" alt="[Zoom]" /></span></a>
                            </li>
							{/if}
							{if $show_feedauthor}
                            <li class="mod_author"><b>{$CONST.AUTHOR}:</b> {$feed.author|truncate:30:"&hellip;"} {$feed.action_author} </li>
							{/if}
							{if $show_feedconum}
                            <li class="mod_comments"><b>{$CONST.COMMENTS}: [ <span class="num">{$feed.countcomments}</span> ]</b> {if $feed.comments}<a href="{$feed.comments}" title="{$feed.comments|truncate:60:"&hellip;"}">Link</a>{else}N/A{/if} </li>
							{/if}
                        </ul>
                
                    </div><!-- class feed_boxed end -->
                    
                </div><!-- class serendipity_admin_list_item end -->
            </div><!-- // #feed_{$smarty.foreach.rssblogfeed.iteration} end -->

            {/foreach}

    </div>
  </div>
{/if}