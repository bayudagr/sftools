<cfcomponent name="SFCL_ExcelGenerator">
    <cffunction name="export">
        <cfparam name="preset" default="">
        
        <cfif len(preset)>
            <cfset qData = evaluate("preset_#preset#()")>
            
            <cfset spreadSheetObj = spreadsheetNew()>
            <cfset SpreadsheetAddRow(spreadSheetObj, arrayToList(qData.getColumnList()))>
            <cfset SpreadsheetAddRows(spreadSheetObj, qData)>
            
            <cfheader name="content-disposition" value="inline; filename=Exported.xls"> 
            <cfcontent type="application/vnd.ms-excel" variable="#spreadsheetReadBinary(spreadsheetObj)#">
        <cfelse>
            <cfoutput>
                <script>
                    alert('Preset is undefined');
                </script>
            </cfoutput>
        </cfif>
    </cffunction>
    
    <cffunction name="preset_initReim">
        <cfparam name="attachment" default="">
        <cfset interval = 0>
        
        <cfif len(attachment)>
            <cfspreadsheet action="read" src="#attachment#" sheet="1" query="qData" headerrow="1" excludeHeaderRow="true"/>
            <cfset lstNotBPG = "">
            <cfset lstNotBPPG = "">
            
            <cfloop query="qData">
                <cfif qData.CLAIM_TYPE eq 'BPG'>
                    <cfset interval = 12>
                <cfelseif qData.CLAIM_TYPE eq 'BPPG'>
                    <cfset interval = 6>
                </cfif>
                
                <cfif dateCompare(now(), dateAdd('m',interval,qData.JOIN_DATE)) lte 0>
                    <cfif qData.CLAIM_TYPE eq 'BPG'>
                        <cfset lstNotBPG = listAppend(lstNotBPG, qData.EMP_NO)>
                    <cfelseif qData.CLAIM_TYPE eq 'BPPG'>
                        <cfset lstNotBPPG = listAppend(lstNotBPPG, qData.EMP_NO)>
                    </cfif>
                </cfif>
                <cfif len(qData.PENGAJUAN_TERAKHIR)>
                    <cfset tmp = dateAdd('m',interval,qData.PENGAJUAN_TERAKHIR)>
                    <cfif dateCompare(qData.PENGAJUAN_TERAKHIR, now()) eq -1 AND dateCompare(now(), tmp) eq -1>
                        <cfset start_date = qData.PENGAJUAN_TERAKHIR>
                    <cfelse>
                        <cfset start_date = dateAdd('m',interval,qData.JOIN_DATE)>
                    </cfif>
                <cfelse>
                    <cfset start_date = dateAdd('m',interval,qData.JOIN_DATE)>
                </cfif>
                
                <cfloop from="1" to="99" index="i">
                    <cfset startValidDate = dateAdd('m',(i-1) * interval,start_date)>
                    <cfset endValidDate = dateAdd('m',i * interval,start_date)>
                    
                    <cfif dateCompare(startValidDate, now()) eq -1 AND dateCompare(now(), endValidDate) eq -1>
                        <cfbreak>
                    </cfif>
                </cfloop>
                
                <cfset qData.START_VALID_DATE = dateFormat(startValidDate,'mm/dd/yyyy')>
                <cfset qData.END_VALID_DATE = dateFormat(endValidDate,'mm/dd/yyyy')>
            </cfloop>
            
            <cfdump var="#lstNotBPG#">
            <cfdump var="#lstNotBPPG#">
            
            <cfquery name="qData" dbtype="query">
                SELECT * FROM qData
                WHERE CLAIM_TYPE = 'BPG'
                AND EMP_NO NOT IN (<cfqueryparam value="#lstNotBPG#" cfsqltype="CF_SQL_VARCHAR" list="yes">)
                
                UNION
                
                SELECT * FROM qData
                WHERE CLAIM_TYPE = 'BPPG'
                AND EMP_NO NOT IN (<cfqueryparam value="#lstNotBPPG#" cfsqltype="CF_SQL_VARCHAR" list="yes">)
            </cfquery>
            
            <cfreturn qData>
        <cfelse>
            <cfoutput>
                <script>
                    alert('Attachment is required for this preset');
                </script>
            </cfoutput>
        </cfif>
    </cffunction>
</cfcomponent>



