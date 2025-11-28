<cfcomponent name="SFCL_DevTools">
    <cfinclude template="./config/config.cfm">

    <cffunction name="initVar">
        <cfset strckInit = structNew()>
        <cfset strckInit["dsn"] = request.sdsn>
        <cfset strckInit["env"] = request.scookie.instance>
        <cfset strckInit["path"] = COOKIES.base_path>

        <cfreturn strckInit>
    </cffunction>

    <cffunction name="getMenuList">
        <cfset qMenu = queryNew("menu_code,menu_name,type")>
        <!--- Excel Generator --->
        <cfset queryAddRow(qMenu)>
        <cfset querySetCell(qMenu, 'menu_code', 'excelgenerator')>
        <cfset querySetCell(qMenu, 'menu_name', 'Excel Generator')>
        <cfset querySetCell(qMenu, 'type', '')>
        <!--- Explorer --->
        <cfset queryAddRow(qMenu)>
        <cfset querySetCell(qMenu, 'menu_code', 'explorer')>
        <cfset querySetCell(qMenu, 'menu_name', 'Explorer')>
        <cfset querySetCell(qMenu, 'type', 'popup')>
        <!--- SQL Fiddle --->
        <cfset queryAddRow(qMenu)>
        <cfset querySetCell(qMenu, 'menu_code', 'sqlfiddle')>
        <cfset querySetCell(qMenu, 'menu_name', 'SQL Fiddle')>
        <cfset querySetCell(qMenu, 'type', '')>
        <!--- Journal Template Generator --->
        <cfset queryAddRow(qMenu)>
        <cfset querySetCell(qMenu, 'menu_code', 'journalgenerator')>
        <cfset querySetCell(qMenu, 'menu_name', 'Epicor Journal')>
        <cfset querySetCell(qMenu, 'type', '')>
        <!--- Epicor Env Config --->
        <cfset queryAddRow(qMenu)>
        <cfset querySetCell(qMenu, 'menu_code', 'epicorenvconfig')>
        <cfset querySetCell(qMenu, 'menu_name', 'Epicor Env Config')>
        <cfset querySetCell(qMenu, 'type', 'popup')>
        <!--- Epicor Workflow --->
        <cfset queryAddRow(qMenu)>
        <cfset querySetCell(qMenu, 'menu_code', 'customparam')>
        <cfset querySetCell(qMenu, 'menu_name', 'Custom Param')>
        <cfset querySetCell(qMenu, 'type', '')>
        <!--- SIR Calculator --->
        <cfset queryAddRow(qMenu)>
        <cfset querySetCell(qMenu, 'menu_code', 'sircalculator')>
        <cfset querySetCell(qMenu, 'menu_name', 'SIR Calculator')>
        <cfset querySetCell(qMenu, 'type', 'popup')>

        <cfreturn qMenu>
    </cffunction>
    
    <cffunction name="verifyFile">
        <cfparam name="full_path" default="">
        <cfparam name="ext" default="">
        <cfparam name="request_type" default="ajax">
        
        <cfset isValid = false>
        
        <cfif fileExists("#full_path#.#ext#")>
            <cfset isValid = true>
        </cfif>
        
        <cfif request_type eq 'ajax'>
            <cfoutput>
                #serializeJson({RESULT: isValid})#
            </cfoutput>
        <cfelse>
            <cfreturn isValid>
        </cfif>
    </cffunction>
</cfcomponent>
