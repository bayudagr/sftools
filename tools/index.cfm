<cfif not isDefined("REQUEST.Scookie.user")>
    <cfoutput>
        <script>
            alert('Please login to your Sunfish Web first to acquire token');
        </script>
    </cfoutput>
    <cf_sfabort>
<cfelseif REQUEST.SCookie.user.utype neq '9'>
    <cfoutput>
        <script>
            alert('You are not authorized');
        </script>
    </cfoutput>
    <cf_sfabort>
</cfif>

<cfinclude template="./config/config.cfm">

<cfset objDevTools = createObject("component", "SFCL_DevTools")>
<cfset appObj = objDevTools.initVar()>
<cfset qMenu = objDevTools.getMenuList()>

<cfif isDefined("debugAppObj")>
    <cfdump var="#appObj#">
</cfif>

<cfoutput>
    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>
    <link href="https://fonts.cdnfonts.com/css/harlow-solid-italic" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet">
    
    <!---<link href="#GetDirectoryFromPath(GetCurrentTemplatePath())#style/app.css" type="text/css" rel="stylesheet">--->
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!--- Include CodeMirror CSS --->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.0/codemirror.min.css" />

    <!--- Include CodeMirror JS --->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.0/codemirror.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/mode/sql/sql.min.js"></script>

    <!--- Search Add-ons --->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/addon/search/searchcursor.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/addon/search/search.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/addon/dialog/dialog.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/addon/dialog/dialog.min.css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/keymap/sublime.min.js"></script>
                
    <style>
        :root {
            --primary-color: ##00adb5;
            --div-box-shadow: 0px 5px 8px rgba(216, 216, 216, 0.3);
        }
        
        body {
            margin: 0;
            padding: 0;
            font-family: 'Open Sans';
            font-size: 11pt;
        }
        
        ##app-container {
            width: 100vw;
            height: 100vh;
            /*position: relative;*/
            display: flex;
            overflow: hidden;
        }
        
        ##app-container-content {
            height: 100%;
            width: calc(100% - 200px);
            flex-grow: 1;
        }
        
        ##app-sidebar {
            /*position: absolute;*/
            /*top: 0;*/
            /*bottom: 0;*/
            /*left: 0;*/
            width: 200px;
            height: 100%;
            /*border-right: 1px solid;*/
        }
        
        ##app-header {
            /*width: calc(100% - 200px);*/
            height: 60px;
            /*position: relative;*/
        }

        ##app-header-content-wrapper {
            display: flex;
            height: 100%;
            padding: 0 20px;
            justify-content: space-between;
            align-items: center;
        }

        .header-bio {
            display: flex;
        }
        
        ##app-content {
            margin: 15px 20px;
            overflow: auto;
            height: calc(100% - 96px);
        }
        
        ##breadcrumb-wrapper {
            box-shadow: var(--div-box-shadow);
            padding: 5px 15px;
        }
        
        .font-harlowsi {
            font-family: 'Harlow Solid Italic', sans-serif;                                  
        }
        
        .font-logo {
            color: var(--primary-color);
            font-weight: bold;
            margin-bottom: 30px;
        }
        
        .app-box-shadow {
            box-shadow: 0px 5px 8px rgba(216, 216, 216, 0.3);
        }
        
        .centered-y {
            margin: auto 0;
        }
        
        .breadcrumb {
            font-size: 9pt;
        }
    </style>
    
    <style>
        .loader {
            margin: auto;
            border: 10px solid ##C9C9C9;
            border-radius: 50%;
            border-top: 10px solid var(--primary-color);
            width: 120px;
            height: 120px;
            animation: spinner 4s linear infinite;
            position: absolute;
            top: calc(50% - 60px);
            left: 50%;
        }
        .menu {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        .menu-item {
            border-radius: 5px;
            margin: 0 10px;
            padding: 10px 15px;
            margin: 5px 10px;
        }
        .menu-item:hover,
        .menu-item:focus {
            background: var(--primary-color);
            color: ##fff;
        }
        .menu-item-active {
            background: var(--primary-color);
            color: ##fff;
        }
        
        .inputfile {
        	width: 0.1px;
        	height: 0.1px;
        	opacity: 0;
        	overflow: hidden;
        	position: absolute;
        	z-index: -1;
        }

        .d-flex {
            display: flex;
        }

        .flex-column {
            flex-direction: column;
        }

        .justify-content-center {
            justify-content: center;
        }

        .justify-content-between {
            justify-content: space-between;
        }
        
        @keyframes spinner {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
    
    <div id="app-container">
        <div id="app-sidebar" class="app-box-shadow">
            <div class="app-logo" align="center">
                <h3 class="font-harlowsi font-logo">SF Tools</h3>
            </div>
            <div class="sidebar-menu">
                <ul class="menu">
                    <cfloop query="qMenu">
                        <li class="menu-item" onclick="navigate('#qMenu.menu_code#', this, '#qMenu.type#');">
                            <div>
                                <span>#htmlEditFormat(qMenu.menu_name)#</span>
                            </div>
                        </li>
                    </cfloop>
                </ul>
            </div>
        </div>
        
        <div id="app-container-content">
            <div id="app-header" class="app-box-shadow">
                <div id="app-header-content-wrapper" class="centered-y">
                    <div>#request.sdsn#</div>
                    <div class="header-bio">
                        <div class="header-bio-thumb"></div>
                        <div class="d-flex flex-column justify-content-center">
                            <div class="header-bio-name">
                                <span>#REQUEST.SCookie.user.uname#</span>
                            </div>
                            <div class="header-bio-instance">
                                <small>#REQUEST.SCOOKIE.INSTANCE#</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="breadcrumb-wrapper" style="display:none;">
                <span class="breadcrumb">/</span>
            </div>
            <div id="app-content">
                <div id="content-wrapper" class="content-wrapper">
                    
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function setLoading(el) {
            $(el).empty();
            $(el).append('<div class="loader"></div>');
        }
        
        function navigate(menu, obj, type='') {
            if(menu == ''){
                return false;
            }
            
            var el = $('##content-wrapper');
            
            setLoading(el);
            
            $('.menu-item').removeClass('menu-item-active');
            
            $(obj).addClass('menu-item-active');
            setBreadcrumb('/'+menu);
            
            if(type == 'popup') {
                $(el).empty();
                window.open("?sfid=#appObj.path#.menu."+menu+".index",menu,"width=600,height=400");
            } else {
                $(el).empty();
                $(el).load("?sfid=#appObj.path#.menu."+menu+".index", JSON.parse('#serializeJSON(COOKIES)#'));
            }
        }
        
        function setBreadcrumb(path) {
            $('##breadcrumb-wrapper').css('display','');
            $('.breadcrumb').text(path);
        }
    </script>
</cfoutput>

