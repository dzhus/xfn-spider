<xsl:transform
    xmlns:xsl  = "http://www.w3.org/1999/XSL/Transform" version="1.0"
    >

  <xsl:output method = "text"
              omit-xml-declaration = "yes"
              indent = "no"
              />

  <xsl:template match="/">
    <xsl:apply-templates select="//rel" />
  </xsl:template>

  <xsl:template match="rel"><xsl:value-of select="@url" /><xsl:text>
</xsl:text>
  </xsl:template>

</xsl:transform>