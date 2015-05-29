<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="div[@class='reescritura']">
        <div class='reescritura'>
            <xsl:apply-templates />
            <div class="re-feedback"></div>
            <button id="re-corregir">Corregir</button><button disabled='disabled' id="re-reescribir">Reescribir</button>
        </div>
    </xsl:template>

</xsl:stylesheet>


