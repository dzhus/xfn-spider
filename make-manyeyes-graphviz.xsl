<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
  <xsl:output method="text" indent="no"/>
  
  <!--
      This stylsheet extracts data from XFN Spider output and produces
      a DOT file with a map of network nodes.
      
      DOT is a Graphviz file format.

      http://www.graphviz.org/
  -->

  <xsl:template match="/">
    digraph G {
    <xsl:for-each select="//site[count(relations/rel) > 0]">
      <xsl:for-each select="relations/rel">
        "<xsl:call-template name="label-by-url">
          <xsl:with-param name="url" select="../../@url" />
        </xsl:call-template>"
        <xsl:text>-></xsl:text>
        "<xsl:call-template name="label-by-url">
          <xsl:with-param name="url" select="@url" />
        </xsl:call-template><xsl:text>";
        </xsl:text>
      </xsl:for-each>
    </xsl:for-each>
    }
  </xsl:template>
  
  <xsl:template name="label-by-url">
    <xsl:param name="url" />
    <xsl:choose>
      <xsl:when test="string-length(//site[@url=$url]/title) > 0">
        <xsl:value-of select="//site[@url=$url]/title" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@url" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>