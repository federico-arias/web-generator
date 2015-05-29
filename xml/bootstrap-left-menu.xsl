<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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

<!--<xsl:template match="p[normalize-space()=''|descendant::*[normalize-space()=''] and not(descendant::*[normalize-space()!=''])|normalize-space() = '\u0160']"/>-->


<xsl:template match="/tema">
<html lang="es">
<head>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/style.css" />
    <xsl:if test="count(content//table)">
        <link rel="stylesheet" href="css/table.css" />
    </xsl:if>
    <xsl:if test="content/*/*/span[@class = 'wrapper-dropdown-1']">
        <link rel="stylesheet" href="css/dd.css" />
        <link rel="stylesheet" href="css/ej.css" />
    </xsl:if>
</head>
<body>
<div class="container-fluid" style="width:100%;">
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <a class="brand" href="http://app.datacare.cl/uvirtual/mdl_uchile">mdluchile</a>
      </div>
    </nav>
    <div class="row" id="cabecera">
        <div class="col-md-2">
        </div>
        <div class="col-md-10">
            <h2><xsl:apply-templates select="title" mode="titulo"/></h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
        </div>
        <div class="col-md-2">
            <xsl:apply-templates select="nav"/>
        </div>
        <div class="col-md-6 text">
            <xsl:apply-templates select="content"/>
            <div>
                <xsl:apply-templates select="pie/prev"/>
                <xsl:apply-templates select="pie/next"/>
            </div>
        </div>
    </div>
</div>
    <xsl:if test="content/*/*/span[@class = 'wrapper-dropdown-1']">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
    </xsl:if>
</body>
</html>
</xsl:template>

<xsl:template match="title" mode="titulo">
    <xsl:value-of select="." />
</xsl:template>

<xsl:template match="nav">
    <h3>Contenidos</h3>
    <div class="nav-container">
        <ul class="nav nav-pills nav-stacked">
            <xsl:apply-templates match="menu" />
        </ul>  
    </div>
</xsl:template>

<xsl:template match="menu">
    <xsl:apply-templates select="node()" />
</xsl:template>

<xsl:template match="menu-item">
    <li> 
        <xsl:if test=". = ancestor::tema[1]/child::title">
            <xsl:attribute name="class">
                active
            </xsl:attribute>
        </xsl:if>
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="concat(translate(normalize-space(./text()), 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ áéíóúüÁÉÍÓÚ¿?&gt;&lt;:,&#13;&#10;', 'abcdefghijklmnñopqrstuvwxyz-aeiouuaeiou--------'), '.html')" />
            </xsl:attribute>
            <xsl:value-of select="./text()" />
        </a>
    </li>
</xsl:template>


<xsl:template match="content">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="next">
        <a class="nav-botn">
            <xsl:attribute name="href">
                <xsl:value-of select="concat(translate(normalize-space(.), 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ áéíóúüÁÉÍÓÚ¿?&gt;&lt;:,&#13;&#10;', 'abcdefghijklmnñopqrstuvwxyz-aeiouuaeiou--------'), '.html')" />
            </xsl:attribute>
            Siguiente
            <span aria-hidden="true">→</span>
        </a> 
</xsl:template>

<xsl:template match="prev">
        <a style="float:left;" class="nav-botn">
            <xsl:attribute name="href">
                <xsl:value-of select="concat(translate(normalize-space(.), 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ áéíóúüÁÉÍÓÚ¿?&gt;&lt;:,&#13;&#10;', 'abcdefghijklmnñopqrstuvwxyz-aeiouuaeiou--------'), '.html')" />
            </xsl:attribute>
            <span aria-hidden="true">←</span>
            Anterior
        </a> 
</xsl:template>

<xsl:template match="table">
    <table class="table">
        <xsl:apply-templates select="@*|node()" />
    </table>
</xsl:template>

<!--
<xsl:template match="p[not(normalize-space(text())!='')]" priority="1000" />
-->
<xsl:template match="p[text()='&#160;']" priority="1000" />

</xsl:stylesheet>
