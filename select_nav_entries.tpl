<ul class="clearfix serendipitySideBarMenuEntry">
{if 'adminEntries'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=entries&amp;serendipity[adminAction]=new">{$CONST.NEW_ENTRY}</a></li>
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=entries&amp;serendipity[adminAction]=editSelect">{$CONST.EDIT_ENTRIES}</a></li>
{/if}
{if 'adminComments'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=comments">{$CONST.COMMENTS}</a></li>
{/if}
{if 'adminCategories'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=category&amp;serendipity[adminAction]=view">{$CONST.CATEGORIES}</a></li>
{/if}
{if 'adminEntries'|checkPermission OR 'adminEntriesPlugins'|checkPermission}
    {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_entries" hookAll="true"}{/if}
{/if}
    <li class="visuallyhidden"></li>
</ul>
