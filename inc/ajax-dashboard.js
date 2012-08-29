// ajax-dashboard.js - last-modified: 2012-08-27
// AJAX 'Asynchronous JavaScript and XML' used as short name for native JavaScript here... meaning pure (mostly S9y) javascript functions

/**
 * Approved Comments Checkbox function
 **/
function invertSelectionApp() {
    var f = document.formMultiDeleteApp;
    for (var i = 0; i < f.elements.length; i++) {
        if( f.elements[i].type == 'checkbox' ) {
            f.elements[i].checked = !(f.elements[i].checked);
            f.elements[i].onclick();
        }
    }
}

/**
 * Moderated Comments Checkbox function
 **/
function invertSelectionPen() {
    var f = document.formMultiDeletePen;
    for (var i = 0; i < f.elements.length; i++) {
        if( f.elements[i].type == 'checkbox' ) {
            f.elements[i].checked = !(f.elements[i].checked);
            f.elements[i].onclick();
        }
    }
}

/**
 * comment checkbox placeholder
 **/
function toggle_checkbox(id, checkvalue) {
    // Void - hold this function as long using serendipity's default toggle functions
    // This returns checkboxes be selectable individually via onClick and get inverted by function
}

/**
 * Cookie/Array functions to extend methods and properties via prototype
 * - used by Dashboards JQuery cookie flip show/hide
 * Return a unique array.
 **/
Array.prototype.getUnique = function() {
 var a = [], o = {}, i, e;
 for (i = 0; e = this[i]; i++) {o[e] = 1};
 for (e in o) {a.push(e)};
 return a;
}

// Fix indexOf in IE
if (!Array.prototype.indexOf) { // if this method does not exist..
 Array.prototype.indexOf = function(obj, start) {
  for (var i = (start || 0), j = this.length; i < j; i++) {
   if (this[i] == obj) { return i; }
  }
  return -1;
 }
}

/**
 * Define some global vars
 **/
// define localStorage use
var isLocalStorage = false;
// define microsoft engine use
var engine = null;

/**
 * IE9 standard mode check
 **/
if (window.navigator.appName == "Microsoft Internet Explorer")
{
   // This is an IE browser. What mode is the engine in?
   if (document.documentMode) // IE8 or later
      engine = document.documentMode;
   else // IE 5-7
   {
      engine = 5; // Assume quirks mode unless proven otherwise
      if (document.compatMode)
      {
         if (document.compatMode == "CSS1Compat")
            engine = 7; // standards mode
      }
      // There is no test for IE6 standards mode because that mode
      // was replaced by IE7 standards mode; there is no emulation.
   }
   // the engine variable now contains the document compatibility mode.
   if (engine == 5) engine = 'Quirks';

   if (engine != 9 && engine !== null) {
      alert("ALERT:\nThis Dashboard needs your Internet Explorer 9, to render the page in its highest available combatibility mode!\n\n" + 
      'Please reset your IE "Document Compatibility" mode: "'+engine+'" to "Internet Explorer Standard" mode! [use Keyboard F12]');
   }
}

/**
 * Test HTML5 clients local Storage
 **/
if (typeof(localStorage) == 'undefined' ) {
    alert('Your browser does not support HTML5 localStorage. Try upgrading.');
} else {
    try {
        localStorage.setItem("name", "S9y - the best blog in blogosphere!"); // test saves to the database, "key", "value"
    } catch (e) {
        if (e == QUOTA_EXCEEDED_ERR) {
            alert('LocalStorage Quota exceeded!'); // the test data wasn't successfully saved due to quota exceed so throw an error
        }
        if (e) { isLocalStorage = false; }
    }
    isLocalStorage = true;
}
