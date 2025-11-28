<cfif not isDefined("REQUEST.SCookie.user") OR REQUEST.Scookie.user.utype neq '9'>
	<cfoutput>
		<script>
			alert("Super Admin Only!! Please login to your Sunfish Super Admin account to acquire token");
		</script>
	</cfoutput>
	<cf_sfabort>
</cfif>

<cfset objComp = createComponent("component","SFCL_Explorer")>
<cfset strckVar = objComp.initVar()>

<cfparam name="sqlText" default="">

<cfoutput>
	<style>
		##query-table {
			font-family: monospace;
			border: 1px solid ##ddd !important;
			border-collapse: collapse;
			margin-top: 10px;
		}
		##query-table tbody tr:hover {
			background-color: ##D6EEEE;
		}
		##query-table tbody td:hover {
			background-color: ##9debeb;
		}
		##query-table thead td {
			padding: 8px;
		}
		##query-table tbody td {
			padding: 0 8px;
		}
		.error-text {
			font-family: monospace;
			font-style: italic;
		}
		.txt_data {
			outline: none;
		}
	</style>
	
	<cftransaction>
		<cftry>
			<input name="hdn_sqlText" id="hdn_sqlText" style="display:none" value="#sqlText#">
			<cfquery name="qData" datasource="#REQUEST.SDSN#">
				#preserveSingleQuotes(sqlText)#
			</cfquery>
			
			<cfif isDefined("qData")>
				<small style="font-style:italic;">record(s) found: #qData.recordcount#</small>
				<table border="1" id="query-table">
					<thead>
						<tr>
							<cfloop list="#qData.columnlist#" item="colName">
								<td style="font-weight:bold">#colName#</td>
							</cfloop>
						</tr>
					</thead>
					<tbody>
						<cfloop query="qData">
							<tr>
								<cfloop list="#qData.columnlist#" item="colName">
									<td>
										<cfif len(htmlEditFormat(qData[colname])) gt 250>
											<textarea class="txt_data" readonly>#htmlEditFormat(qData[colName])#</textarea>
											<span class="span_data" style="display:none">#htmlEditFormat(qData[colName])#</span>
										<cfelse>
											#isDate(qData[colName]) ? dateTimeFormat(qData[colName], "yyyy-mm-dd HH:nn:ss") : htmlEditFormat(qData[colName])#
										</cfif>
									</td>
								</cfloop>
							</tr>
						</cfloop>
					</tbody>
				</table>

				<script>
					$('##copy-result').removeAttr('disabled');

					function getQueryUpdate(){
						const sqlText = $('##hdn_sqlText').val();
						console.log(sqlText);

						var form_data = new FormData();
						form_data.append('sqlText', sqlText);
						form_data.append('objectName', "SFCL_Query");

						$.ajax({
 							type:'POST',
 							url: "?sfid=sys.sec.cron.client.#strckVar.ist#.explorer.action&action=getUpdateQuery",
 							data: form_data,
 							processData: false, 
 							contentType: false,
 							success: function(data){
 								console.log(data);
 								//alert(data.message+'\n'+data.error);
 								//if(data.success && data.dump == '') {
 									
 								//}
 							},
 							error: function(xhr, status, error) {
 								var err = eval("(" + xhr.responseText + ")");
 								console.log(err.Message);
 								alert(err.Message);
 							},
 							complete: function() {
 								//$(obj).html(strBtn);
 								//$('.btn-gd').attr('disabled',false);
 								//$('.edit-container').css('filter','brightness(1)');
 							},
 							dataType: "json"
 						});
					}
				</script>
			<cfelse>
				<span class="error-text">Query executed</span>
				<script>
					$('##copy-result').attr('disabled',true);
				</script>
			</cfif>

			<cfcatch>
				<div class="short-error">
					<cfif len(cfcatch.message)>
						<span class="error-text">#cfcatch.message#</span><br>
					</cfif>
					<cfif len(cfcatch.detail)>
						<span class="error-text">#cfcatch.detail#</span>
					</cfif>
				</div>
				
				<div class="full-error" style="display:none;">
					<cfdump var="#cfcatch#">
				</div>

				<script>
					$('##copy-result').attr('disabled',true);
					$('input[name=chk-show]').prop('checked', false);
					$('.chk-show-error').show();
					
					$('input[name=chk-show]').change(function(){
						if($('input[name=chk-show]').is(':checked')){
							$('.short-error').hide();
							$('.full-error').show();
						} else {
							$('.short-error').show();
							$('.full-error').hide();
						}
					})
				</script>
			</cfcatch>
		</cftry>
	</cftransaction>
	<script>
		$('##loader-container').css("display","none");
		$('##sql-result').css("display","block");
	</script>
</cfoutput>












