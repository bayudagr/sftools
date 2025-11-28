<cfoutput>
    <cfset backUrl = listDeleteAt(dirPath, listLen(dirPath,"/"), "/")>
    <table width="100%" id="t_content">
        <thead>
            <tr>
                <td></td>
                <td></td>
                <td>name</td>
                <td>size</td>
                <td>modified date</td>
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
                        <td>#qDirPath.size# Bytes</td>
                        <td>#dateTimeFormat(qDirPath.dateLastModified,"yyyy-mm-dd hh:nn:ss")#</td>
                        <!---td>
                            <select name="inp_sel_action_#qDirPath.currentrow#" onchange="fileAction('#qDirPath.name#','#qDirPath.directory#', #qDirPath.currentrow#, this)">
                                <option value="0">-- action --</option>
                                <option value="open">Open</option>
                                <option value="rename">Rename</option>
                                <option value="delete">Delete</option>
                                <option value="download">Downlaod</option>
                            </select>
                        </td--->
                    <cfelse>
                        <td>-</td>
                        <td>#dateTimeFormat(qDirPath.dateLastModified,"yyyy-mm-dd hh:nn:ss")#</td>
                    </cfif>
                </tr>
            </cfloop>
        </tbody>
    </table>
</cfoutput>