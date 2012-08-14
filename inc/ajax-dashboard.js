// ajax-dashboard.js - last-modified: 2012-08-14
// AJAX “Asynchronous JavaScript and XML“ used as short name for native JavaScript here... meaning pure (mostly S9y) javascript functions

// Approved Comments Checkbox function
function invertSelectionApp() {
    var f = document.formMultiDeleteApp;
    for (var i = 0; i < f.elements.length; i++) {
        if( f.elements[i].type == 'checkbox' ) {
            f.elements[i].checked = !(f.elements[i].checked);
            f.elements[i].onclick();
        }
    }
}
// Moderated Comments Checkbox function
function invertSelectionPen() {
    var f = document.formMultiDeletePen;
    for (var i = 0; i < f.elements.length; i++) {
        if( f.elements[i].type == 'checkbox' ) {
            f.elements[i].checked = !(f.elements[i].checked);
            f.elements[i].onclick();
        }
    }
}
// comment checkbox placeholder
function toogle_checkbox(id, checkvalue) {
    // void 
	// hold this to make checkboxes be selectable individually via onClick and get inverted by function
}

/* two Cookie/Array functions to extend methods and properties via prototype - used by Dashboards JQuery cookie flip show/hide */
// Return a unique array.
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

