<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:php="http://php.net/xsl">
    <xsl:output 
        method="html"
        doctype-public="-//W3C//DTD HTML 4.01//EN"
        doctype-system="http://www.w3.org/TR/html4/strict.dtd"
        encoding="utf-8" indent="yes"/>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template name="back">
        <a class="back">
            <xsl:attribute name="href">
                <xsl:value-of select="$url" />
            </xsl:attribute>
            Volver al curso
        </a> 
    </xsl:template>

    <xsl:template match="tema">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="css/style.css" />
                <title>
                    <xsl:value-of select="title" />
                </title>
            </head>
            <body>
                <div id="content">
                    <div id="emptyHeader"></div>
                    <div id="siteNav">
                        <xsl:apply-templates select="nav"/>
                    </div>
                    <div id="main">
                        <div id="nodeDecoration">
                            <h1 id="nodeTitle">
                                <xsl:value-of select="title" />
                            </h1>
                        </div>
                        <div class="FreeTextIdevice" id="id0">
                            <div class="iDevice emphasis0">
                                <div id="ta0_1" class="block" style="display:block;position:relative">
                                    <xsl:apply-templates select="content/node()" />
                                </div> <!--ta0_1-->	
                            </div><!-- iDevice -->
                        </div><!-- FreeTextIdevice -->
                        <div id="bottomPagination">
                            <div class="pagination noprt">
                                <xsl:apply-templates select="pie/prev" />
                                <xsl:call-template name="back" ></xsl:call-template>
                                <xsl:apply-templates select="pie/next" />
                            </div>
                        </div> <!--bottomPagination -->
                    </div><!-- main -->
                </div><!-- content -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
                <script type="text/javascript" src="js/main.js"></script>
            </body>
        </html>

    </xsl:template>

    <xsl:template match="next">
        <a class="next">
            <xsl:attribute name="href">
                <xsl:value-of select="php:function('normMenu', concat(attribute::module, ./text()))" />
            </xsl:attribute>
            Siguiente
            <span>&#187;</span>
        </a> 
    </xsl:template>

    <xsl:template match="prev">
        <a class="prev">
            <xsl:attribute name="href">
                <xsl:value-of select="php:function('normMenu', concat(attribute::module, ./text()))" />
            </xsl:attribute>
            <span>&#171;</span>
            Anterior
        </a> 
    </xsl:template>

    <xsl:template match="nav">
        <xsl:apply-templates select="menu" />
    </xsl:template>

    <xsl:template match="menu">
        <ul>
            <xsl:apply-templates select="node()" />
        </ul>
    </xsl:template>

    <xsl:template match="menu-item" >
            <li>
                <!--<xsl:if test="normalize-space(text()) = normalize-space(ancestor::tema[1]/title/text())">-->
                <xsl:if test="attribute::active = 'yes'">
                    <xsl:attribute name="id">
                        <xsl:text>active</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <a>
                    <xsl:attribute name="href">
                        <!--<xsl:value-of select="php:function('normMenu', string(./text()))" />-->
                        <xsl:value-of select="php:function('normMenu', concat(attribute::module, ./text()))" />
                    </xsl:attribute>
                    <xsl:attribute name="class">
                        <xsl:if test="count(submenu)">daddy</xsl:if>
                        <xsl:if test="ancestor::nav/menu/menu-item[1] = current()">
                            <xsl:text> main-node</xsl:text>
                        </xsl:if>
                        <!--<xsl:if test="ancestor::tema[1]/title/text() = ./text()">-->
                        <xsl:if test="attribute::active = 'yes'">
                            <xsl:text> active</xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:value-of select ="./text()" />
                </a>
                <xsl:if test="submenu">
                    <ul>
                        <xsl:attribute name="class">
                            <!-- if any descendant, parent menu-item or self is not active (i.e. equal to <title>), apply 'other-section' class 

                            <xsl:if test="not(submenu/menu-item/text() = (ancestor::tema)[1]/title/text() or ./text() = (ancestor::tema)[1]/title/text() or submenu/menu-item/submenu/menu-item = (ancestor::tema)[1]/title/text())">-->
                            <xsl:if test="not(descendant-or-self::*/attribute::active = 'yes')">
                                <xsl:text> other-section</xsl:text> 
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:apply-templates select="submenu/menu-item" />
                    </ul>
                </xsl:if>
            </li>
    </xsl:template>


    <xsl:include href="components/img.xsl" />
    <xsl:include href="components/articulate.xsl" />
    <xsl:include href="components/accordion.xsl" />
    <xsl:include href="components/figure.xsl" />
    <xsl:include href="components/blockquote.xsl" />
    <xsl:include href="components/definicion.xsl" />
    <xsl:include href="components/collapsible.xsl" />

</xsl:stylesheet>
