<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:XI="http://wendellpiez.com/ns/xinclude-alias"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xpath-default-namespace="http://www.w3.org/1999/xhtml"
  version="3.0">

  <!-- Makes HTML produced by html-enhance.xsl and converts it into a friendlier notation-->
  
  <xsl:mode on-no-match="shallow-copy"/>

  <!-- The namespace alias helps us avoid unwanted interventions -->
  <xsl:namespace-alias stylesheet-prefix="XI" result-prefix="xi"/>
  
  <xsl:template match="html">
    <xsl:apply-templates select="body"/>
  </xsl:template>
  
  <xsl:template match="body">
    <body>
      <xsl:apply-templates/>
    </body>
  </xsl:template>
  
  <xsl:template match="section">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="blockquote"/>
    
  
  <xsl:template match="h1 | h2">
    <head>
      <xsl:apply-templates/>
    </head>
  </xsl:template>
  
  <xsl:template match="p[matches(.,'^\?')]" expand-text="true">
    <xsl:variable name="tag" expand-text="true">{ tokenize(.,'\s+')[1] => replace('\?','') }</xsl:variable>
    <eg>
      <XI:include parse="text" href="../{ $tag }"/>
    </eg>
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
  
  <xsl:template match="code">
    <code>
      <xsl:apply-templates/>
      </code>
  </xsl:template>
  
  <xsl:template match="a">
    
  </xsl:template>
</xsl:stylesheet>


