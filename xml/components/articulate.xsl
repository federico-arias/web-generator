<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- to import <xsl:import href="articulate.xsl" /> -->
  <xsl:template match="div[@class='articulate']">
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="p[parent::div[@class='articulate']]" >
    <iframe>
    	<xsl:attribute name="src">
          <xsl:value-of select="./node()" />
    	</xsl:attribute>
    </iframe>
  </xsl:template>
  
</xsl:stylesheet>
