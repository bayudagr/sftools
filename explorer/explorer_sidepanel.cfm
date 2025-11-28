<cfparam name="dirPathPanel" default="/media/sf6">
<cfdirectory directory="#dirPathPanel#" name="qDirPathPanel" action="list" type="dir" sort="name ASC">

<cfoutput>
    <style>
        .dir-listing {
            font-family: tahoma;
            font-size: 11pt;
        }
        .sidepanel-dir-list {
            list-style-type: none;
            margin: 0;
            padding-left: 10px;
        }
        .sidepanel-dir-list-item {
            padding: 3px 0;
            cursor: pointer;
        }
        .dir-list-wrapper:hover {
            font-weight: 700;
        }
        .dir-list-wrapper {
            display: flex;
            flex-direction: row;
            align-items: center;
        }
        .text-bold {
            font-weight: 700;
        }
        .lbl-toggle-dir {
            padding: 0 8px;
        }
    </style>

    <div class="dir-listing">
        <ul class="sidepanel-dir-list">
            <cfloop query="qDirPathPanel">
                <cfdirectory directory="#qDirPathPanel.directory#/#qDirPathPanel.name#" name="qTempDir" action="list" type="dir">
                <li class="sidepanel-dir-list-item" id="dir-list-item-#qDirPathPanel.currentrow#">
                    <div class="dir-list-wrapper dir-list-1" data-dir-active="#left(dirPath, len(qDirPathPanel.directory & '/' & qDirPathPanel.name)) eq qDirPathPanel.directory & '/' & qDirPathPanel.name ? '1' : '0'#" data-dir-path="#qDirPathPanel.directory & '/' & qDirPathPanel.name#" data-dir-id="#qDirPathPanel.currentrow#">
                        <span class="lbl-toggle-dir" onclick="toggleDir('#qDirPathPanel.currentrow#', this, '#qDirPathPanel.directory#/#qDirPathPanel.name#')" style="#qTempDir.recordcount eq 0 ? 'visibility: hidden' : ''#"><i class="fa fa-angle-right" id="dir-list-item-dropdown-#qDirPathPanel.currentrow#"></i></span>
                        <span class="lbl-dir-name" onclick="changeDirectory('#qDirPathPanel.directory#/#qDirPathPanel.name#')">#htmlEditFormat(qDirPathPanel.name)#</span>
                    </div>
                    <div class="next-dir-list-wrapper"></div>
                </li>
            </cfloop>
        </ul>
    </div>

    <script>
        $(document).ready(function(){
            $('.dir-list-1').each(function(){
                const isActive = $(this).attr('data-dir-active');
                const dirpath = $(this).attr('data-dir-path');
                const id = $(this).attr('data-dir-id');
                if(isActive == '1') {
                    $(this).find('i').first().attr('class', 'fa fa-angle-down');
                    $(this).attr('data-dir-active', '1');
                    $(this).find('.lbl-dir-name').first().addClass('text-bold');

                    $(this).parent().find('.next-dir-list-wrapper').first().load('?sfid=sys.sec.cron.client.samator.explorer.listing_sidepanel', {dirPath: '#dirPath#', thisDir: dirpath, id: id, depth: 2, firstLoad: 1});
                }
            });
        });
        
        function toggleDir(id, el, dirpath) {
            const isActive = $(el).parent().attr('data-dir-active');
            if(isActive == '0') {
                $(el).parent().find('i').first().attr('class', 'fa fa-angle-down');
                $(el).parent().attr('data-dir-active', '1');
                $(el).parent().find('.lbl-dir-name').first().addClass('text-bold');

                $(el).parent().parent().find('.next-dir-list-wrapper').first().load('?sfid=sys.sec.cron.client.samator.explorer.listing_sidepanel', {dirPath: '#dirPath#', thisDir: dirpath, id: id, depth: 2});
            } else {
                $(el).parent().find('i').first().attr('class', 'fa fa-angle-right');
                $(el).parent().attr('data-dir-active', '0');
                $(el).parent().find('.lbl-dir-name').first().removeClass('text-bold');

                $(el).parent().parent().find('.next-dir-list-wrapper').first().empty();
            }
        }
    </script>
</cfoutput>