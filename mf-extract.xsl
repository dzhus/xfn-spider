<xsl:transform
    version="1.0"
    xmlns:xsl  = "http://www.w3.org/1999/XSL/Transform"
    xmlns:xhtml = "http://www.w3.org/1999/xhtml"
    exclude-result-prefixes = "xhtml"
    >
  <!-- 
       `mf-extract.xsl` extracts microformatted content from XHTML,
       resulting in valid `site` element of «mf-network» XML format.
       
       See also `network.dtd`.
       
       Inspired by grokXFN.xsl, see
       http://www.w3.org/2003/12/rdf-in-xhtml-xslts/grokXFN.xsl.
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
      <rss>
        <xsl:call-template name="rss-link">
          <xsl:with-param name="rss-url">
            <xsl:value-of select="//xhtml:link[@rel='alternate'][@type='application/rss+xml']/@href" />
          </xsl:with-param>
        </xsl:call-template>
      </rss>
      <relations>
        <xsl:apply-templates select="//xhtml:a[@rel]" />
      </relations>
      <tags>
        <xsl:for-each select="//xhtml:a[@rel='tag']">
          <tag>
            <!--
                Rather Bad case conversion example follows.
            -->
            <xsl:value-of select="translate(normalize-space(.), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
          </tag>
        </xsl:for-each>
      </tags>
    </site>
  </xsl:template>

  <xsl:template match="//xhtml:a[@rel]" name="rel-link">
    <xsl:choose>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' contact ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' friend ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' acquaintance ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' met ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' co-worker ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' colleague ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' co-resident ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' neighbor ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' child ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' parent ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' sibling ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' spouse ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' kin ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' muse ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' crush ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' date ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' sweetheart ')"><xsl:call-template name="xfn-link" /></xsl:when>
      <xsl:when test="contains(concat(' ', @rel, ' '), ' me ')"><xsl:call-template name="xfn-link" /></xsl:when>
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

  <xsl:template name="rss-link">
    <xsl:param name="rss-url" />
    <xsl:if test="string-length($rss-url)>0">
      <xsl:choose>
        <xsl:when test="starts-with($rss-url, 'http://')">
          <xsl:value-of select="$rss-url" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($site-url, $rss-url)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

</xsl:transform>
