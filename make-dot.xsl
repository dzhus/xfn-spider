<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="xhtml"
                >
  <xsl:output method="text"/>

  <xsl:template match="/">
    digraph G 
    {
    <xsl:apply-templates />
    }
  </xsl:template>
  
  <xsl:template match="site">
    <xsl:if test="count(relations/rel)">
      "<xsl:call-template name="label-by-url">
      <xsl:with-param name="url" select="@url" />
      </xsl:call-template>" ->
      {
      <xsl:for-each select="relations/rel">
        "<xsl:call-template name="label-by-url">
        <xsl:with-param name="url" select="@url" />
        </xsl:call-template>";
      </xsl:for-each>
      }
    </xsl:if>
  </xsl:template>
                      
  <xsl:template name="label-by-url">
    <xsl:param name="url" />
    <xsl:choose>
      <xsl:when test="string-length(//site[contains(@url,$url)]/title) > 0">
        <xsl:value-of select="//site[contains(@url,$url)]/title" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@url" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

