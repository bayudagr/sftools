<cfparam name="route" default="">

<cfset objComponent = createObject("component", "SFCL_ExcelGenerator")>

<cfswitch expression="#route#">
    <cfcase value="export">
        <cfset objComponent.export()>
    </cfcase>
    <cfdefaultcase>
        <cfoutput>
            <script>
                alert('Undefined route');
            </script>
        </cfoutput>
    </cfdefaultcase>
</cfswitch>
