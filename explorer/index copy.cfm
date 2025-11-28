<cfif not isDefined("REQUEST.SCookie.user") OR REQUEST.Scookie.user.utype neq '9'>
	<cfoutput>
		<script>
			alert("Super Admin Only!! Please login to your Sunfish Super Admin account to create session");
		</script>
	</cfoutput>
	<cf_sfabort>
</cfif>
<cfparam name="dirPath" default="#expandPath(APPLICATION.PATH.URL)#/sys/sec/cron/client/samator">
<cfparam name="viewMode" default="list">

<cfset backUrl = listDeleteAt(dirPath, listLen(dirPath,"/"), "/")>

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
            height: 100vh;
        }

        .search {
            width: 100%;
            position: relative;
            display: flex;
            flex-direction: row;
            background: ##00B4CC;
            color: ##fff;
            align-items: center;
            padding: 10px 20px;
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
            width: 100%;
        }

        .header{
            width: 100%;
            position: fixed;
            left: 0;
            top: 0;
            right: 0;
        }
        
        .content{
            position: relative;
            padding: 20px;
            margin-top: 100px;
            width: calc(100vw - 250px);
            overflow-y: auto;
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
            padding: 0px 20px;
            background: ##f2f2f2;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            box-shadow: 0px 5px 8px rgba(216, 216, 216, 0.3);
        }

        .toolbar-left,
        .toolbar-right {
            display: flex;
            flex-direction: row;
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

        ##explorer-context-menu,
        ##explorer-context-menu-file {
			font-family: monospace;
 			background-color: ##ffffff;
 			box-shadow: 0 0 20px rgba(37, 40, 42, 0.22);
 			color: ##1f194c;
 			width: 10em;
 			padding: 0.8em 0.6em;
 			font-size: 10pt;
 			position: fixed;
 			visibility: hidden;
		}

        .explorer-context-menu-item,
        .explorer-context-menu-file-item {
 			padding: 0.3em 1.2em;
		}

		.explorer-context-menu-item:hover,
        .explorer-context-menu-file-item:hover {
 			background-color: rgba(44, 141, 247, 0.2);
 			cursor: pointer;
		}

        .dialog-ovelay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.50);
            z-index: 999999
        }
        .dialog-ovelay .dialog {
            width: 400px;
            margin: 100px auto 0;
            background-color: ##fff;
            box-shadow: 0 0 20px rgba(0,0,0,.2);
            border-radius: 3px;
            overflow: hidden
        }
        .dialog-ovelay .dialog header {
            padding: 10px 8px;
            background-color: ##f6f7f9;
            border-bottom: 1px solid ##e5e5e5
        }
        .dialog-ovelay .dialog header h3 {
            font-size: 14px;
            margin: 0;
            color: ##555;
            display: inline-block
        }
        .dialog-ovelay .dialog header .fa-close {
            float: right;
            color: ##c4c5c7;
            cursor: pointer;
            transition: all .5s ease;
            padding: 0 2px;
            border-radius: 1px    
        }
        .dialog-ovelay .dialog header .fa-close:hover {
            color: ##b9b9b9
        }
        .dialog-ovelay .dialog header .fa-close:active {
            box-shadow: 0 0 5px ##673AB7;
            color: ##a2a2a2
        }
        .dialog-ovelay .dialog .dialog-msg {
            padding: 12px 10px
        }
        .dialog-ovelay .dialog .dialog-msg p{
            margin: 0;
            font-size: 15px;
            color: ##333
        }
        .dialog-ovelay .dialog footer {
            border-top: 1px solid ##e5e5e5;
            padding: 8px 10px
        }
        .dialog-ovelay .dialog footer .controls {
            direction: rtl;
            text-align: right;
        }
        .dialog-ovelay .dialog footer .controls .button {
            padding: 5px 15px;
            border-radius: 3px
        }
        .button {
        cursor: pointer
        }
        .button-default {
            background-color: rgb(248, 248, 248);
            border: 1px solid rgba(204, 204, 204, 0.5);
            color: ##5D5D5D;
        }
        .button-danger {
            background-color: ##f44336;
            border: 1px solid ##d32f2f;
            color: ##f5f5f5
        }
        .link {
        padding: 5px 10px;
        cursor: pointer
        }

        .file-list-item {
            cursor: pointer;
        }

        .toolbar-item {
            display: flex;
            flex-direction: row;
            align-items: center;
            column-gap: 10px;
            padding: 10px 10px;
            cursor: pointer;
        }

        .toolbar-item:hover {
            color: ##fff;
            background: ##f44336;
        }

        .input-file-container {
            position: relative;
            width: 225px;
        } 

        .input-file-trigger {
            display: block;
            padding: 14px 45px;
            background: ##39D2B4;
            color: ##fff;
            font-size: 1em;
            transition: all .4s;
            cursor: pointer;
        }
        .input-file {
            position: absolute;
            top: 0; left: 0;
            width: 225px;
            opacity: 0;
            padding: 14px 0;
            cursor: pointer;
        }
        .input-file:hover + .input-file-trigger,
        .input-file:focus + .input-file-trigger,
        .input-file-trigger:hover,
        .input-file-trigger:focus {
            background: ##34495E;
            color: ##39D2B4;
        }

        .file-return {
            margin: 0;
        }
        .file-return:not(:empty) {
            margin: 0;
        }
        .file-return {
            font-style: italic;
            font-size: .9em;
            font-weight: bold;
        }
        .file-return:not(:empty):before {
            content: "Selected file: ";
            font-style: normal;
            font-weight: normal;
        }
        ##t_content thead td {
            font-weight: 700;
            border-bottom: 1px solid var(--secondary);
        }
        .content-container {
            display: flex;
            flex-direction: row;
            height: 100vh;
            overflow-y: hidden;
        }
        .sidepanel {
            width: 250px;
            padding: 20px;
            margin-top: 100px;
            overflow: auto;
            background: ##f2f2f2;
            box-shadow: 0px 5px 8px rgba(216, 216, 216, 0.3);
        }
        ##t_content thead, ##t_content tbody {
            display: block;
        }
        ##t_content tbody {
            overflow-y: auto;
            height: calc(100vh - 170px);
        }
        ##t_content td {
            padding: 5px;
        }

        ##view-grid {
            display: flex;
            flex-wrap: wrap;
            width: 100%;
            gap: 10px;
            padding: 20px 15px;
        }

        .grid-items {
            font-size: 100px;
            width: 120px;
            height: 150px;
            color: ##00B4CC;
            display: flex;
            flex-direction: column;
            align-items: center;
            row-gap: 5px;
            cursor: pointer;
        }

        .grid-items:hover {
            .grid-items-icon {
                color: ##0090A3;
                font-size: 110px;
            }
        }

        .lbl-grid-item-name {
            color: ##1f194c;
            font-size: 11pt;
        }

        .empty-wrapper {
            position: absolute;
            display: flex;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            align-items: center;
            justify-content: center;
        }
    </style>
    
    <div class="main-container">
        <form name="frmExplorer" id="frmExplorer" action="https://hc.samator.com:2053/sf6/index.cfm?sfid=sys.sec.cron.client.samator.explorer.index" method="post">
            <div class="header">
                <div class="wrap">
                    <div class="search">
                        <div style="padding: 0 10px">
                            <span><i class="fa fa-search"></i></span>
                        </div>
                        <div style="flex-grow: 1">
                            <input type="text" class="searchTerm" name="dirPath" id="dirPath" value="#dirPath#">
                            <input type="hidden" class="hdn_viewmode" id="hdn_viewmode" name="viewMode" value="#viewMode#">
                            <button type="submit" style="display:none"></button>
                        </div>
                    </div>
                    <div class="upload">
                        <div class="toolbar-left">
                            <div class="toolbar-item" onclick="changeDirectory('#backUrl#')">
                                <div><i class="fa fa-arrow-left"></i></div>
                                <div><span class="lbl-toolbar-item">Back</span></div>
                            </div>
                            <div class="toolbar-item" onclick="changeDirectory('#APPLICATION.PATH.URL#')">
                                <div><i class="fa fa-home"></i></div>
                                <div><span class="lbl-toolbar-item">Home</span></div>
                            </div>
                            <div class="toolbar-item" onclick="openModal('upload-file-modal');">
                                <div><i class="fa fa-upload"></i></div>
                                <div><span class="lbl-toolbar-item">Upload</span></div>
                            </div>
                            <div class="toolbar-item" onclick="createFile('#dirPath#')">
                                <div><i class="fa fa-file"></i></div>
                                <div><span class="lbl-toolbar-item">Create File</span></div>
                            </div>
                            <div class="toolbar-item" onclick="openCreateFolderModal('#dirPath#')">
                                <div><i class="fa fa-folder"></i></div>
                                <div><span class="lbl-toolbar-item">Create Folder</span></div>
                            </div>
                        </div>
                        <div class="toolbar-right">
                            <div class="toolbar-item" onclick="toggleView(this)">
                                <div><i class="#viewMode eq 'list' ? 'fa fa-list' : 'fa fa-th'#"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-container">
                <div class="sidepanel">
                    <cfinclude template="./explorer_sidepanel.cfm">
                </div>
                <div class="content" id="explorer-listing">
                    
                </div>
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

    <!--- modal create folder --->
    <div id="create-folder-modal" class="modal">
        <div class="modal__content">
            <input type="hidden" name="hdn_file_path" id="hdn-folder-path">
            <h4>Create new folder</h4>

            <table>
                <tr>
                    <td>Folder Name</td>
                    <td>:</td>
                    <td>
                        <input type="text" name="inp_foldername" id="inp-foldername" value="">
                    </td>
                    <td>
                        <button type="button" id="createfile-btn" onclick="createFolder()">Create</button>
                    </td>
                </tr>
            </table>
    
            <a href="##" class="modal__close">&times;</a>
        </div>
    </div>
    
    <!--- modal upload file --->
    <div id="upload-file-modal" class="modal">
        <div class="modal__content">
            <h4>Upload File</h4>

            <div style="text-align: center;margin: 30px 0;display:flex;flex-direction:column;align-items:center">
                <div class="input-file-container">  
                    <input class="input-file" id="my-file" type="file">
                    <label tabindex="0" for="my-file" class="input-file-trigger">Select a file...</label>
                </div>
                <p class="file-return"></p>
                
                <a href="javascript:uploadFile2('#dirPath#')" style="margin-top: 20px;">Upload</a>
            </div>
    
            <a href="##" class="modal__close">&times;</a>
        </div>
    </div>

    <!--- context menu --->
    <div id="explorer-context-menu">
        <div class="explorer-context-menu-item" data-menu-item-type="open">Open</div>
        <div class="explorer-context-menu-item" data-menu-item-type="rename">Rename</div>
        <div class="explorer-context-menu-item" data-menu-item-type="delete">Delete</div>
    </div>
    <div id="explorer-context-menu-file">
        <div class="explorer-context-menu-file-item" data-menu-item-type="open">Open</div>
        <div class="explorer-context-menu-file-item" data-menu-item-type="rename">Rename</div>
        <div class="explorer-context-menu-file-item" data-menu-item-type="delete">Delete</div>
        <div class="explorer-context-menu-file-item" data-menu-item-type="download">Download</div>
    </div>
    
    <script>
        loadListing('#dirPath#', '#viewMode#', '#backUrl#');
        var activeContextMenuItem = undefined;

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

        function loadListing(dirPath, viewMode, backUrl) {
            $("##explorer-listing").load("?sfid=sys.sec.cron.client.samator.explorer.explorer_listing", {
                dirPath: dirPath,
                viewMode: viewMode,
                backUrl: backUrl
            })
        }

        function reloadListing() {
            loadListing('#dirPath#', '#viewMode#', '#backUrl#');
        }

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

        function openCreateFolderModal(file_path){
            // console.log(file_path);
            $("##hdn-folder-path").val(file_path);
            window.location.href = '##create-folder-modal';
            // $("##link-modal").click();
        }

        function createFolder(){
            const file_path = $('##hdn-folder-path').val();
            const folder_name = $('##inp-foldername').val();
            var new_file_path = file_path + '/' + folder_name;
            console.log(file_path);

            var form_data = new FormData();
            form_data.append('file_path', new_file_path);

            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.samator.explorer.action&action=createFolder",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    if(data.message.length > 0 || data.error.length > 0) {
                        alert(data.message+'\n'+data.error);
                    }
                    if(data.success && data.dump == '') {
                        window.location.href = '##';
                        // window.location.reload();
                        reloadListing();
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
                url: "?sfid=sys.sec.cron.client.samator.explorer.action&action=upload",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    alert(data.message+'\n'+data.error);
                    if(data.success && data.dump == '') {
                        // window.location.reload();
                        reloadListing()
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

        function uploadFile2(file_path){
            var file_data = "";
            var file_name = "";
            if(document.getElementById("my-file").files.length > 0){
                file_data = $('##my-file').prop('files')[0];
                file_name = $('##my-file').prop('files')[0].name;
            }
            var form_data = new FormData();
            form_data.append('file_data', file_data);
            form_data.append('file_name', file_name);
            form_data.append('file_path', file_path);

            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.samator.explorer.action&action=upload",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    alert(data.message+'\n'+data.error);
                    if(data.success && data.dump == '') {
                        window.location.href = '##';
                        // window.location.reload();
                        reloadListing();
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

            if(new_file_name !== file_name) {
                $.ajax({
                    type:'POST',
                    url: "?sfid=sys.sec.cron.client.samator.explorer.action&action=rename",
                    data: form_data,
                    processData: false, 
                    contentType: false,
                    success: function(data){
                        console.log(data);
                        alert(data.message+'\n'+data.error);
                        if(data.success && data.dump == '') {
                            // window.location.reload();
                            reloadListing();
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
        }

        function deleteFile(file_name, file_path, isFolder = false){
            var form_data = new FormData();
            form_data.append('file_name', file_name);
            form_data.append('file_path', file_path);
            form_data.append('is_folder', isFolder);

            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.samator.explorer.action&action=delete",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    alert(data.message+'\n'+data.error);
                    if(data.success && data.dump == '') {
                        // window.location.reload();
                        reloadListing();
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
            window.open('?sfid=sys.sec.cron.client.samator.explorer.downloadFile&file_name='+file_name+'&file_path='+file_path, 'SFExplorer', "width=600,height=400");
        }

        function openFile(file_name, file_path, mode = 'open') {
            var form_data = new FormData();
            form_data.append('file_name', file_name);
            form_data.append('file_path', file_path);
            
            $.ajax({
                type:'POST',
                url: "?sfid=sys.sec.cron.client.samator.explorer.action&action="+mode,
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
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
            // window.location.reload();
            reloadListing();
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
                url: "?sfid=sys.sec.cron.client.samator.explorer.action&action=saveEdit",
                data: form_data,
                processData: false, 
                contentType: false,
                success: function(data){
                    console.log(data);
                    if(data.message !== ''){
                        alert(data.message+'\n'+data.error);
                    }
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

        var contextMenu = document.getElementById("explorer-context-menu");
        var contextMenuFile = document.getElementById("explorer-context-menu-file");

        $('.dir-list-item').on('contextmenu', function(e){
            e.preventDefault();
            //x and y position of mouse or touch
			//mouseX represents the x-coordinate of the mouse
            var mouseX = e.clientX || e.touches[0].clientX;
            //mouseY represents the y-coordinate of the mouse.
            var mouseY = e.clientY || e.touches[0].clientY;
            //height and width of menu
            //getBoundingClientRect() method returns the size of an element and its position relative to the viewport
            var menuHeight = contextMenu.getBoundingClientRect().height;
            var menuWidth = contextMenu.getBoundingClientRect().width;
            //width and height of screen
            //innerWidth returns the interior width of the window in pixels
            var width = window.innerWidth;
            var height = window.innerHeight;
            //If user clicks/touches near right corner
            if (width - mouseX <= 200) {
                contextMenu.style.borderRadius = "5px 0 5px 5px";
                contextMenu.style.left = width - menuWidth + "px";
                contextMenu.style.top = mouseY + "px";
                //right bottom
                if (height - mouseY <= 200) {
                    contextMenu.style.top = mouseY - menuHeight + "px";
                    contextMenu.style.borderRadius = "5px 5px 0 5px";
                }
            }
            //left
            else {
                contextMenu.style.borderRadius = "0 5px 5px 5px";
                contextMenu.style.left = mouseX + "px";
                contextMenu.style.top = mouseY + "px";
                //left bottom
                if (height - mouseY <= 200) {
                    contextMenu.style.top = mouseY - menuHeight + "px";
                    contextMenu.style.borderRadius = "5px 5px 5px 0";
                }
            }
            //display the menu
            contextMenu.style.visibility = "visible";
            contextMenuFile.style.visibility = "hidden";
            activeContextMenuItem = $(this);
        });

        $('.file-list-item').on('contextmenu', function(e){
            e.preventDefault();
            //x and y position of mouse or touch
			//mouseX represents the x-coordinate of the mouse
            var mouseX = e.clientX || e.touches[0].clientX;
            //mouseY represents the y-coordinate of the mouse.
            var mouseY = e.clientY || e.touches[0].clientY;
            //height and width of menu
            //getBoundingClientRect() method returns the size of an element and its position relative to the viewport
            var menuHeight = contextMenuFile.getBoundingClientRect().height;
            var menuWidth = contextMenuFile.getBoundingClientRect().width;
            //width and height of screen
            //innerWidth returns the interior width of the window in pixels
            var width = window.innerWidth;
            var height = window.innerHeight;
            //If user clicks/touches near right corner
            if (width - mouseX <= 200) {
                contextMenuFile.style.borderRadius = "5px 0 5px 5px";
                contextMenuFile.style.left = width - menuWidth + "px";
                contextMenuFile.style.top = mouseY + "px";
                //right bottom
                if (height - mouseY <= 200) {
                    contextMenuFile.style.top = mouseY - menuHeight + "px";
                    contextMenuFile.style.borderRadius = "5px 5px 0 5px";
                }
            }
            //left
            else {
                contextMenuFile.style.borderRadius = "0 5px 5px 5px";
                contextMenuFile.style.left = mouseX + "px";
                contextMenuFile.style.top = mouseY + "px";
                //left bottom
                if (height - mouseY <= 200) {
                    contextMenuFile.style.top = mouseY - menuHeight + "px";
                    contextMenuFile.style.borderRadius = "5px 5px 5px 0";
                }
            }
            //display the menu
            contextMenuFile.style.visibility = "visible";
            contextMenu.style.visibility = "hidden";
            activeContextMenuItem = $(this);
        });

        $('.explorer-context-menu-item').on('click', function(){
            if(typeof activeContextMenuItem !== 'undefined') {
                const file_path = activeContextMenuItem.attr('data-file-path');
                const file_name = activeContextMenuItem.attr('data-file-name');
                const btnType = $(this).attr('data-menu-item-type');
    
                if(btnType === 'delete') {
                    showConfirm(
                        'Delete Folder',
                        '['+file_name+'] Are you sure you want to delete this folder?',
                        'Delete',
                        'Cancel',
                        () => {
                            console.log(file_name);
                            console.log(file_path);
                            alert('Punten, fitur delete folder nya gajadi dibikin, takut ngebug trus salah delete directory, pake anydesk aja ges')
                        }
                    )
                } else if(btnType === 'open') {
                    const toDir = file_path + '/' + file_name;
                    changeDirectory(toDir);
                }
            } else {
                
            }
            contextMenu.style.visibility = "hidden";
        });

        $('.explorer-context-menu-file-item').on('click', function(){
            if(typeof activeContextMenuItem !== 'undefined') {
                const file_path = activeContextMenuItem.attr('data-file-path');
                const file_name = activeContextMenuItem.attr('data-file-name');
                const seq = activeContextMenuItem.attr('data-file-row');
                const btnType = $(this).attr('data-menu-item-type');
    
                if(btnType === 'delete') {
                    showConfirm(
                        'Delete File',
                        '['+file_name+'] Are you sure you want to delete this file?',
                        'Delete',
                        'Cancel',
                        () => {
                            deleteFile(file_name, file_path);
                        }
                    )
                } else if (btnType === 'open') {
                    openFile(file_name, file_path);
                } else if (btnType === 'download') {
                    downloadFile(file_name, file_path);
                } else if (btnType ==='rename') {
                    $('##lbl_filename_'+seq).css('display','none');
                    $('##inp_rename_'+seq).css('display','block');
                    $('##inp_rename_'+seq).focus();
                }
            } else {
                
            }
            contextMenuFile.style.visibility = "hidden";
        });

        document.addEventListener("click", function (e) {
            if (!contextMenu.contains(e.target)) {
                contextMenu.style.visibility = "hidden";
                activeContextMenuItem = undefined;
            }
            if (!contextMenuFile.contains(e.target)) {
                contextMenuFile.style.visibility = "hidden";
                activeContextMenuItem = undefined;
            }
        });

        function showConfirm(title, msg, $true, $false, onOk) { /*change*/
            var $content =  "<div class='dialog-ovelay'>" +
                                "<div class='dialog'><header>" +
                                " <h3> " + title + " </h3> " +
                                "<i class='fa fa-close'></i>" +
                            "</header>" +
                            "<div class='dialog-msg'>" +
                                " <p> " + msg + " </p> " +
                            "</div>" +
                            "<footer>" +
                                "<div class='controls'>" +
                                    " <button class='button button-danger doAction'>" + $true + "</button> " +
                                    " <button class='button button-default cancelAction'>" + $false + "</button> " +
                                "</div>" +
                            "</footer>" +
                        "</div>" +
                        "</div>";
            $('body').prepend($content);
            $('.doAction').click(function () {
                if(onOk) {
                    onOk();
                }
                $(this).parents('.dialog-ovelay').fadeOut(500, function () {
                $(this).remove();
                });
            });
            $('.cancelAction, .fa-close').click(function () {
                $(this).parents('.dialog-ovelay').fadeOut(500, function () {
                $(this).remove();
                });
            });
            
        }

        function openModal(modal) {
            window.location.href = '##' + modal;
        }

        var fileInput  = document.querySelector( ".input-file" ),  
            button     = document.querySelector( ".input-file-trigger" ),
            the_return = document.querySelector(".file-return");
            
        button.addEventListener( "click", function( event ) {
            fileInput.focus();
            return false;
        });  
        fileInput.addEventListener( "change", function( event ) {  
            the_return.innerHTML = this.value;  
        });  

        function toggleView(el) {
            const viewMode = $('##hdn_viewmode').val();

            if(viewMode === 'list') {
                $('##hdn_viewmode').val('grid');
                $(el).find('i').attr('class', 'fa fa-th');

                $('##frmExplorer').submit();
            } else if(viewMode === 'grid') {
                $('##hdn_viewmode').val('list');
                $(el).find('i').attr('class', 'fa fa-list');

                $('##frmExplorer').submit();
            }
        }
    </script>
</cfoutput>

