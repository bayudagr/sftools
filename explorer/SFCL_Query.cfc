<cfcomponent name="SFCL_Query">
	<cffunction name="parseQuery">
		<cfargument name="sqlText" type="string" required="yes">

		<cfset pattern = "(?i)(?=from\s|from)(.*?)(?=\swhere|where|$)">
 	<cfset matches = REMatch(pattern, sqlText)>

		<cfif arrayLen(matches) gt 0>
			<cfloop from="1" to="#arrayLen(matches)#" index="idx">
				<cfset matches[idx] = trim(replace(matches[idx],"from",""))>
			</cfloop>
		</cfif>

		<cfreturn matches>
	</cffunction>

	<cffunction name="getUpdateQuery">
		<cfargument name="sqlText" type="string" required="yes">
		<cfargument name="colName" type="string" required="yes">

		<cfset RETables = parseQuery(sqlText)>
		<cfset retVar = structNew()>
		<cfset retVar["success"] = true>
		<cfset retVar["message"] = "Copied to clipboard">
		<cfset retVar["result"] = "success">
		
		<cfset isFailed = false>
		<cfif arrayLen(RETables) gt 1 OR arrayLen(RETables) eq 0>
			<cfset isFailed = true>
		<cfelseif arrayLen(RETables) eq 1>
			<cfloop array="#RETables#" index="idx">
				<cfif listLen(idx) gt 1>
					<cfset isFailed = true>
					<cfbreak>
				</cfif>
			</cfloop>
		</cfif>

		<cfif isFailed>
			<cfset retVar["success"] = false>
			<cfset retVar["message"] = "Not a simple query">
			<cfset retVar["result"] = "failed">
		<cfelse>
			<cfquery name="qGetKeys" datasource="#request.sdsn#">
				SHOW KEYS FROM #RETables[1]# WHERE Key_name = 'PRIMARY'
			</cfquery>

			<cfset sqlWhere = "">
			<cfloop query="qGetKeys">
				<cfset sqlWhere = sqlWhere & " #qGetKeys.column_name# = ''">
			</cfloop>

			<cfset sqlUpdate = "UPDATE #RETables[1]# set #colName# = '' WHERE#sqlWhere#">
			<cfset retVar[sqlUpdate] = sqlUpdate>
		</cfif>

		<cfreturn serializeJSON(retVar)>
	</cffunction>
</cfcomponent>
