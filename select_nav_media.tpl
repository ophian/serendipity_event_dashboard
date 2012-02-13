<ul class="serendipitySideBarMenuMedia">
{if 'adminImagesAdd'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=addSelect">{$CONST.ADD_MEDIA}</a></li>
{/if}
{if 'adminImagesView'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media">{$CONST.MEDIA_LIBRARY}</a></li>
{/if}
{if 'adminImagesDirectories'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=directorySelect">{$CONST.MANAGE_DIRECTORIES}</a></li>
{/if}
{if 'adminImagesSync'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=sync" onclick="return confirm('{$CONST.WARNING_THIS_BLAHBLAH}');">{$CONST.CREATE_THUMBS}</a></li>
{/if}
{if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_entries_images" hookAll="true"}{/if}
    <li class="visuallyhidden"></li>
</ul>
