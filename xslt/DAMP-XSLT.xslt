<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" 
	exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">


  <xsl:output method="html" omit-xml-declaration="yes" indent="yes"/>

  <xsl:param name="currentPage"/>

  <xsl:template match="/">

    <!--DAMP File-->
    <xsl:variable name="file" select="$currentPage/dampFile/DAMP/mediaItem/File" />

    <h3 style="margin-top: 20px;">XSLT DAMP file sample</h3>
    <p>Download: <a href="{$file/umbracoFile}" target="_blank"><xsl:value-of select="$file/@nodeName"/></a></p>
    
    <!--DAMP Classic-->
    <xsl:variable name="media" select="umbraco.library:GetMedia($currentPage/dampClassic, 0)" />

    <h3 style="margin-top: 20px;">XSLT DAMP classic sample</h3>
    <img src="{$media/umbracoFile}" alt="{$media/@nodeName}" height="400px" />

    <table>
      <tr>
        <td style="vertical-align: top; padding-right: 20px;">

          <!--DAMP New wide-->
          <h3 style="margin-top: 20px;">XSLT DAMP new wide sample</h3>
          <ul>
            <xsl:for-each select="$currentPage/dampNewWide/DAMP/mediaItem/ImageWide">
              <li>
                <img src="{wideImage/crops/crop[@name='wideCrop']/@url}" alt="{@nodeName}"/>
              </li>
            </xsl:for-each>
          </ul>

        </td>
        <td  style="vertical-align: top;">

          <!--DAMP New long-->
          <h3 style="margin-top: 20px;">XSLT DAMP new long sample</h3>
          <ul>
            <xsl:for-each select="$currentPage/dampNewLong/DAMP/mediaItem/ImageLong">
              <li>
                <img src="{longImage/crops/crop[@name='longCrop']/@url}" alt="{@nodeName}"/>
              </li>
            </xsl:for-each>
          </ul>

        </td>
      </tr>
    </table>

  </xsl:template>

</xsl:stylesheet>