<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
  <xsl:output method="text" indent="no"/>
  
  <!--
      This stylsheet extracts data from XFN Spider output to make it
      usable with ManyEyes tag cloud visualization.
      
      http://services.alphaworks.ibm.com/manyeyes/
      http://services.alphaworks.ibm.com/manyeyes/page/Tag_Cloud.html
      
      Based on `make-manyeyes-network.xsl`
  -->

  <xsl:template match="/">
    <xsl:for-each select="//tag[string-length(.)>0]">
      <!--
          Write several occurences of the same tag as one
          `tag` element with proper `count` attribute
      -->
      <xsl:if test="count(following::tag[.=current()])=0">
        <xsl:value-of select="." />

        <xsl:text>	</xsl:text>

        <xsl:value-of select="count(..//tag[.=current()])"/><xsl:text>
</xsl:text>
      </xsl:if>
      
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>