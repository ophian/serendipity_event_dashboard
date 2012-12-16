{*** dashboard_sidebar_nav.tpl - last modified: 2012-12-16 ***}
{*** NAVIGATION-MENU START ***}

        <div id="navbar" class="dashboard_navbar">
            <h2 class="visuallyhidden">Navigation</h2>

            <ul class="clearfix horizontal">
                <li>
                {*** ENTRY LINKS START ***}
                {if 'adminEntries'|checkPermission OR 'adminEntriesPlugins'|checkPermission}
                <h3>{$CONST.ADMIN_ENTRIES}</h3>
                    <ul class="clearfix serendipitySideBarMenuEntry">
                        <li id="menu-e00" class="serendipitySideBarMenuLinkStart"><a href="">{$CONST.NAV_SELECT}</a></li>
                        {if 'adminEntries'|checkPermission}
                        <li id="menu-e01" class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=entries&amp;serendipity[adminAction]=new">{$CONST.NEW_ENTRY}</a></li>
                        <li id="menu-e02" class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=entries&amp;serendipity[adminAction]=editSelect">{$CONST.EDIT_ENTRIES}</a></li>
                        {/if}

                        {if 'adminComments'|checkPermission}
                        <li id="menu-e03" class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=comments">{$CONST.COMMENTS}</a></li>
                        {/if}

                        {if 'adminCategories'|checkPermission}
                        <li id="menu-e04" class="serendipitySideBarMenuLink serendipitySideBarMenuEntryLinks"><a href="serendipity_admin.php?serendipity[adminModule]=category&amp;serendipity[adminAction]=view">{$CONST.CATEGORIES}</a></li>
                        {/if}

                        {if 'adminEntries'|checkPermission OR 'adminEntriesPlugins'|checkPermission}
                        {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_entries" hookAll="true"}{/if}
                        {/if}
                        <li class="visuallyhidden"></li>
                    </ul>
                {/if}
                {*** ENTRY LINKS END ***}
                </li>

                <li>
                {*** MEDIA LINKS START ***}
                {if 'adminImages'|checkPermission}
                <h3>{$CONST.MEDIA}</h3>
                    <ul class="serendipitySideBarMenuMedia">
                        <li id="menu-m00" class="serendipitySideBarMenuLinkStart"><a href="">{$CONST.NAV_SELECT}</a></li>
                        {if 'adminImagesAdd'|checkPermission}
                        <li id="menu-m01" class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=addSelect">{$CONST.ADD_MEDIA}</a></li>
                        {/if}
                        {if 'adminImagesView'|checkPermission}
                        <li id="menu-m02" class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media">{$CONST.MEDIA_LIBRARY}</a></li>
                        {/if}
                        {if 'adminImagesDirectories'|checkPermission}
                        <li id="menu-m03" class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=directorySelect">{$CONST.MANAGE_DIRECTORIES}</a></li>
                        {/if}
                        {if 'adminImagesSync'|checkPermission}
                        <li id="menu-m04" class="serendipitySideBarMenuLink serendipitySideBarMenuMediaLinks"><a href="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=sync" onclick="return confirm('{$CONST.WARNING_THIS_BLAHBLAH}');">{$CONST.CREATE_THUMBS}</a></li>
                        {/if}
                        {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_entries_images" hookAll="true"}{/if}
                        <li class="visuallyhidden"></li>
                    </ul>
                {/if}
                {*** MEDIA LINKS END ***}
                </li>

                <li>
                {*** APPEARANCE START ***}
                {if 'adminTemplates'|checkPermission OR 'adminPlugins'|checkPermission}
                <h3>{$CONST.APPEARANCE}</h3>
                    <ul class="serendipitySideBarMenuAppearance">
                        <li id="menu-a00" class="serendipitySideBarMenuLinkStart"><a href="">{$CONST.NAV_SELECT}</a></li>
                        {if 'adminTemplates'|checkPermission}
                        <li id="menu-a01" class="serendipitySideBarMenuLink serendipitySideBarMenuAppearanceLinks"><a href="serendipity_admin.php?serendipity[adminModule]=templates">{$CONST.MANAGE_STYLES}</a></li>
                        {/if}
                        {if 'adminPlugins'|checkPermission}
                        <li id="menu-a02" class="serendipitySideBarMenuLink serendipitySideBarMenuAppearanceLinks"><a href="serendipity_admin.php?serendipity[adminModule]=plugins">{$CONST.CONFIGURE_PLUGINS}</a></li>
                        {/if}
                        {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_admin_appearance" hookAll="true"}{/if}
                        <li class="visuallyhidden"></li>
                    </ul>
                {/if}
                {*** APPEARANCE END ***}
                </li>

                <li>
                {*** USER MANAGEMENT START ***}
                {if 'adminUsersGroups'|checkPermission OR 'adminImport'|checkPermission OR 'siteConfiguration'|checkPermission OR 'blogConfiguration'|checkPermission OR 'adminUsers'|checkPermission}
                <h3>{$CONST.ADMIN}</h3>
                    <ul class="serendipitySideBarMenuUserManagement">
                        <li id="menu-u00" class="serendipitySideBarMenuLinkStart"><a href="">{$CONST.NAV_SELECT}</a></li>
                        {if 'siteConfiguration'|checkPermission OR 'blogConfiguration'|checkPermission}
                        <li id="menu-u01" class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=configuration">{$CONST.CONFIGURATION}</a></li>
                        {/if}
                        {if 'adminUsers'|checkPermission}
                        <li id="menu-u02" class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=users">{$CONST.MANAGE_USERS}</a></li>
                        {/if}
                        {if 'adminUsersGroups'|checkPermission}
                        <li id="menu-u03" class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=groups">{$CONST.MANAGE_GROUPS}</a></li>
                        {/if}
                        {if 'adminImport'|checkPermission}
                        <li id="menu-u04" class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=import">{$CONST.IMPORT_ENTRIES}</a></li>
                        <li id="menu-u05" class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=export">{$CONST.EXPORT_ENTRIES}</a></li>
                        {/if}
                        {if 'siteConfiguration'|checkPermission || 'blogConfiguration'|checkPermission}
                        <li id="menu-u06" class="serendipitySideBarMenuLink serendipitySideBarMenuUserManagementLinks"><a href="serendipity_admin.php?serendipity[adminModule]=integrity">{$CONST.INTEGRITY}</a></li>
                        {/if}
                        {if $admin_vars.no_create !== true} {serendipity_hookPlugin hook="backend_sidebar_admin" hookAll="true"}{/if}
                        <li class="visuallyhidden"></li>
                    </ul>
                {/if}
                {*** USER MANAGEMENT END ***}
                </li>
            </ul>
        </div>
{*** NAVIGATION-MENU END ***}
