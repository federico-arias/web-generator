<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
 <xsl:key name="kFollowing" match="p[@class='MsoListParagraphCxSpMiddle']|p[@class='MsoListParagraphCxSpLast']" use="generate-id(preceding-sibling::p[@class='MsoListParagraphCxSpFirst'][1])" />
  
 <xsl:template match="node()|@*" name="identity">
  <xsl:copy>
   <xsl:apply-templates select="node()|@*"/>
  </xsl:copy>
 </xsl:template>
  
 <xsl:template match="p[@class='MsoListParagraphCxSpFirst']">
  <List>
    <xsl:call-template name="identity"/>
    <xsl:apply-templates mode="copy" select="key('kFollowing', generate-id())"/>
  </List>
 </xsl:template>
  
  <xsl:template match="p" mode="copy">
    <li><xsl:call-template name="identity"/></li>
 </xsl:template>
  
  <xsl:template match="p[@class='MsoListParagraphCxSpMiddle']" />
 
  
  <xsl:template match="span[ancestor::p[@class='MsoListParagraphCxSpFirst']]"  />
  <xsl:template match="span[ancestor::p[@class='MsoListParagraphCxSpMiddle']]"  />
  <xsl:template match="span[ancestor::p[@class='MsoListParagraphCxSpLast']]"  />
  
</xsl:stylesheet>
