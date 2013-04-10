<?php
/* last modified - 2012-12-22 */

/* propbag config only */
@define('PLUGIN_DASHBOARD_DESC', 'Zeigt ausgew�hlte Informationen auf der Startseite der Verwaltungsoberfl�che als �bersicht');
@define('PLUGIN_DASHBOARD_SEQUENCE', 'Element Reihenfolge');
@define('PLUGIN_DASHBOARD_SEQUENCE_DESC', 'Hier wird die Reihenfolge der verschiedenen Informationsbl�cke festgelegt.<p>Weitere Positionierungen k�nnen dann in Folge im Dashboard selbst vorgenommen werden!</p>');
@define('PLUGIN_DASHBOARD_READONLY', 'Schreibgesch�tztes Dashboard?');
@define('PLUGIN_DASHBOARD_READONLY_DESC', 'Wenn der Schreibschutz aktiviert ist, k�nnen in der Anzeige des Dashboards keine �nderungen vorgenommen werden und dadurch z.B. eine versehentliche L�schung oder Freigabe eines Kommentars verhindert werden.'); 
@define('PLUGIN_DASHBOARD_DEPENDENCY_NOTE', 'Erlaube Hinweis auf Plugin-Abh�ngigkeiten im Dashboard Header?');
@define('PLUGIN_DASHBOARD_DEPENDENCY_NOTE_DESC', '');
@define('PLUGIN_DASHBOARD_UPDATE', 'Pr�fe Serendipity Update');
@define('PLUGIN_DASHBOARD_UPDATE_DESC', 'Soll die Verf�gbarkeit einer neuen stabilen Version angezeigt werden?');
@define('PLUGIN_DASHBOARD_STABLE', 'stabil');
@define('PLUGIN_DASHBOARD_NONE', 'aus');
@define('PLUGIN_DASHBOARD_PLUGUP', 'Plugin Update Notificator');
@define('PLUGIN_DASHBOARD_PATH', 'Element und Script HTTP Pfad');
@define('PLUGIN_DASHBOARD_PATH_DESC', 'Gebe den vollst�ndigen HTTP-Pfad (alles nach dem Domain-Namen) ein, der zu diesem Plugin-Verzeichnis f�hrt.');
@define('PLUGIN_DASHBOARD_CLEAN', 'Erlaube Button: \'L�sche alle kompilierten Templates\' im Dashboard Header?');
@define('PLUGIN_DASHBOARD_INFO', 'Info Box');
@define('PLUGIN_DASHBOARD_MAINTENANCE', 'Erlaube Button: \'Service Wartungsmodus\' im Dashboard Update-Block?');
@define('PLUGIN_DASHBOARD_MAINTENANCE_NOTE', 'Text des Wartungsmodus');
@define('PLUGIN_DASHBOARD_MAINTENANCE_TEXT', 'Dieser Blog &#187;%s&#171; wird momentan gewartet und ist in kurzer Zeit wieder erreichbar.');

/* propbag & mixed */
@define('PLUGIN_DASHBOARD_TITLE', 'Dashboard');

/* propbag feed */
@define('PLUGIN_DASHBOARD_FEED', 'Serendipity (s9y.org) Blog Feed');
@define('PLUGIN_DASHBOARD_FEED_URL', 'URL des RSS-Feeds');
@define('PLUGIN_DASHBOARD_FEED_TITLE', 'Titel des Feed Blocks');
@define('PLUGIN_DASHBOARD_FEED_CONTENT', 'Artikel-Inhalt anzeigen?');
@define('PLUGIN_DASHBOARD_FEED_AUTHOR', 'Artikel-Autor anzeigen?');
@define('PLUGIN_DASHBOARD_FEED_CONUM', 'Auf Artikel-Kommentare verweisen?');

/* propbag limits */
@define('PLUGIN_DASHBOARD_LIMIT_FEED', 'Anzahl der Feed Eintr�ge');
@define('PLUGIN_DASHBOARD_LIMIT_DRAFT', 'Anzahl der Entw�rfe');
@define('PLUGIN_DASHBOARD_LIMIT_FUTURE', 'Anzahl der zuk�nftigen Artikel (nach Ver�ffentlichungsdatum)');
@define('PLUGIN_DASHBOARD_LIMIT_COMMENTS', 'Anzahl der Kommentare');
@define('PLUGIN_DASHBOARD_LIMIT_COMMENTS_PENDING', 'Anzahl der zu bewilligenden Kommentare');


/* UI-Block future */
@define('PLUGIN_DASHBOARD_FUTURE', 'zuk�nftige Artikel');

