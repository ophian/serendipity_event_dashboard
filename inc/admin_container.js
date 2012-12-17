// Serendipity Backend admin helper scripts to append in backend function containerized!
// Serendipity Dashboard - last modified: 2012-09-07

/**
 * serendipity admin header scripts
 */
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

/**
 * image selector script
 */
function change_preview(id)
{
    var text_box = document.getElementById('serendipity[template][' + id + ']');
    var image_box = document.getElementById(id + '_preview'); 
    var filename = text_box.value;
    image_box.style.backgroundImage = 'url(' + filename + ')';
    image_box.style.backgroundRepeat = 'no-repeat';
}
function choose_media(id)
{
    $(window).load(function() {
	window.top.open('serendipity_admin_image_selector.php?serendipity[htmltarget]=' + id + '&serendipity[filename_only]=true', 'ImageSel', 'width=800,height=600,toolbar=no,scrollbars=1,scrollbars,resize=1,resizable=1');
	});
}

/**
 * Serendipity backend functions
 * place any jQuery/helper plugins in here, instead of separate, slower script files.
 *
 * used in:
 * - serendipity_plugins_admin.inc.php::serendipity_plugin_config() function 
 * - templates/default/admin/default_staticpage_backend.tpl
 */
function showConfig(id) {
  if (document.getElementById) {
    plugbox = document.getElementById(id);
    if (plugbox.style.display == 'none') {
        document.getElementById('option' + id).src = img_minus;
        plugbox.style.display = '';
    } else {
        document.getElementById('option' + id).src = img_plus;
        plugbox.style.display = 'none';
    }
  }
}

var state='';
function showConfigAll(count) {
  if (document.getElementById) {
    for (i = 1; i <= count; i++) {
         document.getElementById('el' + i).style.display = state;
         document.getElementById('optionel' + i).src = (state == '' ? img_minus : img_plus);
    }

    if (state == '') {
        document.getElementById('optionall').src = img_minus;
        state = 'none';
    } else {
        document.getElementById('optionall').src = img_plus;
        state = '';
    }
  }
}

function chkAll(frm, arr, mark) {
  for (i = 0; i <= frm.elements.length; i++) {
   try {
     if(frm.elements[i].name == arr) {
       frm.elements[i].checked = mark;
     }
   } catch (err) {}
  }
}

function invertSelection() {
  var f = document.formMultiDelete;
    for (var i = 0; i < f.elements.length; i++) {
      if (f.elements[i].type == 'checkbox') {
          f.elements[i].checked = !(f.elements[i].checked);
      }
    }
}

function showFilters()  {
  s = document.getElementById('moreFilter').style;
  if (s.display == 'none') {
      s.display = 'block';
      } else {
      s.display = 'none';
  }
}

function AddKeyword(keyword)  {
  s = document.getElementById('keyword_input').value;
  document.getElementById('keyword_input').value = (s != '' ? s + ';' : '') + keyword;
}

