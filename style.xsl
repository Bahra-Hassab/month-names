<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" indent="no"/>

  <xsl:template match="tei:teiCorpus">
    <html lang="en" data-theme="light">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css"/>
      </head>
      <body>

        <xsl:for-each select="tei:text/tei:body/tei:div[@type='calendar']">
          <h3 class="title is-3">
            <xsl:value-of select="tei:label"/>
          </h3>

          <table class="table">

            <tr>

              <th></th>

              <xsl:for-each select="tei:div">
                <xsl:variable name="language" select="@xml:lang" />

                <th><xsl:value-of select="/tei:teiCorpus/tei:teiHeader/tei:profileDesc/tei:langUsage/tei:language[@ident=$language]" /></th>

              </xsl:for-each>

            </tr>

            <xsl:for-each select="tei:div[1]/tei:entry">
              <xsl:variable name="month" select="@n" />

              <tr>
                <th><xsl:value-of select="$month" /></th>

                <xsl:for-each select="../../tei:div/tei:entry[@n=$month]">
                  <td>
                    <span><xsl:value-of select="tei:form/tei:orth[@type='standard']"/></span>
                    <xsl:if test="tei:form/tei:orth[@type='transliterated']">
                      <br/>
                      <em><xsl:value-of select="tei:form/tei:orth[@type='transliterated']"/></em>
                    </xsl:if>
                  </td>
                </xsl:for-each>
              </tr>

            </xsl:for-each>

          </table>
        </xsl:for-each>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
