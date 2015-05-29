<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="div[@class='definicion']/table">
        <xsl:apply-templates select='.' mode='df' />
    </xsl:template>

    <xsl:template match="table" mode='df' >
        <span>
            <xsl:value-of select="tr[1]/td"/>
        </span>
        <xsl:if test="tr[3]">
            <div class="df-etim">
                <xsl:value-of select="tr[3]/td"/>
            </div>
        </xsl:if>
        <div class='df'>
            <xsl:value-of select="tr[2]/td" />
        </div>
    </xsl:template>

</xsl:stylesheet>
