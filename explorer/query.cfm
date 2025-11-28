<cfif not isDefined("REQUEST.SCookie.user") OR REQUEST.Scookie.user.utype neq '9'>
	<cfoutput>
		<script>
			alert("Super Admin Only!! Please login to your Sunfish Super Admin account to acquire token");
		</script>
	</cfoutput>
	<cf_sfabort>
</cfif>

<cfoutput>
	<!---script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.0/codemirror.min.css" />

    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/mode/sql/sql.min.js"></script>

    
	<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.0/codemirror.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/addon/search/searchcursor.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/addon/search/search.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/addon/dialog/dialog.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/addon/dialog/dialog.min.css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.13/keymap/sublime.min.js"></script--->

	<style>
		::-webkit-scrollbar {
			width: 4px;
			height: 4px;
			background: ##f1f1f1;
		}

		::-webkit-scrollbar-thumb {
			border-radius: 10px;
			background-color: ##a9a9a9;
		}
		##sql_query {
			width: 100%; 
			margin-bottom:10px;
			border: 1px solid ##ddd !important;
			tab-size: 4;
		}
 		.checkbox-wrapper-29 {
 			--size: 1rem;
 			--background: ##fff;
 			font-size: var(--size);
			display: none;
 		}

 		.checkbox-wrapper-29 *,
 		.checkbox-wrapper-29 *::after,
 		.checkbox-wrapper-29 *::before {
 			box-sizing: border-box;
 		}

 		.checkbox-wrapper-29 input[type="checkbox"] {
 			visibility: hidden;
 			display: none;
 		}

 		.checkbox-wrapper-29 .checkbox__label {
 			width: var(--size);
 		}

 		.checkbox-wrapper-29 .checkbox__label:before {
 			content: ' ';
 			display: block;
 			height: var(--size);
 			width: var(--size);
 			position: absolute;
 			top: calc(var(--size) * 0.125);
 			left: 0;
 			background: var(--background); 
 		}

 		.checkbox-wrapper-29 .checkbox__label:after {
 			content: ' ';
 			display: block;
 			height: var(--size);
 			width: var(--size);
 			border: calc(var(--size) * .14) solid ##000;
 			transition: 200ms;
 			position: absolute;
 			top: calc(var(--size) * 0.125);
 			left: 0;
 			background: var(--background); 
 		}

 		.checkbox-wrapper-29 .checkbox__label:after {
 			transition: 100ms ease-in-out;
 		}

 		.checkbox-wrapper-29 .checkbox__input:checked ~ .checkbox__label:after {
 			border-top-style: none; 
 			border-right-style: none;
 			-ms-transform: rotate(-45deg); /* IE9 */
 			transform: rotate(-45deg);
 			height: calc(var(--size) * .5);
 			border-color: green;
 		}

 		.checkbox-wrapper-29 .checkbox {
 			position: relative;
 			display: flex;
 			cursor: pointer;
 			/* Mobile Safari: */
 			-webkit-tap-highlight-color: rgba(0,0,0,0); 
 		}

 		.checkbox-wrapper-29 .checkbox__label:after:hover,
 		.checkbox-wrapper-29 .checkbox__label:after:active {
 			border-color: green; 
 		}

 		.checkbox-wrapper-29 .checkbox__label {
 			margin-right: calc(var(--size) * 0.45);
 		}
	
		##context-menu {
			font-family: monospace;
 			background-color: ##ffffff;
 			box-shadow: 0 0 20px rgba(37, 40, 42, 0.22);
 			color: ##1f194c;
 			width: 10em;
 			padding: 0.8em 0.6em;
 			font-size: var(--size);
 			position: fixed;
 			visibility: hidden;
		}

		.item {
 			padding: 0.3em 1.2em;
		}

		.item:hover {
 			background-color: rgba(44, 141, 247, 0.2);
 			cursor: pointer;
		}

		.loader {
 			border: 16px solid ##f3f3f3;
 			border-radius: 50%;
 			border-top: 16px solid ##3498db;
 			width: 120px;
 			height: 120px;
 			-webkit-animation: spin 2s linear infinite; /* Safari */
 			animation: spin 2s linear infinite;
		}

		##sqlfiddle-wrapper {
			display: flex;
			flex-direction: column;
			height: 100%;
			overflow: hidden;
		}

		/* Safari */
		@-webkit-keyframes spin {
 			0% { -webkit-transform: rotate(0deg); }
 			100% { -webkit-transform: rotate(360deg); }
		}

		@keyframes spin {
 			0% { transform: rotate(0deg); }
 			100% { transform: rotate(360deg); }
		}
	</style>
	
	<div id="sqlfiddle-wrapper">
		<div>
			<form name="frmQuery">
				<div id="input-container" width="100%">
					<textarea rows="15" id="sql_query" name="sql_query" style="display:none"></textarea>
                    <div style="border: 1px solid ##ddd">
                        <textarea id="sql-mirror-editor" name="sql-mirror-editor" style="height:100%;width:100%"></textarea>
                    </div>
					
					<div style="display:flex;flex-direction:row;column-gap:10px;">
						<button type="button" id="exec-query">Submit</button>
						<button type="button" id="copy-result" onclick="selectElementContents( document.getElementById('query-table') );" disabled>Copy</button>
						<div class="checkbox-wrapper-29 chk-show-error">
							 <label class="checkbox">
								 <input type="checkbox" class="checkbox__input" name="chk-show"/> 
								 <span class="checkbox__label"></span>
								 Show full error
							 </label>
						</div>
					</div>
	
				</div>
			</form>
		</div>

		<div style="overflow: hidden;">
			<div id="context-menu">
				<div class="item">View</div>
				<div class="item">Refresh</div>
				 <div class="item">Copy</div>
				 <div class="item">Customize</div>
				 <div class="item">Save As</div>
			</div>
			
			<div id="loader-container" style="width:100%;display:none" align="center">
				<div class="loader"></div>
			</div>
			<div id="sql-result" style="width:100%;overflow:hidden;display:none"></div>
		</div>
	</div>

	<script>
		const sqleditor = CodeMirror.fromTextArea(document.getElementById("sql-mirror-editor"), {
			mode: "text/x-mysql",        // mode / syntax
			lineNumbers: true,         // show line numbers
			tabSize: 4,
			indentWithTabs: false,
			smartIndent: false,
			keyMap: "sublime",  // Enables Ctrl-F, Ctrl-H, etc.
			extraKeys: {
				"Ctrl-F": "findPersistent",
				"Ctrl-H": "replace",
				"Shift-Ctrl-F": "find",
				"Shift-Ctrl-R": "replaceAll"
			}
		});

		// Example: get code from the editor
		function getSql() {
			const sql = sqleditor.getValue();
			return sql;
		}

		$('##exec-query').click(function(){
			$('##loader-container').css("display","block");
			$('##sql-result').css("display","none");
			const sqlText = getSql()
			$('.chk-show-error').hide();
			$('##sql-result').load('?sfid=sys.sec.cron.client.samator.explorer.queryResult',{sqlText:sqlText});
		});
		
		function selectElementContents(el) {
			var body = document.body, range, sel;
			$('.txt_data').hide();
			$('.span_data').show();
			if (document.createRange && window.getSelection) {
				range = document.createRange();
				sel = window.getSelection();
				sel.removeAllRanges();
				try {
					range.selectNodeContents(el);
					sel.addRange(range);
				} catch (e) {
					range.selectNode(el);
					sel.addRange(range);
				}

				document.execCommand("copy");
				console.log('1');
			} else if (body.createTextRange) {
				range = body.createTextRange();
				range.moveToElementText(el);
				range.select();
				range.execCommand("Copy");
				console.log('2');
			}
			$('.txt_data').show();
			$('.span_data').hide();
			alert("Table copied to clipboard. You can now paste it into Excel or another application");
		}

		function contextCopy(event) {
			var target = event.target;
			var copyText = target.nextElementSibling;

			navigator.clipboard.writeText(copyText.value);

			alert("Text copied");
		}

		$('##sql_query').keydown(function(e){
			if (e.key == 'Tab') {
				e.preventDefault();
				var start = this.selectionStart;
				var end = this.selectionEnd;

				// set textarea value to: text before caret + tab + text after caret
				this.value = this.value.substring(0, start) + "\t" + this.value.substring(end);

				// put caret at right position again
				this.selectionStart =
				this.selectionEnd = start + 1;
			}
		});

		//Events for desktop and touch
					//let events = ["contextmenu"];
					var events = [];

					//initial declaration
					var timeout;

					//for double tap
					var lastTap = 0;

					//refer menu div
					var contextMenu = document.getElementById("context-menu");

					//same function for both events
					//event type is a data structure that defines the data contained in an event
					events.forEach((eventType) => {
						console.log('test');
						document.addEventListener(
							eventType,
							(e) => {
								console.log(e);
								//preventDefault() method stops the default action of a selected element from happening by a user
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
							},
							{ passive: false }
						);
					});

					//for double tap(works on touch devices)
					document.addEventListener("touchendd", function (e) {
						//current time
						var currentTime = new Date().getTime();
						//gap between two gaps
						var tapLength = currentTime - lastTap;
						//clear previous timeouts(if any)
						//The clearTimeout() method clears a timer set with the setTimeout() method.
						clearTimeout(timeout);
						//if user taps twice in 500ms
						if (tapLength < 500 && tapLength > 0) {
							//hide menu
							contextMenu.style.visibility = "hidden";
							e.preventDefault();
						} else {
							//timeout if user doesn't tap after 500ms
							timeout = setTimeout(function () {
								clearTimeout(timeout);
							}, 500);
						}
						//lastTap set to current time
						lastTap = currentTime;
					});

					//click outside the menu to close it (for click devices)
					document.addEventListener("click", function (e) {
						if (!contextMenu.contains(e.target)) {
							contextMenu.style.visibility = "hidden";
						}
					});
	</script>
</cfoutput>













