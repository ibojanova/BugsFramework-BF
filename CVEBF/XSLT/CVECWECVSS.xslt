<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/*">
		<xsl:element name="NVDBFKEV">
			<xsl:apply-templates select="CVE_Items/item" mode="cve"/>
		</xsl:element>
    </xsl:template>

	<xsl:template match="*" mode="cve">
		<xsl:element name="CVE">
			<xsl:attribute name="Id"><xsl:value-of select="cve/CVE_data_meta/ID"/></xsl:attribute>
			<xsl:attribute name="CWE"><xsl:value-of select="cve/problemtype/problemtype_data/item/description/item/value"/></xsl:attribute>
			<xsl:apply-templates select="impact/*[starts-with(local-name(),'baseMetricV')]" mode="score"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="*" mode="score">
		<xsl:copy>
			<xsl:attribute name="baseScore"><xsl:value-of select=".//baseScore"/></xsl:attribute>
			<xsl:attribute name="exploitabilityScore"><xsl:value-of select="exploitabilityScore"/></xsl:attribute>
			<xsl:attribute name="impactScore"><xsl:value-of select="impactScore"/></xsl:attribute>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
