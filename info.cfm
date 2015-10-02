<!---
CF_INFO ColdFusion Custom Tag
Displays information Like phpInfo() or perlInfo()

Usage: cf_info

To Display Datasources add attribute CFAdminPass
cf_info cfAdminPass="yourCFIDE/Railo Admin Password"

To Display Encrypted Passwords (on Adobe ColdFusion Only) add attribute DecryptPass:
cf_info decryptpass ='true'


Written By J Harvey <jharvey@cfmaniac.com>
Version 1.0.2

Tested on Railo 4+, Lucee 4.5.X and Adobe ColdFusion 9-11 and 12 Alpha
--->
<cfparam name="attributes.cfadminpass"	default="">
<cfparam name="attributes.decryptpass"	default="false">
<cfparam name="attributes.TagVersion" default="1.0.2">


<cfswitch expression="#thisTag.ExecutionMode#">
<cfcase value="start">
<cfscript>
  local.version = #server.coldfusion.productversion#;
  local.engine = #server.coldfusion.productname#;
  if(local.engine contains "Railo") {
	  local.engineV = server.railo.version;
  } else if (local.engine contains "Lucee"){
	  local.engineV = server.lucee.version;
  } else if (local.engine contains "Coldfusion"){
     local.engineV = local.version;
  }
