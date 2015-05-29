<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:php="http://php.net/xsl">

<xsl:output 
 method="html"
 doctype-public="-//W3C//DTD HTML 4.01//EN"
 doctype-system="http://www.w3.org/TR/html4/strict.dtd"
 encoding="utf-8" 
 indent="no"/>

<xsl:template match="node()|@href">
     <xsl:copy>
       <xsl:apply-templates/>
     </xsl:copy>
</xsl:template>

<!--<xsl:template match="p[normalize-space()=''|descendant::*[normalize-space()=''] and not(descendant::*[normalize-space()!=''])|normalize-space() = '\u0160']"/>-->


<xsl:template match="/tema">
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css"  />
    <link rel="stylesheet" href="css/style.css" />
    <xsl:if test="count(content//table)">
        <link rel="stylesheet" href="css/table.css" />
    </xsl:if>
    <xsl:if test="content/*/*/span[@class = 'wrapper-dropdown-1']">
        <link rel="stylesheet" href="css/dd.css" />
        <link rel="stylesheet" href="css/ej.css" />
    </xsl:if>
<meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
<div class="container-fluid" style="width:100%;">
    <div class="row" id="cabecera">
        <div class="col-md-2">
        </div>
        <div class="col-md-10">
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <xsl:apply-templates select="nav"/>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12 text">
            <h2><xsl:apply-templates select="title" mode="titulo"/></h2>
            <xsl:apply-templates select="content"/>
            <div class="navFooter">
                <xsl:apply-templates select="pie/prev"/>
                <a class="nav-botn" style="float:left" target="_parent">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$url" />
                    </xsl:attribute>
                    Volver
                </a>
                <xsl:apply-templates select="pie/next"/>
            </div>
        </div>
    </div>
</div>
    <xsl:if test="content/*/*/span[@class = 'wrapper-dropdown-1']">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    </xsl:if>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
</body>
</html>
</xsl:template>

<xsl:template match="title" mode="titulo">
    <xsl:value-of select="." />
</xsl:template>

<xsl:template match="nav">
    <nav class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Desplegar o colapsar menú</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Menú</a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <xsl:apply-templates match="menu" />
            </div>
        </div>
    </nav>
</xsl:template>

<xsl:template match="menu">
    <ul class="nav navbar-nav">
        <xsl:apply-templates select="node()" />
    </ul>
</xsl:template>

<xsl:template match="menu-item">
    <li> 
        <!-- on hold till a solution for repeated titles is found
        <xsl:if test="(./text() = ancestor::tema[1]/title/text() or submenu/menu-item = ancestor::tema[1]/title/text())">
            <xsl:attribute name="class">
                active dropdown
            </xsl:attribute>
        </xsl:if>
        -->
        <xsl:if test="submenu/menu-item">
            <xsl:attribute name="class">
               dropdown 
            </xsl:attribute>
        </xsl:if>
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="php:function('normMenu', string(./text()))" />
            </xsl:attribute>
            <xsl:if test="submenu/menu-item">
                <xsl:attribute name="data-toggle">dropdown</xsl:attribute><xsl:attribute name="class">dropdown-toggle disabled</xsl:attribute><xsl:attribute name="role">button</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="./text()" />
            <xsl:if test="submenu/menu-item">
                <span class="caret">
                </span>
            </xsl:if>
        </a>
        <!-- if has submenu children -->
        <xsl:if test="submenu/menu-item">
            <ul class="dropdown-menu" role="menu">
                <xsl:apply-templates select="submenu/menu-item" mode="submenu"/>
            </ul>
        </xsl:if>
    </li>
</xsl:template>

<xsl:template match="menu-item" mode="submenu">
    <li>
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="php:function('normMenu', string(./text()))" />
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
                <xsl:value-of select="php:function('normNext', string(.))" />
            </xsl:attribute>
            Siguiente
            <span aria-hidden="true">→</span>
        </a> 
</xsl:template>

<xsl:template match="prev">
        <a style="float:left;" class="nav-botn">
            <xsl:attribute name="href">
                <xsl:value-of select="php:function('normPrev', string(.))" />
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

  <xsl:template match="div[@class='img']">
    <xsl:apply-templates mode="img"/>
  </xsl:template>
  
  <xsl:template match="p" mode="img" >
    <img>
    	<xsl:attribute name="src">
          <xsl:value-of select="./node()" />
    	</xsl:attribute>
    </img>
  </xsl:template>

    <xsl:include href="components/caluga.xsl" />
    <xsl:include href="components/articulate.xsl" />
    <xsl:include href="components/popup.xsl" />
    <xsl:include href="components/ejercicio.xsl" />
    <xsl:include href="components/reescritura.xsl" />

<!--
<xsl:template match="p[not(normalize-space(text())!='')]" priority="1000" />
-->
<xsl:template match="p[text()='&#160;']" priority="1000" />

</xsl:stylesheet>
