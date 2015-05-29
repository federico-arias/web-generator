<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="div[@class='figure']/table">
        <xsl:apply-templates select="tr" mode="figure" />
    </xsl:template>
  
    <xsl:template match="tr[1]" mode="figure" >
        <p>
            <img class="fg-scaled">
                <xsl:attribute name="src">
                    <xsl:value-of select="td/node()" />
                </xsl:attribute>
            </img>
        </p>
    </xsl:template>

    <xsl:template match="tr[2]" mode="figure" >
        <p>
            <xsl:value-of select="td/node()" />
        </p>
    </xsl:template>
</xsl:stylesheet>
