<xsl:transform
    version="1.0"
    xmlns:xsl  = "http://www.w3.org/1999/XSL/Transform"
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
      <relations>
        <xsl:apply-templates select="//xhtml:a[@rel]" />
      </relations>
      <tags>
        <xsl:for-each select="//xhtml:a[@rel='tag']">
          <tag>
            <xsl:value-of select="translate(normalize-space(.), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
          </tag>
        </xsl:for-each>
      </tags>
    </site>
  </xsl:template>

  <xsl:template match="//xhtml:a[@rel]" name="rel-link">
    <xsl:choose>
      <xsl:when test="contains(@rel, 'contact')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'friend')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'acquaintance')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'met')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'co-worker')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'colleague')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'co-resident')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'neighbor')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'child')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'parent')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'sibling')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'spouse')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'kin')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'muse')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'crush')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'date')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(@rel, 'sweetheart')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:otherwise />
    </xsl:choose>
  </xsl:template>

  <xsl:template name="xfn-link">
    <rel>
      <xsl:attribute name="url">
        <xsl:value-of select="@href" />
      </xsl:attribute>
      <xsl:attribute name="type">
        <xsl:value-of select="@rel" />
      </xsl:attribute>
    </rel>
  </xsl:template>

</xsl:transform>
