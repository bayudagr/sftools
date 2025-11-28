<cfif not isDefined("REQUEST.Scookie.user")>
    <cfoutput>
        <script>
            alert('Please login to your Sunfish Web first to acquire token');
        </script>
    </cfoutput>
    <cf_sfabort>
</cfif>
<cfset objComp = createObject("component","SFCL_Explorer")>
<cfset strckVar = objComp.initVar()>

<cfparam name="dirPath" default="#APPLICATION.PATH.URL#/sys/sec/cron/client">

<cfdirectory directory="#dirPath#" name="qDirPath" action="list" sort="datelastmodified DESC">

<cfoutput>
 <link href='https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/ui-lightness/jquery-ui.css' rel='stylesheet'>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js" ></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" ></script>
 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet">
 <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
 <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

 <style>
 @import url(https://fonts.googleapis.com/css?family=Open+Sans);

 body{
 background: ##f2f2f2;
 font-family: 'Open Sans', sans-serif;
 }

 ::-webkit-scrollbar {
 width: 5px;
 height: 5px;
 }
 
 ::-webkit-scrollbar-track {
 width: 5px;
 height: 5px;
 background: ##f5f5f5;
 }
 
 ::-webkit-scrollbar-thumb {
 width: 1em;
 background-color: ##ddd;
 outline: 1px solid slategrey;
 border-radius: 1rem;
 }

 .main-container{
 position: relative;
 margin: 20px;
 }

 .search {
 width: 100%;
 position: relative;
 display: flex;
 }

 .searchTerm {
 width: 100%;
 border: 3px solid ##00B4CC;
 border-right: none;
 padding: 5px;
 border-radius: 5px 0 0 5px;
 outline: none;
 color: ##9DBFAF;
 } 

 .searchTerm:focus{
 color: ##00B4CC;
 }

 .searchButton {
 width: 40px;
 height: 39px;
 border: 1px solid ##00B4CC;
 background: ##00B4CC;
 text-align: center;
 color: ##fff;
 border-radius: 0 5px 5px 0;
 cursor: pointer;
 font-size: 20px;
 }

 /*Resize the wrap to see the search bar change!*/
 .wrap{
 width: 80%;
 }

 .header{
 width: 100%;
 }
 
 .content{
 margin: 20px 0;
 }

 .content table {
 font-family: monospace;
 }

 .fit-content {
 width: 1%;
 white-space: nowrap;
 }

 .content td {
 padding: 4px 3px;
 }

 .upload {
 margin-top: 10px;
 }

 .editor-view {
 position: fixed;
 top: 40px;
 left: 40px;
 right: 40px;
 bottom: 40px;
 }

 .editor-wrap {
 position: absolute;
 top: 0;
 left: 0;
 right: 0;
 bottom: 0;
 background: ##fafafa;
 border-radius: 8px;
 box-shadow: 0 5px 8px 0 rgba(0,0,0,.4);
 padding: 10px;
 }

 .editor {
 overflow: hidden;
 margin-top: 50px;
 height: 90% !important;
 }

 .toolbar {
 width: 100%;
 margin: 0 auto 10px;
 }

 .pre {
 height: 100%;
 overflow: auto;
 }

 .close-btn {
 text-decoration: none;
 margin-right: 20px;
 box-shadow: none;
 background: transparent;
 border: none;
 box-sizing: border-box;
 cursor: pointer;
 position: relative;
 width: 30px;
 height: 30px;
 float: right;
 &:before, &:after {
 content: "";
 display: block;
 position: absolute;
 left: 50%;
 top: 50%;
 background-color: ##000;
 width: 100%;
 height: 2px;
 transition: height .2s ease-out;
 border-radius: 3px;
 }
 &:before {
 transform: translate(-50%, -50%) rotate(45deg);
 }
 &:after {
 transform: translate(-50%, -50%) rotate(-45deg);
 }
 &:hover, &:focus {
 &:before, &:after {
 height: 4px;
 }
 }
 }

 ##editor-container {
 display: none;
 }

 pre code,
 pre .line-number {
 /* Ukuran line-height antara teks di dalam tag <code> dan <span class="line-number"> harus sama! */
            font:normal normal 12px/14px "Courier New",Courier,Monospace;
            color:black;
            display:block;
        }

        pre .line-number {
            float:left;
            margin:0 1em -1em;
            border-right:1px solid;
            text-align:right;
            position:sticky;
            left:0;
            clear:both;
            background: ##fafafa;
        }

        pre .line-number span {
            display:block;
            padding:0 .5em 0 1em;
        }

        pre .cl {
            display:block;
            clear:both;
        }

        [contenteditable] {
            outline: 0px solid transparent;
        }

        .title-file {
            float: left;
            display: flex;
            flex-direction: column;
            margin-left: 10px;
        }

        .save-edit {
            float: left;
            position: relative;
            display: flex;
            align-items: center;
            font-size: 0.75rem;
            padding: 0.5rem 1.25rem;
            border: 0;
            font-weight: bold;
            background-color: ##2196F3;
            color: ##fff;
            border-radius: 6px;
            cursor: pointer;
            outline: none;
        }
        .save-edit.active {
            opacity: 0.5;
            cursor: not-allowed;
        }
        .save-edit:focus {
            box-shadow: 0 0 0 0.25rem ##b4eece;
        }
        .save-edit.active .text {
            margin-right: 2rem;
        }
        .save-edit.active .loader {
            animation: spin 0.25s linear infinite;
            opacity: 1;
        }
        .text {
            transition: margin-right 0.25s
                cubic-bezier(0.175, 0.885, 0.32, 1.275);
            margin-right: 0;
        }
        .loader {
            position: absolute;
            right: 1.25rem;
            width: 1rem;
            height: 1rem;
            margin-left: 0.75rem;
            border-left: 2px solid ##fff;
            border-top: 2px solid ##fff;
            border-radius: 1000px;
            opacity: 0;
        }
        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }
        .container {
            display: flex;
            border: 1px solid rgb(203 213 225);
            border-radius: 0.5rem;
            overflow: hidden;
            height: 100%;
			background-color: ##2F3129;
        }
        .container__textarea {
            border: none;
            outline: none;
            padding: 0.5rem;
            width: 100%;
            font:normal normal 12px/14px "Courier New",Courier,Monospace;
            background-color: ##272822;
            color: ##fff;
            tab-size: 4;
        }
        .container__lines {
            border-right: 1px solid ##2F3129;
            padding: 0.5rem;
            text-align: right;
            overflow: hidden;
            background-color: ##2F3129;
            color: ##8F908A;
        }
		.container__textarea::-webkit-scrollbar-track {
			background-color: ##2F3129;
		}

        .wrapper {
            height: 100vh;
            /* This part is important for centering the content */
            display: flex;
            align-items: center;
            justify-content: center;
            /* End center */
            background: -webkit-linear-gradient(to right, ##834d9b, ##d04ed6);
            background: linear-gradient(to right, ##834d9b, ##d04ed6);
        }

        .wrapper a {
            display: inline-block;
            text-decoration: none;
            padding: 15px;
            background-color: ##fff;
            border-radius: 3px;
            text-transform: uppercase;
            color: ##585858;
            font-family: 'Roboto', sans-serif;
        }

        .modal {
            visibility: hidden;
            opacity: 0;
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(77, 77, 77, .7);
            transition: all .4s;
        }

        .modal:target {
            visibility: visible;
            opacity: 1;
        }

        .modal__content {
            border-radius: 4px;
            position: relative;
            width: 500px;
            max-width: 90%;
            background: ##fff;
            padding: 1em 2em;
        }

        .modal__footer {
            text-align: right;
            a {
                color: ##585858;
            }
            i {
                color: ##d02d2c;
            }
        }
        .modal__close {
            position: absolute;
            top: 10px;
            right: 10px;
            color: ##585858;
            text-decoration: none;
        }
    </style>
    
    <div class="main-container">
        <form name="frmExplorer" id="frmExplorer" action="#strckVar.url#?sfid=sys.sec.cron.client.#strckVar.ist#.explorer.index" method="post">
            <div class="header">
                <div class="wrap">
                    <div class="search">
                        <input type="text" class="searchTerm" name="dirPath" id="dirPath" value="#dirPath#">
                        <button type="submit" class="searchButton">
                            Go
                        </button>
                    </div>
                    <div class="upload">
                        <input type="file" name="inp_file" id="inp_file">
                        <button type="button" class="uploadButton" onclick="uploadFile('#qDirPath.directory#')">Upload</button>
                        <button type="button" class="createButton" onclick="createFile('#qDirPath.directory#')">Create File</button>
                        <a href="##demo-modal" id="link-modal" style="display:none;">Open Demo Modal</a>
                    </div>
                </div>
            </div>
            <div class="content">
                <cfset backUrl = listDeleteAt(dirPath, listLen(dirPath,"/"), "/")>
                <table width="100%">
                    <tr>
                        <td>../</td>
                        <td><a href="javascript:void(0)" onclick="changeDirectory('#backUrl#')">back</a></td>
                        <td></td>
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
                                    <a href="javascript:void(0)" onclick="changeDirectory('#qDirPath.directory#/#qDirPath.name#')">#qDirPath.name#</a>
                                <cfelse>
                                    <span id="lbl_filename_#qDirPath.currentrow#">#qDirPath.name#</span>
                                    <input type="text" class="inp_rename" id="inp_rename_#qDirPath.currentrow#" value="#qDirPath.name#" style="display:none;" onblur="renameFile('#qDirPath.name#','#qDirPath.directory#',#qDirPath.currentrow#)">
                                </cfif>
                            </td>
                            <cfif qDirPath.type eq 'File'>
                                <td>#qDirPath.size# Bytes</td>
                                <td>#dateTimeFormat(qDirPath.dateLastModified,"yyyy-mm-dd hh:nn:ss")#</td>
                                <td>
                                    <select name="inp_sel_action_#qDirPath.currentrow#" onchange="fileAction('#qDirPath.name#','#qDirPath.directory#', #qDirPath.currentrow#, this)">
                                        <option value="0">-- action --</option>
                                        <option value="open">Open</option>
                                        <option value="rename">Rename</option>
                                        <option value="delete">Delete</option>
                                        <option value="download">Downlaod</option>
                                    </select>
                                </td>
                            </cfif>
                        </tr>
                    </cfloop>
                </table>
            </div>
        </form>

    </div>
    <div id="editor-container" class="editor-view">
        <input type="hidden" name="inp_file_name" id="inp-file-name" value="">
        <input type="hidden" name="inp_file_dir" id="inp-file-dir" value="">
        <div class="editor-wrap">
            <div class="toolbar">
                <button id="save-edit" class="save-edit">
                    <div class="text">Save</div>
                    <div class="loader"></div>
                </button>
                <div class="title-file">
                    <span class="file-name"></span>
                    <small class="file-dir"></small>
                </div>
                <button class="close-btn" onclick="closeEditor();"></button>
            </div>
            <div class="editor">
                <!---
                <pre class="pre"><code id="code-editor" class="editor-pre" contenteditable onkeyup="handleNewLine();"></code></pre>
                --->
                <!---<textarea id="code-editor" name="code-editor"></textarea--->
                <div id="container" class="container">
                    <div id="line-numbers" class="container__lines"></div>
                    <textarea id="textarea" class="container__textarea"></textarea>
                </div>
            </div>
        </div>
    </div>

    <!--- modal create file --->
    <div id="demo-modal" class="modal">
        <div class="modal__content">
            <input type="hidden" name="hdn_file_path" id="hdn-file-path">
            <h4>Create new file</h4>

            <table>
                <tr>
                    <td>File Name</td>
                    <td>:</td>
                    <td>
                        <input type="text" name="inp_filename" id="inp-filename" value="">
                    </td>
                    <td>
                        <button type="button" id="createfile-btn" onclick="openEditor()">Create</button>
                    </td>
                </tr>
            </table>
    
            <a href="##" class="modal__close">&times;</a>
        </div>
    </div>
    
    <script>
        // document.addEventListener('DOMContentLoaded', () => {
            const textarea = document.getElementById('textarea');
            const lineNumbersEle = document.getElementById('line-numbers');

            const textareaStyles = window.getComputedStyle(textarea);
            [
                'fontFamily',
                'fontSize',
                'fontWeight',
                'letterSpacing',
                'lineHeight',
                'padding',
            ].forEach((property) => {
                lineNumbersEle.style[property] = textareaStyles[property];
            });

            const parseValue = (v) => v.endsWith('px') ? parseInt(v.slice(0, -2), 10) : 0;

            const font = `${textareaStyles.fontSize} ${textareaStyles.fontFamily}`;
            const paddingLeft = parseValue(textareaStyles.paddingLeft);
            const paddingRight = parseValue(textareaStyles.paddingRight);

            const canvas = document.createElement('canvas');
            const context = canvas.getContext('2d');
            context.font = font;

            const calculateNumLines = (str) => {
                const textareaWidth = textarea.getBoundingClientRect().width - paddingLeft - paddingRight;
                const words = str.split(' ');
                let lineCount = 0;
                let currentLine = '';
                for (let i = 0; i < words.length; i++) {
                    const wordWidth = context.measureText(words[i] + ' ').width;
                    const lineWidth = context.measureText(currentLine).width;

                    if (lineWidth + wordWidth > textareaWidth) {
                        lineCount++;
                        currentLine = words[i] + ' ';
                    } else {
                        currentLine += words[i] + ' ';
                    }
                }

                if (currentLine.trim() !== '') {
                    lineCount++;
                }

                return lineCount;
            };

            const calculateLineNumbers = () => {
                const lines = textarea.value.split('\n');
                const numLines = lines.map((line) => calculateNumLines(line));

                let lineNumbers = [];
                let i = 1;
                while (numLines.length > 0) {
                    const numLinesOfSentence = numLines.shift();
                    lineNumbers.push(i);
                    if (numLinesOfSentence > 1) {
                        Array(numLinesOfSentence - 1)
                            .fill('')
                            .forEach((_) => lineNumbers.push(''));
                    }
                    i++;
                }

                return lineNumbers;
            };

            const displayLineNumbers = () => {
                const lineNumbers = calculateLineNumbers();
                lineNumbersEle.innerHTML = Array.from({
                    length: lineNumbers.length
                }, (_, i) => `<div>${lineNumbers[i] || '&nbsp;'}</div>`).join('');
            };

            textarea.addEventListener('input', () => {
                displayLineNumbers();
            });

            displayLineNumbers();

            const ro = new ResizeObserver(() => {
                const rect = textarea.getBoundingClientRect();
                lineNumbersEle.style.height = `${rect.height}px`;
                displayLineNumbers();
            });
            ro.observe(textarea);

            textarea.addEventListener('scroll', () => {
                lineNumbersEle.scrollTop = textarea.scrollTop;
            });

            textarea.addEventListener('keydown', function(e){
                if (e.key == 'Tab') {
                    e.preventDefault();
                    var start = this.selectionStart;
                    var end = this.selectionEnd;

                    // set textarea value to: text before caret + tab + text after caret
                    this.value = this.value.substring(0, start) +
                    "\t" + this.value.substring(end);

                    // put caret at right position again
                    this.selectionStart =
                    this.selectionEnd = start + 1;
                }
            });
        // });

        $(document).ready(function() {
            $('.inp_rename').keydown(function(event){
                if(event.keyCode == 13) {
                event.preventDefault();
                $(this).blur();
                }
            });

            const button = document.getElementById("save-edit");
            const code_editor = document.getElementById("code-editor");

            const handleClick = (event) => {
                // Clicked button
                const button = event.currentTarget;
                // Text within button
                const text = button.querySelector(".text");
                // Spinner within button
                const loader = button.querySelector(".loader");
                button.classList.add("active");
                button.disabled = true;
                text.innerText = "Saving";
                setTimeout(() => {
                    button.classList.remove("active");
                    text.innerText = "Save";
                    button.disabled = false;
                    button.focus();
                }, 1000);

                handleSaveFile();
            };

            // const handleNewLine = (event) => {
            //     console.log('test');
            //     e = event || window.event;
            //     if(e.keyCode == 13){
            //         reLine();
            //     }
            // }

            button.addEventListener("click", handleClick);
            // code_editor.addEventListener("keydown", handleNewLine);
        });

        function handleNewLine(event){
            e = event || window.event;
            console.log(e);
            if(e.keyCode == 13){
                reLine();
            } else if (e.keyCode == 8){
                reLine();
            }
        }

        function changeDirectory(dirpath){
            document.getElementById('dirPath').value = dirpath;
            document.getElementById('frmExplorer').submit();
        }

        function createFile(file_path){
            // console.log(file_path);
            $("##hdn-file-path").val(file_path);
            window.location.href = '##demo-modal';
            // $("##link-modal").click();
        }

        function openEditor(){
            const file_name = $('##inp-filename').val();
            const file_path = $('##hdn-file-path').val();
            const mode = 'create';

            openFile(file_name, file_path, mode);
        }

        function uploadFile(file_path){
            var file_data = "";
            var file_name = "";
            if(document.getElementById("inp_file").files.length > 0){
                file_data = $('##inp_file').prop('files')[0];
                file_name = $('##inp_file').prop('files')[0].name;
            }
            var form_data = new FormData();
            form_data.append('file_data', file_data);
            form_data.append('file_name', file_name);
            form_data.append('file_path', file_path);

            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.#strckVar.ist#.explorer.action&action=upload",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    alert(data.message+'\n'+data.error);
                    if(data.success && data.dump == '') {
                        window.location.reload();
                    }
                },
                error: function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    console.log(err.Message);
                    alert(err.Message);
                },
                complete: function() {
                    //do something
                },
                dataType: "json"
            });
        }

        function fileAction(file_name, file_path, seq, obj){
            var action = $(obj).val();
            console.log(action);
            if(action == 'rename') {
                $('##lbl_filename_'+seq).css('display','none');
                $('##inp_rename_'+seq).css('display','block');
                $('##inp_rename_'+seq).focus();
            } else if(action == 'delete') {
                var confirm_delete = confirm("Delete this file?");
                if(confirm_delete){
                    deleteFile(file_name, file_path);
                }
            } else if(action == 'download') {
                downloadFile(file_name, file_path);
            } else if(action == 'open') {
                openFile(file_name, file_path);
            }
        }

        function renameFile(file_name, file_path, seq){
            $('##inp_rename_'+seq).css('display','none');
            $('##lbl_filename_'+seq).css('display','block');
            var new_file_name = document.getElementById('inp_rename_'+seq).value;

            var form_data = new FormData();
            form_data.append('file_name', file_name);
            form_data.append('file_path', file_path);
            form_data.append('new_file_name', new_file_name);

            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.#strckVar.ist#.explorer.action&action=rename",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    alert(data.message+'\n'+data.error);
                    if(data.success && data.dump == '') {
                        window.location.reload();
                    }
                },
                error: function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    console.log(err.Message);
                    alert(err.Message);
                },
                complete: function() {
                    //do something
                },
                dataType: "json"
            });
        }

        function deleteFile(file_name, file_path){
            var form_data = new FormData();
            form_data.append('file_name', file_name);
            form_data.append('file_path', file_path);

            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.#strckVar.ist#.explorer.action&action=delete",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    alert(data.message+'\n'+data.error);
                    if(data.success && data.dump == '') {
                        window.location.reload();
                    }
                },
                error: function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    console.log(err.Message);
                    alert(err.Message);
                },
                complete: function() {
                    //do something
                },
                dataType: "json"
            });
        }

        function downloadFile(file_name, file_path){
            var form_data = new FormData();
            form_data.append('file_name', file_name);
            form_data.append('file_path', file_path);

            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.#strckVar.ist#.explorer.action&action=download",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    alert(data.message+'\n'+data.error);
                    if(data.success && data.dump == '') {
                        window.location.reload();
                    }
                },
                error: function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    console.log(err.Message);
                    alert(err.Message);
                },
                complete: function() {
                    //do something
                },
                dataType: "json"
            });
        }

        function openFile(file_name, file_path, mode = 'open') {
            var form_data = new FormData();
            form_data.append('file_name', file_name);
            form_data.append('file_path', file_path);
            
            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.#strckVar.ist#.explorer.action&action="+mode,
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    //alert(data.message+'\n'+data.error);
                    // if(data.success && data.dump == '') {
                        //     window.location.reload();
                        // }
                        
                    if(data.success){
                        if(mode == 'create'){
                            window.location.href = '##';
                        }
                        $('##editor-container').show();
                        $(".file-name").html(file_name);
                        $(".file-dir").html(file_path);
                        $("##inp-file-name").val(file_name);
                        $("##inp-file-dir").val(file_path);
                        $(".container__textarea").val(data.content);
                        displayLineNumbers();
                    } else {
                        if(data.message !== ''){
                            alert(data.message);
                        } else {
                            alert('Failed to create a new file');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    console.log(err.Message);
                    alert(err.Message);
                },
                complete: function() {
                    //do something
                },
                dataType: "json"
            });
        }

        function closeEditor(){
            $('##editor-container').hide();
            window.location.reload();
        }

        function handleChange(e){
            e = e || window.event;
            if(e.keyCode == 13){
                reLine();
            }
        }

        function handleSaveFile(){
            const file_name = $('##inp-file-name').val();
            const file_dir = $('##inp-file-dir').val();
            var content = $('.container__textarea').val();

            content = content.replace(/<script/gi, "~&lt;script~");
            content = content.replace(/<object/gi, "~&lt;object~");
            content = content.replace(/<embed/gi, "~&lt;embed~");
            content = content.replace(/<applet/gi, "~&lt;applet~");
            content = content.replace(/<meta/gi, "~&lt;meta~");

            console.log(file_name);
            console.log(file_dir);
            console.log(content);

            var form_data = new FormData();
            form_data.append('file_name', file_name);
            form_data.append('file_path', file_dir);
            form_data.append('content', content);

            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.#strckVar.ist#.explorer.action&action=saveEdit",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    if(data.message !== ''){
                        alert(data.message+'\n'+data.error);
                    }
                    // if(data.success && data.dump == '') {
                    //     window.location.reload();
                    // }
                    $(".container__textarea").val(data.content);
                    displayLineNumbers();
                },
                error: function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    console.log(err.Message);
                    alert(err.Message);
                },
                complete: function() {
                    //do something
                },
                dataType: "json"
            });
        }

        function reLine(){
            console.log('reline');
            var pre = document.getElementsByTagName('pre'),
                pl = pre.length;
            $('.line-number').remove();
            $('.cl').remove();
            for (var i = 0; i < pl; i++) { 
                pre[i].innerHTML = '<span class="line-number"></span>' + pre[i].innerHTML + '<span class="cl"></span>';
                var num = pre[i].innerHTML.split(/\n/).length;
                for (var j = 0; j < num; j++) {
                    var line_num = pre[i].getElementsByTagName('span')[0];
                    line_num.innerHTML += '<span>' + (j + 1) + '</span>';
                }
            }
        }
    </script>
</cfoutput>

