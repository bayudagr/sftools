<cfif not isDefined("REQUEST.SCookie.user") OR REQUEST.Scookie.user.utype neq '9'>
	<cfoutput>
		<script>
			alert("Super Admin Only!! Please login to your Sunfish Super Admin account to acquire token");
		</script>
	</cfoutput>
	<cf_sfabort>
</cfif>

<cfoutput>
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

    <cf_sfinclude SFID="sys.sec.cron.client.samator.explorer.query" ISLOCAL="YES" VARNAME="query">
    <cfinclude template="#query#">
</cfoutput>