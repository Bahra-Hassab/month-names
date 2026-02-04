<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" indent="no"/>

  <xsl:template match="tei:teiCorpus">
    <html lang="en" data-theme="light">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css"/>
        <style>
        abbr {
          text-decoration: none;
        }

        table.table tbody:not(:last-of-type) tr td, table.table tbody:not(:last-of-type) tr th {
          border-bottom-width: 1px;
        }

        table.table tbody tr th {
          border-right-width: 1px;
        }

        table.table tbody tr.has-background-light th {
          border-right-width: 0;
        }
        </style>
      </head>
      <body>

        <section class="section" id="calendars">
          <div class="container">

            <h1 class="title is-2">Calendars</h1>

            <div class="columns is-multiline">

              <xsl:for-each select="tei:text/tei:body/tei:div[@type='calendar']">

                <div class="column is-half-desktop is-full-tablet">
                  <h3 class="title is-3">
                    <xsl:value-of select="tei:label"/>
                  </h3>

                  <table class="table">

                    <thead>
                      <tr>

                        <th></th>

                        <xsl:for-each select="tei:div">
                          <xsl:variable name="language" select="@xml:lang" />

                          <th><xsl:value-of select="/tei:teiCorpus/tei:teiHeader/tei:profileDesc/tei:langUsage/tei:language[@ident=$language]" /></th>
                        </xsl:for-each>

                      </tr>
                    </thead>

                    <tbody>
                      <xsl:for-each select="tei:div[1]/tei:entry">
                        <xsl:variable name="month" select="@n" />

                        <tr>
                          <th class="has-text-right"><xsl:value-of select="$month" /></th>

                          <xsl:for-each select="../../tei:div/tei:entry[@n=$month]">
                            <td>
                              <span><xsl:value-of select="tei:form/tei:orth[@type='standard']" /></span>
                              <xsl:if test="tei:form/tei:orth[@type='transliterated']">
                                <br/>
                                <em><xsl:value-of select="tei:form/tei:orth[@type='transliterated']" /></em>
                              </xsl:if>
                            </td>
                          </xsl:for-each>
                        </tr>

                      </xsl:for-each>
                    </tbody>

                  </table>

                </div>

              </xsl:for-each>

            </div>

          </div>
        </section>
<hr/>
        <section class="section" id="compare-lang">
          <div class="container">

          <h1 class="title is-2">Compare by Language</h1>

            <xsl:for-each select="tei:text/tei:body/tei:div[@type='calendar']">
              <xsl:variable name="calendar" select="@xml:id" />

              <h3 class="title is-3">
                <xsl:value-of select="tei:label"/>
              </h3>

              <table class="table">

                <thead>
                  <!-- witnesses with names from this calendar -->
                  <tr class="has-background-dark">
                    <th colspan="2"></th>

                    <xsl:for-each select="/tei:teiCorpus/tei:TEI[tei:text/tei:body//tei:w[starts-with(@lemmaRef, $calendar)]]">

                      <th class="has-text-light">
                        <abbr>
                          <xsl:attribute name="title">
                            <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository/tei:name" />
                          </xsl:attribute>

                          <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository/tei:abbr" />
                        </abbr>
                        <xsl:text> </xsl:text>
                        <abbr>
                          <xsl:attribute name="title">
                            <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:collection/tei:name" />
                          </xsl:attribute>

                          <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:collection/tei:abbr" />
                        </abbr>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno" />
                      </th>

                    </xsl:for-each>
                  </tr>
                </thead>

                <xsl:for-each select="tei:div[not(@xml:lang='gez')]">
                  <xsl:variable name="language" select="@xml:lang" />

                  <!-- check if there is a witness with this language -->
                  <xsl:if test="/tei:teiCorpus/tei:TEI[tei:text/tei:body//tei:w[starts-with(@lemmaRef, concat($calendar, '/', $language))]]">

                    <tbody>

                      <tr class="has-background-light">
                        <th>
                          <xsl:attribute name="colspan">
                            <xsl:value-of select="2+count(/tei:teiCorpus/tei:TEI[tei:text/tei:body//tei:w[starts-with(@lemmaRef, $calendar)]])" />
                          </xsl:attribute>

                          <xsl:value-of select="/tei:teiCorpus/tei:teiHeader/tei:profileDesc/tei:langUsage/tei:language[@ident=$language]" />
                        </th>
                      </tr>

                      <xsl:for-each select="tei:entry">
                        <xsl:variable name="month" select="@n" />
                        <xsl:variable name="lemmaRef" select="concat($calendar, '/', $language, '/', $month)" />

                        <tr>

                          <th class="has-text-right"><xsl:value-of select="$month" /></th>

                          <th>
                            <span><xsl:value-of select="tei:form/tei:orth[@type='standard']" /></span>
                            <xsl:if test="tei:form/tei:orth[@type='transliterated']">
                              <br/>
                              <em><xsl:value-of select="tei:form/tei:orth[@type='transliterated']" /></em>
                            </xsl:if>
                          </th>

                          <xsl:for-each select="/tei:teiCorpus/tei:TEI[tei:text/tei:body//tei:w[starts-with(@lemmaRef, $calendar)]]">

                            <xsl:choose><!-- how to handle case where one witness has multiple occurrences? -->
                              <xsl:when test=".//tei:w[@lemmaRef=$lemmaRef]">
                                <td><xsl:value-of select=".//tei:w[@lemmaRef=$lemmaRef]" /></td>
                              </xsl:when>

                              <xsl:otherwise>
                                <td>——</td>
                              </xsl:otherwise>
                            </xsl:choose>

                          </xsl:for-each>

                        </tr>

                      </xsl:for-each>

                    </tbody>

                  </xsl:if>

                </xsl:for-each>

              </table>

            </xsl:for-each>

          </div>
        </section>
