<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<!--@author Irena Bojanova(ivb)
*@date - 6/20/2021 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
	xmlns:cwe="http://cwe.mitre.org/cwe-6" exclude-result-prefixes="msxsl cwe">
	
	<xsl:output method="xml" indent="yes"/>

	<xsl:param name="Clusters"/>
	<!-- change here to proper cluster -->
	<xsl:variable name="Cluster" select="$Clusters//Cluster[@Name='_DAT']"/>
	<!--<xsl:variable name="Cluster" select="$Clusters//Cluster[@Name='_MEM']"/>-->
	<!--<xsl:variable name="Cluster" select="$Clusters//Cluster[@Name='_INP' or @Name='_DAT' or @Name='_MEM']"/>-->
	<!--<xsl:variable name="Cluster" select="msxsl:node-set($Clusters)/Cluster[not(@Name='_ALL')]"/>-->

	<xsl:variable name="showClassCWEs" select="$Cluster/showClassCWEs"/>
	<xsl:variable name="showOtherCWEs" select="$Cluster/showOtherCWEs"/>
	<xsl:variable name="showConsequenceCWEs" select="$Cluster/showConsequenceCWEs"/>
	<xsl:variable name="showFinalErrorCWEs" select="$Cluster/showFinalErrorCWEs"/>
	<xsl:variable name="hideCWEs" select="$Cluster/hideCWEs"/>
	<xsl:variable name="classStyles" select="$Cluster/classStyles"/>
	<xsl:variable name="consequenceStyles" select="$Cluster/consequenceStyles"/>
		
	<xsl:include href="keep.xslt"/>

	<!--Read Me: 
	Set params: fromCurrentCWEBF (0 will start from emoty slide), updownDepth, showViews, nature; AND in _<clusterName>.xslt: showClassCWEs, $showConsequenceCWEs, and  hideCWEs, 
	Run with: 
		input cwec_vx.x.xml (https://cwe.mitre.org/data/xml/cwec_latest.xml.zip - download newst version from https://cwe.mitre.org/data/downloads.html >XML Content > ZIP)
		output CWEBF.xml
	Open CWEBF.xml in PowerPoint, SAVE AS CurrentCWEBF.xml and open again and rearrange node
	Run again with new set for param showXXXCWEs"
	Once finalized save "_<clusterName> - CWEBF.xml"-->
	
	<!-- IMPORTANT NOTE to attach arrows, open CWEBF.xml, save it, and open again
	arrows attached to nodes repair after upload to Google Drive - replace all "Google Shape.+" with "nodeCWE" -->

	<!--=======================reg exprs for manual fixes==============================================-->

	<!--
	(\d*)\r\n
	<CWE class="DVL">${0}</CWE>
	
	create regular pdf file:
	select figure in PPT
	copy/paste in Inkscape
	CTRL+Shift+D> Resize to Content
	save as .PDF, enter, Embed Fonts
	
	create pdf_tex file:
	copy figure from PPT in InkScape
	paste in InkScape 
	CTRL+Shift+D> Resize to Content
	and save as .svg (for Farhan to make html)
	save as .PDF, enter, Omit text from PDF (.pdf_tex for Overleaf)

	replace CWE # in pdf_tex 
		run RegEx project to make IDs into \cwelink{ID} and move first coordinate of IDs with 4 digits -0.005

	Clean colors
	Clean IEEEtrans, name.tex usenix2019 c99-main usenix-->

	<!--=================================================================================================-->

	<!--ALL CWEs: 
	in _BF.xslt
		<xsl:param name="Cluster" select="msxsl:node-set($Clusters)/Cluster[@Name='_ALL']"/>
	here:
		<xsl:param name="updownDepth" select="5"/>-->
	
	<!-- 0 - if all nodes are already known)-->	
	<xsl:param name="updownDepth" select="0"/>
	
	<!-- 1 - from slide 'CurrentCWEBF.xml'; NOTE: Uses the coordinates from Slide #2 :)-->
	<xsl:param name="fromCurrentCWEBF" select="1"/>
	
	<xsl:param name="showViews">
		<View>1000</View>
	</xsl:param>

	<!--PeerOf and CanPrecede arrows are not shows, as that causes StackOverflowException due to the recursion-->
	<xsl:param name="nature">
		<Nature>ChildOf</Nature>
		<!--<Nature>CanPrecede</Nature>
		<Nature>CanFollow</Nature>
		<Nature>CanAlsoBe</Nature>-->
		<!--<Nature>PeerOf</Nature>-->
	</xsl:param>
	
	<!--=================================================================================================-->
	
	<xsl:param name="mySlideWidth" select="51206400"/>
	<xsl:param name="mySlideHeight"  select="51206400"/>
	<xsl:param name="myBgClr"  select="c2c2d6"/>
	<xsl:param name="nodeRadius" select="500000"/>
	
	<!-- Node style depends on CWE Abstraction
	s=size, f=font; fs=font size; c=color, w=width; cm=compound; d=dash
	5 colors: pillar - red, Class - blue, Base - purple, Variant - green, Compound - yellow-->

	<!-- changes size for _DAT from 3600 to 3200-->
	<xsl:param name="nodeStyles">
		<Caption n="CWEs by Abstraction:" c="FFFFFF" u="sng" x="32117693" y="30852362"/>
		<CWEabstr n="Pillar" f="Calibri" fs="3200" c="7F7F7F" w="70000" cm="dbl" d="solid"/>
		<CWEabstr n="Class" f="Calibri" fs="3200" c="7F7F7F" w="70000" cm="sng"  d="sysDot"/>
		<CWEabstr n="Base" f="Calibri" fs="3200" c="7F7F7F" w="70000" cm="dbl" d="sysDot"/>
		<CWEabstr n="Variant" f="Calibri" fs="3600" c="7F7F7F" w="70000" cm="sng" d="solid"/>
		<CWEabstr n="Compound" f="Calibri" fs="3200" c="7F7F7F" w="70000" cm="thickThin" d="solid"/>
	</xsl:param>
	
	<!-- Arrow style depends on CWE Nature
	w=width, d=dash, h=head, t=tail -->
	<xsl:param name="arrowStyles">
		<!--<Caption n="CWEs Relation by Nature:" c="FFFFFF" u="sng" x="32117693" y="275852362"/>-->
		<CWEnature n="ChildOf" w="36700" d="solid" h="none" t="stealth"/>
		<CWEnature n="CanPrecede" w="36700" d="dash" h="none" t="stealth"/>
		<CWEnature n="CanFollow" w="36700" d="dash" h="none" t="stealth"/>
		<CWEnature n="CanAlsoBe" w="36700" d="dot" h="none" t="none"/>
		<CWEnature n="PeerOf" w="36700" d="dot" h="stealth" t="stealth"/>
	</xsl:param>

	<!-- ================= Generate Node -->

	<xsl:template name="selectCWEs">
		<xsl:param name="nodes"/>
		<xsl:param name="depth"/>
		<xsl:variable name="allX" select="$nodes | //cwe:Related_Weakness[@CWE_ID = $nodes/@ID][@View_ID=msxsl:node-set($showViews)/View][@Nature=msxsl:node-set($nature)/Nature]/ancestor::cwe:Weakness | //cwe:Weakness[@ID = $nodes//cwe:Related_Weakness[@View_ID=msxsl:node-set($showViews)/View][@Nature=msxsl:node-set($nature)/Nature]/@CWE_ID]"/>
		<xsl:variable name="all" select="$allX[not(@ID = msxsl:node-set($hideCWEs)/*)]"/>
		<xsl:choose>
			<xsl:when test="($depth &lt;= 0) or (count($nodes) = count($all))">
				<xsl:for-each select="$nodes">
					<W Id="{@ID}" A="{@Abstraction}" N="{@Name}" D="{*[name()='Description']}"> 
						<xsl:for-each select=".//cwe:Related_Weakness[@CWE_ID=$nodes/@ID][@Nature=msxsl:node-set($nature)/Nature][@View_ID=msxsl:node-set($showViews)/View]">
							<R Id="{@CWE_ID}" N="{@Nature}"/>
						</xsl:for-each>
					</W>									
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="selectCWEs">
					<xsl:with-param name="nodes" select="$all"/>
					<xsl:with-param name="depth" select="$depth - 1"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		
	<!-- all CWEs that are up/down to "updownDepth" from "showClassCWEs" excluding "hideCWEs" -->
	<xsl:variable name="myCWEs">
		<xsl:call-template name="selectCWEs">
			<xsl:with-param name="nodes" select="//cwe:Weakness[@ID = msxsl:node-set($showClassCWEs)//CWE]"/>
			<xsl:with-param name="depth" select="$updownDepth"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:template name="splitNodesByLevel_OLD">
		<xsl:param name="available"/>
		<xsl:for-each select="msxsl:node-set($nodeStyles)/*">
			<Level> <xsl:copy-of select="$available[@A=current()/@n]"/> </Level>
		</xsl:for-each>
	</xsl:template>

	<!-- PPP start -->

	<xsl:template name="splitNodesByLevel">
		<xsl:param name="available"/>

		<xsl:variable name="hierarchy">
			<xsl:call-template name="splitNodesInHierarchy">
				<xsl:with-param name="available" select="$available"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:call-template name="HierarchyToLevels">
			<xsl:with-param name="available" select="$available"/>
			<xsl:with-param name="level" select="msxsl:node-set($hierarchy)/*"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="HierarchyToLevels">
		<xsl:param name="available"/>
		<xsl:param name="level"/>

		<xsl:if test="$level">
			<Level>
				<xsl:for-each select="$level/@Id">
					<xsl:copy-of select="$available[@Id = current()]"/>
				</xsl:for-each>
				<!--<xsl:copy-of select="$available[@Id = $level/@Id]"/>-->
			</Level>
			<xsl:call-template name="HierarchyToLevels">
				<xsl:with-param name="available" select="$available"/>
				<xsl:with-param name="level" select="$level/*"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	
	<xsl:template name="splitNodesInHierarchy">
		<xsl:param name="available"/>

		<xsl:variable name="roots" select="$available[not(R)]/@Id"/>
		<xsl:variable name="linksByLevel">
			<xsl:call-template name="linksByLevel">
				<xsl:with-param name="parents" select="$roots"/>
				<xsl:with-param name="available" select="$available"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="$roots" mode="hierarchy">
			<xsl:with-param name="links" select="msxsl:node-set($linksByLevel)//Link[not(@To = following::Link/@To)]"/>
		</xsl:apply-templates>		
	</xsl:template>

	<xsl:template match="@*" mode="hierarchy">
		<xsl:param name="links"/>
		<CWE Id="{.}">
			<xsl:apply-templates select="$links[@From=current()]/@To" mode="hierarchy">
				<xsl:with-param name="links" select="$links"/>
			</xsl:apply-templates>
		</CWE>
	</xsl:template>	

	<xsl:template name="linksByLevel">
		<xsl:param name="available"/>
		<xsl:param name="parents"/>

		<xsl:variable name="level" select="$available/R[@Id = $parents]"/>
		<xsl:if test="$level">
			<Level>
				<xsl:for-each select="$level">
					<xsl:sort select="@Id"/>
					<Link From="{@Id}" To="{../@Id}"/>
				</xsl:for-each>
			</Level>
			<xsl:call-template name="linksByLevel">
				<xsl:with-param name="parents" select="$level/../@Id"/>
				<xsl:with-param name="available" select="$available"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- PPP end -->



	<xsl:variable name="myCWEsByLevel">
		<xsl:call-template name="splitNodesByLevel">
			<xsl:with-param name="available" select="msxsl:node-set($myCWEs)/*"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="myNodes">
		<xsl:call-template name="calcNodesCoordinates">
			<xsl:with-param name="levels" select="msxsl:node-set($myCWEsByLevel)/*"/>
			<xsl:with-param name="dX" select="$mySlideWidth"/>
			<xsl:with-param name="dY" select="$mySlideHeight"/>
		</xsl:call-template>
	</xsl:variable>
				
	<xsl:template name="calcNodesCoordinates">
		<xsl:param name="levels"/>
		<xsl:param name="dX"/>
		<xsl:param name="dY"/>
		<xsl:variable name="countY" select="count($levels)"/>
		<xsl:for-each select="$levels">
			<xsl:variable name="posY" select="position()"/>
			<xsl:variable name="countX" select="count(*)"/>
			<xsl:for-each select="*">
				<xsl:variable name="keepNode" select="msxsl:node-set($keepNodes)//*[@Id=current()/@Id]"/>
				<Coordinates>
					<xsl:choose>
						<xsl:when test="$keepNode">
							<xsl:copy-of select="$keepNode/@x | $keepNode/@y"/>							
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="posX" select="position()"/>
							<xsl:attribute name="x"><xsl:value-of select="round(($posX - 0.5)*$dX div $countX)"/></xsl:attribute>
							<xsl:attribute name="y"><xsl:value-of select="round(($posY - 0.5)*$dY div $countY)"/></xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:copy-of select="."/>
				</Coordinates>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>	
	
	<xsl:template mode="drawNodes" match="*">
		<xsl:param name="useClassStyle"/>
		<xsl:variable name="nodeCoordinates" select="ancestor::Coordinates"/>
		<xsl:variable name="nodeStyle" select="msxsl:node-set($nodeStyles)/*[@n=current()/@A]"/>
		<xsl:variable name="attr">
			<xsl:choose>
				<xsl:when test="$useClassStyle">
					<xsl:variable name="class" select="msxsl:node-set($showClassCWEs)/*[CWE=current()/@Id]/@name"/>
					<xsl:variable name="other" select="msxsl:node-set($showOtherCWEs)/*[CWE=current()/@Id]/@name"/>
					<xsl:copy-of select="msxsl:node-set($classStyles)/*[(@n = $class) or (@n = $other)]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="consequence" select="msxsl:node-set($showConsequenceCWEs)/*[CWE=current()/@Id]/@name"/>
					<xsl:copy-of select="msxsl:node-set($consequenceStyles)/*[@n = $consequence]"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="outlineColor">
			<xsl:choose>
				<xsl:when test="msxsl:node-set($attr)//@c"><xsl:copy-of select="msxsl:node-set($attr)//*[@c]"/></xsl:when>
				<xsl:otherwise><x c="C8C8DA"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--<xsl:variable name="zzz" select="count(msxsl:node-set($outlineColor)//@c)"/>-->
		<xsl:variable name="fillColor" select="msxsl:node-set($attr)//@fill[1]"/>
		<xsl:variable name="fontColor" select="msxsl:node-set($attr)//@fc[1]"/>
	
		<xsl:variable name="id" select="@Id"/>
			
		<xsl:for-each select="msxsl:node-set($outlineColor)//*">
			<xsl:variable name="radius" select="$nodeRadius + (position()-1)*80000"/>
				
			<p:sp xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">			
				<!--node id & name-->
					<p:nvSpPr> <p:cNvPr id="{$id*10 + position()}" name="nodeCWE"/> <p:cNvSpPr/> <p:nvPr/> </p:nvSpPr>
					<p:spPr>
						<!--node coordinates -->
						<a:xfrm> <a:off x="{$nodeCoordinates/@x -$radius}" y="{$nodeCoordinates/@y -$radius}"/> <a:ext cx="{2*$radius}" cy="{2*$radius}"/>	</a:xfrm>
						<a:prstGeom prst="ellipse"/>
						<xsl:if test="$fillColor"><a:solidFill><a:srgbClr val="{$fillColor}"/></a:solidFill></xsl:if>
						<a:ln w="{$nodeStyle/@w}" cmpd="{$nodeStyle/@cm}"> <a:solidFill> <a:srgbClr val="{@c}"/> </a:solidFill> <a:prstDash val="{$nodeStyle/@d}"/> </a:ln>
					</p:spPr>
					<xsl:if test="position()=last()">
						<p:txBody>
							<!--node text margins , center-->
							<a:bodyPr lIns="0" tIns="0" rIns="0" bIns="0" rtlCol="0" anchor="ctr"/> <a:lstStyle/>
							<!--node with hyperlink-->
							<a:p> <a:pPr algn="ctr"/> <a:r> <a:rPr sz="{2700 + 900*($id &lt; 1000)}">
								<a:solidFill><a:srgbClr val="{$fontColor}"/>
								</a:solidFill><!--<a:hlinkClick r:id="link{@Id}"/>-->
								</a:rPr> <a:t> <xsl:value-of select="$id"/> </a:t> </a:r> </a:p>
						</p:txBody>
					</xsl:if>			
			</p:sp>			
		</xsl:for-each>

	</xsl:template>
	
	<!-- ================= Generate Arrow -->

	<!-- Draw arrow -->
	<xsl:template mode="drawArrows" match="*">
		<xsl:variable name="arrowStyle" select="msxsl:node-set($arrowStyles)/*[@n=current()/@N]"/>
		<p:cxnSp xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
			<!--connector-->
			<xsl:variable name="conn">
				<!--calculate connector-->
				<xsl:call-template name="calcArrowCoordinates">
					<xsl:with-param name="parent" select="ancestor::Coordinates"/>
					<xsl:with-param name="child" select="msxsl:node-set($myNodes)/*[*/@Id = current()/@Id]"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="connector" select="msxsl:node-set($conn)/*"/>
			<p:nvCxnSpPr>
				<p:cNvPr id="{position()}" name="arrowConnector"/>
				<!-- node connectors, idx = connectors-->
				<p:cNvCxnSpPr>
					<a:stCxn id="{@Id*10+1}" idx="{$connector/@c}"/>
					<a:endCxn id="{../@Id*10+1}" idx="{($connector/@c+4) mod 8}"/>
				</p:cNvCxnSpPr>
				<p:nvPr/>
			</p:nvCxnSpPr>
			<p:spPr>
				<a:xfrm flipH="{$connector/@h}" flipV="{$connector/@v}"> <a:off x="{$connector/@x}" y="{$connector/@y}"/> <a:ext cx="{$connector/@cx}" cy="{$connector/@cy}"/> </a:xfrm>
				<a:prstGeom prst="straightConnector1"> </a:prstGeom><a:avLst/>
				<!-- arrow width, dash, head, tail-->
				<a:ln w="{$arrowStyle/@w}"> <a:solidFill> <a:schemeClr val="tx1"/> </a:solidFill> <a:prstDash val="{$arrowStyle/@d}"/> <a:headEnd type="{$arrowStyle/@h}" w="lg" len="lg"/> <a:tailEnd type="{$arrowStyle/@t}" w="lg" len="lg"/> </a:ln>
			</p:spPr>
		</p:cxnSp>
	</xsl:template>

	<!-- Calculate arrow: node connectors, coordinates -->
	<xsl:variable name="coef45" select="0.7071067811865475"/>
	<xsl:variable name="coef225" select="0.4142135623730950488016887242097"/>
	<xsl:variable name="coef675" select="2.4142135623730950488016887242097"/>
	<xsl:template name="calcArrowCoordinates">
		<xsl:param name="parent"/>
		<xsl:param name="child"/>
		<!-- calculate arrow nodes connectors -->
		<xsl:variable name="dx" select="$parent/@x - $child/@x"/>
		<xsl:variable name="dy" select="$parent/@y - $child/@y"/>
		<xsl:variable name="tan" select="$dy div $dx"/>
		<xsl:variable name="c">
			<xsl:choose>
				<xsl:when test="$tan &lt; -$coef675">0</xsl:when>
				<xsl:when test="$tan &lt; -$coef225">7</xsl:when>
				<xsl:when test="$tan &lt; $coef225">6</xsl:when>
				<xsl:when test="$tan &lt; $coef675">5</xsl:when>
				<xsl:otherwise>4</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="conn">
			<xsl:choose>
				<xsl:when test="$dx >= 0"> <xsl:value-of select="$c"/> </xsl:when>
				<xsl:otherwise> <xsl:value-of select="($c + 4) mod 8"/> </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="cx">
			<xsl:choose>
				<xsl:when test="$conn=2">-1</xsl:when>
				<xsl:when test="$conn=1 or $conn=3"> <xsl:value-of select="-$coef45"/> </xsl:when>
				<xsl:when test="$conn=0 or $conn=4">0</xsl:when>
				<xsl:when test="$conn=5 or $conn=7"> <xsl:value-of select="$coef45"/> </xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="cy">
			<xsl:choose>
				<xsl:when test="$conn=0">-1</xsl:when>
				<xsl:when test="$conn=1 or $conn=7"> <xsl:value-of select="-$coef45"/> </xsl:when>
				<xsl:when test="$conn=2 or $conn=6">0</xsl:when>
				<xsl:when test="$conn=3 or $conn=5"> <xsl:value-of select="$coef45"/> </xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- calculate arrow coordinates -->
		<xsl:variable name="startX" select="$child/@x +round($nodeRadius*$cx)"/>
		<xsl:variable name="startY" select="$child/@y +round($nodeRadius*$cy)"/>
		<xsl:variable name="endX" select="$parent/@x -round($nodeRadius*$cx)"/>
		<xsl:variable name="endY" select="$parent/@y -round($nodeRadius*$cy)"/>
		<xsl:variable name="x">
			<xsl:choose>
				<xsl:when test="$startX > $endX"> <xsl:value-of select="$endX"/> </xsl:when>
				<xsl:otherwise> <xsl:value-of select="$startX"/> </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="y">
			<xsl:choose>
				<xsl:when test="$startY > $endY"> <xsl:value-of select="$endY"/> </xsl:when>
				<xsl:otherwise> <xsl:value-of select="$startY"/> </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="h">
			<xsl:choose>
				<xsl:when test="$child/@x > $parent/@x">1</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="v">
			<xsl:choose>
				<xsl:when test="$child/@y > $parent/@y">1</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<arrow c="{$conn}" x="{$x}" y="{$y}" cx="{$endX+$startX -$x*2}" cy="{$endY+$startY -$y*2}" h="{$h}" v="{$v}"/>
	</xsl:template>

	<!-- =================  Generate legend -->
	<xsl:param name="legendTextSize" select="3600"/>
	
	<xsl:template mode="drawLegendTable" match="*">
		<!--<xsl:variable name="nodeStyle" select="msxsl:node-set($nodeStyles)/*[@n=current()/@A]"/>-->
		<xsl:variable name="highlight" select="@Id = msxsl:node-set($showClassCWEs)//CWE"/>
		<xsl:variable name="class" select="msxsl:node-set($Clusters)//showClassCWEs//CWE[.=current()/@Id]/../@name"/>
		<a:tr h="370840" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
			<a:tc> <a:txBody><a:bodyPr/> <a:p> <a:r>
				<a:rPr sz="{$legendTextSize}"> <a:hlinkClick r:id="{concat('link',@Id)}"/></a:rPr>	
				<a:t>CWE-<xsl:value-of select="@Id"/></a:t> </a:r> </a:p> </a:txBody> <a:tcPr/> </a:tc>
			<a:tc> <a:txBody><a:bodyPr/> <a:p> <a:r> 
				<a:rPr sz="{$legendTextSize}"> <xsl:if test="$highlight"> <a:highlight> <a:schemeClr val="accent1"/> </a:highlight> </xsl:if> </a:rPr>
				<a:t> <xsl:value-of select="@N"/> </a:t> </a:r> </a:p> </a:txBody> <a:tcPr/> </a:tc>
			<!--<a:tc> <a:txBody><a:bodyPr/> <a:p> <a:r> 
				<a:rPr sz="{$legendTextSize}"> <xsl:if test="$highlight"> <a:highlight> <a:schemeClr val="accent1"/> </a:highlight> </xsl:if> </a:rPr>
				<a:t> <xsl:value-of select="@D"/> </a:t> </a:r> </a:p> </a:txBody> <a:tcPr/> </a:tc>-->
			<a:tc> <a:txBody><a:bodyPr/> <a:p><a:r> 
				<a:rPr sz="{$legendTextSize}"> <xsl:if test="$highlight"> <a:highlight> <a:schemeClr val="accent1"/> </a:highlight> </xsl:if> </a:rPr>
				<a:t> <xsl:for-each select="$class"><xsl:value-of select="."/><xsl:if test="position()&lt;last()"><xsl:value-of select="'  xANDx  '"/></xsl:if></xsl:for-each> </a:t> </a:r> </a:p> </a:txBody> </a:tc>
		</a:tr>
	</xsl:template>
	
	<xsl:template mode="drawLegendNodes" match="*">
		<xsl:variable name="caption" select="(. | preceding-sibling::*)[self::Caption][last()]"/>
		<xsl:variable name="pos" select="count(preceding-sibling::*) - count($caption/preceding-sibling::*)"/>

		<xsl:variable name="captionOff">
			<xsl:choose>
				<xsl:when test="self::Caption">780474</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<p:grpSp xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
			<p:nvGrpSpPr>
				<p:cNvPr id="0" name="GroupLegendNode"> </p:cNvPr> <p:cNvGrpSpPr/> <p:nvPr/>
			</p:nvGrpSpPr>
			<p:grpSpPr>
				<a:xfrm>
					<a:off x="{$caption/@x}" y="{$caption/@y + 1200000*$pos}"/> <a:ext cx="5047523" cy="1200329"/> 
					<a:chOff x="30772678" y="44240717"/> <a:chExt cx="5047523" cy="1200329"/>
				</a:xfrm>
			</p:grpSpPr>
			<p:sp>
				<p:nvSpPr> <p:cNvPr id="{position()}" name="legendNode"></p:cNvPr> <p:cNvSpPr/> <p:nvPr/> </p:nvSpPr>
					<p:spPr>
						<a:xfrm> <a:off x="30772678" y="{44366120 - $captionOff}"/> <a:ext cx="1000000" cy="1000000"/> </a:xfrm>
						<!--<xsl:if test="not (self::Caption)">-->
						<!--IMPORTANT: Maybe: Need to draw a node for the Caption for proper alignment of the captions on the .pdf_tex-->
								<a:prstGeom prst="ellipse"> </a:prstGeom>
								<xsl:if test="@fill"><a:solidFill><a:srgbClr val="{@fill}"/></a:solidFill></xsl:if>
								<xsl:variable name="w">
									<xsl:choose><xsl:when test="@w"><xsl:value-of select="@w"/></xsl:when>
									<xsl:otherwise>70000</xsl:otherwise></xsl:choose>
								</xsl:variable>
								<xsl:variable name="cm">
									<xsl:choose><xsl:when test="@cm"><xsl:value-of select="@cm"/></xsl:when>
									<xsl:otherwise>sng</xsl:otherwise></xsl:choose>
								</xsl:variable>
								<a:ln w="{$w}" cmpd="{$cm}">
									<xsl:if test="@c"><a:solidFill><a:srgbClr val="{@c}"/></a:solidFill></xsl:if>
									<xsl:if test="@d"><a:prstDash val="{@d}"/></xsl:if>
								</a:ln>		
						<!--</xsl:if>-->
					</p:spPr>
				<!--<p:txBody>
					<a:bodyPr lIns="0" tIns="0" rIns="0" bIns="0" rtlCol="0" anchor="ctr"/>
					<a:lstStyle/>
					<a:p>
						<a:pPr algn="ctr"/>
						<xsl:if test="@fs">
							<a:r><a:rPr sz="{@fs}"></a:rPr><a:t>359</a:t>
						</a:r>
					</xsl:if>
					</a:p>
				</p:txBody>-->
			</p:sp>
			<p:sp>
				<p:nvSpPr> <p:cNvPr id="{position()}" name="legendNodeTextBox"> </p:cNvPr> <p:cNvSpPr/> <p:nvPr/> </p:nvSpPr>
				<p:spPr> <a:xfrm> <a:off x="{32225704 - 2*$captionOff}" y="44490717"/> <a:ext cx="5047523" cy="1200329"/> </a:xfrm> </p:spPr>
				<p:txBody><a:bodyPr/><a:p> <a:r>
					<a:rPr sz="{$legendTextSize}"><xsl:if test="@u"><xsl:attribute name="u"><xsl:value-of select="@u"/></xsl:attribute></xsl:if> </a:rPr>
					<a:t> <xsl:value-of select="@n"/> </a:t> </a:r> </a:p> 
				</p:txBody>
			</p:sp>
		</p:grpSp>
	</xsl:template>
	
	<xsl:template mode="drawLegendArrows"  match="*">
		<p:grpSp xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
			<p:nvGrpSpPr> <p:cNvPr id="0" name="GroupLegendArrow"> </p:cNvPr> <p:cNvGrpSpPr/> <p:nvPr/>
			</p:nvGrpSpPr>
			<p:grpSpPr>
				<a:xfrm> <a:off x="45084193" y="{0 + 1200000*position()}"/> <a:ext cx="7892988" cy="1200329"/> <a:chOff x="38295200" y="44240717"/> <a:chExt cx="7892988" cy="1200329"/> </a:xfrm>
			</p:grpSpPr>
			<p:cxnSp>
				<p:nvCxnSpPr> <p:cNvPr id="{position()}" name="legendArrow"> </p:cNvPr> <p:cNvCxnSpPr> <a:cxnSpLocks/> </p:cNvCxnSpPr> <p:nvPr/> </p:nvCxnSpPr>
				<p:spPr>
					<a:xfrm flipV="1"> <a:off x="38295200" y="{44366120 + 100*position()}"/> <a:ext cx="2839761" cy="834290"/> </a:xfrm>
					<a:prstGeom prst="straightConnector1"> </a:prstGeom>
					<a:ln w="{@w}"> <a:solidFill> <a:schemeClr val="tx1" /> </a:solidFill> <a:prstDash val="{@d}"/> <a:headEnd type="{@h}" w="lg" len="lg"/> <a:tailEnd type="{@t}" w="lg" len="lg"/> </a:ln>
				</p:spPr>
			</p:cxnSp>
			<p:sp>
				<p:nvSpPr> <p:cNvPr id="{position()}" name="legendArrowTextBox"> </p:cNvPr> <p:cNvSpPr/> <p:nvPr/> </p:nvSpPr>
				<p:spPr> <a:xfrm> <a:off x="41735458" y="44240717"/> <a:ext cx="4452730" cy="1200329"/> </a:xfrm> </p:spPr>
				<p:txBody><a:bodyPr/><a:p> <a:r> <a:rPr  sz="{$legendTextSize}"/> <a:t><xsl:value-of select="@n"/></a:t> </a:r> </a:p></p:txBody>
			</p:sp>
		</p:grpSp>
	</xsl:template>
	
	
	
	<!-- ================ PPT slide -->

	<xsl:include href="ppt.xslt"/>
	<xsl:template match="/">
		<xsl:processing-instruction name="mso-application">progid="PowerPoint.Show"</xsl:processing-instruction>		
		<pkg:package xmlns:pkg="http://schemas.microsoft.com/office/2006/xmlPackage">
			<xsl:call-template name="Slide"/>
			
			<xsl:call-template name="SlideContent">
				<xsl:with-param name="slideNumber" select="1"/>
				<xsl:with-param name="styles" select="$classStyles" />
				<xsl:with-param name="useClassStyle" select="1"/>
			</xsl:call-template>

			<xsl:call-template name="SlideContent">
				<xsl:with-param name="slideNumber" select="2"/>
				<xsl:with-param name="styles" select="$consequenceStyles" />
				<xsl:with-param name="useClassStyle" select="0"/>
			</xsl:call-template>
			 			
			<xsl:call-template name="PowerPointStatic"/>
		</pkg:package>
	</xsl:template>

	<xsl:template match="/test">
		<root>
			<ppp>
				<xsl:copy-of select="msxsl:node-set($myCWEsByLevel)"/>
			</ppp>
		</root>
	</xsl:template>

</xsl:stylesheet>
