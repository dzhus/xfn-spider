<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
  <xsl:output method="xml" indent="no"/>
  
  <!--
      This stylsheet extracts data from XFN Spider output to produce
      list of RSS feeds in OPML format which may be used to import the
      list in a feed reading applications.
      
      See http://opml.org.
  -->

  <xsl:template match="/">
    <opml version="1.1">
      <body>
        <xsl:for-each select="//site[rss]">
          <xsl:element name="outline">
            <xsl:attribute name="type">rss</xsl:attribute>
            <xsl:attribute name="xmlUrl"><xsl:value-of select="rss" /></xsl:attribute>
          </xsl:element>
        </xsl:for-each>
      </body>
    </opml>
  </xsl:template>
  
</xsl:stylesheet>