<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#x00A0;">
]>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library" 
	xmlns:atom="http://www.w3.org/2005/Atom"
	exclude-result-prefixes="msxml umbraco.library atom">

  <xsl:output method="xml" omit-xml-declaration="yes"/>
  <xsl:param name="currentPage"/>

  <!--
    Twitter Search for Umbraco
    
    Documentation
    Search Operators : http://search.twitter.com/operators
    Search API : http://dev.twitter.com/doc/get/search
    
    Instructions
    1. Construct a search at http://search.twitter.com/advanced
    2. Submit the search
    3. Fetch he ATOM feed address for the search
    4. Use the ATOM feed URL as the parameter in the Twitter Search macro.
  -->

  <!-- The maximum results to be displayed -->
  <xsl:param name="maxResults" select="/macro/maxResults" />

  <!-- The search query -->
  <xsl:param name="queryURI" select="/macro/queryURI" />

  <xsl:template match="/">

    <!-- Get the results -->
    <xsl:variable name="twitterSearchResults" select="umbraco.library:GetXmlDocumentByUrl($queryURI)" />

    <xsl:choose>
      <xsl:when test="$twitterSearchResults//atom:feed/atom:entry">
        <div class="twitterSearchResults">

          <xsl:choose>
            <!-- Limit results when max results specified. -->
            <xsl:when test="$maxResults">

              <xsl:for-each select="$twitterSearchResults//atom:feed/atom:entry">

                <xsl:if test="position() &lt;= $maxResults">
                  <xsl:apply-templates select="current()"/>
                </xsl:if>

              </xsl:for-each>

            </xsl:when>
            <xsl:otherwise>
              <!-- Show all results -->
              <xsl:apply-templates select="$twitterSearchResults//atom:feed/atom:entry" />

            </xsl:otherwise>

          </xsl:choose>

        </div>
      </xsl:when>
      <xsl:otherwise>
        <!-- Show the 'no results found' template -->
        <xsl:call-template name="noResults" />
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="atom:entry">

    <div class="twitterResult">
      <p>
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="atom:author/atom:uri"/>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:value-of select="atom:author/atom:name"/>
          </xsl:attribute>
          <img>
            <xsl:attribute name="src">
              <xsl:value-of select="atom:link[@type='image/png']/@href"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
              <xsl:value-of select="atom:author/atom:name"/>
            </xsl:attribute>
          </img>
        </a>
        <xsl:value-of select="atom:content[@type='html']" disable-output-escaping="yes"/>
      </p>
    </div>

  </xsl:template>

  <xsl:template name="noResults">
    <div class="twitterNoSearchResults">
      No Results Found
    </div>
  </xsl:template>


</xsl:stylesheet>