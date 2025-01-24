<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:wps="http://www.opengis.net/wps/1.0.0" 
	xmlns:ows="http://www.opengis.net/ows/1.1"
    xsi:schemaLocation="http://www.opengis.net/wps/1.0.0 ../wpsDescribeProcess_response.xsd"
	exclude-result-prefixes="xsi wps ows">
	
<xsl:output version="1.0" encoding="iso-8859-1" method="html" omit-xml-declaration="yes"/>  
<xsl:template match="/">
    
        <xsl:for-each select="/wps:ProcessDescriptions/ProcessDescription">
	 <xsl:if test="count(/wps:ProcessDescriptions/ProcessDescription)&gt;'1' and not(ows:Abstract = preceding::ows:Abstract)">
	 <ul>
		<b><xsl:value-of select="ows:Title" disable-output-escaping="yes"/></b>: 
		 <xsl:value-of select="ows:Abstract" disable-output-escaping="yes"/> 
	 </ul>
	 </xsl:if>
	 	 <xsl:if test="count(/wps:ProcessDescriptions/ProcessDescription)='1'">
		 <xsl:value-of select="ows:Abstract" disable-output-escaping="yes"/> 
	 </xsl:if>
        </xsl:for-each>
 </xsl:template>
 </xsl:stylesheet>

