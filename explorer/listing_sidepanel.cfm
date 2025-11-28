<cfparam name="dirPath" default="">
<cfparam name="thisDir" default="">
<cfparam name="id" default="">
<cfparam name="depth" default="0">
<cfparam name="firstLoad" default="0">

<cfif len(thisDir) AND len(id) AND depth gt 0>
    <cfdirectory directory="#thisDir#" name="qThisDirList" action="list" type="dir" sort="name ASC">
    <cfoutput>
        <div class="dir-listing">
            <ul class="sidepanel-dir-list">
                <cfloop query="qThisDirList">
                    <cfdirectory directory="#qThisDirList.directory#/#qThisDirList.name#" name="qTempDir" action="list" type="dir">
                    <li class="sidepanel-dir-list-item" id="dir-list-item-#id#-#qThisDirList.currentrow#">
                        <div class="dir-list-wrapper dir-list-#depth#" data-dir-active="#left(dirPath, len(qThisDirList.directory & '/' & qThisDirList.name)) eq qThisDirList.directory & '/' & qThisDirList.name ? '1' : '0'#" data-dir-path="#qThisDirList.directory & '/' & qThisDirList.name#" data-dir-id="#qThisDirList.currentrow#">
                            <span class="lbl-toggle-dir" onclick="toggleDir('#id#-#qThisDirList.currentrow#', this, '#qThisDirList.directory#/#qThisDirList.name#')" style="#qTempDir.recordcount eq 0 ? 'visibility: hidden' : ''#"><i class="fa fa-angle-right" id="dir-list-item-dropdown-#id#-#qThisDirList.currentrow#"></i></span>
                            <span class="lbl-dir-name" onclick="changeDirectory('#qThisDirList.directory#/#qThisDirList.name#');">#htmlEditFormat(qThisDirList.name)#</span>
                        </div>
                        <div class="next-dir-list-wrapper"></div>
                    </li>
                </cfloop>
            </ul>
        </div>

        <script>
            <cfif firstLoad eq '1'>
                $(document).ready(function(){
                    $('.dir-list-#depth#').each(function(){
                        const isActive = $(this).attr('data-dir-active');
                        const dirpath = $(this).attr('data-dir-path');
                        const id = $(this).attr('data-dir-id');
                        if(isActive == '1') {
                            $(this).find('i').first().attr('class', 'fa fa-angle-down');
                            $(this).attr('data-dir-active', '1');
                            $(this).find('.lbl-dir-name').first().addClass('text-bold');
    
                            $(this).parent().find('.next-dir-list-wrapper').first().load('?sfid=sys.sec.cron.client.samator.explorer.listing_sidepanel', {dirPath: '#dirPath#', thisDir: dirpath, id: id, depth: #depth+1#, firstLoad: 1});
                        }
                    });
                });
            </cfif>
        </script>
    </cfoutput>
</cfif>