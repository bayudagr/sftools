<cfcomponent name="SFCL_Explorer">
 	<cfset request.scookie.instance = ''>

	<cffunction name="initVar">
		<cfset strckVar["url"] = "">
		<cfset strckVar["ist"] = request.scookie.instance>
	</cffunction>

 	<cffunction name="upload">
 		<cfargument name="file_data" required="yes">
 		<cfargument name="file_path" required="yes">
 		<cfargument name="file_name" required="yes">

		<cffile action="upload" destination="#file_path#" fileField="file_data" nameConflict="overwrite" result="retvar">

 		<cfset strckData = structNew()>
 		<cfset strckData["message"] = "File uploaded">
 		<cfset strckData["error"] = "">
 		<cfset strckData["dump"] = "">
 		<cfset strckData["success"] = true>
 		<cfset strckData["result"] = "success">

 		<cfreturn serializeJSON(strckData)>
 	</cffunction>

 	<cffunction name="rename">
 		<cfargument name="file_path" required="yes">
 		<cfargument name="file_name" required="yes">
 		<cfargument name="new_file_name" required="yes">

 		<cffile action="rename" source="#file_path#/#file_name#" destination="#file_path#/#new_file_name#">

 		<cfset strckData = structNew()>
 		<cfset strckData["message"] = "File renamed">
 		<cfset strckData["error"] = "">
 		<cfset strckData["dump"] = "">
 		<cfset strckData["success"] = true>
 		<cfset strckData["result"] = "success">

 		<cfreturn serializeJSON(strckData)>
 	</cffunction>

 	<cffunction name="delete">
 		<cfargument name="file_path" required="yes">
 		<cfargument name="file_name" required="yes">

 		<cftry>
 			<cffile action="delete" file="#file_path#/#file_name#">
 			<cfcatch>
 				<cfdump var="#cfcatch#">
 			</cfcatch>
 		</cftry>

 		<cfset strckData = structNew()>
 		<cfset strckData["message"] = "File deleted">
 		<cfset strckData["error"] = "">
 		<cfset strckData["dump"] = "">
 		<cfset strckData["success"] = true>
 		<cfset strckData["result"] = "success">

 		<cfreturn serializeJSON(strckData)>
 	</cffunction>
	
 	<cffunction name="download">
 		<cfargument name="file_path" required="yes">
 		<cfargument name="file_name" required="yes">
 		<cfset mimeType = FilegetMimeType('#file_path#/#file_name#')>

 		<cftry>
			<cfset result="">
 			<cfheader name="content-disposition" value="inline; filename = #trim(file_name)#">
 			<cfcontent type="#mimeType#" file="#file_path#/#file_name#">
 			<!---cfcontent type="text/xml; charset=utf-8" file="#file_path#/#file_name#"--->
 			<cfcatch>
 				<cfset result="">
 				<cfdump var="#cfcatch#">
 			</cfcatch>
 		</cftry>

 		<cfset strckData = structNew()>
 		<cfset strckData["message"] = "File downloaded">
 		<cfset strckData["error"] = "">
 		<cfset strckData["dump"] = "#result#">
 		<cfset strckData["success"] = true>
 		<cfset strckData["result"] = "success">

 		<cfreturn serializeJSON(strckData)>
 	</cffunction>

 	<cffunction name="create">
 		<cfargument name="file_path" required="yes">
 		<cfargument name="file_name" required="yes">

 		<cfset validMime = 'cfm,cfc,txt,xml,js,css,html'>
 		<cfset mimeType = listLast(file_name, ".")>
 		<cfset success = true>
 		<cfset msg = "">

 		<cftry>
 			<cfset isExist = fileExists("#file_path#/#file_name#")>
 			<cfif isExist>
 				<cfset msg = "File name already exists">
 				<cfset success = false>
 			</cfif>
 			<cfif listFindNoCase(validMime, mimeType) eq 0>
 				<cfset msg = "Not supported file type">
 				<cfset success = false>
 			</cfif>
 			<cfcatch>
 				<cfset success = false>
 				<cfdump var="#cfcatch#">
 			</cfcatch>
 		</cftry>

 		<!---cfset result = replace(result, '<', '&lt;', 'ALL')>
 		<cfset result = replace(result, '>', '&gt;', 'ALL')--->

		<cfset strckData = structNew()>
 		<cfset strckData["message"] = msg>
 		<cfset strckData["error"] = "">
 		<cfset strckData["dump"] = "">
 		<cfset strckData["success"] = success>
 		<cfset strckData["result"] = "success">
 		<cfset strckData["content"] = "">

 		<cfreturn serializeJSON(strckData)>
 	</cffunction>

 	<cffunction name="open">
 		<cfargument name="file_path" required="yes">
 		<cfargument name="file_name" required="yes">
 		<cfset mimeType = FilegetMimeType('#file_path#/#file_name#')>

 		<cftry>
 			<!---cfheader name="content-disposition" value="inline; filename = #trim(file_name)#">
 			<cfcontent type="#mimeType#" file="#file_path#/#file_name#" variable="result">
 			<cfcontent type="text/xml; charset=utf-8" file="#file_path#/#file_name#"--->
 			<cffile action="read" file="#file_path#/#file_name#" variable="result" charset="utf-8">
 			<cfcatch>
 				<cfset result="">
 				<cfdump var="#cfcatch#">
 			</cfcatch>
 		</cftry>

 		<!---cfset result = replace(result, '<', '&lt;', 'ALL')>
 		<cfset result = replace(result, '>', '&gt;', 'ALL')--->

 		<cfset strckData = structNew()>
 		<cfset strckData["message"] = "">
 		<cfset strckData["error"] = "">
 		<cfset strckData["dump"] = "">
 		<cfset strckData["success"] = true>
 		<cfset strckData["result"] = "success">
 		<cfset strckData["content"] = result>

 		<cfreturn serializeJSON(strckData)>
 	</cffunction>

 	<cffunction name="saveEdit">
 		<cfargument name="file_path" required="yes">
 		<cfargument name="file_name" required="yes">
 		<cfargument name="content" required="yes">
 		<cfset mimeType = FilegetMimeType('#file_path#/#file_name#')>

 		<cfset msg = "">
 		<cfif "#file_path#/#file_name#" neq "/media/sf6/sunfish/app/sys/sec/cron/client/#request.scookie.instance#/explorer/index.cfm">
 			<cftry>
 				<!---cfheader name="content-disposition" value="inline; filename = #trim(file_name)#">
 				<cfcontent type="#mimeType#" file="#file_path#/#file_name#" variable="result">
 				<cfcontent type="text/xml; charset=utf-8" file="#file_path#/#file_name#"--->
 				<cfset content = replace(content, "~&lt;script~", "<script", "ALL")>
 				<cfset content = replace(content, "~&lt;embed~", "<embed", "ALL")>
 				<cfset content = replace(content, "~&lt;object~", "<object", "ALL")>
 				<cfset content = replace(content, "~&lt;applet~", "<applet", "ALL")>
 				<cfset content = replace(content, "~&lt;meta~", "<meta", "ALL")>
 				<cffile action="write" file="#file_path#/#file_name#" output="#content#">
 				<cfcatch>
 					<cfdump var="#cfcatch#">
 				</cfcatch>
 			</cftry>
 		<cfelse>
 			<cfset msg = "Cannot edit this source code">
 		</cfif>

 		<cffile action="read" file="#file_path#/#file_name#" variable="result" charset="utf-8">

 		<cfset strckData = structNew()>
 		<cfset strckData["message"] = msg>
 		<cfset strckData["error"] = "">
 		<cfset strckData["dump"] = "">
 		<cfset strckData["success"] = true>
 		<cfset strckData["result"] = "success">
 		<cfset strckData["content"] = content>

 		<cfreturn serializeJSON(strckData)>
 	</cffunction>
</cfcomponent>