</cfscript>
<!--- HTML HEAD--->
<cfsavecontent variable="htmlHead">
<cfoutput>

  <html>
	     <head>
		 <style type="text/css"><!--
			body {
			background-color: ##ffffff; 
			background-image: url();
			background-position: center;
			background-repeat: no_repeat;
			background-attachment: fixed;  
			color: ##000000;}
			body, td, th, h1, h2 {font-family: sans-serif;}
			pre {margin: 0px; font-family: monospace;}
			a:link {color: ##000099; text-decoration: none; background-color: ;}
			a:hover {text-decoration: underline;}
			table {border-collapse: collapse; border: 0; width: 934px; box-shadow: 1px 2px 3px ##ccc;}
			.fixed_headers {table-layout: fixed;border-collapse: collapse;}
			.fixed_headers th {text-decoration: underline;}
			.fixed_headers th, .fixed_headers td {padding: 5px;text-align: left;}
			.fixed_headers td:nth-child(1), .fixed_headers th:nth-child(1) {min-width: 200px;}
			.fixed_headers td:nth-child(2),	.fixed_headers th:nth-child(2) {min-width: 200px;}
			.fixed_headers td:nth-child(3),	.fixed_headers th:nth-child(3) {min-width: 252px;}
			.fixed_headers td:nth-child(4),	.fixed_headers th:nth-child(4) {min-width: 220px;}
			.fixed_headers thead {background-color: ##ccccff;color: ##000;}
			.fixed_headers thead tr {display: block; position: relative;}
			.fixed_headers tbody {display: block;overflow: auto;width: 100%;height: 150px;}
			.fixed_headers tbody tr:nth-child(even) {background-color: ##dddddd;}
			.old_ie_wrapper {height: 300px;width: 750px;overflow-x: hidden;	overflow-y: auto;}
			.old_ie_wrapper tbody {height: auto;}
			.center {text-align: center;}
			.center table { margin-left: auto; margin-right: auto; text-align: left;}
			.center th { text-align: center !important; }
			td, th { border: 1px solid ##000000; font-size: 75%; vertical-align: top;}
			.modules table {border: 0;}
			.modules td { border:0; font-size: 100%; vertical-align: baseline;}
			.modules th { border:0; font-size: 100%; vertical-align: baseline;}
			h1 {font-size: 150%;}
			h2 {font-size: 125%;}
			.p {text-align: left;}
			.e {background-color: ##ccccff; font-weight: bold; color: ##000000;}
			.h {background-color: ##9999cc; font-weight: bold; color: ##000000;}
			.v {background-color: ##cccccc; color: ##000000;}
			i {color: ##666666; background-color: ##cccccc;}
			img {float: right; border: 0px;}
			hr {width: 600px; background-color: ##cccccc; border: 0px; height: 1px; color: ##000000;}
			//-->
		 </style>
		 <title>&lt;CF_INFO&gt; 
		 <cfif(local.engine contains "Railo")>
			 Railo #local.engineV#
	     <cfelseif(local.engine contains "Lucee")>
	         Lucee #local.engineV#		 
		 <cfelseif(local.engine contains "ColdFusion")>
			 ColdFusion #local.version#
		 </cfif>
         </title>
		 </head>
		 <body>
		 <div class="center">
</cfoutput>
</cfsavecontent>
<!---ServerInfo--->
<cfsavecontent variable="ServerInfo">
  <cfscript>
    local.version = #server.coldfusion.productversion#;
      local.engine = #server.coldfusion.productname#;
      if(local.engine contains "Railo"){
	      local.engineV = server.railo.version;
	  } else if (local.engine contains "Lucee"){
	      local.engineV = server.lucee.version;
         
      } else if (local.engine contains "Coldfusion"){
	      local.engineV = local.version;
      }
      local.os = #server.os.name# & " (#server.os.version#)";
      local.arch = #server.os.arch#;
      if(local.engine Contains "Railo") {
	      local.servlet = #server.servlet.name#;
	  } else if (local.engine contains "Lucee"){
	      local.servlet = #server.servlet.name#;    
      } else if (local.engine contains "ColdFusion"){
	      local.servlet = #server.coldfusion.appserver#;
      }
      
      WriteOutput('<table border="0" cellpadding="3" width="600">
			<tr class="h"><td>
			<h1 class="p"><img border="0" src="assets/#lcase(rereplace(local.engine, " ", "_","All"))#.png" alt="#local.engine# logo">'); 
			if(local.Engine contains "Railo") {
				WriteOutput( 'Railo&trade; #local.engineV#</h1><br style="clear:both" />' );
			} else if(local.Engine contains "Lucee"){
				WriteOutput( 'Lucee&trade; #local.engineV#</h1><br style="clear:both" />' );
			} else {
				WriteOutput('ColdFusion #local.version#</h1><br style="clear:both" />');
			}
			
			WriteOutput('
			</td></tr>
			</table><br />
			
			<table border="0" cellpadding="3" width="600">
			<tr><td class="e">Currently running on </td><td class="v">#local.os# #local.arch# </td></tr>
			<tr><td class="e">ColdFusion Server Engine </td><td class="v">#local.engine# </td></tr>
			<tr><td class="e">ColdFusion Server Engine Version</td><td class="v">#local.engineV# </td></tr>');
			if(local.engine contains "Railo" || local.engine contains "Lucee"){ 
			WriteOutput('<tr><td class="e">ColdFusion Compatibility Version </td><td class="v">#local.version# </td></tr>');
			}
			WriteOutput('<tr><td class="e">ColdFusion Servlet </td><td class="v">#local.servlet# </td></tr>
			</table><br />
			
			
	  ');
  </cfscript>
</cfsavecontent>

<!---DataSources--->

<cfsavecontent variable="DataSources">
  <cfif isdefined('attributes.cfadminpass') and attributes.cfadminpass NEQ "">
  <cfscript>
        local.engine = #server.coldfusion.productname#;
		local.cfadminPass =attributes.cfadminpass;
			    
	    WriteOutput('<table border="0" cellpadding="3" width="600" >
			<tr class="h"><td>
			<h1 class="p">DataSources</h1><br style="clear:both" /></td></tr>
			</tr>
			</table>
			<table border="0" cellpadding="3" width="600" class="fixed_headers">
			<thead>
			<th>Datasource</th>
			<th>Server</th>
			<th>DB-Type</th>
			<th>User / Pass</th>
			</thead>
			<tbody>');
			
			 
	    
	    
	    if(local.engine contains "Railo" || local.engine contains "Lucee"){
	      
	      include "railods.cfm";
	      for(ds=1; ds LTE datasources.recordcount; ds++){
		          QueryAddRow(srcLocal);
			      QuerySetCell(srcLocal,"name",datasources.name[ds]);
			      QuerySetCell(srcLocal,"classname",datasources.classname[ds]);
			      QuerySetCell(srcLocal,"dsn",datasources.dsn[ds]);
			      QuerySetCell(srcLocal,"username",datasources.username[ds]);
			      QuerySetCell(srcLocal,"password",datasources.password[ds]);
			      QuerySetCell(srcLocal,"readonly",datasources.readonly[ds]);
			      QuerySetCell(srcLocal,"storage",datasources.storage[ds]);
			      QuerySetCell(datasources,"host",datasources.host[ds]);
		      
	      }
		
		for(ds=1; ds LTE datasources.recordcount; ds++){
				WriteOutput('<tr><td>#datasources.name[ds]#</td>
				<td>#datasources.host[ds]#</td>
				<td>#getTypeName(datasources.ClassName[ds],datasources.dsn[ds])#</td><td>');
				if(len(datasources.username[ds])) {
					WriteOutput( '#datasources.username[ds]# | #datasources.password[ds]#' );
				}
				Writeoutput('</td></tr>');
				
			  }
	  } else if(local.engine contains "ColdFusion") {
		  local.decryptPass = attributes.DecryptPass;
		  local.version = #server.coldfusion.productversion#;

		  if(local.version contains "9."){
          local.seed='0yJ!@1$r8p0L@r1$6yJ!@1rj';  
        } else if (local.version contains "10."){
          local.seed='FA8E9653AC7975B7';
          local.algorithm='AES/CBC/PKCS5Padding';
        } else if (local.version contains "11." || local.version contains "12."){
          local.seed='442C36FABD24B3C7';
          local.algorithm='AES/CBC/PKCS5Padding';
        }
        
        adminObj = createObject( "component", "cfide.adminapi.administrator" ); 
        adminObj.login( #local.cfadminPass# );
  
        DataSources = createObject( "component", "cfide.adminapi.datasource" ).getDataSources();
		 
		  
		  for (dsn in Datasources) {
		   if(len(datasources[dsn].password)){
			  DecryptedPass = Decrypt(datasources[dsn].password,generate3DesKey("#local.Seed#"),"#local.algorithm#","Base64");
	      } else {
			  DecryptedPass = '';
	      }
		      StructSort( datasources, "text", "ASC", "name");
			  WriteOutput('<tr><td>#datasources[dsn].name#</td>
	                    <td><em>#datasources[dsn].urlmap.connectionprops.host#</em></td>
	                    <td>#datasources[dsn].driver#<br></td>
	                    <td>');
	                    if(len(datasources[dsn].username)){
	                    writeOutput('#datasources[dsn].username# || <!---#datasources[dsn].password#--->#decryptedPass#');
	                    }
		                WriteOutput('</td></tr>');
		  }
	  }    	
	  
	  	 	WriteOutput('</tbody></table><br />');	 
  </cfscript>
  </cfif>
</cfsavecontent>

<!---Additional Server Info--->
<cfsavecontent variable="ServerExt">
	<cfscript>
	  local.serverName = cgi.server_name;
	  local.serverSW =cgi.server_software;
	  local.serverAdmin = cgi.server_admin;
	  local.serverAPI = cgi.serverAPI;
	  local.engine = #server.coldfusion.productname#;
	  
	 
		  WriteOutput( '<table border="0" cellpadding="3" width="600">
			<tr class="h"><td>
			<h1 class="p">Server Information</h1><br style="clear:both" /></td></tr>
			</tr>
			</table>
			
			<table border="0" cellpadding="3" width="600">
			<tr><td class="e">Server Name </td><td class="v">#local.servername# </td></tr>
			<tr><td class="e">Server Software </td><td class="v">#local.serverSW# </td></tr>
			<tr><td class="e">Server Admin</td><td class="v">#local.serverAdmin# </td></tr>
			<tr><td class="e">Server API</td><td class="v">#local.serverAPI# </td></tr></table>
								
			<br />
			');
		    if(local.engine contains "Railo" || local.engine contains "Lucee"){
			WriteOutput('<table border="0" cellpadding="3" width="600">
			<tr><td class="e">Server Name </td><td class="v">#local.servername# </td></tr>
			<tr><td class="e">Server Software </td><td class="v">#local.serverSW# </td></tr>
			<tr><td class="e">Server Admin</td><td class="v">#local.serverAdmin# </td></tr>
			<tr><td class="e">Server API</td><td class="v">#local.serverAPI# </td></tr>
			<tr><td class="e">Supported Locales</td><td class="v"> <select name="locales" size="20">');
			locales = ListToArray(server.coldfusion.supportedlocales);
			ArraySort(locales, "textnocase", "asc");
		    for (i = 1; i <= ArrayLen(locales); i++)
			{
				WriteOutput('<option value="#locales[i]#">#locales[i]#</option> ');
			    /*fieldName = arr[i];
			    form[FieldName] = qry[FieldName][1];*/
			}
			WriteOutput('</select></td></tr>
			</table>    
			<br>
			<table border="0" cellpadding="3" width="600">
			<tr class="h"><td>
			<h1 class="p">Java Information</h1><br style="clear:both" /></td></tr>
			</tr>
			</table>
			<table border="0" cellpadding="3" width="600">
			<tr><td class="e">Execution Path </td><td class="v">#server.java.executionPath# </td></tr>
			<tr><td class="e">Java Version </td><td class="v">#server.java.version# </td></tr>
			<tr><td class="e">Vendor</td><td class="v">#server.java.vendor# </td></tr>
			<tr><td class="e">Java Agent Supported</td><td class="v">#server.java.javaAgentSupported# </td></tr>
			</table>
			<br />
			<table border="0" cellpadding="3" width="600">
			<tr class="h"><td>
			<h1 class="p">#local.engine# Information</h1><br style="clear:both" /></td></tr>
			</tr>
			</table>
			<table border="0" cellpadding="3" width="600">
			<tr><td class="e">Loader Path </td><td class="v">#server.railo.loaderpath# </td></tr>
			<tr><td class="e">Loader Version </td><td class="v">#server.railo.loaderVersion# </td></tr>
			
			</table>
			<br />');
		    } else  if(local.engine contains "ColdFusion"){
			    local.serviceTags = server.coldfusion.serviceTagAttributes;
			    WriteOutput( '<table border="0" cellpadding="3" width="600">
			<tr class="h"><td>
			<h1 class="p">ColdFusion Information</h1><br style="clear:both" /></td></tr>
			</tr>
			</table>
			<table border="0" cellpadding="3" width="600">
			<tr><td class="e">Loader Path </td><td class="v">#server.coldfusion.rootdir# </td></tr>
			<tr><td class="e">Supported Locales</td><td class="v"> <select name="locales" size="20">');
			locales = ListToArray(server.coldfusion.supportedlocales);
			ArraySort(locales, "textnocase", "asc");
		    for (i = 1; i <= ArrayLen(locales); i++)
			{
				WriteOutput('<option value="#locales[i]#">#locales[i]#</option> ');
			    
			}
			WriteOutput('</select></td></tr>');
			
			writeOutput('<tr><td class="e">Service Tags</td><td class="v"> <select name="tags" size="10">');
			for(tag in local.serviceTags){
			WriteOutput('<option value="#tag#">#tag#</option>');
		    }
			WriteOutput('</select></td></tr>
			</table>
			<br />
			');
		    }
			//WriteDump(var=#server#);
	</cfscript>
</cfsavecontent>

<!---Closing HTML--->
<cfsavecontent variable="htmlFoot">
  <cfoutput>
    <div class="copyright">
	    &lt;CF_INFO<sup>#attributes.TagVersion#</sup>&gt; &copy; 2015 J Harvey. All Rights Reserved.<br>
	    Released as-is, whereis as no warranty is given. Share and distribute.
	    </div>
	    </div>
	    
	    </body>
	    </html>
  </cfoutput>
</cfsavecontent>


<cfoutput>#htmlHead#
#serverInfo#
#datasources#
#serverext#
#htmlFoot#

</cfoutput>
</cfcase>
</cfswitch>