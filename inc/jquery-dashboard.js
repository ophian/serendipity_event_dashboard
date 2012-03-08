// usage: log('inside coolFunc', this, arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = function f(){ log.history = log.history || []; log.history.push(arguments); if(this.console) { var args = arguments, newarr; args.callee = args.callee.caller; newarr = [].slice.call(args); if (typeof console.log === 'object') log.apply.call(console.log, console, newarr); else console.log.apply(console, newarr);}};

// make it safe to use console.log always
(function(a){function b(){}for(var c="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),d;!!(d=c.pop());){a[d]=a[d]||b;}})
(function(){try{console.log();return window.console;}catch(a){return (window.console={});}}());

// jquery-dashboard.js - last-modified: 2012-02-09

// Q: Is $(this).siblings() the same as $(this).parent().children()
// A: No.
//    $(this).parent().children() selects all the children of the parent (including $(this)).
//    $(this).siblings() includes all the children of the parent except for $(this)
//    $(this).closest('classname') walks the DOM tree upwards until match
//    $(this).children().find('searchtag') falls down the tree until tag matches

jQuery(document).ready(function($) {

    // remove overview.inc's echo drop-in
    $('h3.serendipityWelcomeBack').addClass('visuallyhidden');
    
    // toggle comments view more block
    $('.comment_boxed').addClass('visuallyhidden');
    $('.box-right').click(function() {
        // set the class and change the src the first time
        $(this).siblings('.comment_boxed').toggleClass('visuallyhidden');
        $(this).children().find('img').stop(true, true).attr({src:img_minus}); 
        // now toggle src target each time
        $(this).children('.button').toggle( 
            function () { 
                $(this).find('img').stop(true, true).attr({src:img_plus}); 
                $(this).parent().siblings('.comment_boxed').toggleClass('visuallyhidden');
            }, 
            function () { 
                //console.log(this); // <a class="button" href="#cpl_%">
                $(this).find('img').stop(true, true).attr({src:img_minus}); 
                $(this).parent().siblings('.comment_boxed').toggleClass('visuallyhidden');
            }
        );
    });

    // the toggle show/hide all button
    $('.comment_toggleall').addClass('visuallyhidden');
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
        //$(this).parent().parent().parent().parent().siblings('.comment_text').children().toggleClass('visuallyhidden'); // OK
        //$(this).closest('.comment_boxed').siblings('.comment_text').children('.comment_text').children().toggleClass('visuallyhidden'); // OK
        $(this).closest('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden'); // OK
        //$('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden'); // does not halt on ID
      },
      function (event) {
        $(event.target).html(const_view);
        //$(this).parent().parent().parent().parent().siblings('.comment_text').children().toggleClass('visuallyhidden'); // OK
        $(this).closest('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden'); // OK
        //$('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden'); // does not halt on ID
      });
      
    // set a margin to fits child of the two rows, entries and updates
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
        //console.log('click-minus');
        $(event.target).siblings().toggleClass('visuallyhidden');
        $(event.target).find('img').stop(true, true).attr({src:img_minus});
      },
      function (event) {
        //console.log('click-plus');
        $(event.target).siblings().toggleClass('visuallyhidden');
        $(event.target).find('img').stop(true, true).attr({src:img_plus});
    });
    
    // toggle between embed mode navigation per side-bar or select-bar
    // td#serendipitySideBar and nav#user-menu-user-navigation-select
    $('nav#user-menu-user-navigation-select').addClass('visuallyhidden');
    $('td#serendipitySideBar').addClass('no-class');
    $("img.slidenav").toggle(
      function (event) {
        //console.log('click-in');
        $('td#serendipitySideBar').fadeOut();
        $('nav#user-menu-user-navigation-select').toggleClass('visuallyhidden');
        $('td.serendipityAdminContent').addClass('serendipityAdminContentDashboard');
      },
      function (event) {
        //console.log('click-out');
        $('td#serendipitySideBar').fadeIn();
        $('nav#user-menu-user-navigation-select').toggleClass('visuallyhidden');
        $('td.serendipityAdminContent').removeClass('serendipityAdminContentDashboard');
    });


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

    // help Container
    $(function(){
      function openModal(o){
        var $overlay=$("<div/>").attr("id","mb_overlay").css({position:"fixed",width:"100%", height:"100%", top:0, left:0, background:"#000", opacity:.7}).hide();
        $("body").prepend($overlay);
        $overlay.mb_bringToFront();
        o.mb_bringToFront();
        o.mb_centerOnWindow(false);
        $overlay.fadeIn(500);
      }
      function closeModal(o){
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
