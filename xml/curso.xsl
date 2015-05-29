<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="no" version="1.0" encoding="utf-8" indent="no"/>
<!-- groups of h2 have the same id -->
<xsl:key name="h2" match="h2" use="generate-id(preceding-sibling::h1[1])" />
<xsl:key name="h3" match="h3" use="generate-id(preceding-sibling::h2[1])" />
<xsl:strip-space elements="*"/>

  <xsl:template match="node()|@src">
      <xsl:apply-templates select="node()"/>
  </xsl:template>

<!--

  <xsl:template match="font" />

  <xsl:template match="div">
    <xsl:apply-templates select="*"/>
  </xsl:template>
-->

<xsl:template match="/html/body">
    <temas>
        <xsl:for-each select="h1 | h2 | h3" >
            <xsl:variable name="h" select="."/>
            <tema>
                <filename>
                    <xsl:value-of select="concat(count(preceding-sibling::h1), .)"/>
                </filename>
              <title><xsl:value-of select="." /></title>
                <nav>
                    <menu>
                        <xsl:apply-templates select="/html/body/h1" mode="nav">
                            <xsl:with-param name="tema" select="$h" />
                        </xsl:apply-templates>
                    </menu>
                </nav>
                <content>
                  <xsl:apply-templates select="." mode="body"/>
                </content>
                <pie>
                  <xsl:apply-templates select="." mode="footer"/>
                </pie>
            </tema>
        </xsl:for-each>
    </temas>
</xsl:template>

<xsl:template match="h1 | h2 | h3"  mode="nav">
    <xsl:param name="tema"/>
    <menu-item>
        <xsl:attribute name="active">
            <xsl:if test="generate-id($tema) = generate-id()">yes</xsl:if>
        </xsl:attribute>
        <xsl:attribute name="module">
            <xsl:value-of select="count(./preceding-sibling::h1)" />
        </xsl:attribute>
        <xsl:value-of select="."/>
        <xsl:variable name="h2" select="key('h2', generate-id())" />       
        <xsl:variable name="h3" select="key('h3', generate-id())" />       
        <xsl:if test="$h2">
            <submenu>
                <xsl:apply-templates select="$h2" mode="nav">
                    <xsl:with-param name="tema" select="$tema" />
                </xsl:apply-templates>
            </submenu>
        </xsl:if>
        <xsl:if test="$h3">
            <submenu>
                <xsl:apply-templates select="$h3" mode="nav">
                    <xsl:with-param name="tema" select="$tema" />
                </xsl:apply-templates>
            </submenu>
        </xsl:if>
    </menu-item>
  </xsl:template>
  
  <xsl:template match="h1" mode="body">
    <xsl:apply-templates select="following-sibling::*[preceding-sibling::h1[1] = current()][not(self::h1)][not(self::h2)][not(preceding-sibling::h2[preceding-sibling::h1 = current()])]" mode="dele" />
  </xsl:template>

  <xsl:template match="node()" mode="dele" priority="1" >
      <xsl:copy-of select=".">
      </xsl:copy-of>
  </xsl:template>

  <xsl:template match="p/*/font|*/*/attribute::*" mode="dele" priority="2">
  </xsl:template>
  <xsl:template match="p/span|p/*/span|p/*/*/span" mode="dele" priority="3">
      <xsl:value-of select="." />
  </xsl:template>
   <!--matches all text beneath this h2 until next h2.
       if there is a h3 in between, ignore its content
       if there is a h1 in between, ignore its content
       matches all that follows current h2 EXCEPT:
       - another h{1,2,3}
       - anything preceded by an h1 AND that is after the current h2 (i.e., it is preceded by more h2s [one more exactly] than current h2 ) 
       - anything preceded by an h3 AND that is after the current h2 (i.e., whose NodeList of preceding h2s contains current h2)// doesn't work if two h2 have the same name

  -->
  <xsl:template match="h2" mode="body">
      <xsl:apply-templates select="following-sibling::*[generate-id(preceding-sibling::h2[1]) = generate-id(current())]
          [not(self::h1)][not(self::h2)][not(self::h3)]
          [not(preceding-sibling::h1[count(./preceding-sibling::h2)>count(current()/preceding-sibling::h2)])]
          [not(preceding-sibling::h3[count(./preceding-sibling::h2)>count(current()/preceding-sibling::h2)])]" mode="dele" />
  </xsl:template>

  <xsl:template match="h3" mode="body">
   <xsl:apply-templates select="following-sibling::*[preceding-sibling::h3[1] = current()][not(self::h1)][not(self::h2)][not(self::h3)][not(preceding-sibling::h1[preceding-sibling::h3 = current()])][not(preceding-sibling::h2[preceding-sibling::h3 = current()])]" mode="dele" />
  </xsl:template>

