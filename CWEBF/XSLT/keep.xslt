<!--@author Irena Bojanova(ivb)
*@date - 6/20/2021 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

	<xsl:variable name="keepNodes">
		<xsl:if test="$fromCurrentCWEBF">
			<!--<xsl:for-each select="document('../XML/CurrentCWEBF.xml')//pkg:part[@pkg:name='/ppt/slides/slide1.xml']//p:sp[p:nvSpPr/p:cNvPr[@name='nodeCWE']]" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"  xmlns:pkg="http://schemas.microsoft.com/office/2006/xmlPackage">-->
			<xsl:for-each select="document('../../_DB/CWEBF/CurrentCWEBF.xml')//pkg:part[@pkg:name='/ppt/slides/slide1.xml']//p:sp[p:nvSpPr/p:cNvPr[@name='nodeCWE']]" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"  xmlns:pkg="http://schemas.microsoft.com/office/2006/xmlPackage">
				<xsl:variable name="id" select="p:txBody/a:p/a:r/a:t"/>
				<xsl:variable name="coord" select="p:spPr/a:xfrm/a:off"/>
				<xsl:variable name="size" select="p:spPr/a:xfrm/a:ext"/>
				<KeepNode Id="{$id}" x="{round($coord/@x + $size/@cx div 2)}" y="{round($coord/@y + $size/@cy div 2)}"/>
				<!--<xsl:apply-templates select="." mode="keep"><xsl:with-param name="id" select="$id"/></xsl:apply-templates>
				</KeepNode>-->
			</xsl:for-each>
		</xsl:if>
	</xsl:variable>

	<xsl:template match="@* | * | text()[normalize-space()]" mode="keep">
		<xsl:param name="id"/>
		<xsl:copy>
			<xsl:apply-templates select="@* | * | text()[normalize-space()]" mode="keep">
				<xsl:with-param name="id" select="$id"/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="p:cNvPr[@name='nodeCWE']/@id" mode="keep" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
		<xsl:param name="id"/>
		<xsl:attribute name="{name()}">
			<xsl:value-of select="$id"/>
		</xsl:attribute>
	</xsl:template>
	
	<xsl:template match="p:cNvPr[@name='legendNodeTextBox']/@text" mode="keep" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
		<xsl:param name="text"/>
		<xsl:attribute name="{name()}">
			<xsl:value-of select="$text"/>
		</xsl:attribute>
	</xsl:template>

	<!--xxxlinks-->
	<!--<xsl:template match="a:hlinkClick/@r:id" mode="keep" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
		<xsl:param name="id"/>
		<xsl:attribute name="{name()}"><xsl:value-of select="concat('link',$id)"/></xsl:attribute>
	</xsl:template>-->

	<!--<xsl:template match="a:ln/a:solidFill/a:srgbClr/@val" mode="keep" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
		<xsl:param name="id"/>
		<xsl:variable name="class" select="msxsl:node-set($showCWEs)/*[.=$id]/@class"/>
		<xsl:variable name="color" select="msxsl:node-set($classStyles)/*[name()=$class]/@c"/>
		<xsl:attribute name="{name()}">
			<xsl:choose>
				<xsl:when test="$color">
					<xsl:value-of select="$color"/>
				</xsl:when>
				<xsl:otherwise>c2c2d6</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>-->

	<!--Fig. 4 - _INP-->
	<!--<xsl:template match="a:ln/a:solidFill/a:srgbClr/@val" mode="keep" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
		<xsl:param name="id"/>
		<xsl:variable name="class" select="msxsl:node-set($showCWEs)/*[.=$id]/@class"/>
		<xsl:variable name="color" select="msxsl:node-set($classStyles)/*[name()=$class]/@c"/>
		<xsl:attribute name="{name()}">
			<xsl:choose>
				<xsl:when test="$color">
					<xsl:value-of select="$color"/>
				</xsl:when>
				<xsl:otherwise>002774</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>-->

	<!--Fig. 5 - _INP-->
	<!--($showClassCWEs)//CWE-->
	<!--<xsl:template match="a:ln/a:solidFill/a:srgbClr/@val" mode="keep" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
		<xsl:param name="id"/>
		<xsl:variable name="consequence" select="msxsl:node-set($showCWEs)/*[.=$id]/@consequence"/>
		<xsl:variable name="color" select="msxsl:node-set($consequenceStyles)/*[name()=$consequence]/@c"/>
		<xsl:attribute name="{name()}">
			<xsl:choose>
				<xsl:when test="$color">
					<xsl:value-of select="$color"/>
				</xsl:when>
				<xsl:otherwise>c2c2d6</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>-->

	<!--<xsl:template match="a:extLst" mode="keep" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"/>-->

</xsl:stylesheet>
