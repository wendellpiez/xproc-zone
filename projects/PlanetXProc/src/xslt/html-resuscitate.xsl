<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:XI="http://wendellpiez.com/ns/xinclude-alias"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
  xpath-default-namespace="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all"
  version="3.0">

  <!-- Makes HTML produced by html-enhance.xsl and converts it into a friendlier notation-->
  
  <xsl:mode on-no-match="fail"/>

  <!-- The namespace alias helps us avoid unwanted interventions -->
  <xsl:namespace-alias stylesheet-prefix="XI" result-prefix="xi"/>
  
  <!-- Because processing fails on unmatched nodes -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>
  
  <xsl:template match="html">
    <xsl:assert test="zone:well-nested(//h1 | //h2 | //h3 | //h4 | //h5)">Header elements in source are not well nested.</xsl:assert>
    <xsl:apply-templates select="body"/>
  </xsl:template>
  
  <xsl:template match="body">
    <body>
      <xsl:apply-templates/>
    </body>
  </xsl:template>
  
  <xsl:template match="hr"/>
  
  <!-- Dropping signature line -->
  <xsl:template match="p[starts-with(.,'/wap')]"/>
  
  <xsl:template match="body">
    <body>
      <xsl:for-each-group select="*" group-starting-with="h1">
        <xsl:choose>
          <xsl:when test="self::h1 => empty()">
            <xsl:apply-templates select="current-group()"/>
          </xsl:when>
          <xsl:otherwise>
            <div>
              <xsl:call-template name="level2-groups"/>
            </div>
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
          <div>
            <xsl:apply-templates select="current-group()"/>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each-group>
  </xsl:template>
  
  <xsl:template match="blockquote"/>
  
  <xsl:template match="h1 | h2">
    <head>
      <xsl:apply-templates/>
    </head>
  </xsl:template>
  
  <xsl:template match="p[matches(.,'^\?')]" expand-text="true">
    <xsl:variable name="tag" select="tokenize(.,'\s+')[1]"/>
    <xsl:variable name="fileref" select="replace($tag,'\?','')"/>
    <xsl:assert test="resolve-uri($fileref, base-uri(.)) => doc-available()">No XML document is to be found at { $fileref }</xsl:assert>
    <figure source="{ $fileref }">
      <xsl:for-each select="( substring-after(., $fileref) => replace('^\?\s*', '') )[matches(.,'\S')]">
        <head type="gloss">{ . }</head>
      </xsl:for-each>
      <eg>
        <XI:include parse="text" href="{ $fileref }"/>
      </eg>
    </figure>
  </xsl:template>
  
  <xsl:template match="p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  
  <xsl:template match="ul">
    <list>
      <xsl:apply-templates/>
    </list>
  </xsl:template>
  
  <xsl:template match="li">
    <item>
      <xsl:apply-templates/>
    </item>
  </xsl:template>
  
  <xsl:template match="strong">
    <emph rend="bold">
      <xsl:apply-templates/>
    </emph>
  </xsl:template>
  
  <xsl:template match="em">
    <hi rend="italic">
      <xsl:apply-templates/>
    </hi>
  </xsl:template>
  
  <xsl:template match="q">
    <q>
      <xsl:apply-templates/>
    </q>
  </xsl:template>
  
  <xsl:template match="code">
    <code>
      <xsl:apply-templates/>
      </code>
  </xsl:template>
  
  <xsl:template match="a">
    <ref target="{ @href }">
      <xsl:apply-templates/>
    </ref>
  </xsl:template>

  <!-- visibility public so we can test with XSpec: header-nesting.xspec -->
  
  <xsl:function name="zone:well-nested" as="xs:boolean" visibility="public">
    <xsl:param    name="headers" as="element()*"/>
    <xsl:variable name="levels"  select="$headers/(local-name() => replace('\D','')
      => xs:positiveInteger() )"/>
    <!-- the expression returns -11 if $levels goes down by more than single steps,
         or the level of the last item -->
    <xsl:sequence
      select="fold-left( $levels, $levels[1], function($c,$s) { ($s[. le ($c + 1)],-11)[1] } ) > 0"/>
  </xsl:function>
  
  <xsl:function name="zone:well-nested-recursive" as="xs:boolean" visibility="public">
    <xsl:param name="headers" as="element()*"/>
    <xsl:sequence select="zone:check-seq( $headers/(local-name() => substring-after('h') => xs:positiveInteger() ) )"/>
  </xsl:function>
  
  <xsl:function name="zone:check-seq" as="xs:boolean">
    <xsl:param name="seq" as="xs:positiveInteger*"/>
    <xsl:variable name="this" select="head($seq)"/>
    <xsl:variable name="next" select="tail($seq)"/>
    <xsl:choose>
      <xsl:when test="empty($next)">
        <xsl:sequence select="true()"/>
      </xsl:when>
      <xsl:when test="($next[1] - $this) gt 1">
        <xsl:sequence select="false()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="zone:check-seq( $next )"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

</xsl:stylesheet>


