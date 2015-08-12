/*
  CF-INFO: ColdFusion Information Utility
  Similiar to PHPInfo() or PerlInfo()
  Written by James Harvey <jharvey@cfmaniac.com
  Version 1.0
  */
component {
  
    
  public any function GetHTMLHead(){
	  savecontent variable="local.HTMLHead" { 
	  
	    WriteOutput('<html>
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
			table {border-collapse: collapse;}
			.center {text-align: center;}
			.center table { margin-left: auto; margin-right: auto; text-align: left;}
			.center th { text-align: center !important; }
			td, th { border: 1px solid ##000000; font-size: 75%; vertical-align: baseline;}
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
		 <title>cfINFO()</title>
		 </head>
		 <body>
		 <div class="center">
			');
	  
	  }
	   return local.HTMLHead;
	   return GetCFServer();
	  
  }
  
  public any function GetHTMLFoot(){
	  savecontent variable="local.HTMLFoot" { 
	  
	    WriteOutput('</div>
	    </body>
	    </html>');
	  
	  }
	  
	  return local.HTMLFoot;
	  
  }
  
  public any function GetServerInfo(){
	  local.server = GetCFServer();
	  
	  
	  return local.server;
	 
	  
  }
  
  public any function GetCFServer(){
      local.version = #server.coldfusion.productversion#;
      local.engine = #server.coldfusion.productname#;
      if(local.engine contains "Railo"){
	      local.engineV = server.railo.version;
      } else if (local.engine contains "Coldfusion"){
	      local.engineV = local.version;
      }
      local.os = #server.os.name# & #server.os.version#;
      local.arch = #server.os.arch#;
      if(local.engine Contains "Railo") {
	      local.servlet = #server.servlet.name#;
      } else if (local.engine contains "ColdFusion"){
	      local.servlet = #server.coldfusion.appserver#;
      }
      
	  savecontent variable="local.server"{
		WriteOutput('<table border="0" cellpadding="3" width="600">
			<tr class="h"><td>
			<h1 class="p"><img border="0" src="assets/#lcase(rereplace(local.engine, " ", "_","All"))#.png" alt="#local.engine# logo"> ColdFusion #local.version#</h1><br style="clear:both" /></td></tr>
			</table><br />
			
			<table border="0" cellpadding="3" width="600">
			<tr><td class="e">Currently running on </td><td class="v">#local.os# #local.arch# </td></tr>
			<tr><td class="e">ColdFusion Server Engine </td><td class="v">#local.engine# </td></tr>
			<tr><td class="e">ColdFusion Server Engine Version</td><td class="v">#local.engineV# </td></tr>
			<tr><td class="e">ColdFusion Servlet </td><td class="v">#local.servlet# </td></tr>
			</table><br />
			
			
			');  
		  
	  }
	  
	  return local.server & GetDataSources() & GetCFServerInfo();
	  
  }
  
  public any function GetDataSources(){
	  local.engine = #server.coldfusion.productname#;
	  
	  if(local.engine contains "Railo"){
	      local.cfadminPass ='sith1701';
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
	      
		  savecontent variable="local.dslist"{
			  for(ds=1; ds LTE datasources.recordcount; ds++){
				WriteOutput('<tr><td>#datasources.name[ds]#</td>
				<td>#datasources.host[ds]#</td>
				<td>#getTypeName(datasources.ClassName[ds],datasources.dsn[ds])#</td>
				<td>#datasources.username[ds]# | #datasources.password[ds]#</td>
				</tr>
				');
			  }
			  
			  
		  }
	  } else if(local.engine contains "ColdFusion"){
	      local.cfadminPass ='sith1701';
	      local.decryptPass = 'true';
	      local.version = #server.coldfusion.productversion#;
	      
	      include "acfds.cfm";
	     
	  
	  
		  savecontent variable="local.dslist"{
		  for (dsn in Datasources) {
		   if(len(datasources[dsn].password)){
			  DecryptedPass = Decrypt(datasources[dsn].password,generate3DesKey("#local.Seed#"),"#local.algorithm#","Base64");
	      } else {
			  DecryptedPass = '';
	      }
		  
			  WriteOutput('<tr><td>#datasources[dsn].name#</td>
	                    <td><em>#datasources[dsn].urlmap.connectionprops.host#</em></td>
	                    <td>#datasources[dsn].driver#<br></td>
	                    <td>#datasources[dsn].username# || <!---#datasources[dsn].password#--->#decryptedPass#</td></tr>');
		  }
			  
		  }
	  }
	  
	  savecontent variable="local.datasources"{
		WriteOutput('<table border="0" cellpadding="3" width="600">
			<tr class="h"><td>
			<h1 class="p">DataSources</h1><br style="clear:both" /></td></tr>
			</tr>
			</table>
			<table border="0" cellpadding="3" width="600">
			<thead>
			<th>Datasource</th>
			<th>Server</th>
			<th>DB-Type</th>
			<th>User / Pass</th>
			
			#local.dslist#
		   							
			</table><br />');  
		  
	  }
	  return local.datasources;
  }
  
  public any function GetCFServerInfo(){
	  local.serverName = cgi.server_name;
	  local.serverSW =cgi.server_software;
	  local.serverAdmin = cgi.server_admin;
	  local.serverAPI = cgi.serverAPI;
	  
	  savecontent variable="local.ServerInfo"{
		  WriteOutput( '<table border="0" cellpadding="3" width="600">
			<tr class="h"><td>
			<h1 class="p">Server Information</h1><br style="clear:both" /></td></tr>
			</tr>
			</table>			
			<table border="0" cellpadding="3" width="600">
			<tr><td class="e">Server Name </td><td class="v">#local.servername# </td></tr>
			<tr><td class="e">Server Software </td><td class="v">#local.serverSW# </td></tr>
			<tr><td class="e">Server Admin</td><td class="v">#local.serverAdmin# </td></tr>
			<tr><td class="e">Server API</td><td class="v">#local.serverAPI# </td></tr>
			<br />
			');
	  }		
	  
	  return local.ServerInfo;
	 
  }

}
