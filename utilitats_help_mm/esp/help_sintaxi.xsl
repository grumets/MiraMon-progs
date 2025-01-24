<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wps="http://www.opengis.net/wps/1.0.0" xmlns:ows="http://www.opengis.net/ows/1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/wps/1.0.0 ../wpsDescribeProcess_response.xsd" exclude-result-prefixes="xsi wps ows xlink">
	<xsl:output version="1.0" encoding="iso-8859-1" method="html" omit-xml-declaration="yes"/>
	<xsl:variable name="processDescription" select="/wps:ProcessDescriptions/ProcessDescription"/>
	<xsl:template match="/">
		<a id="sintaxi" name="sintaxi"></a><h3>Sintaxis:</h3>
			<ul style="list-style-type:none;">
			<xsl:for-each select="$processDescription">
				<li>
					<xsl:if test="substring-before(substring-after(ows:Identifier,'MiraMon:'),':')= ''">
						<xsl:value-of select="substring-after(ows:Identifier,'MiraMon:')"/>
					</xsl:if>
					<xsl:value-of select="substring-before(substring-after(ows:Identifier,'MiraMon:'),':')"/>
					<xsl:text> </xsl:text>
					<xsl:variable name="inout" select="DataInputs/Input | ProcessOutputs/Output"/>
<!--Opcio quan "opció" és el primer paràmetre-->
					<xsl:for-each select="$inout">
						<xsl:sort select="ows:Metadata[starts-with(@xlink:title,'Param')]/@xlink:title"/>
						<xsl:if test="ows:Identifier='Opcio' and ows:Metadata/@xlink:title='Param01'">
							<xsl:if test="(count(LiteralData/ows:AllowedValues/ows:Value)&gt;'1')">
								<xsl:value-of select="substring-after(ows:Metadata[2]/@xlink:title,'Name:')"/>
							</xsl:if>
							<xsl:if test="(count(LiteralData/ows:AllowedValues/ows:Value)='1')">
								<xsl:value-of select="LiteralData/ows:AllowedValues/ows:Value"/>
							</xsl:if>
						</xsl:if>
						<xsl:text> </xsl:text>
					</xsl:for-each>
<!--Fi Opcio quan "opció" és el primer paràmetre de la sintaxi-->
<!--Parametres-->
					<xsl:for-each select="$inout">
						<xsl:sort select="ows:Metadata[starts-with(@xlink:title,'Param')]/@xlink:title"/>
						<xsl:if test="not(ows:Identifier='Opcio') and not(ows:Identifier=preceding-sibling::ows:Identifier) and not(ows:Identifier='StdOut')">
							<xsl:if test="ows:Metadata[starts-with(@xlink:title,'Param')]">
								<xsl:if test="(@minOccurs='0')">[</xsl:if>
								<xsl:if test="ows:Metadata[starts-with(@xlink:title,'Name:')]">
									<xsl:value-of select="substring-after(ows:Metadata[2]/@xlink:title,'Name:')"/>
								</xsl:if>
								<xsl:if test="(@minOccurs='0')">]</xsl:if>
							</xsl:if>
							<xsl:text> </xsl:text>
						</xsl:if>
<!--Fi Parametres-->
<!--Opcio quan la opcio no és el primer parametre de la sintaxi-->
						<xsl:if test="ows:Identifier='Opcio' and not(ows:Metadata/@xlink:title='Param01')">
							<xsl:if test="(count(LiteralData/ows:AllowedValues/ows:Value)&gt;'1')">
								<xsl:value-of select="substring-after(ows:Metadata[2]/@xlink:title,'Name:')"/>
							</xsl:if>
							<xsl:if test="(count(LiteralData/ows:AllowedValues/ows:Value)='1')">
							<xsl:value-of select="LiteralData/ows:AllowedValues/ows:Value"/>
							</xsl:if>
							<xsl:text> </xsl:text>
						</xsl:if>
					</xsl:for-each>
<!--Fi Opcio quan la "opcio" no es el primer parametre de la sintaxi-->
<!--Modificadors-->
					<xsl:for-each select="$inout">
						<xsl:if test="not(ows:Identifier='Opcio') and not(/ows:Identifier = preceding::ows:Identifier) and not(ows:Identifier='StdOut')">
							<xsl:if test="not(ows:Metadata[starts-with(@xlink:title,'Param')])">
								<xsl:if test="(@minOccurs='0')">[</xsl:if>/<xsl:value-of select="ows:Identifier"/>
								<xsl:if test="(@minOccurs='0')">]</xsl:if>
							</xsl:if>
							<xsl:text> </xsl:text>
						</xsl:if>
					</xsl:for-each>
