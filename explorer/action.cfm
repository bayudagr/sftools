<cfif not isDefined("REQUEST.SCookie.user") OR REQUEST.Scookie.user.utype neq '9'>
	<cfoutput>
		<script>
			alert("Super Admin Only!! Please login to your Sunfish Super Admin account to create session");
		</script>
	</cfoutput>
	<cf_sfabort>
</cfif>

<cfparam name="action" default="">
<cfparam name="objectName" default="SFCL_Explorer">

<cfset objComponent = CreateObject("component","#objectName#")>

<cfset defaultResponse = structNew()>
<cfset defaultResponse["result"] = "failed">
<cfset defaultResponse["success"] = false>
<cfset defaultResponse["message"] = "Something went wrong, please contact system administrator">
<cfset defaultResponse["error"] = "">
<cfset defaultResponse["dump"] = "">
<!--- End Logic --->
<cfparam name="file_data" default="">
<cfparam name="file_path" default="">
<cfparam name="file_name" default="">
<cfparam name="is_folder" default=false>
<cfparam name="new_file_name" default="">
<cfparam name="content" default="">
<cfparam name="sqlText" default="">
<cfparam name="colName" default="">

<cftry>
	<cfswitch expression="#action#">
		<!--- Explorer --->
		 <cfcase value="upload">
			 <cfset retvar = objComponent.upload(file_data, file_path, file_name)>
		 </cfcase>
		 <cfcase value="rename">
			 <cfset retvar = objComponent.rename(file_path, file_name, new_file_name)>
		 </cfcase>
		 <cfcase value="delete">
			 <cfset retvar = objComponent.delete(file_path, file_name, is_folder)>
		 </cfcase>
		 <cfcase value="download">
			 <cfset retvar = objComponent.download(file_path, file_name)>
		 </cfcase>
		 <cfcase value="create">
			 <cfset retvar = objComponent.create(file_path, file_name)>
		 </cfcase>
		 <cfcase value="createFolder">
			 <cfset retvar = objComponent.createFolder(file_path)>
		 </cfcase>
		 <cfcase value="open">
			 <cfset retvar = objComponent.open(file_path, file_name)>
		 </cfcase>
		 <cfcase value="saveEdit">
			 <cfset retvar = objComponent.saveEdit(file_path, file_name, content)>
		 </cfcase>
	
		<!--- Query --->
		<cfcase value="getUpdateQuery">
			<cfset retvar = objComponent.getUpdateQuery(sqlText,colName)>
		</cfcase>
		 <cfdefaultcase>
			 <cfset retvar = serializeJson(defaultResponse)>
		 </cfdefaultcase>
	</cfswitch>
	<cfcatch>
		<cfset retvar = duplicate(defaultResponse)>
		<cfset retvar["error"] = cfcatch.message>
		<cfset retvar = serializeJson(retvar)>
	</cfcatch>
</cftry>
 
<cfoutput>
 	#retvar#
</cfoutput>

