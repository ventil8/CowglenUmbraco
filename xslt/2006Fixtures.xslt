<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
	version="1.0"
	  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exslt="http://exslt.org/common"
  xmlns:date="http://exslt.org/dates-and-times"
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets"
	exclude-result-prefixes="date exslt msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">


  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:param name="currentPage"/>

  <xsl:template match="/">
        <xsl:choose>
          <xsl:when test="count($currentPage//* [@isDoc and name()='Fixture' and Exslt.ExsltStrings:lowercase($currentMonthYear) = Exslt.ExsltStrings:lowercase(umbraco.library:FormatDateTime(./eventStartDateTime, 'MMMM,yyyy'))]) &gt; 0">
            
              <xsl:for-each select="$currentPage//* [@isDoc and name()='Fixture' and ageGroup = '2006' and  Exslt.ExsltStrings:lowercase($currentMonthYear) = Exslt.ExsltStrings:lowercase(umbraco.library:FormatDateTime(./eventStartDateTime, 'MMMM,yyyy'))]">
                <xsl:sort select="current()/eventStartDateTime"  order="descending" />
                
                  
                  <h3>
                    <a href="{umbraco.library:NiceUrl(current()/@id)}">
                      <xsl:value-of select="current()/@nodeName" /> - <xsl:value-of select="current()/homeTeam" /> V <xsl:value-of select="current()/awayTeam" />
                    </a>
                  </h3>
                  <h4>
                    <xsl:value-of select="umbraco.library:FormatDateTime(current()/eventStartDateTime, 'dddd, d MMMM, yyyy H:mm')"/>
                  </h4>
                  <!--<p><xsl:value-of select="current()/data [@alias='eventLocationAddress']"/></p>-->
                

              </xsl:for-each>
            
          </xsl:when>
          <xsl:otherwise>
            <p class="no_events">Fixures are currently being updated</p>
          </xsl:otherwise>
        </xsl:choose>
      
    

   

  </xsl:template>

  <xsl:variable name="DisplayDate" select="Exslt.ExsltDatesAndTimes:date()"/>



  <xsl:variable name="Year">
    <xsl:choose>
      <xsl:when test="umbraco.library:Request('year') &lt;= 0 or string(umbraco.library:Request('year')) = ''">
        <xsl:value-of select="Exslt.ExsltDatesAndTimes:year($DisplayDate)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="umbraco.library:Request('year')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="Month">
    <xsl:choose>
      <xsl:when test="umbraco.library:Request('month') &lt;= 0 or string(umbraco.library:Request('month')) = ''">
        <xsl:value-of select="Exslt.ExsltDatesAndTimes:monthinyear($DisplayDate)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="umbraco.library:Request('month')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="currentMonthYear" select="concat($MonthName,',',$Year)" />

  <xsl:variable name="MonthName">
    <xsl:choose>
      <xsl:when test="$Month = 1">January</xsl:when>
      <xsl:when test="$Month = 2">February</xsl:when>
      <xsl:when test="$Month = 3">March</xsl:when>
      <xsl:when test="$Month = 4">April</xsl:when>
      <xsl:when test="$Month = 5">May</xsl:when>
      <xsl:when test="$Month = 6">June</xsl:when>
      <xsl:when test="$Month = 7">July</xsl:when>
      <xsl:when test="$Month = 8">August</xsl:when>
      <xsl:when test="$Month = 9">September</xsl:when>
      <xsl:when test="$Month = 10">October</xsl:when>
      <xsl:when test="$Month = 11">November</xsl:when>
      <xsl:when test="$Month = 12">December</xsl:when>
      <xsl:otherwise>invalid month</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="NumberOfDaysInMonth">
    <xsl:call-template name="DaysInMonth">
      <xsl:with-param name="month" select="$Month" />
      <xsl:with-param name="year" select="$Year" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="FirstDayInWeekForMonth">
    <xsl:choose>
      <xsl:when test="$Month &lt; 10">
        <xsl:value-of select="Exslt.ExsltDatesAndTimes:dayinweek(Exslt.ExsltDatesAndTimes:date(concat($Year,'-0', $Month, '-01')))" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="Exslt.ExsltDatesAndTimes:dayinweek(Exslt.ExsltDatesAndTimes:date(concat($Year,'-', $Month, '-01')))" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="WeeksInMonth">
    <xsl:value-of select="($NumberOfDaysInMonth + $FirstDayInWeekForMonth - 1) div 7" />
  </xsl:variable>

  <xsl:template name="DaysInMonth">
    <xsl:param name="month">
      <xsl:value-of select="$Month" />
    </xsl:param>
    <xsl:param name="year">
      <xsl:value-of select="$Year" />
    </xsl:param>
    <xsl:choose>
      <xsl:when test="$month = 1 or $month = 3 or $month = 5 or $month = 7 or $month = 8 or $month = 10 or $month = 12">31</xsl:when>
      <xsl:when test="$month=2">
        <xsl:choose>
          <xsl:when test="$year mod 4 = 0">29</xsl:when>
          <xsl:otherwise>28</xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>30</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="NextMonthLink">
    <xsl:param name="currentMonth">
      <xsl:value-of select="$Month" />
    </xsl:param>
    <xsl:param name="currentYear">
      <xsl:value-of select="$Year" />
    </xsl:param>
    <xsl:choose>
      <xsl:when test="$currentMonth = 12">
        <a class="next_month" title="Next Month">
          <xsl:attribute name="href">
            <xsl:value-of select="umbraco.library:NiceUrl($currentPage/@id)"/>
            <xsl:text>?year=</xsl:text>
            <xsl:value-of select="$currentYear + 1"/>
            <xsl:text>&amp;month=1</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:text>Next Month</xsl:text>
          </span>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a class="next_month" title="Next Month">
          <xsl:attribute name="href">
            <xsl:value-of select="umbraco.library:NiceUrl($currentPage/@id)"/>
            <xsl:text>?year=</xsl:text>
            <xsl:value-of select="$currentYear"/>
            <xsl:text>&amp;month=</xsl:text>
            <xsl:value-of select="$currentMonth + 1"/>
          </xsl:attribute>
          <span>
            <xsl:text>Next Month</xsl:text>
          </span>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="PreviousMonthLink">
    <xsl:param name="currentMonth">
      <xsl:value-of select="$Month" />
    </xsl:param>
    <xsl:param name="currentYear">
      <xsl:value-of select="$Year" />
    </xsl:param>
    <xsl:choose>
      <xsl:when test="$currentMonth = 1">
        <a class="previous_month" title="Previous Month">
          <xsl:attribute name="href">
            <xsl:value-of select="umbraco.library:NiceUrl($currentPage/@id)"/>
            <xsl:text>?year=</xsl:text>
            <xsl:value-of select="$currentYear - 1"/>
            <xsl:text>&amp;month=12</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:text>Previous Month</xsl:text>
          </span>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a class="previous_month" title="Previous Month">
          <xsl:attribute name="href">
            <xsl:value-of select="umbraco.library:NiceUrl($currentPage/@id)"/>
            <xsl:text>?year=</xsl:text>
            <xsl:value-of select="$currentYear"/>
            <xsl:text>&amp;month=</xsl:text>
            <xsl:value-of select="$currentMonth - 1"/>
          </xsl:attribute>
          <span>
            <xsl:text>Previous Month</xsl:text>
          </span>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="Calendar">


    <div class="calWrapper">
      <h5 class="event_cal_current">
        <xsl:value-of select="$MonthName" />
        <xsl:text> </xsl:text>
        <xsl:value-of select="$Year" />
        <xsl:call-template name="PreviousMonthLink" />
        <xsl:call-template name="NextMonthLink" />
      </h5>

      <table class="sm_calendar">
        <tr>
          <th>
            <abbr title="Sunday">Sun</abbr>
          </th>
          <th>
            <abbr title="Monday">Mon</abbr>
          </th>
          <th>
            <abbr title="Tuesday">Tue</abbr>
          </th>
          <th>
            <abbr title="Wednesday">Wed</abbr>
          </th>
          <th>
            <abbr title="Thursday">Thu</abbr>
          </th>
          <th>
            <abbr title="Friday">Fri</abbr>
          </th>
          <th>
            <abbr title="Saturday">Sat</abbr>
          </th>
        </tr>
        <xsl:call-template name="CalendarWeek"/>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="CalendarWeek">
    <xsl:param name="week">1</xsl:param>
    <xsl:param name="day">1</xsl:param>
    <tr>
      <xsl:call-template name="CalendarDay">
        <xsl:with-param name="day" select="$day" />
      </xsl:call-template>
    </tr>
    <xsl:if test="$WeeksInMonth &gt; $week">
      <xsl:call-template name="CalendarWeek">
        <xsl:with-param name="week" select="$week + 1" />
        <xsl:with-param name="day" select="$week * 7 - ($FirstDayInWeekForMonth - 2)" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="CalendarDay">
    <xsl:param name="count">1</xsl:param>
    <xsl:param name="day" />
    <xsl:choose>
      <xsl:when test="($day = 1 and $count != $FirstDayInWeekForMonth) or $day &gt; $NumberOfDaysInMonth">
        <td class="empty">
          <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
        </td>
        <xsl:if test="$count &lt; 7">
          <xsl:call-template name="CalendarDay">
            <xsl:with-param name="count" select="$count + 1" />
            <xsl:with-param name="day" select="$day" />
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <td>
          <xsl:variable name="currentDate" select="concat($MonthName,' ',$day,', ',$Year)" />

          <xsl:variable name="eventsToday" select="count($currentPage//* [@isDoc and name()='Fixture' and Exslt.ExsltStrings:lowercase($currentDate) = Exslt.ExsltStrings:lowercase(umbraco.library:FormatDateTime(./eventStartDateTime, 'MMMM d, yyyy'))])" />

          <xsl:if test="$eventsToday &gt; 0">
            <xsl:attribute name="class">
              <xsl:text>eventDay</xsl:text>
            </xsl:attribute>
            <div class="events_today">
              <h6>
                <xsl:value-of select="$currentDate" />
              </h6>
              events today: <xsl:value-of select="$eventsToday" />
              <ul class="events_today_list">
                <xsl:for-each select="$currentPage//* [@isDoc and name()='Fixture' and Exslt.ExsltStrings:lowercase($currentDate) = Exslt.ExsltStrings:lowercase(umbraco.library:FormatDateTime(./eventStartDateTime, 'MMMM d, yyyy'))]">
                  <li>
                    <a href="{umbraco.library:NiceUrl(current()/@id)}">
                      <xsl:value-of select="current()/@nodeName" />
                    </a>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </xsl:if>

          <xsl:value-of select="$day" />
        </td>
        <xsl:if test="$count &lt; 7">
          <xsl:call-template name="CalendarDay">
            <xsl:with-param name="count" select="$count + 1" />
            <xsl:with-param name="day" select="$day + 1" />
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>