<cfset driverNames=ComponentListPackage("assets.dbdriver")>

		<cfset variables.drivers=struct()>
		<cfloop array="#driverNames#" item="n">
		    <cfif n NEQ "Driver" and n NEQ "IDriver">
		        <cfset variables.drivers[n]=createObject("component","assets.dbdriver."&n)>
		    </cfif>
		</cfloop>
		
		<cffunction name="getTypeName">
		
		    <cfargument name="className" required="true">
		    <cfargument name="dsn" required="true">
		    <cfset var key="">
		
		    <cfloop collection="#variables.drivers#" item="key">
		        <cfif variables.drivers[key].equals(arguments.className,arguments.dsn)>
		            <cfreturn variables.drivers[key].getName()>
		        </cfif>
		    </cfloop>
		
		    <cfreturn variables.drivers['other'].getName()>
		</cffunction>
		
		<cffunction name="getType">
		    <cfargument name="className" required="true">
		    <cfargument name="dsn" required="true">
		    <cfset var key="">
		    <cfloop collection="#variables.drivers#" item="key">
		        <cfif variables.drivers[key].equals(arguments.className,arguments.dsn)>
		            <cfreturn key>
		        </cfif>
		    </cfloop>
		    <cfreturn "other">
		</cffunction>
		<cfadmin action="getDatasources" type="server" password="#local.cfadminPass#" returnVariable="datasources">
		<cfset querySort(datasources,"name")>
		<cfset srcLocal=queryNew("name,classname,dsn,username,password,readonly,storage,host")>
		<cfset srcGlobal=queryNew("name,classname,dsn,username,password,readonly,storage,host")>