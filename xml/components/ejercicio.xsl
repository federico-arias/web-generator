<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="div[@class='ejercicio']">
        <div class='ejercicio'>
            <xsl:apply-templates />
            <div class="alert" id="feedback"></div>
            <div style="margin-top:14px;">
                <input type="button" id="assess" class="ejercicio-button" value="Comprobar respuestas"/>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>


