<cfparam name="dirPath" default="/">
<cfparam name="viewMode" default="list">
<cfparam name="backUrl" default="/">

<cfdirectory directory="#dirPath#" name="qDirPath" action="list" sort="datelastmodified DESC">
<cfoutput>
    <cfif viewMode eq 'list'>
        <div id="view-list">
            <table width="100%" id="t_content">
                <thead>
                    <tr>
                        <td></td>
                        <td></td>
                        <td>name</td>
                        <td>modified date</td>
                        <td>type</td>
                        <td>size</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="3">../ <a href="javascript:void(0)" onclick="changeDirectory('#backUrl#')">back</a></td>
                    </tr>
                    <cfloop query="qDirPath">
                        <tr>
                            <td class="fit-content">
                                <cfif qDirPath.type eq 'File'>
                                    <input type="checkbox" name="inp_check_#qDirPath.currentrow#">
                                </cfif>
                            </td>
                            <td class="fit-content">
                                <cfif qDirPath.type eq 'Dir'>
                                    <i class="fa fa-folder"></i>
                                <cfelse>
                                    <i class="fa fa-file"></i>
                                </cfif>
                            </td>
                            <td>
                                <cfif qDirPath.type eq 'Dir'>
                                    <a href="javascript:void(0)" class="dir-list-item" data-file-path="#qDirPath.directory#" data-file-name="#qDirPath.name#" onclick="changeDirectory('#qDirPath.directory#/#qDirPath.name#')">#qDirPath.name#</a>
                                <cfelse>
                                    <span id="lbl_filename_#qDirPath.currentrow#" class="file-list-item" data-file-row="#qDirPath.currentrow#" data-file-name="#qDirPath.name#" data-file-path="#qDirPath.directory#">#qDirPath.name#</span>
                                    <input type="text" class="inp_rename" id="inp_rename_#qDirPath.currentrow#" value="#qDirPath.name#" style="display:none;" onblur="renameFile('#qDirPath.name#','#qDirPath.directory#',#qDirPath.currentrow#)">
                                </cfif>
                            </td>
                            <cfif qDirPath.type eq 'File'>
                                <td>#dateTimeFormat(qDirPath.dateLastModified,"yyyy-mm-dd hh:nn:ss")#</td>
                                <td>#listLast(qDirPath.name,".")#</td>
                                <!---td>#fileGetMimeType("#qDirPath.directory#/#qDirPath.name#")#</td--->
                                <td>#qDirPath.size# Bytes</td>
                            <cfelse>
                                <td>#dateTimeFormat(qDirPath.dateLastModified,"yyyy-mm-dd hh:nn:ss")#</td>
                                <td>File Folder</td>
                                <td></td>
                            </cfif>
                        </tr>
                    </cfloop>
                </tbody>
            </table>
        </div>
    <cfelseif viewMode eq 'grid'>
        <div id="view-grid">
            <cfif qDirPath.recordcount gt 0>
                <cfloop query="qDirPath">
                    <cfif qDirPath.type eq 'Dir'>
                        <div class="grid-items dir-list-item" data-file-path="#qDirPath.directory#" data-file-name="#qDirPath.name#" onclick="changeDirectory('#qDirPath.directory#/#qDirPath.name#')">
                    <cfelse>
                        <div class="grid-items file-list-item" data-file-row="#qDirPath.currentrow#" data-file-name="#qDirPath.name#" data-file-path="#qDirPath.directory#">
                    </cfif>
                        <div class="grid-items-icon">
                            <cfif qDirPath.type eq 'Dir'>
                                <i class="fa fa-folder"></i>
                            <cfelse>
                                <i class="fa fa-file"></i>
                            </cfif>
                        </div>
                        <div>
                            <!---span class="lbl-grid-item-name">#len(qDirpath.name) gt 15 ? htmlEditFormat(left(qDirPath.name, 12)) & '...' : htmlEditFormat(qDirPath.name)#</span--->
                            <span id="lbl_filename_#qDirPath.currentrow#" class="lbl-grid-item-name">#len(qDirpath.name) gt 15 ? htmlEditFormat(left(qDirPath.name, 12)) & '...' : htmlEditFormat(qDirPath.name)#</span>
                            <input type="text" class="inp_rename" id="inp_rename_#qDirPath.currentrow#" value="#qDirPath.name#" style="display:none;" onblur="renameFile('#qDirPath.name#','#qDirPath.directory#',#qDirPath.currentrow#)">
                        </div>
                    </div>
                </cfloop>
            <cfelse>
                <div class="empty-wrapper">
                    <span>Empty</span>
                </div>
            </cfif>
        </div>
    </cfif>

    <script>
        // Change the selector if needed
        var $table = $('##t_content'),
            $bodyCells = $table.find('tbody tr:nth-child(2)').children(),
            colWidth;

        // Get the tbody columns width array
        colWidth = $bodyCells.map(function() {
            return $(this).width();
        }).get();

        // Set the width of thead columns
        $table.find('thead tr').children().each(function(i, v) {
            $(v).width(colWidth[i]);
        });
    </script>
</cfoutput>