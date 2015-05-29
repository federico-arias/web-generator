<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="div[@class='accordion']">
        <xsl:apply-templates select='table' mode='accordion' />
    </xsl:template>

    <xsl:template match="table" mode='accordion' >
        <div class="st-accordion" id="st-accordion">
            <ul>
                <xsl:apply-templates select="tr" mode="accordion" />
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="tr" mode="accordion">
        <li>
            <a>
                <xsl:value-of select="td[1]" />
                <span class="st-arrow"></span>
            </a>
            <div class="st-content">
                <xsl:apply-templates select="td[2]" />
            </div>
        </li>
    </xsl:template>

</xsl:stylesheet>
