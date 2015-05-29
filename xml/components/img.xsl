<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="div[@class='img']">
    <xsl:apply-templates mode="img"/>
  </xsl:template>
  
  <xsl:template match="p" mode="img" >
    <img>
    	<xsl:attribute name="src">
          <xsl:value-of select="./node()" />
    	</xsl:attribute>
    </img>
  </xsl:template>
  
</xsl:stylesheet>
