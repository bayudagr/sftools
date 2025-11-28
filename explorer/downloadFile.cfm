<cfparam name="file_path" default="">
<cfparam name="file_name" default="">

<cfdump var="#file_path#">
<cfdump var="#file_name#">

<cfset objComp = createObject('component', 'SFCL_Explorer')>
<cfset objComp.download(file_path,file_name)>