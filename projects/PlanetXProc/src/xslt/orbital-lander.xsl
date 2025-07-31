<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="3.0">
  
  <xsl:param name="noisy" select="false()"/>
  
  <xsl:template match="/">
    <html>
       <head>
         <title>XProc from Orbit</title>
       </head>
      <xsl:apply-templates/>
    </html>
  </xsl:template>
  
  <xsl:template match="*[$noisy]" priority="101">
    <xsl:message expand-text="true">Matching { name(.) }</xsl:message>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="body">
    <body>
      <xsl:apply-templates/>
    </body>
  </xsl:template>
  
  <xsl:template match="div">
    <section>
      <xsl:apply-templates/>
    </section>
  </xsl:template>
  
  <xsl:template match="head">
    <h1>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>
  
  <xsl:template match="div/head" priority="20">
    <h2>
      <xsl:apply-templates/>
    </h2>
  </xsl:template>
  
  <xsl:template match="div/div/head" priority="30">
    <h3>
      <xsl:apply-templates/>
    </h3>
  </xsl:template>
  
  <xsl:template match="p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="list">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
  
  <xsl:template match="item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  
  <xsl:template match="figure"/>

  <!-- First figure in a sequence provides a group for the sequence -->
  <xsl:template priority="101" match="figure[empty(preceding-sibling::*[1]/self::figure)]">
    <aside class="fig_set">
      <!-- 'grab' mode will acquire the figure plus its successors in sequence -->
      <xsl:apply-templates select="." mode="grab"/>
    </aside>
  </xsl:template>
  
  <xsl:template match="figure" mode="grab" expand-text="true">
    <div class="fig_block">
      <h4>Example <a class="eg" href="{ @source }">{ @source }</a></h4>      
      <xsl:apply-templates/>
    </div>
    <!-- Next, grab the next element
         A figure matches this same template aka 'sibling recursion' -->
    <xsl:apply-templates select="following-sibling::*[1]" mode="grab"/>
  </xsl:template>  
  
  <!-- done grabbing -->
  <xsl:template match="*" mode="grab"/>
  
  <xsl:template match="figure/head" expand-text="true">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="figure/eg">
    <pre class="eg">
      <xsl:apply-templates/>
    </pre>
  </xsl:template>
  
  <xsl:template match="code">
    <code>
      <xsl:apply-templates/>
    </code>
  </xsl:template>
  
  <xsl:template match="emph">
    <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>
  
  <xsl:template match="hi">
    <i>
      <xsl:apply-templates/>
    </i>
  </xsl:template>
  
  <xsl:template match="ref">
    <a href="{ @target }">
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
</xsl:stylesheet>