// usage: log('inside coolFunc', this, arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = function f(){ log.history = log.history || []; log.history.push(arguments); if(this.console) { var args = arguments, newarr; args.callee = args.callee.caller; newarr = [].slice.call(args); if (typeof console.log === 'object') log.apply.call(console.log, console, newarr); else console.log.apply(console, newarr);}};

// make it safe to use console.log always
(function(a){function b(){}for(var c="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),d;!!(d=c.pop());){a[d]=a[d]||b;}})
(function(){try{console.log();return window.console;}catch(a){return (window.console={});}}());
// Attention: do not use paulirish log() method, as making our events behave different

// jquery-dashboard.js - last-modified: 2013-04-10

if (typeof String.prototype.startsWith != 'function') {
  String.prototype.startsWith = function (str){
    return this.slice(0, str.length) == str;
  };
}
/**
 *  This is a simple prototype plugin which converts 'a,form,select,button' targets dynamically into AJAX requests
 **/
$.fn.ajax_submit = function(degurl) {
    var callback  = $(this).attr('data-callback'); // = rebuildContainer
    var $thisscope = $('#cont2 .mbc_content'); // not 'this' or 'document.body' - $thisscope can't be a global var, as it its build on load later on
    // create the url
    var url = $(this).attr('action') || $(this).attr('href') || degurl;
    if (typeof url === 'undefined') { 
        var url = ''; 
    } else {
        var url = url +(url.search.length ? '&' : '?')+'serendipity[noHeading]=true'; // reduced, as the rest is done in dashboards backend_configure hook
    }
    var url = url.replace('.html&','.html?'); // tests
    var url = url.replace('.php&','.php?');
    var url = url.replace('?&','?');
    // create the method
    var method = "" + $(this).attr('method'); // fasted method to stringify is ""+
    var method = (method.toUpperCase() == 'POST' || method == '' || method == 'undefined') ? 'POST' : 'GET';
    // append submit button value to query string, which is left out by default $(this).serialize()
    if ($(this).attr('action')) {
        var $itsu  = $(this).find('input[type="submit"]');
        var $itim  = $(this).find('input[type="image"]');
        var name   = $itsu.attr('name');
        var value  = $itsu.attr('value'); 
        if (typeof name === 'undefined') {
            var name   = 'submit['+$(this).closest('[id]').attr('id')+']'; // some submits don't have a name attribute
        }
        if (typeof value === 'undefined' && $itim.length) { 
            var x = ($itim.attr('value') ? $itim.attr('value') : 8); // fake mouse coords to also send input type=image request i.e. $_POST[change_selected]
            $itim.after('<input type="hidden" name="'+$itim.attr('name')+'" value="'+x+'" />'); 
            var value = 'clicked';
        }
        var appmit = '&' + name + '=' + value; // could be written analog to itim.after
    }
    // we can not use plain encodeURIComponent(appmit) here as it encodes = and &, but not !
    var appmit = appmit ? encodeURIComponent(appmit).replace(/[!'()*]/g, escape).replace('%26','&').replace('%3D','=') : '';

    // ToDo workaround this bad button w/ context behaviour, or disable ajax like: if request page has scripts goto location.href else use ajax and container
    $.ajax({
        data: $(this).serialize() + appmit,
        type: method,
        dataType: 'html',
        url: url,
        async: false,
        context: $thisscope,
        success: function(data, status, xhr) {
            // return cut data from/to into container; cut is starting in front of expression.
            var hasString = '<td class="serendipityAdminContent">';
            if (data.lastIndexOf(hasString) != -1) {
                resultdata = containersCut('<td class="serendipityAdminContent">', '</td>', data);
            } else {
                resultdata = containersCut('<div id="content" class="clearfix">', '</div>', data);
            }
            if (callback) {
                if (typeof callback == 'function') { // make sure the callback is a function
                    callback.call(this, resultdata, url); // brings the scope to the callback
                } else {
                    rebuildContainer.call(this, resultdata, url); // if callback is not willing to be a function, try with our real function name
                }
            }
        },
        error: function(xhr, status, error) {
            console.log(error);
        },
        complete: function( xhr ) { loadSpin('OFF'); } //Hide spinner
        /**
        .success() gets called only, if the server responds with a 200 OK HTTP header
        .complete() will always get called, no matter if the ajax call was successful or not - even after error returns
        and that .complete() will get called after .success() gets called
        http://api.jquery.com/ajaxComplete/
        http://api.jquery.com/ajaxSuccess/
        **/
   });
};

$.fn.autoAjax = function(delegatedUrl) {
    $(this).ajax_submit(delegatedUrl); // and then?
    return false;
};

/**
 * Start main functions on document.ready = load in DOM
 **/
jQuery(document).ready(function($) {

    // define some global vars
    var isRunBlocksort = false; // defines BlockSort use
    var isSetService   = typeof servicehook !== 'undefined' ? servicehook : false; // avoid reloading missmatch

    // each containers [t_ = toggle, c_ = click]
    var meta       = ['#meta-box-left, #meta-box-right'];
    var c_text     = ['#info, #draft, #future, #update, #plugup'];
    var t_text     = ['#comapp, #compen, #feed'];
    var t_form     = ['#formMultiDeleteApp, #formMultiDeletePen'];
    var c_blocks   = ['#draft, #future, #plugup, #comapp, #compen, #info'];

    // start object selectors
    var $button    = $('#menu-fadenav');
    var $sidebar   = $('#main_menu');
    //var $sidebar   = $('#serendipitySideBar'); // 1.6.x
    var $selectbar = $('#nav-navigation-select');

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
    var result             = '';
    var logoff_text        = "Gotcha!\n" + 
                             "I remember me saying: 'Do not log off while Maintenance Mode'!\n" + 
                             "Note: There is no return if you proceed!\n\n" + 
                             "Do you really want to log off now?\n\n" +
                             "Then please unset maintenance mode first!"; /* scare user! ;-) Actually the origin problem with maintenance supercookie should be solved by now...*/

    // check to see if cookies exist for the flip box toggle state
    var flipcookie = $.cookie('serendipity[dashboard_cookie_flipped]');
    var fliparray  = flipcookie ? flipcookie.split("|").getUnique() : [];

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

                    // replace the sort id by newsortid, which must depend on '#layout > section.flipflop' count, do not use LS- prefix while using toggle cookie return info
                    $sortthis.find('div.block-content').attr("id", 'sort_'+newsortid);

                    // also add new id to flipbox h3 title
                    $sortthis.find('h3.flipbox').attr("id", newid);

                    // return global var set to true, to prevent attracting h3.flipbox id in function setStorageArray(), as running later
                    isRunBlocksort = true;

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
            $metaArr.push([$bid, 'sort_'+index]); // stick to array and do not use objects here, as objects key can not be $var, returns "$bid"
            // do not return new flipbox h3 title ID, if that was done by function runBlockSort
            if( isRunBlocksort === false ) return $metaid+"-sort_" + index; //else return $bid;
        });
        if( isRunBlocksort === false) {
            // set the sort_X ID to the new dragged value, if that was not! done by function runBlockSort
            $metaobj.find('div.block-content').attr("id", function (indexblock) { 
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
            var $thisobj = $(this); // = [div#meta-box-left.boxed-left] + [div#meta-box-right.boxed-right]
            // set dragged and sorted blocks into Storage
            setStorageArray($metaid, $thisobj);
            // set new first blocks title
            $thisobj.children("section:first").find(".flipbox").attr('title', fstBHead);
        }

        // lastly put the returned array/object into storage
        setLocalStorage(arr);
    });

    /**
     * Function Expression containersCut() [OK]
     */
    containersCut = (function(start, end, datastring) {
        var s = datastring.lastIndexOf(start);
        var e = datastring.lastIndexOf(end);
        var d = datastring.substring(s,e);
        var a = d.replace('addLoadEvent(templatePluginMoverInit)', 'jQuery(function ($) { templatePluginMoverInit(); })');
        var b = a.replace('addLoadEvent(pluginMoverInitEvent)', 'jQuery(function ($) { pluginMoverInitEvent(); })');
        var c = b.replace('addLoadEvent(treeInit)', 'jQuery(function ($) { treeInit(); })');
        var f = c.replace('addLoadEvent(enableAutocomplete)', 'jQuery(function ($) { enableAutocomplete(); })');
        var g = f.replace('addLoadEvent(placeSpambutton)', 'jQuery(function ($) { placeSpambutton(); })');
        var h = g.replace('addLoadEvent(showItem)', 'jQuery(function ($) { showItem(); })');
        var i = h.replace('addLoadEvent(init_sequence_Sequence)', 'jQuery(function ($) { init_sequence_Sequence(); })'); // dashboard and entryproperties plugin
        var k = i.replace('addLoadEvent(init_cat_precedence_Sequence)', 'jQuery(function ($) { init_cat_precedence_Sequence(); })'); // categorytemplates plugin
        /*
        addLoadEvent(templatePluginMoverInit); functions_plugins_admin.inc.php
        addLoadEvent(pluginMoverInitEvent); functions_plugins_admin.inc.php
        addLoadEvent(treeInit); media_choose.tpl
        addLoadEvent(enableAutocomplete); serendipity_event_freetag.php
        addLoadEvent(placeSpambutton); bayes_commentlist.js
        addLoadEvent(showItem); entries.tpl & functions_entries_admin.inc.php 
        var x = y.replace('addLoadEvent(showItem)', 'jQuery(function ($) { showItem(); })'); //no need ?
        addLoadEvent(init_${config_item}_Sequence); functions_plugins_admin.inc.php
        addLoadEvent(liveSearchInit); serendipity_event_livesearch.php
        */
        var m = k.replace('<td class="serendipityAdminContent">', '<td id="mdc_content" class="clearfix">');
        var n = m.replace('<div id="content" class="clearfix">', '<div id="mdc_content" class="clearfix">');
        return n;
    });

    /**
     * Function Expression convert all click and submit targets into ajaxified POST container requests [OK]
     */
    contLinksToAjax = (function (tag, url) {
        // append data-remote="auto-ajax" data-callback="rebuildContainer" to all anchor elements in our new container class
        $(tag).each( function() {
            var $this = $(this).not('[onclick]').not('[target="_blank"]').not('[href*="mailto:"]').not('.toggle_text'); // if tag a has no attribute onclick and is not a target _blank or href mailto or has class toggle_text
            var $that = $(this).is('form') && $(this).not('[action]'); // if tag is a form element with no action attribute, returning to self in document environments
            if($that[0]) {
                $that.attr({'action':url, 'data-remote':'auto-ajax', 'data-callback':'rebuildContainer'});
            } else {
                // don't use for abort buttons, as in do sync media library
                $this.not('[href="serendipity_admin.php"]').attr({'data-remote':'auto-ajax', 'data-callback':'rebuildContainer'});
            }
        });
    });

    /**
     * Function Expression reset all ajaxified link anchors [OK]
     */
    resetContLinksToAjax = (function (tag, url) {
        // reset data-remote="auto-ajax" data-callback="rebuildContainer" from all anchor elements in our new container class
        $(tag).each( function() {
            var $this = $(this); // take them all to reset
            $this.not('[href="serendipity_admin.php"]').removeAttr('data-remote data-callback');
        });
    });

    /**
     * Function Expression callback update container with prefetched ajax [OK]
     */
    rebuildContainer = (function(result, delegatedUrl) {
        if(result.length) {
            var $item = $('#cont2 .mbc_content > div');
            var url   = '';
            // clean up previous data in container, if any
            $item.empty().remove(); // they say its faster to empty before remove ...
            // append data to backend container
            $('#cont2 .mbc_content').append('<div class="backend_entry_container">' + result + '</div>'); // [OK] also prepend
            $('footer#colophon').empty().remove(); /* new backend entered some unwanted siblings of */
            // what does configs extend to Container var say? Are we allowed to follow containerized backend content?
            if( extend2Cont === true ) {
                // add ajaxification attributes to all anchor links already placed in DOM - ajaxifies a, form, select, button elements
                var $container = "#cont2 .mbc_content > .backend_entry_container";
                contLinksToAjax($container+' a[href]', url);
                contLinksToAjax($container+' form[action]', url);
                contLinksToAjax($container+' form:not([action])', delegatedUrl);
                /*contLinksToAjax($container+' select option[value]', url); // do we really need this (automatic option selects) anywhere?*/
                contLinksToAjax($container+' button[value]', url);
                // remove 100px inline style in plugin configurations submit spacer
                $plugconf = $('#cont2 #configuration_footer');
                if ($plugconf) $plugconf.removeAttr('style');
            }
        } else { console.log('fcn rebuildContainer: An ajax result error occured'); }
    });

    /**
     * Function Expression check for ajaxification call [OK]
     **/
    ajaxify = (function(set) {
        // react on dashboards config setting (true, false, 'never')
        if( $.type(extend2Cont) === 'boolean' ) {
            if (set === true) { 
                // attract ajaxified data calls to personal settings button
                $('#menu-perset').attr({'data-remote':'auto-ajax', 'data-callback':'rebuildContainer'});
                // attract ajaxified data calls to plugin config button
                $('#menu-plugco').attr({'data-remote':'auto-ajax', 'data-callback':'rebuildContainer'});
                // set event handler
                $('#menu-perset[data-remote="auto-ajax"], #menu-plugco[data-remote="auto-ajax"]').on('click', function(e) {
                    loadSpin('ON');
                    e.preventDefault();
                    // if container is closed, open it (this is the case, if we follow containable links outside a container, like this opening personal settings in navbar)
                    if($('#cont2').get(0).isClosed) $("#cont2").containerize("open",500); // open new modal container / fs = .containerize("fullScreen")
                    emac = e.delegatedTarget;
                    return $(this).autoAjax(emac);
                });
            } else {
                // remove previsous set data-* attributes and event handler
                $('#menu-perset, #menu-plugco').removeAttr('data-remote data-callback');
                $('#menu-perset, #menu-plugco').off();
            }

            // the selectbar ajaxification is done somewhere else
            // if sidebar slide button or read cookie declares a dashboard fullview, ajaxify all other links
            $(c_blocks.join(', ')).each(linkToBox);
        }

        function linkToBox() {
            var $this = $(this);
            var url   = '';
            if ( set === true ) {
                // add ajaxification attributes to all boxed anchor links already placed in DOM - ajaxifies a(, form, select, button) elements
                contLinksToAjax($this.find('a[href]'), url);
            } else {
                // reset already added data attributes 
                resetContLinksToAjax($this.find('a[href]'), url);
            }
        }
    });

    /**
     * Function Expression setContainersHeight() [OK]
     * 
     * Sets the #layout containers height on demand
     * Neither Function Expressions, nor Function Declarations 
     * work with IE9 loading on window load, which always throws undefined
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
     * Removes this selectors upper section class ui-state-highlight on click flip and toggle buttons
     **/
    unsetUIHightlight = (function(obj) {
        obj.closest('section.flipflop').removeClass('ui-state-highlight');
    });

    /**
     * Function Expression smooth element blink() [OK]
     */
    blink = (function(el) {
        if (!el) { el = this; }
        $(el).animate({ opacity: 0.5 }, 1200, 'linear', function() {
            $(this).animate({ opacity: 1 }, 1200, blink );
        });
    });

    /**
     * Function Expression set function blink w/o to bind another time [OK]
     */
    triggerBlinkReload = (function(set) {
        if (set) {
            // blink button active maintenance mode if set on page reload
            $("#moma").css({'color':'red'}).html(const_serv_active);
            blink("#moma");
        }
    });

    /**
     * Function Expression set spinning img layer on modal container page load() [OK]
     */
    loadSpin = (function(state) {
        if (state == 'ON') { 
            $('#serendipity_admin_page').addClass('spinLoadProgress');
            $('#loaderPanel').html('<img alt="" src="'+dashpath+'img/spinner.gif">'+" loading...").css("color","#FFFFFF"); //Add spinner;
        } else {
            $('#serendipity_admin_page').removeClass('spinLoadProgress');
            //$('#loaderPanel').html(''); //Remove spinner; - do no leave it in DOM
        }
    });

    /**
     * Function Expression watchLogOff() [OK]
     *
     * Set on click logoff notification, while in maintenance mode
     * Denies logoff if isSetService = servicehook = response = true
     **/
    watchLogOff = (function(set) {
        if (set) {
            $('#user_menu li:nth-child(6)').on('click', 'a#menu-logoff', (function(e) {
            //$('#nav-embed-iconset li:nth-child(1)').on('click', 'a#menu-logoff', (function(e) { // 1.6.x
                e.preventDefault(); // Cancel a link's default action using the preventDefault method
                alert(logoff_text);
            })); // master has no nav-embed-iconset any more
        } else {
            $('#user_menu li:nth-child(6)').unbind('click');
            //$('#nav-embed-iconset li:nth-child(1)').unbind('click'); // 1.6.x
        }
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
     * Check Cookie for flip.ped box content that was hidden
     **/
    $(function() {
        $.each( $(meta.join(', ')).find('.flip'), function(){
            // new backend awesome font use - on load, set all boxes to open state imgage arrow
            $(this).addClass('flipclose');
        });
        $.each( fliparray, function(){
            var blocktohide = $('#' + this).find('div[id].block-content').attr('id');
            // hide all sort_ID boxes which appear in fliparray
            $('#' + blocktohide).hide(); // do we need to setContainersHeight() ?
            // new backend awesome font use - unset open state imgage arrow to closed boxes
            $('#' + blocktohide).siblings('.flip').removeClass('flipclose');
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
                runBlockSort(blocksort); // meta-box-left,[object Object], etc 
            }
        }
    });

    /**
     * Some selectors Startup Manipulations on DOM ready
     **/
    $(function() {
        // remove overview.inc's echo drop-in, if set
        $('h3.serendipityWelcomeBack').addClass('visuallyhidden');

        // set .serendipityAdminContent left padding class on default
        //$('td.serendipityAdminContent').addClass('serendipityAdminContentDashboard clearfix'); // 1.6.x

        // add missing class to #serendipitySideBar
        $sidebar.addClass('no-class');

        // rename sidebar Button 'Startpage' to 'Dashboard'
        $sidebar.find('li.serendipitySideBarMenuMainFrontpage a').html('Dashboard');

        // attract a title to the help gazette before running tooltip
        $('#iopen.help').attr('title', 'The Gazette!');
    });

    /**
     * Start up some essential init functions
     **/
    $(function() {
        /*
         * Initialize tooltip on DOM ready
         */
        runTooltip();

        /*
         * Watch init set Maintenance Mode
         */
        if (isSetService) {
            // trigger event blink() on page load
            triggerBlinkReload(isSetService);
            // trigger event stop log-off
            watchLogOff(isSetService);
        }

        /*
         * Try to init #layout height on document ready
         * As we couldn't use (see bottom) only 'jQuery(window).load(' w/o IE9 alerts, we use this instead
         */
        setContainersHeight(); // set to height of highest meta-box-xxx
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
                    $(this).find('img').stop(true, true).attr({src:img_plus});//.parent().css({'display':'block'});
                    $(this).parents().next().siblings('.comment_boxed').toggleClass('visuallyhidden');
                    unsetUIHightlight($(this));
                }, 
                function () { 
                    $(this).find('img').stop(true, true).attr({src:img_minus});//.parent().css({'display':'block'});
                    $(this).parents().next().siblings('.comment_boxed').toggleClass('visuallyhidden');
                    unsetUIHightlight($(this));
                }
            );
            unsetUIHightlight($(this));
            // set new id#layout height on toggle inside 
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
     * Toggle the feed/comments text blocks and change view/hide constant on event
     **/
    $(function() {
        $(t_text.join(', ')).find('.toggle_text').toggle( 
            function (event) { 
                $(this).closest('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden');
                $(this).find('span:first-of-type').removeClass().addClass('text toggle-icon icon-zoom-out'); /*new backend and chrome needed to switch to a.toggle_text */
                unsetUIHightlight($(this));
                setContainersHeight(); // set new id#layout height on toggle inside 
            }, 
            function (event) { 
                $(this).closest('.serendipity_admin_list_item').children('.comment_text').children().toggleClass('visuallyhidden');
                $(this).find('span:first-of-type').removeClass().addClass('text toggle-icon icon-zoom-in'); /*new backend and chrome needed to switch to a.toggle_text */
                unsetUIHightlight($(this));
                setContainersHeight(); // set new id#layout height on toggle inside 
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
     * Toggle (flip) and store to Cookie the block-box function on click [OK]
     **/
    $(function() {
        $(meta.join(', ')).find('.flip').click(function() {
            // new backend awesome font use - on click toggle state box open/close icon
            $(this).toggleClass('flipclose');
            $(this).each(addNSet);

            function updateCookie(block, el) {
                var indx = el.attr('id');
                var tmp  = fliparray.getUnique();
                if (block.is(':hidden')) { // :visible
                    // add index of widget to hidden list
                    tmp.push(indx);
                } else {
                    // remove element id from the list
                    tmp.splice( tmp.indexOf(indx), 1);
                }
                fliparray = tmp.getUnique();
                // ugly workaround for chrome and ie browser, which denied local hostnames
                if( !$.cookie('serendipity[dashboard_cookie_flipped]', fliparray.join('|'), { expires: 180, path: pathname, domain: hostname }) ) {
                    $.cookie('serendipity[dashboard_cookie_flipped]', fliparray.join('|'), { expires: 180, path: pathname });//, domain: hostname
                }
            }

            function addNSet() {
                $(this).siblings('div').toggle('slow', function() {
                    // set new id#layout height on flip, as flip is a single event only
                    setContainersHeight();
                    // get closest parent section element object as this is unique only in both metas
                    var parsec = $(this).closest('section');
                    // set cookie to hold the blocks hidden state
                    updateCookie( $(this), parsec ); // elem_ID is the static number we want, use this for the cookie!
                });
                // unsets this parents section.flipflop class ui-state-highlight, if active
                unsetUIHightlight($(this));
            }
        });
    });

    /**
     * Toggle autoupdater header note [OK]
     **/
    $(function() {
        $("#menu-autoupdate").toggle( 
            function (event) { 
                $('#nav-welcome h2').hide();
                $('#nav-info').toggleClass('visuallyhidden');
            }, 
            function (event) { 
                $('#nav-welcome h2').show();
                $('#nav-info').toggleClass('visuallyhidden');
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
            // let the function toggle sidebar/selectbar as stated and set cookie to hold the state
            // .is(":visible") - Checks for display:[none|block], ignores visible:[true|false]
            if ($sidebar.is(':visible')) {
                $sidebar.fadeOut();
                $("#content").addClass('no-sidebar');
                //$('td.serendipityAdminContent').addClass('no-sidebar'); // 1.6.x
                extendLinks = true; // containerize links
                // ugly workaround for chrome and ie browser, which denied local hostnames set as domain: hostname
                if( !$.cookie('serendipity[dashboard_cookie_sidebar]', 'isSelectBar', { expires: 180, path: pathname, domain: hostname }) ) {
                    $.cookie('serendipity[dashboard_cookie_sidebar]', 'isSelectBar', { expires: 180, path: pathname });//, domain: hostname
                }
            } else {
                $sidebar.fadeIn();
                $("#content").removeClass('no-sidebar');
                //$('td.serendipityAdminContent').removeClass('no-sidebar'); // 1.6.x
                extendLinks = false; // uncontainerize links
                // ugly workaround for chrome and ie browser, which denied local hostnames set as domain: hostname
                if( !$.cookie('serendipity[dashboard_cookie_sidebar]', 'isSideBar', { expires: 180, path: pathname, domain: hostname }) ) {
                    $.cookie('serendipity[dashboard_cookie_sidebar]', 'isSideBar', { expires: 180, path: pathname });//, domain: hostname
                }
            }
            $selectbar.toggleClass('visuallyhidden');
            ajaxify(extendLinks); // set/reset ajaxified block container links
            runTooltip(); // init tooltip for the changed extendLinks nav elements again
        });

        if( typeof extendLinks === 'undefined' ) {
            // check to see if a cookie exists for the app state
            var cookie_sidebar = $.cookie('serendipity[dashboard_cookie_sidebar]');
            if(cookie_sidebar == 'isSelectBar') { 
                $sidebar.fadeOut();
                $("#content").addClass('no-sidebar');
                //$('td.serendipityAdminContent').addClass('no-sidebar'); // 1.6.x
                extendLinks = true; // containerize links
                //ajaxify(true); // also ajaxify block container links
                $selectbar.toggleClass('visuallyhidden');
            } else {
                $sidebar.fadeIn();
                extendLinks = false; // uncontainerize links
                //ajaxify(false);  // reset ajaxified block container links
                $("#content").removeClass('no-sidebar');
                //$('td.serendipityAdminContent').removeClass('no-sidebar'); // 1.6.x
            }

            // make sure everything outside dashboard context has the normal 'isSideBar' Layout!
            if ( !$('#dashboard').children().length > 0 ) { 
                $sidebar.fadeIn();
                extendLinks = false; // uncontainerize links
                //ajaxify(false);  // reset ajaxified block container links
                $("#content").removeClass('no-sidebar');
                //$('td.serendipityAdminContent').removeClass('no-sidebar'); // 1.6.x
            }
            ajaxify(extendLinks); // set/reset ajaxified block container links
        }
    });

    /**
     * Some Event Delegation Listeners on DOM ready [need to be settled here, after the ajaxify call has been done, else it listens on something set later (at least in the nav)]
     **/
    $(function() {
        if( $.type(extend2Cont) !== 'null') {
            // containerized auto-ajax event listeners
            $('#cont2').on('submit', 'form[data-remote="auto-ajax"]', function(e) {
                loadSpin('ON');
                e.preventDefault();
                return $(this).autoAjax();
            });
            $('#menu-perset[data-remote="auto-ajax"], #menu-plugco[data-remote="auto-ajax"]').on('click', function(e) {
                loadSpin('ON');
                e.preventDefault();
                // if container is closed, open it (this is the case, if we follow containable links outside a container, like this opening personal settings in navbar)
                if($('#cont2').get(0).isClosed) $("#cont2").containerize("open",500); // open new modal container / fs = .containerize("fullScreen")
                emac = e.delegatedTarget;
                return $(this).autoAjax(emac);
            });
            $(c_blocks.join(', ')).on('click', 'a[data-remote="auto-ajax"], button[data-remote="auto-ajax"]', function(e) {
                loadSpin('ON');
                e.preventDefault();
                // if container is closed, open it (this is the case, if we follow containable links outside a container, or plugbox container links)
                if($('#cont2').get(0).isClosed) $("#cont2").containerize("open",500); // open new modal container / fs = .containerize("fullScreen")
                return $(this).autoAjax();
            });
            $('#cont2').on('click', 'a[data-remote="auto-ajax"], button[data-remote="auto-ajax"]', function(e) {
                loadSpin('ON');
                e.preventDefault();
                return $(this).autoAjax();
            });
            $('#cont2').on('change', 'select[data-remote="auto-ajax"]', function(e) {
                loadSpin('ON');
                e.preventDefault();
                return $(this).autoAjax();
            });
        }
    });

    /**
     * Convert backend sidebar entries to dropdown select box - case each selector [OK]
     **/
    $(function() {
        var base = '#indent-navigation';
        var selectors = [
            'ul.serendipitySideBarMenuEntry',
            'ul.serendipitySideBarMenuMedia',
            'ul.serendipitySideBarMenuAppearance',
            'ul.serendipitySideBarMenuUserManagement'
        ];

        // In FF this is a click event and we can just use 'select' tag w/o selectors here, as this is strictly based to base id only, like
        // $(base).on('change click', 'select > option', function(e) { 
        // but Chrome denied to fire the event at all.... possibly because using dummy 'option' element directly
        $(base).on('click', '#navbar > ul > li > select', function(e) { 
            var $so = $(this).children("option:selected").stop();
            var val = $so.val();
            e.stopImmediatePropagation();
            $(this).prop('selectedIndex',0); // set selected index back to the first empty element for debug or error cases
            if (val.length) {
                if( $.type(extend2Cont) === 'null') {
                    location.href = val; // never allow containerized backend location
                } else {
                    e.preventDefault(); /* prevents the link from opening the href link */
                    var $thisscope = $('#cont2 .mbc_content'); // $thisscope can't be a global var, as it its build on load later on
                    val = val+'&serendipity[noHeading]=true';
                    
                    $.ajax({
                        url: val,
                        type: 'POST',
                        dataType: 'html',
                        async: true, // set to true as chrome did not want to trigger beforeSend properly
                        context: $thisscope,
                        success: function(data) {
                            // remove everything else from fetched page than block *.*
                            // return cut data from/to into container
                            result = containersCut('<div id="content" class="clearfix">', '</div>', data);
                            //result = containersCut('<div class="serendipityAdminContent">', '</td>', data); // 1.6.x?
                        },
                        beforeSend: function ( xhr ) {
                            loadSpin('ON');
                        },
                        error: function(){
                            alert('Work in Backend respond failure!');
                        },
                    }).done(function() {
                        if(result.length) {
                            // store result data as cache into localStorage container, to emulate a browsers back button later on
                            var basecache = new Cache( localStorage, JSON );
                            basecache.removeItem( "icache" ); // clear old cached data
                            var basestore = { value: result, url: val }; // create the object
                            basecache.setItem( "icache", basestore );
                            // cleanup old and handle new result set into container
                            rebuildContainer(result, val);
                            $("#cont2").containerize("open",500); // open new modal container / fs = .containerize("fullScreen")
                        }
                        loadSpin('OFF'); // Hide spinner (the only case why we use this her instead of coplete, is calling the styles section)
                    });
                }
            }
        }).find(selectors.join(', ')).each(linksToSelect); // trigger the event with .change() on load, if we ever want to

        function linksToSelect() {
            var $this = $(this);
            var $class = $this.attr("class").replace(/[-\s\w]*?([-\w]+)\s?$/, '$1'); // is greedy, replaces first elements clearfix
            var $select = $('<select/>').addClass($class);

            $this.find('a').each(function() {
                var $a = $(this);
                $('<option/>')
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
        $("#layout section.flipflop")
        // Script to deferentiate a click from a mousedown for drag event (1.0.3x changed .bind() to .on() as of jquery 1.7+)
        .on('mousedown mouseup', function(e) {
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
            containment: '#layout',
            helper: 'clone', 
            revert: 'invalid',
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

                // keep upgrading localStorage
                setLocalStorage(arr);

                var sobj = $('#'+this.id).find('section[id].flipflop');
                var $postMetaArr = [$(this.id).selector]; // eg. meta-box-right (chrome needs strict selector match, else pushing circular structure to JSON errors)

                sobj.attr("id", function (index) { 
                    var $dropid = $(this).attr('id').toString(); // collect section#ID name as string
                    var $blockid = $(this).find('div.block-box');
                    var $blid = $blockid.attr('id');
                    $postMetaArr.push([$dropid, $blid]); // stick to array and do not use objects here
                });

                $url = pathname + 'plugin/dbjsonsort/';

                // Post the array via external_plugin to Plugins config storage
                jQuery.post($url, {json: JSON.stringify($postMetaArr)});
            }
        }).on(runTooltip); // bind event function tooltip to reset the first elements tooltip on drop and sort
        // This fixes issue after drag&drop and tooltip by first element, which, hovered, brought vertical scrollbar to show/hide until reload
    });

    /**
     * Set service maintenance mode on click
     **/
    $(function(){
        $("#moma").on("click", function(){
            isSetService = !isSetService; // toggle boolean
            if (isSetService) {
                alert( $(this).text() + ' = ' + isSetService + "\n\n" + const_service); // is button text + attention const
                // keep original button text and set active Maintenance Mode button
                service_origin = $(this).html();
                // blink button active maintenance mode
                $(this).css({'color':'red'}).html(const_serv_active).unbind('change').on('change', blink(this));
            } else { 
                if(typeof service_origin === 'undefined') service_origin = const_serv_origin;
                // As of jQuery 1.7, stopping a toggled animation prematurely with .stop() will trigger jQuery's internal effects tracking.
                $(this).unbind('change').stop().removeAttr('style').html( service_origin ); // stop looping animate in function blink
            }
            $url = pathname + 'plugin/modemaintence/';

            // Post the set/unset via external_plugin to Plugins config storage - pass POST booleans as (set?1:0)
            response = $.ajax({
                url: $url,
                type: 'post',
                async: false,
                dataType: 'text',
                data: { setmoma: (isSetService?1:0) },
                success: function(response){
                    // async false is needed to really know what has been set
                    response = (response === 'true') ? true : false;
                },
                error: function(){
                    alert('MoMa respond set failure!');
                }
            }).responseText;

            // un/set watchLogger's popup click event
            watchLogOff(isSetService);
        });
    });


    /**
     * JQuery.simpleModal help
     **/
    $(function(){
        $("#info-help").click(function (e) {
            // Disable focus (allows tabbing away from dialog)
            $('#info-help-content').modal({focus:false});
            return false;
        });
    });

    jQuery(function ($) {
        // Load dialog on page load
        //$('#basic-modal-content').modal();

        // Load dialog on click
        $('#basic-modal .basic').click(function (e) {
            $('#basic-modal-content').modal();

            return false;
        });
    });

    /*
     * SimpleModal OSX Style Modal Dialog
     * http://simplemodal.com
     *
     * Copyright (c) 2013 Eric Martin - http://ericmmartin.com
     *
     * Licensed under the MIT license:
     *   http://www.opensource.org/licenses/mit-license.php
     */

    jQuery(function ($) {
        var OSX = {
            container: null,
            init: function () {
                $("input.osx, a.osx, button.osx").click(function (e) {
                    e.preventDefault();    

                    //$("#osx-modal-content").modal({.load(dashpath+'ihelp.html')
                    $("#osx-modal-content").modal({
                        overlayId: 'osx-overlay',
                        containerId: 'osx-container',
                        closeHTML: null,
                        minHeight: 80,
                        /*maxHeight: 440,*/
                        opacity: 65,
                        position: ['0',],
                        overlayClose: true,
                        onOpen: OSX.open,
                        onClose: OSX.close
                    });
                });
            },
            open: function (d) {
                var self = this;
                self.container = d.container[0];
                d.overlay.fadeIn('slow', function () {
                    $("#osx-modal-content", self.container).show();
                    var title = $("#osx-modal-title", self.container);
                    title.show();
                    d.container.slideDown('slow', function () {
                        setTimeout(function () {
                            var h = $("#osx-modal-data", self.container).height()
                                + title.height()
                                + 20; // padding
                            d.container.animate(
                                {height: h}, 
                                200,
                                function () {
                                    $("div.close", self.container).show();
                                    $("#osx-modal-data", self.container).show();
                                }
                            );
                        }, 300);
                    });
                })
            },
            close: function (d) {
                var self = this; // this = SimpleModal object
                d.container.animate(
                    {top:"-" + (d.container.height() + 20)},
                    500,
                    function () {
                        self.close(); // or $.modal.close();
                    }
                );
            }
        };

        OSX.init();
        //$('#osx-modal-content .simplemodal-close').on('click', OSX.close).close();
    });

    /**
     * JQuery.mb.containerPlus help
     **/
    $(function(){
        /**
         * custom method to add ajaxified content
         **/
        $.containerize.addMethod("getdata",function(){
            var el = this;
            $.ajax({
                url: dashpath + 'dashboard_gazette.html',
                type: 'POST', /* take type:post to leave inner script code untouched */
                contentType: "text/html; charset=UTF-8",
                /*dataType: 'html', let ajax decide the dataType automatically*/
                success: function(data) {
                    result = data;
                },
                error: function(xhr, status, thrown) {
                    alert('Fetching help page failure! '+status+': '+thrown);
                }
            }).done(function() {
                if(result.length) {
                    el.content.prepend(result);
                }
            });
        });

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
        var backBtn = $("<button/>").addClass("mbc_button").html("back").click(function(e){
            var el = $(this).parents(".mbc_container");
            el.containerize("back");
            var returncache = new Cache( localStorage, JSON );
            // catch the back emulator event
            result = returncache.getItem( "icache" ).value;
            val    = returncache.getItem( "icache" ).url;
            rebuildContainer(result, val);
            e.stopPropagation();
            e.preventDefault();
        });

        var changeSkinBtn = $("<button/>").addClass("mbc_button").html("change skin").click(function(e){
            var el = $(this).parents(".mbc_container");
            if(!el.hasClass('black')) el.containerize('skin','black'); else el.containerize('skin');
            e.stopPropagation();
            e.preventDefault();
        });

        var fullScreenBtn = $("<button/>").addClass("mbc_button").html("full screen").click(function(e){
            var el = $(this).parents(".mbc_container");
            el.containerize("fullScreen");
            $('#cont1.container, #cont2.container, #cont3.container').css({'width':'auto !important'});
            e.stopPropagation();
            e.preventDefault();
        });

        var iconizeBtn = $("<button/>").addClass("mbc_button").html("iconize").click(function(e){
            var el = $(this).parents(".mbc_container");
            loadSpin('OFF');
            el.containerize("iconize");
            e.stopPropagation();
            e.preventDefault();
        });

        var dockBtn = $("<button/>").addClass("mbc_button").html("dock").click(function(e){
            var el = $(this).parents(".mbc_container");
            loadSpin('OFF');
            el.containerize("iconize","dock");
            e.stopPropagation();
            e.preventDefault();
        });
        
        var closeBtn = $("<button/>").addClass("mbc_button").html("close").click(function(e){
            var el = $(this).parents(".mbc_container");
            loadSpin('OFF');
            el.containerize("close");
            e.stopPropagation();
            e.preventDefault();
        });

        $("#cont1").containerize("addtotoolbar", [fullScreenBtn,iconizeBtn,changeSkinBtn,dockBtn,closeBtn]); // the help box
        //$("#cont2 .mbc_footer").empty(); // empty debug notes, if any
        $("#cont2").containerize("addtotoolbar", [backBtn, fullScreenBtn,iconizeBtn,changeSkinBtn,dockBtn,closeBtn]); // the modal container backend!
        $("#cont3").containerize("addtotoolbar", [fullScreenBtn,iconizeBtn,changeSkinBtn,dockBtn,closeBtn]); // the 2cd help box
        $("#cont3 > .mbc_content > .autojs").addClass('content-box guide');
    });

    /**
     * Debug elements used
     * 
     * count how much selectors used - faster access, the more less - .length = count 
     * use with ('*') all selectors, or selector tagNames, idNames, classNames etc.
     **/
    $(function(){
        // as of now = 651FF/652CH ??? elements, which is less than half!
        // console.log( $('*').length );
        loadSpin('OFF'); /* thus to make sure layer is off by default */
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
