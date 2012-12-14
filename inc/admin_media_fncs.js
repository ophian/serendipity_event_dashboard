// Function prototype inspired by http://molily.de/javascript-nodelist
function showNodes(n) {
    var html;
    html = '<!--nodeset--><li>';

    switch (n.nodeType) {
        case 1:
            html += 'Type is <em>' + n.nodeName + '<\/em>';
            if (n.hasChildNodes()) {
                ausgabe += ' - childNodes: ' + n.childNodes.length;
            }
            break;

        case 3:
            var nval = n.nodeValue.replace(/</g, '&lt;').replace(/\n/g, '\\n');
            html += 'Content: <strong>' + nval + '<\/strong>';
            break;

        case 8:
            var nval = n.nodeValue.replace(/</g, '&lt;').replace(/\n/g, '\\n');
            html += 'Hidden: <em>' + nval + '<\/em>';
            break;

        default:
            html += 'Type is ' + n.nodeType + ', Content is <strong>' + n.nodeValue + '<\/strong>';
    }

    if (n.hasChildNodes()) {
        html += '\n<ol>\n';
        for (i=0; i < n.childNodes.length; i++) {
            j = n.childNodes[i];
            html += showNodes(j);
        }
        html += '</ol>\n';
    }
    html += '</li>\n';

    return html;
}

function getfilename(value) {
    re = /^.+[\/\\]+?(.+)$/;
    return value.replace(re, "$1");
}

isFileUpload = true;
function hideForeign() {
    document.getElementById('foreign_upload').style.display = 'none';
    document.getElementById('imageurl').value = '';
    isFileUpload = false;
}

var fieldcount = 1;
function addField() {
    fieldcount++;

    fields = document.getElementById('upload_template').cloneNode(true);
    fields.id = 'upload_form_' + fieldcount;
    fields.style.display = 'block';

    // Get the DOM outline be uncommenting this:
    //document.getElementById('debug').innerHTML = showNodes(fields);

    // garvin: This gets a bit weird. Opera, Mozilla and IE all have their own numbering.
    // We cannot operate on "ID" basis, since a unique ID is not yet set before instancing.
    if (fields.childNodes[0].nodeValue == null) {
        // This is Internet Explorer, it does not have a linebreak as first element.
        userfile       = fields.childNodes[0].childNodes[0].childNodes[0].childNodes[1].childNodes[0];
        targetfilename = fields.childNodes[0].childNodes[0].childNodes[2].childNodes[1].childNodes[0];
        targetdir      = fields.childNodes[0].childNodes[0].childNodes[3].childNodes[1].childNodes[0];
        columncount    = fields.childNodes[1].childNodes[0];
    } else {
        // We have a browser which has \n's as their own nodes. Don't ask me. Now let's check if it's Opera or Mozilla.
        if (fields.childNodes[1].childNodes[0].nodeValue == null) {
            // This is Opera.
            userfile       = fields.childNodes[1].childNodes[0].childNodes[0].childNodes[1].childNodes[0];
            targetfilename = fields.childNodes[1].childNodes[0].childNodes[2].childNodes[1].childNodes[0];
            targetdir      = fields.childNodes[1].childNodes[0].childNodes[3].childNodes[1].childNodes[0];
            columncount    = fields.childNodes[3].childNodes[0];
        } else if (fields.childNodes[1].childNodes[1].childNodes[0].childNodes[3] == null) {
            // This is Safari.
            userfile       = fields.childNodes[1].childNodes[1].childNodes[0].childNodes[1].childNodes[0];
            targetfilename = fields.childNodes[1].childNodes[1].childNodes[2].childNodes[1].childNodes[0];
            targetdir      = fields.childNodes[1].childNodes[1].childNodes[3].childNodes[1].childNodes[0];
            columncount    = fields.childNodes[3].childNodes[0];
        } else {
            // This is Mozilla.
            userfile       = fields.childNodes[1].childNodes[1].childNodes[0].childNodes[3].childNodes[0];
            targetfilename = fields.childNodes[1].childNodes[1].childNodes[4].childNodes[3].childNodes[0];
            targetdir      = fields.childNodes[1].childNodes[1].childNodes[6].childNodes[3].childNodes[0];
            columncount    = fields.childNodes[3].childNodes[0];
        }
    }

    userfile.id   = 'userfile_' + fieldcount;
    userfile.name = 'serendipity[userfile][' + fieldcount + ']';

    targetfilename.id   = 'target_filename_' + fieldcount;
    targetfilename.name = 'serendipity[target_filename][' + fieldcount + ']';

    targetdir.id   = 'target_directory_' + fieldcount;
    targetdir.name = 'serendipity[target_directory][' + fieldcount + ']';

    columncount.id   = 'column_count_' + fieldcount;
    columncount.name = 'serendipity[column_count][' + fieldcount + ']';

    iNode = document.getElementById('upload_form');
    iNode.parentNode.insertBefore(fields, iNode);

    document.getElementById(targetdir.id).selectedIndex = document.getElementById('target_directory_' + (fieldcount - 1)).selectedIndex;
}

var inputStorage = new Array();
function checkInputs() {
    for (i = 1; i <= fieldcount; i++) {
        if (!inputStorage[i]) {
            fillInput(i, i);
        } else if (inputStorage[i] == document.getElementById('target_filename_' + i).value) {
            fillInput(i, i);
        }
    }

}

function debugFields() {
    for (i = 1; i <= fieldcount; i++) {
        debugField('target_filename_' + i);
        debugField('userfile_' + i);
    }
}

function rememberOptions() {
    td     = document.getElementById('target_directory_2');
    td_val = td.options[td.selectedIndex].value;
    SetCookie("addmedia_directory", td_val);
}

function debugField(id) {
    alert(id + ': ' + document.getElementById(id).value);
}

function fillInput(source, target) {
    useDuplicate = false;

    // First field is a special value for foreign URLs instead of uploaded files
    if (source == 1 && document.getElementById('imageurl').value != "") {
        sourceval = getfilename(document.getElementById('imageurl').value);
        useDuplicate = true;
    } else {
        sourceval = getfilename(document.getElementById('userfile_' + source).value);
    }

    if (sourceval.length > 0) {
        document.getElementById('target_filename_' + target).value = sourceval;
        inputStorage[target] = sourceval;
    }

    // Display filename in duplicate form as well!
    if (useDuplicate) {
        tkey = target + 1;

        if (!inputStorage[tkey] || inputStorage[tkey] == document.getElementById('target_filename_' + tkey).value) {
            document.getElementById('target_filename_' + (target+1)).value = sourceval;
            inputStorage[target + 1] = '~~~';
        }
    }
}
