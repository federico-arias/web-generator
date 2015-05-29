<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="table[parent::div[@class='popup']]" >
            <xsl:apply-templates select="tr/td" mode="popup" />
    </xsl:template>

    <xsl:template match="tr/td[1]" mode="popup">
        <span class="pu-contenido">
            <xsl:value-of select="./node()" />
        </span>
    </xsl:template>

    <xsl:template match="tr/td[2]" mode="popup">
        <span class="pu-tooltip">
            <xsl:value-of select="./node()" />
        </span>
    </xsl:template>

</xsl:stylesheet>
