<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
  <xsl:output method="xml"/>

  <xsl:template match="/">
    <network>
      <xsl:for-each select="//site">
        <xsl:sort select="@url" />
        <xsl:sort select="count(relations/rel)" />
        <xsl:if test="string-length(title) > 0">
          <xsl:copy>
            
            <xsl:attribute name="url">
              <xsl:value-of select="@url" />
            </xsl:attribute>
            
            <xsl:copy-of select="title"/>
          
            <!-- 
               Tags and relations are kept only for the last site in a
               group of sites with the same page title (they are
               considered to be dupes). For other sites in a group of
               dupes, only page titles are preserved.
            -->
  
            <xsl:if test="count(following::site[title=current()/title]) = 0">
              
              <xsl:copy-of select="relations"/>

              <tags>
                <xsl:for-each select="tags/tag">
                  <xsl:sort/>
                  <!--
                      Write several occurences of the same tag as one
                      `tag` element with proper `count` attribute
                  -->
                  <!--
                      <xsl:if test="count(following::tag[.=current()]) = 0">
                      <xsl:copy>
                      <xsl:attribute name="count">
                      <xsl:value-of select="count(..//tag[.=current()])"/>
                      </xsl:attribute>
                      <xsl:value-of select="." />
                      </xsl:copy>
                      </xsl:if>
                  -->
                  <!-- (just copy tags for now) -->
                  <xsl:copy-of select="." />
                </xsl:for-each>
              </tags>

            </xsl:if>

          </xsl:copy>

        </xsl:if>

      </xsl:for-each>
    </network>
  </xsl:template>

</xsl:stylesheet>