<!--Fi Modificadors-->
				</li>
			</xsl:for-each>
		</ul>
<!--Descripció Opcions-->
		<xsl:if test="wps:ProcessDescriptions/ProcessDescription/DataInputs/Input/ows:Identifier='Opcio'">
			<h4>Opciones:</h4>
		</xsl:if>
		<xsl:if test="count(/wps:ProcessDescriptions/ProcessDescription)&gt;'1'">
			<ul>
				<xsl:for-each select="$processDescription">
				<xsl:variable name="inout" select="DataInputs/Input | ProcessOutputs/Output"/>
					<xsl:for-each select="$inout">
						<xsl:if test="ows:Identifier='Opcio' and not(ows:Abstract = preceding-sibling::ows:Abstract)">
							<li>
								<xsl:if test="not(/ows:Abstract = following ::ows:Abstract) and count(LiteralData/ows:AllowedValues/ows:Value)='1'">
									<xsl:value-of select="LiteralData/ows:AllowedValues/ows:Value"/>: 
								</xsl:if> 
									<xsl:value-of select="ows:Abstract" disable-output-escaping="yes"/>
							</li>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
			</ul>
		</xsl:if>
		<xsl:if test="count(/wps:ProcessDescriptions/ProcessDescription)='1'">
			<ul>
				<xsl:for-each select="$processDescription">
				<xsl:variable name="inout" select="DataInputs/Input | ProcessOutputs/Output"/>
					<xsl:for-each select="$inout">
						<xsl:if test="ows:Identifier='Opcio' and not(ows:Abstract = preceding::ows:Abstract)">
							<xsl:value-of select="ows:Abstract" disable-output-escaping="yes"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
			</ul>
		</xsl:if>
