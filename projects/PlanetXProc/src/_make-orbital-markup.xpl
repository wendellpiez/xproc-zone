<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
 type="zone:make-orbital-markup"
 xmlns:zone="http://wendellpiez.com/ns/xproc-zone">
  
  <!-- Accepts an XML (XHTML) document on 'source' port,
       and enhances through an XSLT sequence -->
  
  <p:input port="source"/>
  
  <p:output/>
  
  <p:xslt>
    <p:with-input port="stylesheet" href="../src/html-enhance.xsl"/>
  </p:xslt>
  
  <p:xslt>
    <p:with-input port="stylesheet" href="../src/html-resuscitate.xsl"/>
  </p:xslt>

  <p:validate-with-relax-ng>
    <p:with-input port="schema">
      <p:document href="../src/orbital-promoted.rnc"/>
    </p:with-input>
  </p:validate-with-relax-ng>

</p:declare-step>