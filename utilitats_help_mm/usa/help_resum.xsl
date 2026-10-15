<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:wps="http://www.opengis.net/wps/1.0.0"
	xmlns:ows="http://www.opengis.net/ows/1.1"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xsi:schemaLocation="http://www.opengis.net/wps/1.0.0 ../wpsDescribeProcess_response.xsd"
	exclude-result-prefixes="xsi wps ows xlink">
	<xsl:output version="1.0" encoding="iso-8859-1" method="html" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<xsl:value-of select="substring-after(/wps:ProcessDescriptions/ProcessDescription[1]/ows:Metadata[starts-with(@xlink:title,'Abstract:')]/@xlink:title,'Abstract:')" disable-output-escaping="yes"/>
	</xsl:template>
</xsl:stylesheet>
