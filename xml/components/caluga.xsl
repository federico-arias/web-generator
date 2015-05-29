<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="table[parent::div[@class='caluga']]" >
            <xsl:apply-templates select="tr" mode="caluga" />
    </xsl:template>

    <xsl:template match="tr" mode="caluga">
        <div>
            <xsl:apply-templates select="td[1]" mode="caluga" />
        </div>
    </xsl:template>

    <xsl:template match="td" mode="caluga">
        <h1>
            <xsl:value-of select="./node()" />
        </h1>
        <p>
            <xsl:value-of select="following-sibling::td[1]" />
        </p>
        <h4>
            Excepciones
        </h4>
        <p>
            <xsl:value-of select="following-sibling::td[2]" />
        </p>
    </xsl:template>
</xsl:stylesheet>