<xsl:template match="h1" mode="footer">
    <xsl:variable name="prev" select="preceding-sibling::h1[1][following-sibling::h1[1] = current()][not(following-sibling::h2[following-sibling::h1 = current()])][not(following-sibling::h3[following-sibling::h1 = current()])]|preceding-sibling::h2[1][following-sibling::h1[1] = current()][not(following-sibling::h3[following-sibling::h1 = current()])]" />       
    <xsl:variable name="next" select="following-sibling::h1[preceding-sibling::h1[1] = current()][not(preceding-sibling::h2[preceding-sibling::h1 = current()])][not(preceding-sibling::h3[preceding-sibling::h1 = current()])]|following-sibling::h2[1][preceding-sibling::h1[1] = current()][not(preceding-sibling::h3[preceding-sibling::h1 = current()])][not(preceding-sibling::h1[preceding-sibling::h1 = current()])]" /> 
    <xsl:if test="$prev">
        <prev>
            <xsl:attribute name="module">
                <xsl:value-of select="count($prev/preceding-sibling::h1)" />
            </xsl:attribute>
            <xsl:value-of select="$prev" />
        </prev>
    </xsl:if>
    <xsl:if test="$next">
        <next>
            <xsl:attribute name="module">
                <xsl:value-of select="count($next/preceding-sibling::h1)" />
            </xsl:attribute>
            <xsl:value-of select="$next" />
        </next>
    </xsl:if>
</xsl:template>

<xsl:template match="h2" mode="footer">
    <!--<xsl:variable name="prev" select="preceding-sibling::h1[1][following-sibling::h2[1] = current()][not(following-sibling::h1[following-sibling::h2 = current()])][not(following-sibling::h3[following-sibling::h2 = current()])]|preceding-sibling::h2[1][following-sibling::h2[1] = current()][not(following-sibling::h3[following-sibling::h2 = current()])]
        |
        preceding-sibling::h3[1][following-sibling::h2[1] = current()]" 
        />   -->
        <!-- inmediately preceeding header (h) ?
             h1[1] IF that h1's first child is = current
             h2[1] IF both have the same parent AND h2[1] has no children (i.e., inmediately preceding h3 has h2[1] for parent) 
             h3[1] IF 
         -->
    <xsl:variable name="prev" select="
        preceding-sibling::h2[1][preceding-sibling::h1[1] = current()/preceding-sibling::h1[1]]
            [not(preceding-sibling::h3[1][generate-id(preceding-sibling::h2[1]) = generate-id(current())])]
        |
        preceding-sibling::h1[1][following-sibling::h2[1] = current()]
        "/>   
    <!-- 
        Old xpath that does not work and that i don't understand
        following-sibling::h1[1][preceding-sibling::h2[1] = current()][not(preceding-sibling::h1[preceding-sibling::h2 = current()])][not(preceding-sibling::h3[preceding-sibling::h2 = current()])]|following-sibling::h2[1][preceding-sibling::h2[1] = current()][not(preceding-sibling::h3[preceding-sibling::h2 = current()])]
    -->
    <xsl:variable name="next" select="
        following-sibling::h1[1][preceding-sibling::h2[1] = current()][not(preceding-sibling::h3[preceding-sibling::h2[1] = current()])]
        |
        following-sibling::h2[1][preceding-sibling::h1[1] = current()/preceding-sibling::h1[1]][not(preceding-sibling::h3[preceding-sibling::h2[1] = current()])]
        |
        following-sibling::h3[1][preceding-sibling::h2[1] = current()]" /> 
    <xsl:if test="$prev">
        <prev>
            <xsl:attribute name="module">
                <xsl:value-of select="count($prev/preceding-sibling::h1)" />
            </xsl:attribute>
            <xsl:value-of select="$prev" />
        </prev>
    </xsl:if>
    <xsl:if test="$next">
        <next>
            <xsl:attribute name="module">
                <xsl:value-of select="count($next/preceding-sibling::h1)" />
            </xsl:attribute>
            <xsl:value-of select="$next" />
        </next>
    </xsl:if>
</xsl:template>

<xsl:template match="h3" mode="footer">
    <xsl:variable name="prev" select="
        preceding-sibling::h2[1][following-sibling::h3[1] = current()]
        |
        preceding-sibling::h3[1][preceding-sibling::h2[1] = current()/preceding-sibling::h2[1]]
        "/>   

    <!-- 'next' logic
       DETECT IF FOLLOWED BY 
           SAME LEVEL: both have the same parent 
           INFERIOR LEVEL: if it is his parent (i.e if the inmediately preceeding superior is the current node)
           SUPERIOR LEVEL: if it is preceded by current AND there are no h3 in between (i.e. the first ocurrence of h3 is NOT preceded first by current)
     -->

    <xsl:variable name="next" select="
        following-sibling::h3[1][preceding-sibling::h2[1] = current()/preceding-sibling::h2[1]]
        |
        following-sibling::h2[1][preceding-sibling::h3[1] = current()]
        "/> 
    <xsl:if test="$prev">
        <prev>
            <xsl:attribute name="module">
                <xsl:value-of select="count($prev/preceding-sibling::h1)" />
            </xsl:attribute>
            <xsl:value-of select="$prev" />
        </prev>
    </xsl:if>
    <xsl:if test="$next">
        <next>
            <xsl:attribute name="module">
                <xsl:value-of select="count($next/preceding-sibling::h1)" />
            </xsl:attribute>
            <xsl:value-of select="$next" />
        </next>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
