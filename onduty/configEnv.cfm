<cfif not isDefined("request.scookie.user")>
    <cfoutput>
        <script>
            alert("Please login to your sunfish account first to get session");
        </script>
    </cfoutput>
    <cf_sfabort/>
</cfif>

<cfquery name="qEpicor" datasource="#request.sdsn#">
    SELECT * FROM tclmapisetting
    WHERE api_code = 'EPICOR'
</cfquery>

