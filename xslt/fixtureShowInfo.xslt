<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" 
	exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">


<xsl:output method="xml" omit-xml-declaration="yes"/>

<xsl:param name="currentPage"/>

<xsl:template match="/">

	<xsl:if test="string($currentPage/eventStartDateTime) != ''">
    <h2>
      <xsl:value-of select="$currentPage/homeTeam" /> V <xsl:value-of select="$currentPage/awayTeam" />
    </h2>
    <p class="eventinfo_date">
		<strong><xsl:text>Team: </xsl:text></strong>
			<span>
				<xsl:value-of select="$currentPage/ageGroup" />
			
			</span>	
		</p>
		<p class="eventinfo_date">
		<strong><xsl:text>Date: </xsl:text></strong>
			<span>
				<xsl:value-of select="umbraco.library:FormatDateTime($currentPage/eventStartDateTime, 'dddd, d MMMM, yyyy')" />
			
			</span>
		</p>
		<p class="eventinfo_time">
			<strong><xsl:text>Time: </xsl:text></strong>
			<span>
				<xsl:value-of select="umbraco.library:FormatDateTime($currentPage/eventStartDateTime, 'H:mm')" />
				<xsl:if test="string($currentPage/eventEndDateTime) != ''">
					<xsl:text> - </xsl:text>
					<xsl:value-of select="umbraco.library:FormatDateTime($currentPage/eventEndDateTime, 'H:mm')" />
				</xsl:if>
			</span>		
		</p>
	</xsl:if>
	<xsl:if test="string($currentPage/eventLocationAddress) != '' or string($currentPage/eventLocationName) != ''">
		<p class="eventinfo_location"><strong><xsl:text>Location: </xsl:text></strong><a href="{umbraco.library:NiceUrl($currentPage/locationLink)}"><xsl:value-of select="$currentPage/eventLocationName" /></a> <xsl:value-of select="$currentPage/eventLocationAddress" /> (Click the location to view more info)</p>
	</xsl:if>


</xsl:template>

</xsl:stylesheet>