/* UI-Block update */
@define('UPDATE', 'Update notifier');
@define('PLUGIN_DASHBOARD_UPDATE_TITLE', 'Serendipity Update');
@define('PLUGIN_DASHBOARD_UPDATE_NOTIFIER_AUTOADD', ', oder nutze:');
@define('PLUGIN_DASHBOARD_UPDATE_BUTTON_TEXT', 'Automatisches Update');
@define('PLUGIN_DASHBOARD_UPDATE_BLOCKTITLE', 'Plugin Update verf�gbar');

/* UI-Blocks both comments */
@define('PLUGIN_DASHBOARD_COMMENTS_PENDING', 'zu bewilligende Kommentare');
@define('PLUGIN_DASHBOARD_COMMENT_SELECTION_SHORT', '<span>#%s</span>');

/* UI-Block info */
@define('PLUGIN_DASHBOARD_INFO_HEADER', 'Auf einen Blick');
@define('PLUGIN_DASHBOARD_INFO_CONTENT', 'Inhalt');
@define('PLUGIN_DASHBOARD_INFO_DISCUSSION', 'Diskussion');
@define('PLUGIN_DASHBOARD_INFO_ENTRIES', 'Artikel');
@define('PLUGIN_DASHBOARD_INFO_FREETAGS', 'Schlagw�rter');
@define('PLUGIN_DASHBOARD_INFO_COMMENTS_APPROVED', 'Genehmigte');
@define('PLUGIN_DASHBOARD_INFO_COMMENTS_PENDING', 'Offen');
@define('PLUGIN_DASHBOARD_INFO_WIDGETS', 'Seitenleisten Plugins [Widgets]');
@define('PLUGIN_DASHBOARD_INFO_VERSION', 'Du nutzt: %s');
@define('PLUGIN_DASHBOARD_INFO_WITH', 'mit');

/* UI-Block maintenance */
@define('PLUGIN_DASHBOARD_MAINTENANCE_MODE', 'Service Wartungsmodus');
@define('PLUGIN_DASHBOARD_MAINTENANCE_MODE_ACTIVE', '...aktive Wartung...');
@define('PLUGIN_DASHBOARD_MAINTENANCE_MODE_DESC', 'ACHTUNG:\nNicht ausloggen, bevor wieder auf false zur�ckgesetzt!!');

/* HTML element attributes */
@define('PLUGIN_DASHBOARD_CLEANSMARTY', 'S�ubere Smarty\'s kompilierte Templates');
@define('PLUGIN_DASHBOARD_FLIPNOTE', 'Zum Umschalten klicken');
@define('PLUGIN_DASHBOARD_DELETE_SELECTED', 'L�sche Auswahl');
@define('PLUGIN_DASHBOARD_MODERATE_SELECTED', 'Genehmige Auswahl');
@define('READ_ONLY', 'Inaktiv');
@define('NAV_SELECT', 'Auswahl');

/* Dashboard notifications */
@define('PLUGIN_DASHBOARD_ERROR_URL', 'Fehler beim �berpr�fen der Verf�gbarkeit einer neueren Serendipity Version.');
@define('PLUGIN_DASHBOARD_UPDATE_NOTIFIER', '<strong>Eine neue Serendipity Version ist verf�gbar.</strong><br>Diese Version kann hier manuell heruntergeladen werden: v.%s');
@define('PLUGIN_DASHBOARD_CLEANUP_CONFIRM', 'Sollen die kompilierten Smarty Template Dateien (au�er denen des Dashboards) wirklich gel�scht werden? Normalerweise ist dies nicht erforderlich, solange alles gut funktioniert!');
@define('PLUGIN_DASHBOARD_MARK', 'Bitte nicht alle Dashboard-Elemente auf einmal au�er Kraft setzen! Gehe zur�ck zur Config!');
@define('PLUGIN_DASHBOARD_AUTOUPDATE_NOTE', 'Dieses Dashboard kann ein verf�gbares Tochter-Plugin nutzen: \'serendipity_event_autoupdate\'!<br />Um ein angek�ndigtes Serendipity Core-Update ohne weitere manuelle Bearbeitung auszuf�hren, installieren Sie zun�chst bitte dieses Plugin zus�tzlich �ber Spartacus.');

/* keep for future purposes - deprecated constants */
@define('PLUGIN_DASHBOARD_UNSTABLE', 'beta');
@define('INCLUDE_COMMENT_SELECTION', 'F�ge %s #%s %s');
@define('IN_SELECTION', 'zur Auswahl');
@define('PLUGIN_DASHBOARD_SYS', 'Dashboard System');
@define('PLUGIN_DASHBOARD_NA', '<b>N/A</b> [<em>%s, %s</em>] <sup class="note">(activiere in config)</sup>');
