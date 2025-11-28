<cfinclude template="../../config/config.cfm">
<cfset lstpreset = 'initReim'>

<cfoutput>
    <form name="frmexcelgenerator" id="frmexcelgenerator" enctype='multipart/form-data' method="post" action="?sfid=#COOKIES.base_path#.menu.excelgenerator.utils&route=export">
        <label class="input">
            <select name="preset">
                <option value="">-- Select One --</option>
                <cfloop list="#lstpreset#" index="idx">
                    <option value="#idx#">#idx#</option>
                </cfloop>
            </select>
        </label>
        
        <label class="file">
          <input type="file" id="file" name="attachment" aria-label="File browser example">
          <span class="file-custom"></span>
        </label>
        
        <button type="submit" id="btn-submit">Submit</button>
    </form>
    
    <script>
        $('##frmexcelgenerator').submit(function(e){
            //e.preventDefault();
            
            var form = document.getElementById('frmexcelgenerator')
            
            var formData = new FormData(form);
            console.log(formData);
            
            window.open("","excelgenerator","width=600,height=400");
            this.target = 'excelgenerator';
        })
    </script>
</cfoutput>

