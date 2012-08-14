<?php
/* last modified - 2012-08-14 */
@define('PLUGIN_DASHBOARD_TITLE', 'Dashboard');
@define('PLUGIN_DASHBOARD_DESC', 'Zeigt ausgewählte Informationen auf der Startseite der Verwaltungsoberfläche als Übersicht');

@define('PLUGIN_DASHBOARD_LIMIT_DRAFT', 'Anzahl der Entwürfe');
@define('PLUGIN_DASHBOARD_LIMIT_COMMENTS', 'Anzahl der Kommentare');
@define('PLUGIN_DASHBOARD_LIMIT_FUTURE', 'Anzahl der zukünftigen Artikel (nach Veröffentlichungsdatum)');

@define('PLUGIN_DASHBOARD_SEQUENCE', 'Element Reihenfolge');
@define('PLUGIN_DASHBOARD_SEQUENCE_DESC', 'Hier wird die Reihenfolge der verschiedenen Informationsblöcke festgelegt.<p>Weitere Positionierungen können dann in Folge im Dashboard selbst vorgenommen werden!</p>');

@define('PLUGIN_DASHBOARD_FUTURE', 'zukünftige Artikel');

@define('PLUGIN_DASHBOARD_LIMIT_COMMENTS_PENDING', 'Anzahl der zu bewilligenden Kommentare');
@define('PLUGIN_DASHBOARD_COMMENTS_PENDING', 'zu bewilligende Kommentare');

@define('PLUGIN_DASHBOARD_READONLY', 'Schreibgeschütztes Dashboard?');
@define('PLUGIN_DASHBOARD_READONLY_DESC', 'Wenn der Schreibschutz aktiviert ist, können in der Anzeige des Dashbords keine Änderungen vorgenommen werden und dadurch z.B. eine versehentliche Löschung oder Freigabe eines Kommentars verhindert werden.'); 

@define('PLUGIN_DASHBOARD_UPDATE', 'Prüfe Serendipity Update');
@define('PLUGIN_DASHBOARD_UPDATE_DESC', 'Soll die Verfügbarkeit einer neuen stabilen Version oder einer neuen Beta-Version angezeigt werden?');
@define('PLUGIN_DASHBOARD_STABLE', 'stabil');
@define('PLUGIN_DASHBOARD_UNSTABLE', 'beta');
@define('PLUGIN_DASHBOARD_NONE', 'aus');
@define('PLUGIN_DASHBOARD_ERROR_URL', 'Fehler beim Überprüfen der Verfügbarkeit einer neueren Serendipity Version.');
@define('UPDATE', 'Update notifier');
@define('PLUGIN_DASHBOARD_UPDATE_TITLE', 'Serendipity Update');
@define('PLUGIN_DASHBOARD_UPDATE_NOTIFIER', '<strong>Eine neue Serendipity Version ist verfügbar.</strong><br>Diese Version kann hier manuell heruntergeladen werden: v.%s');
@define('PLUGIN_DASHBOARD_UPDATE_NOTIFIER_AUTOADD', ', oder nutze:');
@define('PLUGIN_DASHBOARD_CLEANUP_CONFIRM', 'Sollen die kompilierten Smarty Template Dateien (außer denen des Dasboards) wirklich gelöscht werden? Normalerweise ist dies nicht erforderlich, solange alles gut funktioniert!');

@define('PLUGIN_UPDATE_NOTIFIER', 'Plugin Update verfügbar');
@define('INCLUDE_COMMENT_SELECTION', 'Füge %s #%s %s');
@define('IN_SELECTION', 'zur Auswahl');

