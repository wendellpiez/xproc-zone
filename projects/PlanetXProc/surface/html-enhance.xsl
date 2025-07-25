<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xpath-default-namespace="http://www.w3.org/1999/xhtml"
  version="3.0">

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:template match="hr"/>
  
  <xsl:template match="body">
    <body>
      <xsl:for-each-group select="*" group-starting-with="h1">
        <xsl:choose>
          <xsl:when test="self::h1 => empty()">
            <xsl:apply-templates select="current-group()"/>
          </xsl:when>
          <xsl:otherwise>
            <section>
              <xsl:call-template name="level2-groups"/>
            </section>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each-group>
    </body>
  </xsl:template>
  
  <xsl:template name="level2-groups">
    <xsl:for-each-group select="current-group()" group-starting-with="h2">
      <xsl:choose>
        <xsl:when test="self::h2 => empty()">
          <xsl:apply-templates select="current-group()"/>
        </xsl:when>
        <xsl:otherwise>
          <section>
            <xsl:apply-templates select="current-group()"/>
          </section>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each-group>
  </xsl:template>

</xsl:stylesheet>
