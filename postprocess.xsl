<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
  <xsl:output method="xml"/>

  <xsl:template match="/">
    <network>
      <xsl:for-each select="//site">
        <xsl:sort select="title" />
        <xsl:if test="string-length(title) > 0">
          <xsl:copy>
            
            <xsl:attribute name="url">
              <xsl:value-of select="@url" />
            </xsl:attribute>
          
            <xsl:copy-of select="title"/>
            
            <!-- 
                 In a group of sites with the same page title (they
                 are considered to be dupes), tags and relations are
                 kept only for the site with the biggest count of
                 relations. For other sites in a group of dupes, only
                 page titles are preserved.
                 (XSLT 2.0 has grouping feautures)
            -->
            
            <xsl:if test="count(following::site[title=current()/title][count(./relations/rel)>=count(current()/relations/rel)])=0">
              
              <xsl:copy-of select="relations"/>

              <tags>
                <xsl:for-each select="tags/tag">
                  <xsl:sort/>
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