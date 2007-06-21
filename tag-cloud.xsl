<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
  <xsl:output method="text" />

  <xsl:template match="/">
    <xsl:for-each select="//tag">
      <xsl:sort />
      <xsl:if test="count(following::tag[.=current()]) = 0">
        <xsl:value-of select="."/> <xsl:value-of select="count(//tag[.=current()])" />
        <xsl:text>
</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>