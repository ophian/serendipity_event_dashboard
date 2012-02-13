<ul class="serendipitySideBarMenuAppearance">
{if 'adminTemplates'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuAppearanceLinks"><a href="serendipity_admin.php?serendipity[adminModule]=templates">{$CONST.MANAGE_STYLES}</a></li>
{/if}
{if 'adminPlugins'|checkPermission}
    <li class="serendipitySideBarMenuLink serendipitySideBarMenuAppearanceLinks"><a href="serendipity_admin.php?serendipity[adminModule]=plugins">{$CONST.CONFIGURE_PLUGINS}</a></li>
{/if}
    {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_admin_appearance" hookAll="true"}{/if}
    <li class="visuallyhidden"></li>
</ul>
