// usage: log('inside coolFunc', this, arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = function f(){ log.history = log.history || []; log.history.push(arguments); if(this.console) { var args = arguments, newarr; args.callee = args.callee.caller; newarr = [].slice.call(args); if (typeof console.log === 'object') log.apply.call(console.log, console, newarr); else console.log.apply(console, newarr);}};

// make it safe to use console.log always
(function(a){function b(){}for(var c="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),d;!!(d=c.pop());){a[d]=a[d]||b;}})
(function(){try{console.log();return window.console;}catch(a){return (window.console={});}}());
// do we need this if we use jquery.cookie?
//var s9yCookies={each:function(d,a,c){var e,b;if(!d){return 0}c=c||d;if(typeof(d.length)!="undefined"){for(e=0,b=d.length;e<b;e++){if(a.call(c,d[e],e,d)===false){return 0}}}else{for(e in d){if(d.hasOwnProperty(e)){if(a.call(c,d[e],e,d)===false){return 0}}}}return 1},getHash:function(b){var c=this.get(b),a;if(c){this.each(c.split("&"),function(d){d=d.split("=");a=a||{};a[d[0]]=d[1]})}return a},setHash:function(b,c,a,f,d,e){var g="";this.each(c,function(i,h){g+=(!g?"":"&")+h+"="+i});this.set(b,g,a,f,d,e)},get:function(c){var d=document.cookie,g,f=c+"=",a;if(!d){return}a=d.indexOf("; "+f);if(a==-1){a=d.indexOf(f);if(a!=0){return null}}else{a+=2}g=d.indexOf(";",a);if(g==-1){g=d.length}return decodeURIComponent(d.substring(a+f.length,g))},set:function(b,e,a,g,c,f){var h=new Date();if(typeof(a)=="object"&&a.toGMTString){a=a.toGMTString()}else{if(parseInt(a,10)){h.setTime(h.getTime()+(parseInt(a,10)*1000));a=h.toGMTString()}else{a=""}}document.cookie=b+"="+encodeURIComponent(e)+((a)?"; expires="+a:"")+((g)?"; path="+g:"")+((c)?"; domain="+c:"")+((f)?"; secure":"")},remove:function(a,b){this.set(a,"",-1000,b)}};function getUserSetting(a,b){var c=getAllUserSettings();if(c.hasOwnProperty(a)){return c[a]}if(typeof b!="undefined"){return b}return""}function setUserSetting(c,f,b){if("object"!==typeof userSettings){return false}var d="s9y-settings-"+userSettings.uid,e=s9yCookies.getHash(d)||{},g=userSettings.url,h=c.toString().replace(/[^A-Za-z0-9_]/,""),a=f.toString().replace(/[^A-Za-z0-9_]/,"");if(b){delete e[h]}else{e[h]=a}s9yCookies.setHash(d,e,31536000,g);s9yCookies.set("s9y-settings-time-"+userSettings.uid,userSettings.time,31536000,g);return c}function deleteUserSetting(a){return setUserSetting(a,"",1)}function getAllUserSettings(){if("object"!==typeof userSettings){return{}}return s9yCookies.getHash("s9y-settings-"+userSettings.uid)||{}};

// jquery-dashboard.js - last-modified: 2012-06-22

// Q: Is $(this).siblings() the same as $(this).parent().children()
// A: No.
//    $(this).parent().children() selects all the children of the parent (including $(this)).
//    $(this).siblings() includes all the children of the parent except for $(this)
//    $(this).closest('classname') walks the DOM tree upwards until match
//    $(this).children().find('searchtag') falls down the tree until tag matches

// Attention: do not use paulirish log() method, as making our events behave different

jQuery(document).ready(function($) {

    // remove overview.inc's echo drop-in
    $('h3.serendipityWelcomeBack').addClass('visuallyhidden');
    // remove defaults important span colour //$('span').css(" !important", "");//.removeAttr('style');
    // This technique does not remove a style that has been applied with a CSS rule in a stylesheet or <style> element
    // in special properties with !important, while these need overrides with !important too.
    //$('.serendipityAdminContent span').attr('style','color: #464646 !important');  // this sets an inline style to childrens span elements

    // remove Spartacus Plugin 'backend_pluginlisting_header' < S9y 1.7 PlugUp notice break markup
    // <br /><div id="upgrade_notice" class="serendipityAdminMsgSuccess...
    // this did work before, I swear! but now this is pre-captured and replaced by php
    //$('div.dashboard_plugup').children().nextUntil(':not(br)').remove();
    //$('div.dashboard_plugup').children().nextAll('br').remove();

    // toggle comments view more block
    $('.comment_boxed').addClass('visuallyhidden');
    $('.box-right').click(function() { 
        // console.log(this);
        // set the class and change the src the first time
        $(this).parent().siblings('.comment_boxed').toggleClass('visuallyhidden');
        $(this).children().find('img').stop(true, true).attr({src:img_minus}); 
        // now toggle src target each time
        $(this).children('.button').toggle( 
            function () { 
                $(this).find('img').stop(true, true).attr({src:img_plus});
                $(this).parents().next().siblings('.comment_boxed').toggleClass('visuallyhidden');
            }, 
            function () { 
                //console.log(this); // <a class="button" href="#cpl_%">
                $(this).find('img').stop(true, true).attr({src:img_minus});
                $(this).parents().next().siblings('.comment_boxed').toggleClass('visuallyhidden');
            }
        );
    });
    // the toggle show/hide all button
    //$('.comment_toggleall').addClass('visuallyhidden');
    $('.all-box-right').click(function() { 
        // set the class and change the src the first time
        $(this).siblings('.comment_toggleall').toggleClass('visuallyhidden');
        $(this).children().find('img').stop(true, true).attr({src:img_minus});
        // now toggle src target each time
        $(this).children('.button').toggle( 
            function () { 
                $(this).find('img').stop(true, true).attr({src:img_plus});
                $(this).parent().siblings('.comment_toggleall').toggleClass('visuallyhidden');
            }, 
            function () { 
                //console.log(this); // <a class="button" href="#ta_%">
                $(this).find('img').stop(true, true).attr({src:img_minus});
                $(this).parent().siblings('.comment_toggleall').toggleClass('visuallyhidden');
            }
        );
    });

    // toggle comments text block and change view/hide constant on event
    $('.fulltxt').addClass('visuallyhidden');
    $('.text').toggle( 
      function (event) { 
        $(event.target).html(const_hide);
        $(this).closest('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden'); // OK
      }, 
      function (event) { 
        $(event.target).html(const_view);
        $(this).closest('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden'); // OK
      });

    // set a margin to fits child of the two rows, entries and updates
    $("#dashboard .block-comments:first").addClass("first");
    $("#dashboard .block-entries:first").addClass("first");
    $("#dashboard .block-updates:first").addClass("first");

    // check if in dashboard w/o or anywhere with old sidebar left
    if ($("tr td:first-child").hasClass("serendipityAdminContent")) { 
        $("td.serendipityAdminContent").removeClass("serendipityAdminContent noClass").addClass("serendipityAdminContentnoSb");
    };

    // help button hover
    $('button.help').hover(function() { 
        $(this).find('img').stop(true, true).attr({src:img_help2});//.fadeOut()
    }, function() { 
        $(this).find('img').stop(true, true).attr({src:img_help1});//.fadeIn()
    });

    // navigation event
    $("button.navi").toggle( 
      function (event) { 
        //console.log('button.navi: click-minus');
        $(event.target).siblings().toggleClass('visuallyhidden');
        $(event.target).find('img').stop(true, true).attr({src:img_minus});
      }, 
      function (event) { 
        //console.log('button.navi: click-plus');
        $(event.target).siblings().toggleClass('visuallyhidden');
        $(event.target).find('img').stop(true, true).attr({src:img_plus});
    });

    // toggle between embed mode navigation per side-bar or select-bar
    // td#serendipitySideBar and nav#user-menu-user-navigation-select
    $('nav#user-menu-user-navigation-select').addClass('visuallyhidden');
    $('td#serendipitySideBar').addClass('no-class');
    $("img.slidenav").toggle( 
      function (event) { 
        //console.log('toogle slidenav: click-in');
        $('td#serendipitySideBar').fadeOut();//.toggleClass('visuallyhidden');
        $('nav#user-menu-user-navigation-select').toggleClass('visuallyhidden');
        $('td.serendipityAdminContent').addClass('serendipityAdminContentDashboard');
      }, 
      function (event) { 
        //console.log('toogle slidenav: click-out');
        $('td#serendipitySideBar').fadeIn();//.toggleClass('visuallyhidden');
        $('nav#user-menu-user-navigation-select').toggleClass('visuallyhidden');
        $('td.serendipityAdminContent').removeClass('serendipityAdminContentDashboard');
    });

    // toogle block-box function
    $('.flip').click(function() {
        var boxid = this.parentNode.id;
        $(this).closest('.flip').siblings().find('div').toggle('slow', function() {
            $('.block-box').css({minHeight:"0"});
            $('.dashboard').css({minHeight:"0"});// Animation complete.
        });
    });

    // autoupdater note
    $("span#menu-autoupdate").toggle( 
      function (event) { 
        //console.log('toogle autoupdate: click-in');
        $(this).parents().siblings('#user-menu-user-welcome').find('span').hide();
        $('#boxed_autoupdate').toggleClass('visuallyhidden');
      }, 
      function (event) { 
        //console.log('toogle autoupdate: click-out');
        $(this).parents().siblings('#user-menu-user-welcome').find('span').show();
        $('#boxed_autoupdate').toggleClass('visuallyhidden');
    });

    // set cookie on slidenav click event
    var $layouts = $('td#serendipitySideBar, .nav#user-menu-user-navigation-select'), // cache objects
        $button  = $('img.slidenav');                                                 // to avoid overhead

    $button.click(function(e, className) { 
        e.preventDefault();
        // let the function toogle as stated
        $layouts.toggle();
        // set cookie to hold the state
        $.cookie('shown_type', ($layouts.eq(0).is(':visible') ? 'isSideBar' : 'isSelectBar'));
        //console.log(className);
    });

    // check to see if a cookie exists for the app state
    var shown_type = $.cookie('shown_type');
    if(shown_type == 'isSelectBar') { 
        //$button.trigger('click', [shown_type]); // yes, a cookie exist, show this layout
        $('td#serendipitySideBar').fadeOut();
        $('nav#user-menu-user-navigation-select').toggleClass('visuallyhidden');
        $('td.serendipityAdminContent').addClass('serendipityAdminContentDashboard');
        //console.log('Cookie: '+shown_type);
    } else { 
        //$button.trigger('click', ['td#serendipitySideBar']); // no, a cookie does not exist, show td#serendipitySideBar by default
        $('td#serendipitySideBar').fadeIn();
        $('nav#user-menu-user-navigation-select').addClass('visuallyhidden');
        $('td.serendipityAdminContent').removeClass('serendipityAdminContentDashboard');
        //console.log('Cookie: '+shown_type);
    }

    // make sure everything outside dashboard has the normal 'isSideBar' Layout!
    if ( !$('#dashboard').children().length > 0 ) { 
        $('td#serendipitySideBar').fadeIn();
        //$('nav#user-menu-user-navigation-select').toggleClass('visuallyhidden');
        $('td.serendipityAdminContent').removeClass('serendipityAdminContentDashboard');
    }

    // convert backend sidebar entries to dropdown select box - case entries
    $(function() { 
        $('ul#indent-navigation ul.serendipitySideBarMenuEntry').each(function() { 
            var $select = $('<select />').attr('class', 'serendipitySideBarMenuEntry');

            $(this).find('a').each(function() { 
                var $option = $('<option />');
                $option.attr('value', $(this).attr('href')).html($(this).html()).click(function(){window.location.href=$(this).val();});
                $select.append($option);
            });

            $(this).replaceWith($select);
        });
    });

    // convert backend sidebar entries to dropdown select box - case media
    $(function() { 
        $('ul#indent-navigation ul.serendipitySideBarMenuMedia').each(function() { 
            var $select = $('<select />').attr('class', 'serendipitySideBarMenuMedia');

            $(this).find('a').each(function() { 
                var $option = $('<option />');
                $option.attr('value', $(this).attr('href')).html($(this).html()).click(function(){window.location.href=$(this).val();});
                $select.append($option);
            });

            $(this).replaceWith($select);
        });
    });

    // convert backend sidebar entries to dropdown select box - case appearance
    $(function() { 
        $('ul#indent-navigation ul.serendipitySideBarMenuAppearance').each(function() { 
            var $select = $('<select />').attr('class', 'serendipitySideBarMenuAppearance');

            $(this).find('a').each(function() { 
                var $option = $('<option />');
                $option.attr('value', $(this).attr('href')).html($(this).html()).click(function(){window.location.href=$(this).val();});
                $select.append($option);
            });

            $(this).replaceWith($select);
        });
    });

    // convert backend sidebar entries to dropdown select box - case userManagement
    $(function() { 
        $('ul#indent-navigation ul.serendipitySideBarMenuUserManagement').each(function() { 
            var $select = $('<select />').attr('class', 'serendipitySideBarMenuUserManagement');

            $(this).find('a').each(function() { 
                var $option = $('<option />');
                $option.attr('value', $(this).attr('href')).html($(this).html()).click(function(){window.location.href=$(this).val();});
                $select.append($option);
            });

            $(this).replaceWith($select);
        });
    });

    $(function() { 
      function openModal(o) { 
        var $overlay=$("<div/>").attr("id","mb_overlay").css({position:"fixed",width:"100%", height:"100%", top:0, left:0, background:"#000", opacity:.7}).hide();
        $("body").prepend($overlay);
        $overlay.mb_bringToFront();
        o.mb_bringToFront();
        o.mb_centerOnWindow(false);
        $overlay.fadeIn(500);
      }
      function closeModal(o) { 
        $("#mb_overlay").fadeOut(500,function(){$(this).remove();})
      }

      $(".containerPlus").buildContainers({
        containment:"document",
        elementsPath:elpath,
        dockedIconDim:45,
        onCreate:function(o){},
        onClose:function(o){closeModal(o)},
        onRestore:function(o){openModal(o)},
        onIconize:function(o){},
        effectDuration:300
      });
    });

}); // close jQuery
