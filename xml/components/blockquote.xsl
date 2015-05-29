<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="div[@class='blockquote']" >
        <xsl:apply-templates select="table" mode="bq" />
    </xsl:template>

    <xsl:template match="table" mode="bq">
        <div class="mb-wrap mb-style-3">
            <blockquote>
                <p>
                <xsl:value-of select="tr[2]/td" />
                </p>
            </blockquote>
            <div class="mb-attribution">
                <p class="mb-author">
                    <xsl:value-of select="tr[3]/td" />
                </p>
                <xsl:if test="tr[4]">
                    <cite>
                        <a>
                            <xsl:value-of select="tr[4]/td" />
                        </a>
                    </cite>
                </xsl:if>
                <div class="mb-thumb">
                    <xsl:attribute name="style">
                        <xsl:value-of select="concat('background-image:url(', tr[1]/td, ')')" />
                    </xsl:attribute>
                </div>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>
