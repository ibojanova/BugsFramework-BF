
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="xml" indent="yes"/>

	<xsl:param name="Clusters"/>
	<!--<xsl:variable name="Cluster" select="$Clusters//Cluster[@Name='_DTC']"/>-->
	<!--<xsl:variable name="Cluster" select="$Clusters//Cluster[@Name='_INP' or @Name='_DTC' or @Name='_MEM']"/>-->
	<xsl:variable name="Cluster" select="msxsl:node-set($Clusters)/Cluster[not(@Name='_ALL')]"/>

	<xsl:variable name="cwe" select="/CVECWE-NVD/CWE"/>

	<xsl:template match="/*">
		<xsl:copy>
			<xsl:apply-templates select="$Cluster" mode="cluster"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*" mode="cluster">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates select="showClassCWEs/* | showOtherCWEs/* | showConsequenceCWEs/*" mode="overParam"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@* | node()" mode="overParam">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" mode="overParam"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template mode="overParam" match="CWE">	
		<xsl:copy>
			<xsl:attribute name="Id"><xsl:value-of select="."/></xsl:attribute>
			<xsl:copy-of select="$cwe[@Id = concat('CWE-',current())]/*"/>		
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>


