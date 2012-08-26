// usage: log('inside coolFunc', this, arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = function f(){ log.history = log.history || []; log.history.push(arguments); if(this.console) { var args = arguments, newarr; args.callee = args.callee.caller; newarr = [].slice.call(args); if (typeof console.log === 'object') log.apply.call(console.log, console, newarr); else console.log.apply(console, newarr);}};

// make it safe to use console.log always
(function(a){function b(){}for(var c="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),d;!!(d=c.pop());){a[d]=a[d]||b;}})
(function(){try{console.log();return window.console;}catch(a){return (window.console={});}}());
// Attention: do not use paulirish log() method, as making our events behave different

// jquery-dashboard.js - last-modified: 2012-08-26

/**
 * Start main functions on document.ready = load in DOM
 **/
jQuery(document).ready(function($) {

    // define some global vars
    var isRunBlocksort = false; // defines BlockSort use

    // each containers [t_ = toggle, c_ = click]
    var meta       = ['#meta-box-left, #meta-box-right'];
    var c_text     = ['#info, #draft, #future, #update, #plugup'];
    var t_text     = ['#comapp, #compen, #feed'];
    var t_form     = ['#formMultiDeleteApp, #formMultiDeletePen'];

    // start object selectors
    var $button    = $('#menu-fadenav');
    var $sidebar   = $('#serendipitySideBar');
    var $selectbar = $('#user-menu-user-navigation-select');

    // storage containers
    var arr        = []; // array
    var obj        = {}; // object

    // strings
    var pathname           = $(location).attr('pathname').replace('serendipity_admin.php', '');
    var hostname           = $(location).attr('hostname');
    var protocol           = $(location).attr('protocol');
    var img_plus           = pathname + 'templates/default/img/plus.png';
    var img_minus          = pathname + 'templates/default/img/minus.png';
    var img_help2          = dashpath + 'img/help_oran.png';
    var img_help1          = dashpath + 'img/help_blue.png';
    var learncommentPath   = protocol + '//' + hostname + pathname + 'index.php?/plugin/learncomment';
    var ratingPath         = protocol + '//' + hostname + pathname + 'index.php?/plugin/getRating';
    var bayesHelpImage     = pathname + 'templates/default/admin/img/admin_msg_note.png';
    var bayesLoadIndicator = pathname + 'img/spamblock_bayes.load.gif';

    // check to see if cookies exist for the flip box toggle state
    var flipcookie = $.cookie('serendipity[dashboard][cookie_flipped]');
    var fliparray  = flipcookie ? flipcookie.split("|").getUnique() : [];

    // var functions
    /**
     * Function Expression runBlockSort(storageobject) [OK]
     * 
     * Retrieves the object from storage and manipulates Block IDs
     **/
    runBlockSort = (function(bsarr) {
        var newsortid = 0;
        jQuery.each(bsarr, function(i, v){
            $.each(v, function( key, value ) {
                if ( key == 0 ) { 
                    storedMeta = value; // = metas | needs to be global in scope!!!
                }
                if ( key > 0 ) {
                    var storedBlockId = this[0];
                    var storedSortId  = this[1];
                    var newid         = 'LS-'+storedMeta+'-'+storedSortId; // if storedMeta not set global, this will be the obj of changing key instead, eg 's9y-plugup,sort_3' and the -sort_3-new
                    var $sortthis     = $('#'+storedBlockId); // even faster as singulary node, no need for add #layout

                    // replace the sort id by newsortid, which must depend on '#layout > li.flipflop' count, do not use LS- prefix while using toggle cookie return info
                    $sortthis.find('div.dashboard').attr("id", 'sort_'+newsortid);

                    // also add new id to flipbox h3 title
                    $sortthis.find('h3.flipbox').attr("id", newid);

                    // return global var set to true, to prevent attracting h3.flipbox id in function setStorageArray(), as running later
                    isRunBlocksort = true;

                    // console.log('newsortid: '+newsortid+' storedBlockId: '+storedBlockId+ ' && storedSortId: meta '+storedSortId);
                    newsortid++;
                }
            });
        });
    });

    /**
     * Function Expression setLocalStorage(array) [OK]
     * 
     * Feature detect + clear + local reference
     **/
    setLocalStorage = (function(sid) {
        var storage, fail, uid;
        try {
            uid = new Date;
            (storage = window.localStorage).setItem(uid, uid);
            fail = storage.getItem(uid) != uid;
            storage.removeItem(uid);
            fail && (storage = false);
        } catch(e) {}
        // Remove old items first
        localStorage.removeItem('sortid');

        // Put the array/object into storage
        localStorage.setItem('sortid', JSON.stringify(sid)); 
    });
    
    /**
     * Function Expression setStorageArray(metaid, metaobject) [OK]
     * 
     * Returns the new Storage array by new arranged meta and block object
     **/
    setStorageArray = (function($metaid, $metaobj) {
        var $metaArr = [$metaid];

        $metaobj.find('.flipbox').attr("id", function (index) { 
            var $bid = $(this).closest('div[id].block-box').attr('id').toString();
            // stick to array and do not use objects here, as objects key can not be $var, returns "$bid"
            $metaArr.push([$bid, 'sort_'+index]);
            // do not return new flipbox h3 title ID, if that was done by function runBlockSort
            if( isRunBlocksort === false ) return $metaid+"-sort_" + index;
        });
        if( isRunBlocksort === false) {
            // set the sort_X ID to the new dragged value, if that was not! done by function runBlockSort
            $metaobj.find('div.dashboard').attr("id", function (indexblock) { 
                return "sort_" + indexblock; 
            });
        }
        // push both meta arrays to globar arr
        arr.push($metaArr);
    });

    /**
     * Function Expression setCustomTooltip() [OK]
     * 
     * Sets the Tooltips first element and removes others by attr()
     * Calls the setStorageArray(id, object) and 
     * Sets setLocalStorage(array)
     **/
    setCustomTooltip = (function() {
        var fstBHead  = 'Click to group block items together,<br>Move to drag single or grouped items'; // firstBlocksHeadHelpTitle custom headtooltip
        arr = []; // will remove preset sort array from DOM

        $('#layout').on('click', '.block-box > h3.flipbox', function() {
            //void
        }).find(meta.join(', ')).each(addTooltip);
        
        function addTooltip() {
            var $metaid = this.id;
            var $thisobj = $(this); // = [ul#meta-box-left.boxed-left] + [ul#meta-box-right.boxed-right]
            // set dragged and sorted blocks into Storage
            setStorageArray($metaid, $thisobj);
            // set new first blocks title
            $thisobj.children("li:first").find(".flipbox").attr('title', fstBHead);
        }
       
        // lastly put the returned array/object into storage
        setLocalStorage(arr);
    });

    /**
     * Function Expression setContainersHeight() [OK]
     * 
     * Sets the #layout containers height on demand
     **/
    setContainersHeight = (function() {
        var newLayout = $("#meta-box-left").height();
        var rightBox  = $("#meta-box-right").height();
        if(newLayout < rightBox) { var newLayout = rightBox; }
        $("#layout").css("height", newLayout +10 + 'px'); // 10px seperation space between meta and layout
        //return newLayout +10;
    });

    /**
     * Function Expression unsetUIHightlight(object) [OK]
     * 
     * Removes this selectors upper li class ui-state-highlight on click flip and toogle buttons
     **/
    unsetUIHightlight = (function(obj) {
        obj.closest('li.flipflop').removeClass('ui-state-highlight');
    });

    /**
     * Function Expression runTooltip() [OK]
     * 
     * The Tooltip function
     **/
    runTooltip = (function() {
        // Default tooltip settings
        var offsetX = 5;
        var offsetY = 22;
        var TooltipOpacity = 1;

        setCustomTooltip(); // init customtitles

        // Select all tags having a title attribute
        $('[title]').mouseenter(function(e) {

            // Get the value of the title attribute
            var Tooltip = $(this).attr('title');

            if(Tooltip !== '') {
                // Tooltip exists. Assign it to a custom attribute
                $(this).attr('customTooltip',Tooltip);

                // Empty title attribute (to ensure that native browser tooltip is not shown)
                $(this).attr('title','');
            }

            // Assign customTooltip to variable
            var customTooltip = $(this).attr('customTooltip');

            // Tooltip exists? Added undefined check to avoid removeAttr returning empty attribute string values
            if(customTooltip !== '' && customTooltip !== undefined) {
                // Append tooltip element to body
                $("body").append('<div id="tooltip">' + customTooltip + '</div>');

                // Set X and Y coordinates for Tooltip
                $('#tooltip').css('left', e.pageX + offsetX );
                $('#tooltip').css('top', e.pageY + offsetY );

                // FadeIn effect for Tooltip
                $('#tooltip').fadeIn('500');
                $('#tooltip').fadeTo('10',TooltipOpacity);
            }

        }).mousemove(function(e) {
            var X = e.pageX;
            var Y = e.pageY;
            var tipToBottom, tipToRight;

            // Distance to the right
            tipToRight = $(window).width() - (X + offsetX + $('#tooltip').outerWidth() + 5);

            // Tooltip too close to the right?
            if(tipToRight < offsetX) {
                X = e.pageX + tipToRight;
            }

            // Distance to the bottom
            tipToBottom = $(window).height() - (Y + offsetY + $('#tooltip').outerHeight() + 5); // document ?

            // Tooltip too close to the bottom?
            if(tipToBottom < offsetY) {
                // Y = e.pageY + tipToBottom; // we dont want this
                Y = e.pageY - (offsetY + $('#tooltip').outerHeight() + 5);
            }

            // Assign tooltip position
            $('#tooltip').css('left', X + offsetX );
            $('#tooltip').css('top', Y + offsetY );

        }).mouseleave(function() {
            // Remove tooltip element
            $("body").children('div#tooltip').remove();
        });
    });

    /**
     * Remember flipped box content that was hidden
     **/
    $(function() {
        $.each( fliparray, function(){
            var blocktohide = $('#' + this).find('div[id].dashboard').attr('id');
            // hide all sort_ID boxes which appear in fliparray
            $('#' + blocktohide).hide(); // do we need to setContainersHeight() ?
        });
    });

    /**
     * If LocalStorage is available and is preset with array/object, start fnc runBlockSort()
     **/
    $(function() {
        if ( isLocalStorage === true ) {
            // Retrieve the object from storage
            var blocksort = JSON.parse(localStorage.getItem('sortid'));
            if ( blocksort !== null ) {
                // hand over the parsed array to be truly readable
                runBlockSort(blocksort); // meta-box-left,[object Object] etc 
            }
        }
    });

    /**
     * Initialize tooltip on DOM ready
     **/
    $(function() {
        runTooltip();
    });

    /**
     * Try to init #layout height on document ready
     * As we couldn't use 'jQuery(window).load(' w/o IE9 alerts, we use this here instead
     **/
    $(function(){
        setContainersHeight(); // set to height of highest meta-box-xxx
    });

    /**
     * Some selectors Startup Manipulations on DOM ready
     **/
    $(function() {
        // remove overview.inc's echo drop-in, if set
        $('h3.serendipityWelcomeBack').addClass('visuallyhidden');

        // set .serendipityAdminContent left padding class on default
        $('td.serendipityAdminContent').addClass('serendipityAdminContentDashboard');
    
        // add missing class to #serendipitySideBar
        $sidebar.addClass('no-class');
    
        // Rename sidebar Button 'Startpage' to 'Dashboard'
        $sidebar.find('li.serendipitySideBarMenuMainFrontpage a').html('Dashboard');
    });

    /**
     * Toggle the comments view more block on click
     **/
    $(function() {
        $(t_form.join(', ')).find('.comment_boxed').addClass('visuallyhidden');
        $(t_text.join(', ')).find('.box-right').click(function() { 
            // set the class and change the src the first time
            $(this).parent().siblings('.comment_boxed').toggleClass('visuallyhidden');
            $(this).children().find('img').stop(true, true).attr({src:img_minus});
            // now toggle src target each time
            $(this).children('.button').toggle( 
                function () { 
                    $(this).find('img').stop(true, true).attr({src:img_plus});
                    $(this).parents().next().siblings('.comment_boxed').toggleClass('visuallyhidden');
                    unsetUIHightlight($(this));
                }, 
                function () { 
                    $(this).find('img').stop(true, true).attr({src:img_minus});
                    $(this).parents().next().siblings('.comment_boxed').toggleClass('visuallyhidden');
                    unsetUIHightlight($(this));
                }
            );
            unsetUIHightlight($(this));
            // set new id#layout height on toogle inside 
            setContainersHeight();
        });
    });
    
    /**
     * On click feed/comments input-* buttons unset ui-highlight parent box
     **/
    $(function() {
        $(t_text.join(', ')).find('span, a, img, div.comment_titel, div.input-boxed, div.bayes-boxed, div.feed_title, ul.feed_fields').click(function(){
            unsetUIHightlight($(this));
        });
        $(c_text.join(', ')).find('a, p, span, table, ul, time, input[type=submit], button').click(function(){
            unsetUIHightlight($(this));
        });
    });

    /**
     * Toggle the feed/comments text block and change view/hide constant on event
     **/
    $(function() {
        $(t_text.join(', ')).find('.fulltxt').addClass('visuallyhidden');
        $(t_text.join(', ')).find('.text').toggle( 
            function (event) { 
                $(event.target).html(const_hide);
                $(this).closest('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden'); // OK
                $(this).find('img').attr({src:"templates/default/admin/img/downarrow.png"}); // OK
                unsetUIHightlight($(this));
                // set new id#layout height on toogle inside 
                setContainersHeight();
            }, 
            function (event) { 
                $(event.target).html(const_view);
                $(this).closest('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden'); // OK
                $(this).find('img').attr({src:"templates/default/admin/img/uparrow.png"}); // OK
                unsetUIHightlight($(this));
                // set new id#layout height on toogle inside 
                setContainersHeight();
            }
        );
    });

    /**
     * Help button hover on mouseover
     **/
    $(function() {
        $('#iopen.help').hover(function() { 
            $(this).find('img').stop(true, true).attr({src:img_help2}); // .fadeOut()
        }, function() { 
            $(this).find('img').stop(true, true).attr({src:img_help1}); // .fadeIn()
        });
    });

    /**
     * Toogle (flip) and store to Cookie the block-box function on click [OK]
     **/
    $(function() {
        $(meta.join(', ')).find('.flip').click(function() {
            $(this).each(addNSet);

            function updateCookie(block, el) {
                var indx = el.attr('id');
                var tmp = fliparray.getUnique();
                if (block.is(':hidden')) { // :visible
                    // add index of widget to hidden list
                    tmp.push(indx);
                } else {
                    // remove element id from the list
                    tmp.splice( tmp.indexOf(indx) , 1);
                }
                fliparray = tmp.getUnique();
                $.cookie('serendipity[dashboard][cookie_flipped]', fliparray.join('|'), { expires: 180, path: pathname, domain: hostname });
            }

            function addNSet() {
                $(this).siblings('div').toggle('slow', function() {
                    // set new id#layout height on flip, as flip is a single event only
                    setContainersHeight();
                    // get closest parent li element object as this is unique only in both metas
                    var parliobj = $(this).closest('li');
                    // set cookie to hold the blocks hidden state
                    updateCookie( $(this), parliobj ); // elem_ID is the static number we want, use this for the cookie!
                });
                // unsets this parents li .flipflop class ui-state-highlight, if active
                unsetUIHightlight($(this));
            }
        });
    });

    /**
     * Toogle autoupdater header note [OK]
     **/
    $(function() {
        $("#menu-autoupdate").toggle( 
            function (event) { 
                $(this).parents().siblings('#user-menu-user-welcome').find('span').hide();
                $('#boxed_autoupdate').toggleClass('visuallyhidden');
            }, 
            function (event) { 
                $(this).parents().siblings('#user-menu-user-welcome').find('span').show();
                $('#boxed_autoupdate').toggleClass('visuallyhidden');
            }
        );
    });

    /**
     * Toggle between embed mode navigation per side-bar or select-bar on button click
     * and set the side/select-bar cookie on slide navigation click event [OK]
     **/
    $(function() { 
        $button.click(function(e){
            e.preventDefault();
            // let the function toogle sidebar/selectbar as stated and set cookie to hold the state
            // .is(":visible") // Checks for display:[none|block], ignores visible:[true|false]
            if ($sidebar.is(':visible')) {
                $sidebar.fadeOut();
                $.cookie('serendipity[dashboard][cookie_sidebar]', 'isSelectBar', { expires: 180, path: pathname, domain: hostname });
            } else {
                $sidebar.fadeIn();
                $.cookie('serendipity[dashboard][cookie_sidebar]', 'isSideBar', { expires: 180, path: pathname, domain: hostname });
            }
            $selectbar.toggleClass('visuallyhidden');
        });

        // check to see if a cookie exists for the app state
        var cookie_sidebar = $.cookie('serendipity[dashboard][cookie_sidebar]');
        if(cookie_sidebar == 'isSelectBar') { 
            $sidebar.fadeOut();
            $selectbar.toggleClass('visuallyhidden');
        } else {
            $sidebar.fadeIn();
        }

        // make sure everything outside dashboard has the normal 'isSideBar' Layout!
        if ( !$('#dashboard').children().length > 0 ) { 
            $sidebar.fadeIn();
            $('td.serendipityAdminContent').removeClass('serendipityAdminContentDashboard');
        }
    });

    /**
     * Convert backend sidebar entries to dropdown select box - case each selector [OK]
     **/
    $(function() {
        var base = '#indent-navigation ';
        var selectors = [
            'ul.serendipitySideBarMenuEntry',
            'ul.serendipitySideBarMenuMedia',
            'ul.serendipitySideBarMenuAppearance',
            'ul.serendipitySideBarMenuUserManagement'
        ];

        // we can just use 'select' tag w/o selectors here, as this is strictly based to base id only
        $(base).on('click', 'select > option', function() {
            location.href = $(this).val();
        }).find(selectors.join(', ')).each(linksToSelect);

        function linksToSelect() {
            var $this = $(this);
            var $class = $this.attr("class").replace(/[-\s\w]*?([-\w]+)\s?$/, '$1'); // is greedy, replaces first elements clearfix
            var $select = $(document.createElement('select'))
                .addClass($class);

            $this.find('a').each(function() {
                var $a = $(this);
                $(document.createElement('option'))
                    .val($a.attr('href'))
                    .text($a.text())
                    .appendTo($select);
            });

            $this.replaceWith($select);
        }
    });

    /**
     * The metabox drag and drop funtion via jquery-ui framework [OK]
     **/
    $(function() {
        var selectedClass = 'ui-state-highlight',
            clickDelay = 600,
            // click time (milliseconds)
            lastClick, diffClick; // timestamps

        // set to flipflop class only! 
        $("#layout li.flipflop")
        // Script to deferentiate a click from a mousedown for drag event
        .bind('mousedown mouseup', function(e) {
            if (e.type == "mousedown") {
                lastClick = e.timeStamp; // get mousedown time
            } else {
                diffClick = e.timeStamp - lastClick;
                if (diffClick < clickDelay) {
                    // add selected class to group draggable objects
                    $(this).toggleClass(selectedClass);
                }
            }
        })
        .draggable({
            revertDuration: 10,
            // grouped items animate separately, so leave this number low
            containment: '#layout',
            start: function(e, ui) {
                ui.helper.addClass(selectedClass);
            },
            stop: function(e, ui) {
                // reset group positions
                $('.' + selectedClass).css({
                    top: 0,
                    left: 0
                });
            },
            drag: function(e, ui) {
                // set selected group position to main dragged object
                // this works because the position is relative to the starting position
                $('.' + selectedClass).css({
                    top: ui.position.top,
                    left: ui.position.left
                });
            }
        });
        
        $(meta.join(', ')).sortable().droppable({
            drop: function(e, ui) {
                $('.' + selectedClass).appendTo($(this)).add(ui.draggable) // ui.draggable is appended by the script, so add it after
                .removeClass(selectedClass).css({
                    top: 0,
                    left: 0
                }).find("h3.flipbox").removeAttr('title customtooltip'); // and remove customtooltip header if class was the first child of meta

                // set new id#layout height on drop and sort
                setContainersHeight();

                // define BlockSort use to false again, as we now have a dropped object, which needs new sort ids by setStorageArray()
                isRunBlocksort = false;

                // restart function tooltip to reset the first elements tooltip on drop and sort
                runTooltip();

                // keep upgrading localStorage
                setLocalStorage(arr);

                var sobj = $('#'+this.id).find('li[id].flipflop');
                var $postMetaArr = [$('#'+this.id)]; // eg. #meta-box-right
                
                sobj.attr("id", function (index) { 
                    // this = li.flipflop
                    var $dropid = $(this).attr('id').toString(); // collect li#ID name as string
                    var $blockid = $(this).find('div.block-box');
                    var $blid = $blockid.attr('id');
                    $postMetaArr.push(['#'+$dropid, $blid]); // stick to array and do not use objects here
                });

                $url = pathname + 'plugin/dbjsonsort/';
                
                // Post the array via external_plugin to Plugins config storage
                jQuery.post($url, {json: JSON.stringify($postMetaArr)}/*, function(data){ alert(data); }*/);
            }
        });
    });
    
    /**
     * Set service maintenance mode on click
     **/
    $(function(){
        var set = typeof servicehook !== 'undefined' ? servicehook : false; // avoid reloading missmatch
        $("#moma").on("click", function(){
            set = !set; // toogle boolean
            alert( $(this).text() + ' = ' + set + "\n\n" + const_service); // is button text + attention const
            $url = pathname + 'plugin/modemaintence/';
                
            // Post the set/unset via external_plugin to Plugins config storage - pass booleans as (set?1:0)
            jQuery.post($url, {setmoma: (set?1:0)});
        });
    });
   

    /**
     * JQuery.mb.containerPlus help
     **/
    $(function(){
        // custom method added to the component
        $.containerize.addMethod("modal",function(){
            var el = this;

            function openModal(o){
                var $overlay=$("<div/>").attr("id","mb_overlay").css({position:"fixed",width:"100%", height:"100%", top:0, left:0, background:"#000", opacity:.7}).hide();

                if($("#mb_overlay").length)
                    return;

                $("body").prepend($overlay);
                $overlay.mb_bringToFront();
                o.mb_bringToFront();

                o.containerize("centeronwindow",false);
                $overlay.fadeIn(300);
            }

            function closeModal(o){
                $("#mb_overlay").fadeOut(300,function(){$(this).remove();})
            }

            var opt = {
                onRestore:function(o){openModal(o.$)},
                onClose: function(o){closeModal(o.$)}
            };

            $.extend (el.opt,opt);
        });

        $(".container").containerize();

        // custom Buttons for the toolbar
        var changeSkinBtn = $("<button/>").addClass("mbc_button").html("change skin").click(function(e){
            var el = $(this).parents(".mbc_container");
            if(!el.hasClass('black')) el.containerize('skin','black'); else el.containerize('skin');
            e.stopPropagation();
            e.preventDefault();
        });

        var fullScreenBtn = $("<button/>").addClass("mbc_button").html("full screen").click(function(e){
            var el = $(this).parents(".mbc_container");
            el.containerize("fullScreen");
            e.stopPropagation();
            e.preventDefault();
        });

        var closeBtn = $("<button/>").addClass("mbc_button").html("close").click(function(e){
            var el = $(this).parents(".mbc_container");
            el.containerize("close");
            e.stopPropagation();
            e.preventDefault();
        });

        $("#cont1").containerize("addtotoolbar", [fullScreenBtn,changeSkinBtn,closeBtn]);

    });
  
    /**
     * Debug elements used
     * 
     * count how much selectors used - faster access, the more less - .length = count 
     * use with ('*') all selectors, or selector tagNames, idNames, classNames etc.
     **/
    $(function(){
        // console.log( $('*').length );
    });
}); // close jQuery document ready

/**
 * Init #layout height on window load = DOM and full Content load ready
 * As we can't use 'jQuery(window).load(' here w/o IE9 alerts, we have to check undefined
 * See also document ready init
 **/
jQuery(window).load(function() {
    if(typeof setContainersHeight !== 'undefined') setContainersHeight(); // set to height of highest meta-box-xxx
}); // close jQuery window load
