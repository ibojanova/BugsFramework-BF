<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
				xmlns:o="urn:schemas-microsoft-com:office:office"
         xmlns:x="urn:schemas-microsoft-com:office:excel"
         xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
         xmlns:html="http://www.w3.org/TR/REC-html40"
>
    <xsl:output method="xml" indent="yes"/>

	<xsl:template match="/*">
		<xsl:processing-instruction name="mso-application">progid="Excel.Sheet"</xsl:processing-instruction>

        <Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet">
         <Styles>
          <Style ss:ID="Default" ss:Name="Normal">
           <Alignment ss:Vertical="Bottom"/>
           <Borders/>
           <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>
           <Interior/>
           <NumberFormat/>
           <Protection/>
          </Style>
          <Style ss:ID="Hyperlink" ss:Name="Hyperlink">
           <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#0563C1"
            ss:Underline="Single"/>
          </Style>
         </Styles>
         <Worksheet ss:Name="Sheet1">
          <Table>
           <Row>
            <Cell><Data ss:Type="String">KEV-cveID</Data></Cell>
            <Cell><Data ss:Type="String">NVD-CVSS</Data></Cell>
            <Cell><Data ss:Type="String">NVD-CWE</Data></Cell>
            <Cell><Data ss:Type="String">BF Class</Data></Cell>
            <Cell><Data ss:Type="String">Reference Files</Data></Cell>
            <Cell><Data ss:Type="String">Resources</Data></Cell>
            <Cell><Data ss:Type="String">NVD Link</Data></Cell>
            <Cell><Data ss:Type="String">Enough Information?</Data></Cell>
            <Cell><Data ss:Type="String">BF Ready to Describe It?</Data></Cell>
            <Cell><Data ss:Type="String">Is Open Source?</Data></Cell>
            <Cell><Data ss:Type="String">KEV-vendorProject</Data></Cell>
            <Cell><Data ss:Type="String">KEV-product</Data></Cell>
            <Cell><Data ss:Type="String">KEV-vulnerabilityName</Data></Cell>
            <Cell><Data ss:Type="String">KEV-dateAdded</Data></Cell>
            <Cell><Data ss:Type="String">KEV-shortDescription</Data></Cell>
           </Row>
			  
		    <xsl:apply-templates select="KEV/root/vulnerabilities/item"/>	  
          </Table>
         </Worksheet>
        </Workbook>
	
	</xsl:template>

	<xsl:key name="cve" match="KEVNVDBF/CVE" use="@Id"/>
	<xsl:key name="cwe" match="BFCWE//CWE" use="."/>

    <xsl:template match="*">
        <Row  xmlns="urn:schemas-microsoft-com:office:spreadsheet">
		<xsl:variable name="link" select="concat('https://nvd.nist.gov/vuln/detail/',cveID)"/>	
		<xsl:variable name="cve" select="key('cve',cveID)"/>

		<!--from KEV-->
        <Cell><Data ss:Type="String"><xsl:value-of select="cveID"/></Data></Cell>
		
		<!--from NVD-->
		<Cell><Data ss:Type="String"><xsl:value-of select="$cve//@baseScore"/></Data></Cell>
        <Cell><Data ss:Type="String"><xsl:value-of select="$cve/@CWE"/></Data></Cell>
        <Cell><Data ss:Type="String">
			<xsl:call-template name="multiple">
				<xsl:with-param name="values" select="key('cwe',substring-after($cve/@CWE,'-'))/parent::ClassOperation/@name"/>
				<xsl:with-param name="separator" select="' xANDx '"/>
			</xsl:call-template>
		</Data></Cell>
        <!--<Cell><Data ss:Type="String"><xsl:value-of select="key('cwe',substring-after($cve/@CWE,'-'))/../@name"/></Data></Cell>-->
			
        <!--<Cell><Data ss:Type="String"><xsl:value-of select="&eq; IFNA(VLOOKUP(A2,PREVIOUS!A:J,5, FALSE),'')"/></Data></Cell>-->		
	    <Cell><Data ss:Type="String">To be done</Data></Cell>		
	    <Cell><Data ss:Type="String">To be done</Data></Cell>

		<Cell ss:StyleID="Hyperlink" ss:HRef="{$link}">
			<Data ss:Type="String"><xsl:value-of select="$link"/></Data>
		</Cell>
			
		<Cell><Data ss:Type="String">To be done</Data></Cell>			
	    <Cell><Data ss:Type="String">To be done</Data></Cell>	
	    <Cell><Data ss:Type="String">To be done</Data></Cell>

		<!--from KEV-->
        <Cell><Data ss:Type="String"><xsl:value-of select="vendorProject"/></Data></Cell>
        <Cell><Data ss:Type="String"><xsl:value-of select="product"/></Data></Cell>
        <Cell><Data ss:Type="String"><xsl:value-of select="vulnerabilityName"/></Data></Cell>
        <Cell><Data ss:Type="String"><xsl:value-of select="dateAdded"/></Data></Cell>
        <Cell><Data ss:Type="String"><xsl:value-of select="shortDescription"/></Data></Cell>
        </Row>
    </xsl:template>

	<xsl:template name="multiple">
		<xsl:param name="values"/>
		<xsl:param name="separator" select="','"/>

		<xsl:for-each select="$values">
			<xsl:if test="position() > 1"><xsl:value-of select="$separator"/></xsl:if>
			<xsl:value-of select="."/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
