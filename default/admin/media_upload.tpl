<!--- DASHBOARD MEDIA_UPLOAD START -->
<div class="image_add_form">{$CONST.ADD_MEDIA_BLAHBLAH}</div>

<script type="text/javascript" language="JavaScript" src="{$CONST.DASHBOARD_PLUGINPATH}/inc/admin_media_fncs.js"></script>

<form action="?" method="POST" id="uploadform" enctype="multipart/form-data" onsubmit="rememberOptions()">
    <div>
        {if $media.max_file_size}
        <input type="hidden" name="MAX_FILE_SIZE" value="{$max_file_size}" />
        {/if}
        {$media.token}
        <input type="hidden" name="serendipity[action]"      value="admin" />
        <input type="hidden" name="serendipity[adminModule]" value="images" />
        <input type="hidden" name="serendipity[adminAction]" value="add" />
        {$media.form_hidden}
        <table id="foreign_upload" class="image_add_foreign">
            <tr>
                <td nowrap="nowrap">{$CONST.ENTER_MEDIA_URL}</td>
                <td><input class="input_textbox" type="text" id="imageurl" name="serendipity[imageurl]"
                         onchange="checkInputs()"
                          value=""
                           size="40" /></td>
            </tr>
            <tr>
                <td nowrap="nowrap">{$CONST.ENTER_MEDIA_URL_METHOD}</td>
                <td>
                    <select name="serendipity[imageimporttype]">
                        <option value="image">{$CONST.FETCH_METHOD_IMAGE}</option>
                        <option value="hotlink">{$CONST.FETCH_METHOD_HOTLINK}</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td align="center" colspan="2"><b> - {$CONST.WORD_OR} - </b></td>
            </tr>
        </table>

        <!-- WARNING: Do not change spacing or breaks below. If you do, the JavaScript childNodes need to be edited. Newlines count as nodes! -->
        <div id="upload_template">
        <table style="margin-top: 35px" id="upload_table" class="image_add_local">
            <tr>
                <td nowrap='nowrap'>{$CONST.ENTER_MEDIA_UPLOAD}</td>
                <td><input class="input_file" id="userfile_1" name="serendipity[userfile][1]"
                         onchange="checkInputs();"
                           type="file" /></td>
            </tr>

            <tr>
                <td align="center" colspan="2"><br /></td>
            </tr>

            <tr>
                <td>{$CONST.SAVE_FILE_AS}</td>
                <td><input class="input_textbox" type="text" id="target_filename_1" name="serendipity[target_filename][1]" value="" size="40" /></td>
            </tr>

            <tr>
                <td>{$CONST.STORE_IN_DIRECTORY}</td>
                <td><select id="target_directory_1" name="serendipity[target_directory][1]">
                    <option value="">{$CONST.BASE_DIRECTORY}</option>
                    {foreach from=$media.folders item="folder"}
                    <option {if $media.only_path == $folder.relpath}selected="selected"{/if} value="{$folder.relpath}">{'&nbsp;'|@str_repeat:($folder.depth*2)} {$folder.name}</option>
                    {/foreach}
                    </select>
                </td>
            </tr>
       </table>
       <div id="ccounter"><input type="hidden" name="serendipity[column_count][1]" id="column_count_1" value="true" /></div>
       </div>

       <div id="debug">
       </div>

       <script type="text/javascript">
            (function(d){ldelim}
                reference = d.getElementById('upload_template');
                reference.style.display  = 'none';
                var s = d.createElement('span');
                s.id  = "upload_form";
                $(document).ready(function() {ldelim} reference.parentNode.insertBefore(s, reference.nextSibling); {rdelim});
                addField();
            {rdelim})(document);
       </script>
        {serendipity_hookPlugin hook="backend_image_addform" hookAll=true}

        <div style="text-align: center; margin-top: 15px; margin-bottom: 15px">
            <input class="serendipityPrettyButton input_button" type="button" value="{$CONST.IMAGE_MORE_INPUT}" onclick="hideForeign(); addField()" /><br />
            <input type="hidden" name="serendipity[all_authors]" value="true" checked="checked" id="all_authors" />
            <br />
            <input onclick="checkInputs();" type="submit" value="{$CONST.GO}" class="serendipityPrettyButton input_button" />
            - {$CONST.WORD_OR} -
            <input onclick="checkInputs();" name="go_properties" type="submit" value="{$CONST.GO_ADD_PROPERTIES|@escape}" class="serendipityPrettyButton input_button" />
        </div>
    </div>
    <div class="image_add_note">{$CONST.ADD_MEDIA_BLAHBLAH_NOTE}</div>
</form>