@define('PLUGIN_DASHBOARD_CLEAN', 'Erlaube Button: \'Lösche alle kompilierten Templates\' im Dashboard Header?');
@define('PLUGIN_DASHBOARD_SYS', 'Dashboard System');
@define('PLUGIN_DASHBOARD_CLEANSMARTY', 'Säubere Smarty\'s kompilierte Templates');
@define('PLUGIN_DASHBOARD_NA', '<b>N/A</b> [<em>%s, %s</em>] <sup class="note">(activiere in config)</sup>');
@define('PLUGIN_DASHBOARD_MARK', 'Bitte nicht alle Dashboard-Elemente auf einmal außer Kraft setzen! Gehe zurück zur Config!');
@define('PLUGIN_DASHBOARD_AUTOUPDATE_NOTE', 'Dieses Dashboard kann ein verfügbares Abhängigkeits-Plugin nutzen: \'serendipity_event_autoupdate\'!<br />Um ein angekündigtes Serendipity Core-Update ohne weitere manuelle Bearbeitung ausführen, installieren Sie zunächst bitte dieses Plugin zusätzlich über Spartacus.');
@define('PLUGIN_DASHBOARD_PATH', 'Element und Script HTTP Pfad');
@define('PLUGIN_DASHBOARD_PATH_DESC', 'Gebe den vollständigen HTTP-Pfad (alles nach dem Domain-Namen) ein, der zu diesem Plugin-Verzeichnis führt.');
@define('PLUGIN_DASHBOARD_FLIPNOTE', 'Zum Umschalten klicken');
@define('PLUGIN_DASHBOARD_COMMENT_SELECTION_SHORT', '#%s');
@define('PLUGIN_DASHBOARD_DELETE_SELECTED', 'Lösche Auswahl');
@define('PLUGIN_DASHBOARD_MODERATE_SELECTED', 'Genehmige Auswahl');

@define('PLUGIN_DASHBOARD_INFO', 'Info Box');
@define('PLUGIN_DASHBOARD_INFO_HEADER', 'Auf einen Blick');
@define('PLUGIN_DASHBOARD_INFO_CONTENT', 'Inhalt');
@define('PLUGIN_DASHBOARD_INFO_DISCUSSION', 'Diskussion');
@define('PLUGIN_DASHBOARD_INFO_ENTRIES', 'Artikel');
@define('PLUGIN_DASHBOARD_INFO_FREETAGS', 'Schlagwörter');
@define('PLUGIN_DASHBOARD_INFO_COMMENTS_APPROVED', 'Genehmigte');
@define('PLUGIN_DASHBOARD_INFO_COMMENTS_PENDING', 'Offen');
@define('PLUGIN_DASHBOARD_INFO_WIDGETS', 'Seitenleisten Plugins [Widgets]');
@define('PLUGIN_DASHBOARD_INFO_VERSION', 'Du nutzt: %s');
@define('PLUGIN_DASHBOARD_INFO_WITH', 'mit');

@define('PLUGIN_DASHBOARD_DEPENDENCY_NOTE', 'Erlaube Hinweis auf Plugin-Abhängigkeiten im Dashboard Header?');
@define('PLUGIN_DASHBOARD_DEPENDENCY_NOTE_DESC', '');
@define('PLUGIN_DASHBOARD_MAINTENANCE', 'Erlaube Button: \'In den Upgrade Wartungsmodus versetzen\' im Dashboard Update-Block?');
@define('PLUGIN_DASHBOARD_MAINTENANCE_NOTE', 'Text des Wartungsmodus');
@define('PLUGIN_DASHBOARD_MAINTENANCE_TEXT', 'Dieser Blog <%s> wird momentan gewartet und ist in kurzer Zeit wieder erreichbar.');

@define('PLUGIN_DASHBOARD_LIMIT_FEED', 'Anzahl der Feed Einträge');

@define('PLUGIN_DASHBOARD_FEED', 'Serendipity (s9y.org) Blog Feed');
@define('PLUGIN_DASHBOARD_FEED_URL', 'URL des RSS-Feeds');
@define('PLUGIN_DASHBOARD_FEED_TITLE', 'Titel des Feed Blocks');
@define('PLUGIN_DASHBOARD_FEED_CONTENT', 'Artikel-Inhalt anzeigen?');
@define('PLUGIN_DASHBOARD_FEED_AUTHOR', 'Artikel-Autor anzeigen?');
@define('PLUGIN_DASHBOARD_FEED_CONUM', 'Auf Artikel-Kommentare verweisen?');