<!--Fi Descripció Opcions-->
<!--Descripció Parametres-->
		<h4>Parámetros:</h4>
		<xsl:for-each select="$processDescription">
			<ul style="list-style-type:none;">
				<xsl:variable name="inout" select="DataInputs/Input | ProcessOutputs/Output"/>
				<xsl:for-each select="$inout">
				<xsl:sort select="ows:Metadata[starts-with(@xlink:title,'Param')]/@xlink:title"/>
					<xsl:if test="ows:Metadata[starts-with(@xlink:title,'Param')] and not(ows:Abstract = preceding::ows:Abstract) and not(ows:Identifier='Opcio') and not(ows:Identifier='StdOut')">
						<li>
							<b>
								<xsl:value-of select="substring-after(ows:Metadata[2]/@xlink:title,'Name:')"/>
							</b>
								<xsl:text> </xsl:text>
								<xsl:choose>
									<xsl:when test="ows:Identifier!=ows:Title">
										(<xsl:value-of select="ows:Title" disable-output-escaping="yes"/><xsl:text> </xsl:text>-
										<xsl:choose>
											<xsl:when test="../Input">Parámetro de entrada):</xsl:when>
											<xsl:otherwise>Parámetro de salida):</xsl:otherwise>									
										</xsl:choose>
										</xsl:when>
									<xsl:otherwise>										
										<xsl:choose>
											<xsl:when test="../Input">(Parámetro de entrada):</xsl:when>
											<xsl:otherwise>(Parámetro de salida):</xsl:otherwise>									
										</xsl:choose>
									</xsl:otherwise>									
								</xsl:choose>
								<xsl:text> </xsl:text><xsl:value-of select="ows:Abstract" disable-output-escaping="yes"/>
						</li>
					</xsl:if>
					<!--<xsl:if test="ows:Identifier = preceding::ows:Identifier and not(ows:Identifier='Opcio') and ows:Metadata/@xlink:title = preceding::ows:Metadata/@xlink:title">
						<li>
							<b>
								<xsl:value-of select="substring-after(ows:Metadata[2]/@xlink:title,'Name:')"/>
							</b>
								<xsl:text> </xsl:text>(<xsl:value-of select="ows:Title" disable-output-escaping="yes"/>)<xsl:text> </xsl:text>
								<xsl:value-of select="ows:Abstract" disable-output-escaping="yes"/><xsl:text> </xsl:text>(Paràmetre d'entrada i de sortida)
						</li>
					</xsl:if>-->
				</xsl:for-each>
			</ul>
		</xsl:for-each>
<!--Fi Descripció Parametres-->
<!--Descripció Modificadors-->
		<h4>Modificadores:</h4>
		<xsl:variable name="complet_path_inout" select="/wps:ProcessDescriptions/ProcessDescription/DataInputs/Input | /wps:ProcessDescriptions/ProcessDescription/ProcessOutputs/Output"/>
		<ul style="list-style-type:none;">
			<xsl:for-each select="$complet_path_inout">
				<!--xsl:sort select="ows:Abstract"/-->
				<xsl:if test="not(ows:Metadata[starts-with(@xlink:title,'Param')]) and not (ows:Identifier =following::ows:Identifier) and not(ows:Identifier='StdOut')">
<!-- No tinc cap abstract igual abans i en tinc algun després-->
					<xsl:if test="not(ows:Abstract = preceding::ows:Abstract) and (ows:Abstract =following::ows:Abstract)">
						<b>/</b>
						<b>
							<xsl:value-of select="ows:Identifier"/>
						</b>
					</xsl:if>
<!--Tinc algun abstract igual abans i en tinc algun després-->
					<xsl:if test="(ows:Abstract =preceding::ows:Abstract) and (ows:Abstract =following::ows:Abstract)">
						<xsl:text> </xsl:text>
<!--<b>|</b>-->
						<xsl:text> </xsl:text>
						<b>/</b>
						<b>
							<xsl:value-of select="ows:Identifier"/>
						</b>
					</xsl:if>
<!--Tinc algun abstract igual abans i no en tinc cap després-->
					<xsl:if test="(ows:Abstract =preceding::ows:Abstract) and not(ows:Abstract =following::ows:Abstract)">
						<xsl:text> </xsl:text>
<!--<b>|</b>-->
						<xsl:text> </xsl:text>
						<b>/</b>
						<b>
							<xsl:value-of select="ows:Identifier"/>
						</b>
						<xsl:choose>
							<xsl:when test="LiteralData/ows:AllowedValues/ows:Value='##blank##'">
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:otherwise>=</xsl:otherwise>
						</xsl:choose>						
						<xsl:text> </xsl:text>
<!--<xsl:if test="(count(ows:Abstract = preceding::ows:Abstract)='0')">-->
						<xsl:text>(</xsl:text>
						<xsl:value-of select="ows:Title" disable-output-escaping="yes"/>
						<xsl:text>) </xsl:text>
<!--</xsl:if>-->
						<xsl:value-of select="ows:Abstract" disable-output-escaping="yes"/>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="ows:Metadata/@xlink:href">
								<a>
									<xsl:attribute name="href"><xsl:value-of select="ows:Metadata/@xlink:href"/></xsl:attribute>
									<xsl:text> </xsl:text>
									<xsl:value-of select="ows:Metadata/@xlink:title"/>
								</a>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="../Input">(Parámetro de entrada)</xsl:when>
							<xsl:otherwise>(Parámetro de salida)</xsl:otherwise>
						</xsl:choose>
						<xsl:text> </xsl:text>
<!-- Vull un retorn de carro després de l'abstract-->
						<li/>
					</xsl:if>
<!-- No tinc cap abstract igual ni abans ni després-->
					<xsl:if test="not(ows:Abstract = preceding::ows:Abstract) and not(ows:Abstract =following::ows:Abstract)">
						<xsl:text> </xsl:text>
						<b>/</b>
						<b>
							<xsl:value-of select="ows:Identifier"/>
						</b>
						<xsl:choose>
							<xsl:when test="LiteralData/ows:AllowedValues/ows:Value='##blank##'">
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:otherwise>=</xsl:otherwise>
						</xsl:choose>
						<xsl:text> </xsl:text>
						(<xsl:value-of select="ows:Title" disable-output-escaping="yes"/>)
						<xsl:text> </xsl:text>
						<xsl:value-of select="ows:Abstract" disable-output-escaping="yes"/>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="ows:Metadata/@xlink:href">
								<a>
									<xsl:attribute name="href"><xsl:value-of select="ows:Metadata/@xlink:href"/></xsl:attribute>
									<xsl:text> </xsl:text>
									<xsl:value-of select="ows:Metadata/@xlink:title"/>
								</a>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="../Input">(Parámetro de entrada)</xsl:when>
							<xsl:otherwise>(Parámetro de salida)</xsl:otherwise>
						</xsl:choose>
						<xsl:text> </xsl:text>
<!-- Vull un retorn de carro després de l'abstract-->
						<li/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>
<!--Fi Descripció Modificadors-->