<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#x00A0;">
]>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxml="urn:schemas-microsoft-com:xslt"
  xmlns:umbraco.library="urn:umbraco.library"
  xmlns:twitter.library="urn:twitter.library"
  xmlns:georss="http://www.georss.org/georss"
  exclude-result-prefixes="msxml umbraco.library twitter.library georss">

  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:param name="currentPage"/>

  <!--
    Twitter for Umbraco
    Version:  2.0
  -->

  <!-- FUTURE TODO:
        * Use entities XML for hashtags, mentions, URLs and photos
        * Use embed.ly for all media (maybe even native twitter photo)
    -->
  
  <!-- Twitter username -->
  <xsl:param name="twitterUsername" select="/macro/twitterUsername" />

  <!-- Number of Statuses -->
  <xsl:param name="noStatus">
    <xsl:choose>
      <!-- Max status's we can retrieve is upto 200 -->
      <xsl:when test="/macro/noStatus &lt;= 200">
        <xsl:value-of select="/macro/noStatus"/>
      </xsl:when>
      <xsl:otherwise>
        200
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <!-- Exclude @replies? -->
  <xsl:param name="excludeReplies" select="/macro/excludeReplies" />

  <!-- Display native RTs? -->
  <xsl:param name="displayNativeRTs">
    <xsl:choose>
      <xsl:when test="/macro/displayNativeRTs = 1">
        <xsl:text>true</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>false</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <!-- Display map? -->
  <xsl:param name="displayMaps" select="/macro/displayMaps" />

  <!-- Goole Static Maps Params-->
  <xsl:param name="baseURL"  select="'http://maps.google.com/maps/api/staticmap'"/> <!-- DO NOT CHANGE URL -->
  <xsl:param name="zoom"     select="/macro/zoom" />                                <!-- Zoom level (0 to 21) -->
  <xsl:param name="size"     select="/macro/size" />                                <!-- Size of Map in pixels (400x400) -->
  <xsl:param name="mapType"  select="/macro/mapType" />                             <!-- Map Type (roadmap, satellite, terrain, hybrid) -->


  <xsl:template match="/">

    <!-- Twitter XML URL -->
    <!--
    http://api.twitter.com/1/statuses/user_timeline.xml?screen_name=warrenbuckley&include_rts=0&exclude_replies=1&include_entities=1&count=5
    -->
    <xsl:variable name="twitterXMLUrl" select="concat('http://api.twitter.com/1/statuses/user_timeline.xml?screen_name=', $twitterUsername ,'&amp;include_rts=', $displayNativeRTs ,'&amp;exclude_replies=', $excludeReplies, '&amp;include_entities=1&amp;count=', $noStatus)"/>

    <!-- Go fetch the tweets & cache for 60 seconds -->
    <xsl:for-each select="umbraco.library:GetXmlDocumentByUrl($twitterXMLUrl,'60')//statuses/status">
      <xsl:apply-templates mode="tweet" select="current()"/>
    </xsl:for-each>

  </xsl:template>

  <xsl:template match="status" mode="tweet">
    <!-- Change the XHTML here for how you want each tweet to be displayed -->

    <div class="tweet">
      <p>
        <!-- Your Profile Image -->
        <img src="{user/profile_image_url}" />

        <!-- Your real name (not profile name) -->
        <strong>
          <xsl:value-of select="user/name"/>
        </strong>
        -
        <!-- Date of tweet -->
        <span>
          <xsl:value-of select="umbraco.library:FormatDateTime(twitter.library:FormatTwitterDate(created_at), 'ddd d MMM yy @ H:mm')"/>
        </span>

        <!-- Tweet content-->
        <xsl:value-of select="twitter.library:FormatUrls(text)" disable-output-escaping="yes"/>
      </p>

      <!-- Show any images if attached -->
      <xsl:if test="entities/media/creative/media_url">
        <a href="{entities/media/creative/media_url}">
          <img src="{entities/media/creative/media_url}:thumb" />
        </a>
      </xsl:if>

      <!-- Show Map of Tweet - IF value in XML is there & user enabled maps -->
      <xsl:if test="geo/georss:point != '' and $displayMaps = 1">
        <p>
          <!-- Pass coordinates to map template-->
          <xsl:call-template name="map">
            <!-- Google wants coordinates as comma seperated so replace (space) with comma -->
            <xsl:with-param name="coordinates" select="umbraco.library:Replace(geo/georss:point,' ',',')" />
          </xsl:call-template>
        </p>
      </xsl:if>
    </div>   
  </xsl:template>

  <xsl:template name="map">
    <xsl:param name="coordinates" />

    <!--
    See Google Static Maps API to customise your map
    http://code.google.com/apis/maps/documentation/staticmaps/
    -->
    <img src="{$baseURL}?center={$coordinates}&amp;zoom={$zoom}&amp;size={$size}&amp;maptype={$mapType}&amp;markers=color:red|label:A|{$coordinates}&amp;sensor=false" />

  </xsl:template>

</xsl:stylesheet>