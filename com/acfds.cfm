<cfscript>
  if(local.version contains "9."){
    local.seed='0yJ!@1$r8p0L@r1$6yJ!@1rj';  
  } else if (local.version contains "10."){
    local.seed='FA8E9653AC7975B7';
    local.algorithm='AES/CBC/PKCS5Padding';
  } else if (local.version contains "11." || local.version contains "12."){
    local.seed='F9576C78C17146CC';
    local.algorithm='AES/CBC/PKCS5Padding';
  }
  
  adminObj = createObject( "component", "cfide.adminapi.administrator" ); 
  adminObj.login( #local.cfadminPass# );
  
  DataSources = createObject( "component", "cfide.adminapi.datasource" ).getDataSources();
</cfscript>