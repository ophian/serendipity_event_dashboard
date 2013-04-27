<?php # $Id$
// dashboard_requests_actions.inc.php - last modified 2013-04-27
// some POST & GET actions copied from head of comments.inc.php to get included, as also used for the dashboard plugin

if (IN_serendipity !== true) {
    die ("Don't hack!");
}

if (!serendipity_checkPermission('adminComments')) {
    return;
}

$errormsg = '';

if ($serendipity['POST']['formAction'] == 'multiDelete' && sizeof($serendipity['POST']['delete']) != 0 && serendipity_checkFormToken()) {
    if ($serendipity['POST']['togglemoderate'] != '') {
        foreach ( $serendipity['POST']['delete'] as $k => $v ) {
            $ac = serendipity_approveComment($k, $v, false, 'flip');
            if ($ac > 0) {
                $errormsg .= DONE . ': '. sprintf(COMMENT_APPROVED, (int)$k) . '<br />';
            } else {
                $errormsg .= DONE . ': '. sprintf(COMMENT_MODERATED, (int)$k) . '<br />';
            }
        }
    } else {
        foreach ( $serendipity['POST']['delete'] as $k => $v ) {
             serendipity_deleteComment($k, $v);
            $errormsg .= DONE . ': '. sprintf(COMMENT_DELETED, (int)$k) . '<br />';
        }
    }
}

/* We clear all compiles smarty template files in templates_c */
if($serendipity['GET']['dashboard_event'] == 'capct' && serendipity_checkFormToken()) { 
    $clear = false;
    // smarty clear all compiled templates = capct - reduced to clear $serendipity['template'] only, as the recompile including the gravatar event plugin may cause a servers memory exhaustment
    if(method_exists($serendipity['smarty'], 'clearCompiledTemplate')) {
        if($serendipity['smarty']->clearCompiledTemplate(null, $serendipity['template'])) {
            $clear = true;
        }
    }
    if(!$clear && method_exists($serendipity['smarty'], 'clear_compiled_tpl')) {
        if($serendipity['smarty']->clear_compiled_tpl(null, $serendipity['template'])) {
            $clear = true;
        }
    }
    if($clear) $errormsg .= DONE . ': '. 'All Smarty compiled templates cleared!';
}
        

/* We approve a comment */
if (isset($serendipity['GET']['adminAction']) && $serendipity['GET']['adminAction'] == 'approve' && serendipity_checkFormToken()) {
    $sql = "SELECT c.*, e.title, a.email as authoremail, a.mail_comments
            FROM {$serendipity['dbPrefix']}comments c
            LEFT JOIN {$serendipity['dbPrefix']}entries e ON (e.id = c.entry_id)
            LEFT JOIN {$serendipity['dbPrefix']}authors a ON (e.authorid = a.authorid)
            WHERE c.id = " . (int)$serendipity['GET']['id']  ." AND (status = 'pending' OR status LIKE 'confirm%')";
    $rs  = serendipity_db_query($sql, true);

    if ($rs === false) {
        $errormsg .= ERROR .': '. sprintf(COMMENT_ALREADY_APPROVED, (int)$serendipity['GET']['id']);
    } else {
        serendipity_approveComment($serendipity['GET']['id'], $rs['entry_id']);
        $errormsg .= DONE . ': '. sprintf(COMMENT_APPROVED, (int)$serendipity['GET']['id']);
    }
}

if (isset($serendipity['GET']['adminAction']) && $serendipity['GET']['adminAction'] == 'pending' && serendipity_checkFormToken()) {
    $sql = "SELECT c.*, e.title, a.email as authoremail, a.mail_comments
            FROM {$serendipity['dbPrefix']}comments c
            LEFT JOIN {$serendipity['dbPrefix']}entries e ON (e.id = c.entry_id)
            LEFT JOIN {$serendipity['dbPrefix']}authors a ON (e.authorid = a.authorid)
            WHERE c.id = " . (int)$serendipity['GET']['id']  ." AND status = 'approved'";
    $rs  = serendipity_db_query($sql, true);

    if ($rs === false) {
        $errormsg .= ERROR .': '. sprintf(COMMENT_ALREADY_APPROVED, (int)$serendipity['GET']['id']);
    } else {
        serendipity_approveComment($serendipity['GET']['id'], $rs['entry_id'], true, true);
        $errormsg .= DONE . ': '. sprintf(COMMENT_MODERATED, (int)$serendipity['GET']['id']);
    }
}

/* We are asked to delete a comment */
if (isset($serendipity['GET']['adminAction']) && $serendipity['GET']['adminAction'] == 'delete' && serendipity_checkFormToken()) {
    serendipity_deleteComment($serendipity['GET']['id'], $serendipity['GET']['entry_id']);
    $errormsg .= DONE . ': '. sprintf(COMMENT_DELETED, (int)$serendipity['GET']['id']);
}

// Save the entry, or just display a preview
$use_legacy = true;
serendipity_plugin_api::hook_event('backend_entry_iframe', $use_legacy);

?>