// ajax-dashboard.js - last-modified: 2012-01-17

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
	// hold this to make checkboxes be individual selectable via onClick and get inverted by function
}
