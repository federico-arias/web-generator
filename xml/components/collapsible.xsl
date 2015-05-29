<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="div[@class='collapsible']">
        <xsl:apply-templates select='table' mode='collapsible' />
    </xsl:template>

    <xsl:template match="table" mode='collapsible' >
            <ul class="collapsible-list">
                    <xsl:apply-templates select="tr" mode='collapsible' />
            </ul>
    </xsl:template>

    <xsl:template match="tr" mode="collapsible">
        <li class="collapsible-list__item--collapsed">
            <a>
                <span class="arrow-left"></span>
                <xsl:value-of select="td[1]" />
            </a>
            <div>
                <xsl:copy-of select="td[2]/node()" />
            </div>
        </li>
    </xsl:template>

</xsl:stylesheet>
