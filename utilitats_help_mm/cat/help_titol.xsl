<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:wps="http://www.opengis.net/wps/1.0.0" 
	xmlns:ows="http://www.opengis.net/ows/1.1"
    xmlns:xlink="http://www.w3.org/1999/xlink"	
    xsi:schemaLocation="http://www.opengis.net/wps/1.0.0 ../wpsDescribeProcess_response.xsd"
	exclude-result-prefixes="xsi wps ows xlink">
	<xsl:output version="1.0" encoding="iso-8859-1" method="html" omit-xml-declaration="yes"/>  
		<xsl:variable name="processDescription" select="/wps:ProcessDescriptions/ProcessDescription"></xsl:variable>                       
		<xsl:template match="/">
			<ul style="list-style-type:none;">
				<li>
					<h1>
						<a href="https://www.miramon.cat/help/cat/" target="_blank">
							<img>
								<xsl:attribute name="src">vecras.gif</xsl:attribute>
							</img>
						</a>
						<xsl:if test="substring-before(substring-after($processDescription/ows:Identifier,'MiraMon:'),':')= ''">
							<xsl:value-of select="substring-after($processDescription/ows:Identifier,'MiraMon:')"/>
						</xsl:if>
						<xsl:value-of select="substring-before(substring-after($processDescription/ows:Identifier,'MiraMon:'),':')"/>
						<xsl:text>: </xsl:text>
						<xsl:value-of select="substring-after($processDescription/ows:Metadata/@ xlink:title,'Title:')"/> 	
					</h1>
				</li>
			</ul>
		</xsl:template>
</xsl:stylesheet>