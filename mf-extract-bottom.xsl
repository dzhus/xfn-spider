<xsl:transform
    xmlns:xsl  = "http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xhtml = "http://www.w3.org/1999/xhtml"
    exclude-result-prefixes = "xhtml"
    >
  <!-- 
       `mf-extract.xfl` extracts microformatted content from XHTML,
       resulting in valid `site` element of «mf-network» XML format.
       
       See `mf-network.dtd`.
  -->

  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="site-url" />

  <xsl:template match="/">
    <site>
      <xsl:attribute name="url">
        <xsl:value-of select="$site-url" />
      </xsl:attribute>
      <title>
        <xsl:value-of select="normalize-space(//xhtml:title)" />
      </title>
    </site>
  </xsl:template>
</xsl:transform>