<hr/>
        <section class="section" id="compare-month">
          <div class="container">

            <h1 class="title is-2">Compare by Month</h1>

            <xsl:for-each select="tei:text/tei:body/tei:div[@type='calendar']">
              <xsl:variable name="calendar" select="@xml:id" />

              <h3 class="title is-3">
                <xsl:value-of select="tei:label"/>
              </h3>

              <table class="table">

                <thead>
                  <!-- witnesses with names from this calendar -->
                  <tr class="has-background-dark">
                    <th colspan="2"></th>

                    <xsl:for-each select="/tei:teiCorpus/tei:TEI[tei:text/tei:body//tei:w[starts-with(@lemmaRef, $calendar)]]">

                      <th class="has-text-light">
                        <abbr>
                          <xsl:attribute name="title">
                            <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository/tei:name" />
                          </xsl:attribute>

                          <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository/tei:abbr" />
                        </abbr>
                        <xsl:text> </xsl:text>
                        <abbr>
                          <xsl:attribute name="title">
                            <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:collection/tei:name" />
                          </xsl:attribute>

                          <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:collection/tei:abbr" />
                        </abbr>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno" />
                      </th>

                    </xsl:for-each>
                  </tr>
                </thead>

                <xsl:for-each select="tei:div[1]/tei:entry">

                  <tbody>
                    <xsl:variable name="language1" select="../@xml:lang" />
                    <xsl:variable name="month" select="@n" />

                    <tr>

                      <th class="has-text-right">
                        <xsl:attribute name="rowspan">
                          <xsl:value-of select="count(../../tei:div[not(@xml:lang='gez')])" />
                        </xsl:attribute>

                        <xsl:value-of select="$month" />
                      </th>

                      <th>
                        <span><xsl:value-of select="tei:form/tei:orth[@type='standard']" /></span>
                        <xsl:if test="tei:form/tei:orth[@type='transliterated']">
                          <br/>
                          <em><xsl:value-of select="tei:form/tei:orth[@type='transliterated']" /></em>
                        </xsl:if>
                      </th>

                      <!-- foreach witness first language... -->
                      <xsl:variable name="lemmaRef1" select="concat($calendar, '/', $language1, '/', $month)" />

                      <xsl:for-each select="/tei:teiCorpus/tei:TEI[tei:text/tei:body//tei:w[starts-with(@lemmaRef, $calendar)]]">

                        <td>
                          <xsl:choose><!-- how to handle case where one witness has multiple occurrences? -->
                            <xsl:when test=".//tei:w[@lemmaRef=$lemmaRef1]">
                              <xsl:value-of select=".//tei:w[@lemmaRef=$lemmaRef1]" />
                            </xsl:when>

                            <xsl:otherwise>
                              <xml:text>——</xml:text>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>

                      </xsl:for-each>

                    </tr>

                    <xsl:for-each select="../../tei:div[position()>1][not(@xml:lang='gez')]">
                      <xsl:variable name="language" select="@xml:lang" />
                    
                      <tr>

                        <th>
                          <span><xsl:value-of select="tei:entry[@n=$month]/tei:form/tei:orth[@type='standard']" /></span>
                          <xsl:if test="tei:entry[@n=$month]/tei:form/tei:orth[@type='transliterated']">
                            <br/>
                            <em><xsl:value-of select="tei:entry[@n=$month]/tei:form/tei:orth[@type='transliterated']" /></em>
                          </xsl:if>
                        </th>

                        <!-- foreach witness... -->
                        <xsl:variable name="lemmaRef" select="concat($calendar, '/', $language, '/', $month)" />

                        <xsl:for-each select="/tei:teiCorpus/tei:TEI[tei:text/tei:body//tei:w[starts-with(@lemmaRef, $calendar)]]">

                          <xsl:choose><!-- how to handle case where one witness has multiple occurrences? -->
                            <xsl:when test=".//tei:w[@lemmaRef=$lemmaRef]">
                              <td><xsl:value-of select=".//tei:w[@lemmaRef=$lemmaRef]" /></td>
                            </xsl:when>

                            <xsl:otherwise>
                              <td>——</td>
                            </xsl:otherwise>
                          </xsl:choose>

                        </xsl:for-each>

                      </tr>
                    </xsl:for-each>

                  </tbody>

                </xsl:for-each>

              </table>

            </xsl:for-each>

          </div>
        </section>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
