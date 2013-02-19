<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" xmlns:twitter.library="urn:twitter.library" xmlns:ucomponents.media="urn:ucomponents.media" xmlns:PS.XSLTsearch="urn:PS.XSLTsearch" 
	exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets twitter.library ucomponents.media PS.XSLTsearch ">


<xsl:output method="xml" omit-xml-declaration="yes"/>

    <xsl:param name="currentPage"/>
    
    <xsl:variable name="noOfItems" select="1" />
    <xsl:param name="MaxNoChars" select="70" />

    <xsl:template match="/">
      
    
      
         
       
            <xsl:for-each select="$currentPage/ancestor-or-self::* [@isDoc]/Venues/* [@isDoc]">
                <xsl:sort select="@createDate" order="ascending"/>
              
                <!-- Position() <= $noOfItems -->
                <xsl:if test="position()&lt;= $noOfItems">
                    
                  
                   
            <!-- TODO: strip HTML & truncate -->
                  
                    <h5><a href="{umbraco.library:NiceUrl(@id)}"> <xsl:value-of select="@nodeName" /></a></h5>
                    
                      <img src="/ImageGen.ashx?image={current()/mainImage}&amp;width=300&amp;height=100&amp;constrain=true" alt="{@nodeName}" class="imgBorderSml"  />
           

                  <div class="hpSmallText">
					<p>
                       <xsl:value-of select="umbraco.library:TruncateString(umbraco.library:StripHtml(current()/introduction), $MaxNoChars, '...')" /> [ <a href="{umbraco.library:NiceUrl(@id)}">Full Story</a> ]
   
                  	</p>
					</div>
         
                </xsl:if>
                
            </xsl:for-each>
         
</xsl:template>


</xsl:stylesheet>
