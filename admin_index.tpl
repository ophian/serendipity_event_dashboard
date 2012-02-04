<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <title>{$admin_vars.title} - {$CONST.SERENDIPITY_ADMIN_SUITE}</title>
    <meta http-equiv="Content-Type" content="text/html; charset={$CONST.LANG_CHARSET}" />
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="{$serendipityHTTPPath}{$thispath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="{$admin_vars.css_file}" />
    <link rel="stylesheet" type="text/css" href="{$admin_vars.admin_css_file}" />
    <link rel="stylesheet" type="text/css" href="{$serendipityHTTPPath}{$thispath}/css/mbContainer.css" title="style"  media="screen"/>
    
    <script type="text/javascript" src="{$serendipityHTTPPath}{$thispath}/inc/modernizr-2.0.6.min.js"></script>
    <script type="text/javascript" src="{$serendipityHTTPPath}{$thispath}/inc/jquery.min.js"></script>
    <script type="text/javascript" src="{$serendipityHTTPPath}{$thispath}/inc/ajax-dashboard.js"></script>
    <script type="text/javascript" src="{$serendipityHTTPPath}{$thispath}/inc/jquery-dashboard.js"></script>
    <script type="text/javascript" src="{$serendipityHTTPPath}{$thispath}/inc/jquery-ui-1.8.17.custom.min.js"></script>
    <script type="text/javascript" src="{$serendipityHTTPPath}{$thispath}/inc/jquery.metadata.js"></script>
    <script type="text/javascript" src="{$serendipityHTTPPath}{$thispath}/inc/mbContainer.js"></script>
    <script type="text/javascript">
        var const_view = '{$CONST.VIEW_FULL}';
        var const_hide = '{$CONST.HIDE}';
        var img_plus   = '{serendipity_getFile file="img/plus.png"}';
        var img_minus  = '{serendipity_getFile file="img/minus.png"}';
        var jspath     = '{$serendipityHTTPPath}{$thispath}';
        var elpath     = '{$serendipityHTTPPath}{$thispath}/elements/';
    </script>

    <script type="text/javascript">
        {literal}
        function spawn() {
            if (self.Spawnextended) {
                Spawnextended();
            }

            if (self.Spawnbody) {
                Spawnbody();
            }

            if (self.Spawnnugget) {
                Spawnnugget();
            }
        }

        function SetCookie(name, value) {
            var today  = new Date();
            var expire = new Date();
            expire.setTime(today.getTime() + (60*60*24*30*1000));
            document.cookie = 'serendipity[' + name + ']='+escape(value) + ';expires=' + expire.toGMTString();
        }

        function addLoadEvent(func) {
          var oldonload = window.onload;
          if (typeof window.onload != 'function') {
            window.onload = func;
          } else {
            window.onload = function() {
              oldonload();
              func();
            }
          }
        }
        {/literal}

    </script>
    {if $admin_vars.admin_installed}
        {serendipity_hookPlugin hook="backend_header" hookAll="true"}
    {/if}
    
</head>
