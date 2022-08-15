<!--@author Irena Bojanova(ivb)
*@date - 6/20/2021 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

	<xsl:template name="Slide" xmlns:pkg="http://schemas.microsoft.com/office/2006/xmlPackage">
        <pkg:part pkg:name="/ppt/presentation.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml">
        <pkg:xmlData>
            <p:presentation xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main" saveSubsetFonts="1">
            <p:sldMasterIdLst> <p:sldMasterId id="2147483648" r:id="rId1"/> </p:sldMasterIdLst>
            <p:sldIdLst> <p:sldId id="256" r:id="rId2"/> <p:sldId id="258" r:id="rId4"/> </p:sldIdLst>
            <p:sldSz cx="{$mySlideWidth}" cy="{$mySlideHeight}"/>
            <p:notesSz cx="6858000" cy="9144000"/>
            </p:presentation>
        </pkg:xmlData>
        </pkg:part>		
	</xsl:template>
	
    <xsl:template name="SlideContent" xmlns:pkg="http://schemas.microsoft.com/office/2006/xmlPackage">
        <xsl:param name="slideNumber"/>
        <xsl:param name="styles"/>
        <xsl:param name="useClassStyle"/>
        <pkg:part pkg:name="{concat('/ppt/slides/slide', $slideNumber,'.xml')}" pkg:contentType="application/vnd.openxmlformats-officedocument.presentationml.slide+xml">
            <pkg:xmlData> 
				<p:sld xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
                    <p:cSld>
                        <p:spTree>
                            <p:nvGrpSpPr> <p:cNvPr id="1" name=""/> <p:cNvGrpSpPr/> <p:nvPr/> </p:nvGrpSpPr>
                            <p:grpSpPr> <a:xfrm> <a:off x="0" y="0"/> <a:ext cx="0" cy="0"/> <a:chOff x="0" y="0"/> <a:chExt cx="0" cy="0"/> </a:xfrm> </p:grpSpPr>
			  
 			                <!-- Generate nodes and arrows from cwec_vx.x.xml-->
			                <xsl:apply-templates mode="drawNodes" select="msxsl:node-set($myNodes)//W">
			                    <xsl:with-param name="useClassStyle" select="$useClassStyle"/>
			                </xsl:apply-templates>
			                <xsl:apply-templates mode="drawArrows" select="msxsl:node-set($myNodes)//R"/>
								
			                <!-- Generate legend kinds of nodes, kinds of arrows-->
							<xsl:apply-templates mode="drawLegendNodes" select="msxsl:node-set($styles)/* | msxsl:node-set($nodeStyles)/*" />
			                <!--<xsl:apply-templates mode="drawLegendArrows" select="msxsl:node-set($arrowStyles)"/>-->
								
			                <!-- Generate legend table of CWEs-->
			                <p:graphicFrame>
				                <p:nvGraphicFramePr> <p:cNvPr id="{position()}" name="tableCWEs"/> <p:cNvGraphicFramePr> <a:graphicFrameLocks noGrp="1"/> </p:cNvGraphicFramePr> <p:nvPr/> </p:nvGraphicFramePr>
					                <p:xfrm> <a:off x="1025648" y="41602875"/> <a:ext cx="28491199" cy="7955280"/> </p:xfrm>
					                <a:graphic>
						                <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/table">
							                <a:tbl> <a:tblGrid> <a:gridCol w="1948834"/> <a:gridCol w="9230333"/> <a:gridCol w="30312032"/> <a:gridCol w="9230333"/> </a:tblGrid>
								                <a:tr h="370840">
									                <a:tc> <a:txBody> <a:bodyPr/> <a:p> <a:r> <a:rPr sz="{$legendTextSize}" b="1"/> <a:t>CWEs (#<xsl:value-of select="count(msxsl:node-set($myNodes)//W)"/>)</a:t> </a:r> </a:p> </a:txBody> <a:tcPr/> </a:tc>
									                <a:tc> <a:txBody> <a:bodyPr/> <a:p> <a:r> <a:rPr sz="{$legendTextSize}" b="1"/> <a:t>Name</a:t> </a:r> </a:p> </a:txBody> <a:tcPr/> </a:tc>
									                <a:tc> <a:txBody> <a:bodyPr/> <a:p> <a:r> <a:rPr sz="{$legendTextSize}" b="1"/> <a:t>Description</a:t> </a:r> </a:p> </a:txBody> <a:tcPr/> </a:tc>
									                <a:tc> <a:txBody> <a:bodyPr/> <a:p> <a:r> <a:rPr sz="{$legendTextSize}" b="1"/> <a:t>BF Class Operation</a:t> </a:r> </a:p> </a:txBody> <a:tcPr/> </a:tc>
								                </a:tr>
												<xsl:apply-templates mode="drawLegendTable" select="msxsl:node-set($myNodes)//W"><xsl:sort select="@Id" data-type="number"/></xsl:apply-templates>
							                </a:tbl>
						                </a:graphicData>
					                </a:graphic>
				                </p:graphicFrame>
                          </p:spTree>
                    </p:cSld>
                    <p:clrMapOvr> <a:masterClrMapping/> </p:clrMapOvr>
                </p:sld>
             </pkg:xmlData>
        </pkg:part>
		
        <pkg:part pkg:name="{concat('/ppt/slides/_rels/slide', $slideNumber,'.xml.rels')}" pkg:contentType="application/vnd.openxmlformats-package.relationships+xml">
            <pkg:xmlData>		
                <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
                    <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout1.xml"/>
		            <!-- Generate hyperlink for CWE-->
		            <xsl:for-each select="msxsl:node-set($myCWEs)/*">
    		            <Relationship Id="link{@Id}" Target="https://cwe.mitre.org/data/definitions/{@Id}.html" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" TargetMode="External" xmlns="http://schemas.openxmlformats.org/package/2006/relationships"/>
		            </xsl:for-each>
	            </Relationships>		
            </pkg:xmlData>
        </pkg:part>		
	</xsl:template>
	
	<xsl:template name="PowerPointStatic" xmlns:pkg="http://schemas.microsoft.com/office/2006/xmlPackage">
      <pkg:part pkg:name="/_rels/.rels" pkg:contentType="application/vnd.openxmlformats-package.relationships+xml" pkg:padding="512">
        <pkg:xmlData>
          <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
            <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="ppt/presentation.xml"/>
          </Relationships>
        </pkg:xmlData>
      </pkg:part>
      <pkg:part pkg:name="/ppt/_rels/presentation.xml.rels" pkg:contentType="application/vnd.openxmlformats-package.relationships+xml" pkg:padding="256">
        <pkg:xmlData>
          <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
            <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide1.xml"/>
			<Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide2.xml"/>
            <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="slideMasters/slideMaster1.xml"/>
            <Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/>
          </Relationships>
        </pkg:xmlData>
      </pkg:part>
      <pkg:part pkg:name="/ppt/slideMasters/slideMaster1.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml">
        <pkg:xmlData>
          <p:sldMaster xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
            <p:cSld>
              <p:bg> <p:bgRef idx="1001"> <a:schemeClr val="bg1"/> </p:bgRef> </p:bg>
              <p:spTree>
                <p:nvGrpSpPr> <p:cNvPr id="1" name=""/> <p:cNvGrpSpPr/> <p:nvPr/> </p:nvGrpSpPr>
                <p:grpSpPr> <a:xfrm> <a:off x="0" y="0"/> <a:ext cx="0" cy="0"/> <a:chOff x="0" y="0"/> <a:chExt cx="0" cy="0"/> </a:xfrm> </p:grpSpPr>
              </p:spTree>
            </p:cSld>
            <p:clrMap bg1="lt1" tx1="dk1" bg2="lt2" tx2="dk2" accent1="accent1" accent2="accent2" accent3="accent3" accent4="accent4" accent5="accent5" accent6="accent6" hlink="hlink" folHlink="folHlink"/>
            <p:sldLayoutIdLst> <p:sldLayoutId id="2147483649" r:id="rId1"/> </p:sldLayoutIdLst>
          </p:sldMaster>
        </pkg:xmlData>
      </pkg:part>
      <pkg:part pkg:name="/ppt/slideLayouts/slideLayout1.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml">
        <pkg:xmlData>
          <p:sldLayout xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main" type="title" preserve="1">
            <p:cSld name="Title Slide">
              <p:spTree>
                <p:nvGrpSpPr> <p:cNvPr id="1" name=""/> <p:cNvGrpSpPr/> <p:nvPr/> </p:nvGrpSpPr>
                <p:grpSpPr> <a:xfrm> <a:off x="0" y="0"/> <a:ext cx="0" cy="0"/> <a:chOff x="0" y="0"/> <a:chExt cx="0" cy="0"/> </a:xfrm> </p:grpSpPr>
              </p:spTree>
            </p:cSld>
            <p:clrMapOvr> <a:masterClrMapping/> </p:clrMapOvr>
          </p:sldLayout>
        </pkg:xmlData>
      </pkg:part>
      <pkg:part pkg:name="/ppt/slideMasters/_rels/slideMaster1.xml.rels" pkg:contentType="application/vnd.openxmlformats-package.relationships+xml">
        <pkg:xmlData>
          <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
            <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="../theme/theme1.xml"/>
            <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout1.xml"/>
          </Relationships>
        </pkg:xmlData>
      </pkg:part>
      <pkg:part pkg:name="/ppt/slideLayouts/_rels/slideLayout1.xml.rels" pkg:contentType="application/vnd.openxmlformats-package.relationships+xml">
        <pkg:xmlData>
          <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
            <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="../slideMasters/slideMaster1.xml"/>
          </Relationships>
        </pkg:xmlData>
      </pkg:part>
      <pkg:part pkg:name="/ppt/theme/theme1.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.theme+xml">
        <pkg:xmlData>
          <a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="Office Theme">
            <a:themeElements>
              <a:clrScheme name="Office">
                <a:dk1>
                  <a:sysClr val="windowText" lastClr="000000"/>
                </a:dk1>
                <a:lt1>
                  <a:sysClr val="window" lastClr="FFFFFF"/>
                </a:lt1>
                <a:dk2>
                  <a:srgbClr val="44546A"/>
                </a:dk2>
                <a:lt2>
                  <a:srgbClr val="E7E6E6"/>
                </a:lt2>
                <a:accent1>
                  <a:srgbClr val="C2C2D6"/>
                </a:accent1>
                <a:accent2>
                  <a:srgbClr val="ED7D31"/>
                </a:accent2>
                <a:accent3>
                  <a:srgbClr val="A5A5A5"/>
                </a:accent3>
                <a:accent4>
                  <a:srgbClr val="FFC000"/>
                </a:accent4>
                <a:accent5>
                  <a:srgbClr val="5B9BD5"/>
                </a:accent5>
                <a:accent6>
                  <a:srgbClr val="70AD47"/>
                </a:accent6>
                <a:hlink>
                  <a:srgbClr val="0563C1"/>
                </a:hlink>
                <a:folHlink>
                  <a:srgbClr val="954F72"/>
                </a:folHlink>
              </a:clrScheme>
              <a:fontScheme name="Office">
                <a:majorFont>
                  <a:latin typeface="Calibri Light" panose="020F0302020204030204"/>
                  <a:ea typeface=""/>
                  <a:cs typeface=""/>
                  <a:font script="Jpan" typeface="游ゴシック Light"/>
                  <a:font script="Hang" typeface="맑은 고딕"/>
                  <a:font script="Hans" typeface="等线 Light"/>
                  <a:font script="Hant" typeface="新細明體"/>
                  <a:font script="Arab" typeface="Times New Roman"/>
                  <a:font script="Hebr" typeface="Times New Roman"/>
                  <a:font script="Thai" typeface="Angsana New"/>
                  <a:font script="Ethi" typeface="Nyala"/>
                  <a:font script="Beng" typeface="Vrinda"/>
                  <a:font script="Gujr" typeface="Shruti"/>
                  <a:font script="Khmr" typeface="MoolBoran"/>
                  <a:font script="Knda" typeface="Tunga"/>
                  <a:font script="Guru" typeface="Raavi"/>
                  <a:font script="Cans" typeface="Euphemia"/>
                  <a:font script="Cher" typeface="Plantagenet Cherokee"/>
                  <a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
                  <a:font script="Tibt" typeface="Microsoft Himalaya"/>
                  <a:font script="Thaa" typeface="MV Boli"/>
                  <a:font script="Deva" typeface="Mangal"/>
                  <a:font script="Telu" typeface="Gautami"/>
                  <a:font script="Taml" typeface="Latha"/>
                  <a:font script="Syrc" typeface="Estrangelo Edessa"/>
                  <a:font script="Orya" typeface="Kalinga"/>
                  <a:font script="Mlym" typeface="Kartika"/>
                  <a:font script="Laoo" typeface="DokChampa"/>
                  <a:font script="Sinh" typeface="Iskoola Pota"/>
                  <a:font script="Mong" typeface="Mongolian Baiti"/>
                  <a:font script="Viet" typeface="Times New Roman"/>
                  <a:font script="Uigh" typeface="Microsoft Uighur"/>
                  <a:font script="Geor" typeface="Sylfaen"/>
                  <a:font script="Armn" typeface="Arial"/>
                  <a:font script="Bugi" typeface="Leelawadee UI"/>
                  <a:font script="Bopo" typeface="Microsoft JhengHei"/>
                  <a:font script="Java" typeface="Javanese Text"/>
                  <a:font script="Lisu" typeface="Segoe UI"/>
                  <a:font script="Mymr" typeface="Myanmar Text"/>
                  <a:font script="Nkoo" typeface="Ebrima"/>
                  <a:font script="Olck" typeface="Nirmala UI"/>
                  <a:font script="Osma" typeface="Ebrima"/>
                  <a:font script="Phag" typeface="Phagspa"/>
                  <a:font script="Syrn" typeface="Estrangelo Edessa"/>
                  <a:font script="Syrj" typeface="Estrangelo Edessa"/>
                  <a:font script="Syre" typeface="Estrangelo Edessa"/>
                  <a:font script="Sora" typeface="Nirmala UI"/>
                  <a:font script="Tale" typeface="Microsoft Tai Le"/>
                  <a:font script="Talu" typeface="Microsoft New Tai Lue"/>
                  <a:font script="Tfng" typeface="Ebrima"/>
                </a:majorFont>
                <a:minorFont>
                  <a:latin typeface="Calibri" panose="020F0502020204030204"/>
                  <a:ea typeface=""/>
                  <a:cs typeface=""/>
                  <a:font script="Jpan" typeface="游ゴシック"/>
                  <a:font script="Hang" typeface="맑은 고딕"/>
                  <a:font script="Hans" typeface="等线"/>
                  <a:font script="Hant" typeface="新細明體"/>
                  <a:font script="Arab" typeface="Arial"/>
                  <a:font script="Hebr" typeface="Arial"/>
                  <a:font script="Thai" typeface="Cordia New"/>
                  <a:font script="Ethi" typeface="Nyala"/>
                  <a:font script="Beng" typeface="Vrinda"/>
                  <a:font script="Gujr" typeface="Shruti"/>
                  <a:font script="Khmr" typeface="DaunPenh"/>
                  <a:font script="Knda" typeface="Tunga"/>
                  <a:font script="Guru" typeface="Raavi"/>
                  <a:font script="Cans" typeface="Euphemia"/>
                  <a:font script="Cher" typeface="Plantagenet Cherokee"/>
                  <a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
                  <a:font script="Tibt" typeface="Microsoft Himalaya"/>
                  <a:font script="Thaa" typeface="MV Boli"/>
                  <a:font script="Deva" typeface="Mangal"/>
                  <a:font script="Telu" typeface="Gautami"/>
                  <a:font script="Taml" typeface="Latha"/>
                  <a:font script="Syrc" typeface="Estrangelo Edessa"/>
                  <a:font script="Orya" typeface="Kalinga"/>
                  <a:font script="Mlym" typeface="Kartika"/>
                  <a:font script="Laoo" typeface="DokChampa"/>
                  <a:font script="Sinh" typeface="Iskoola Pota"/>
                  <a:font script="Mong" typeface="Mongolian Baiti"/>
                  <a:font script="Viet" typeface="Arial"/>
                  <a:font script="Uigh" typeface="Microsoft Uighur"/>
                  <a:font script="Geor" typeface="Sylfaen"/>
                  <a:font script="Armn" typeface="Arial"/>
                  <a:font script="Bugi" typeface="Leelawadee UI"/>
                  <a:font script="Bopo" typeface="Microsoft JhengHei"/>
                  <a:font script="Java" typeface="Javanese Text"/>
                  <a:font script="Lisu" typeface="Segoe UI"/>
                  <a:font script="Mymr" typeface="Myanmar Text"/>
                  <a:font script="Nkoo" typeface="Ebrima"/>
                  <a:font script="Olck" typeface="Nirmala UI"/>
                  <a:font script="Osma" typeface="Ebrima"/>
                  <a:font script="Phag" typeface="Phagspa"/>
                  <a:font script="Syrn" typeface="Estrangelo Edessa"/>
                  <a:font script="Syrj" typeface="Estrangelo Edessa"/>
                  <a:font script="Syre" typeface="Estrangelo Edessa"/>
                  <a:font script="Sora" typeface="Nirmala UI"/>
                  <a:font script="Tale" typeface="Microsoft Tai Le"/>
                  <a:font script="Talu" typeface="Microsoft New Tai Lue"/>
                  <a:font script="Tfng" typeface="Ebrima"/>
                </a:minorFont>
              </a:fontScheme>
              <a:fmtScheme name="Office">
                <a:fillStyleLst>
                  <a:solidFill>
                    <a:schemeClr val="phClr"/>
                  </a:solidFill>
                  <a:gradFill rotWithShape="1">
                    <a:gsLst>
                      <a:gs pos="0">
                        <a:schemeClr val="phClr">
                          <a:lumMod val="110000"/>
                          <a:satMod val="105000"/>
                          <a:tint val="67000"/>
                        </a:schemeClr>
                      </a:gs>
                      <a:gs pos="50000">
                        <a:schemeClr val="phClr">
                          <a:lumMod val="105000"/>
                          <a:satMod val="103000"/>
                          <a:tint val="73000"/>
                        </a:schemeClr>
                      </a:gs>
                      <a:gs pos="100000">
                        <a:schemeClr val="phClr">
                          <a:lumMod val="105000"/>
                          <a:satMod val="109000"/>
                          <a:tint val="81000"/>
                        </a:schemeClr>
                      </a:gs>
                    </a:gsLst>
                    <a:lin ang="5400000" scaled="0"/>
                  </a:gradFill>
                  <a:gradFill rotWithShape="1">
                    <a:gsLst>
                      <a:gs pos="0">
                        <a:schemeClr val="phClr">
                          <a:satMod val="103000"/>
                          <a:lumMod val="102000"/>
                          <a:tint val="94000"/>
                        </a:schemeClr>
                      </a:gs>
                      <a:gs pos="50000">
                        <a:schemeClr val="phClr">
                          <a:satMod val="110000"/>
                          <a:lumMod val="100000"/>
                          <a:shade val="100000"/>
                        </a:schemeClr>
                      </a:gs>
                      <a:gs pos="100000">
                        <a:schemeClr val="phClr">
                          <a:lumMod val="99000"/>
                          <a:satMod val="120000"/>
                          <a:shade val="78000"/>
                        </a:schemeClr>
                      </a:gs>
                    </a:gsLst>
                    <a:lin ang="5400000" scaled="0"/>
                  </a:gradFill>
                </a:fillStyleLst>
                <a:lnStyleLst>
                  <a:ln w="6350" cap="flat" cmpd="sng" algn="ctr">
                    <a:solidFill>
                      <a:schemeClr val="phClr"/>
                    </a:solidFill>
                    <a:prstDash val="solid"/>
                    <a:miter lim="800000"/>
                  </a:ln>
                  <a:ln w="12700" cap="flat" cmpd="sng" algn="ctr">
                    <a:solidFill>
                      <a:schemeClr val="phClr"/>
                    </a:solidFill>
                    <a:prstDash val="solid"/>
                    <a:miter lim="800000"/>
                  </a:ln>
                  <a:ln w="19050" cap="flat" cmpd="sng" algn="ctr">
                    <a:solidFill>
                      <a:schemeClr val="phClr"/>
                    </a:solidFill>
                    <a:prstDash val="solid"/>
                    <a:miter lim="800000"/>
                  </a:ln>
                </a:lnStyleLst>
                <a:effectStyleLst>
                  <a:effectStyle>
                    <a:effectLst/>
                  </a:effectStyle>
                  <a:effectStyle>
                    <a:effectLst/>
                  </a:effectStyle>
                  <a:effectStyle>
                    <a:effectLst>
                      <a:outerShdw blurRad="57150" dist="19050" dir="5400000" algn="ctr" rotWithShape="0">
                        <a:srgbClr val="000000">
                          <a:alpha val="63000"/>
                        </a:srgbClr>
                      </a:outerShdw>
                    </a:effectLst>
                  </a:effectStyle>
                </a:effectStyleLst>
                <a:bgFillStyleLst>
                  <a:solidFill>
                    <a:schemeClr val="phClr"/>
                  </a:solidFill>
                  <a:solidFill>
                    <a:schemeClr val="phClr">
                      <a:tint val="95000"/>
                      <a:satMod val="170000"/>
                    </a:schemeClr>
                  </a:solidFill>
                  <a:gradFill rotWithShape="1">
                    <a:gsLst>
                      <a:gs pos="0">
                        <a:schemeClr val="phClr">
                          <a:tint val="93000"/>
                          <a:satMod val="150000"/>
                          <a:shade val="98000"/>
                          <a:lumMod val="102000"/>
                        </a:schemeClr>
                      </a:gs>
                      <a:gs pos="50000">
                        <a:schemeClr val="phClr">
                          <a:tint val="98000"/>
                          <a:satMod val="130000"/>
                          <a:shade val="90000"/>
                          <a:lumMod val="103000"/>
                        </a:schemeClr>
                      </a:gs>
                      <a:gs pos="100000">
                        <a:schemeClr val="phClr">
                          <a:shade val="63000"/>
                          <a:satMod val="120000"/>
                        </a:schemeClr>
                      </a:gs>
                    </a:gsLst>
                    <a:lin ang="5400000" scaled="0"/>
                  </a:gradFill>
                </a:bgFillStyleLst>
              </a:fmtScheme>
            </a:themeElements>
            <a:objectDefaults/>
            <a:extraClrSchemeLst/>
          </a:theme>
        </pkg:xmlData>
      </pkg:part>	
	</xsl:template>
	
</xsl:stylesheet>
