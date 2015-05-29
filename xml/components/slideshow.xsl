<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="div[@class='slideshow']/table">
        <xsl:apply-templates select='.' mode='slideshow' />
    </xsl:template>

    <xsl:template match="table" mode='slideshow' >
            <ul class="sl-slides">
                    <xsl:apply-templates select="tr" mode='slideshow' />
            </ul>
            <div class="ss-navbar">
                <div class="ss-next" id="next"></div>
                <div class="ss-progress">
                    <div class="ss-progress-indicator"></div>
                </div>
                <div class="ss-prev" id="prev"></div>
            </div>
    </xsl:template>

    <xsl:template match="tr" mode="slideshow">
        <li>
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </img>
        </li>
    </xsl:template>

</xsl:stylesheet>
