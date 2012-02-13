<ul class="serendipitySideBarMenuUserManagement">
{if 'siteConfiguration'|checkPermission OR 'blogConfiguration'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=configuration">{$CONST.CONFIGURATION}</a></li>
{/if}
{if 'adminUsers'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=users">{$CONST.MANAGE_USERS}</a></li>
{/if}
{if 'adminUsersGroups'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=groups">{$CONST.MANAGE_GROUPS}</a></li>
{/if}
{if 'adminImport'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=import">{$CONST.IMPORT_ENTRIES}</a></li>
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=export">{$CONST.EXPORT_ENTRIES}</a></li>
{/if}
{if 'siteConfiguration'|checkPermission || 'blogConfiguration'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=integrity">{$CONST.INTEGRITY}</a></li>
{/if}
    {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_admin" hookAll="true"}{/if}
    <li class="visuallyhidden"></li>
</ul>
