<cfscript>
  /*
  CF-INFO: ColdFusion Information Utility
  Similiar to PHPInfo() or PerlInfo()
  Written by James Harvey <jharvey@cfmaniac.com
  Version 1.0
  */
  rc.head = createObject('component', 'com.cfinfo').getHTMLHead();
  rc.info = createObject('component', 'com.cfinfo').GetServerInfo();
  rc.foot = createObject('component', 'com.cfinfo').getHTMLFoot();
</cfscript>
<cfoutput>
  #rc.head#
  #rc.info#
  #rc.foot#
</cfoutput>