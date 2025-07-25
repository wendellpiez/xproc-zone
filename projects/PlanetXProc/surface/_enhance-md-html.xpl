<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
 type="zone:enhance-md-html"
 xmlns:zone="http://wendellpiez.com/ns/xproc-zone">
  
  <!-- Accepts an XML (XHTML) document on 'source' port,
       and enhances through an XSLT sequence -->
  
  <p:input port="source"/>
  
  <p:output/>
  
  <p:xslt>
    <p:with-input port="stylesheet" href="html-enhance.xsl"/>
  </p:xslt>
  
  <p:cast-content-type content-type="application/xml"/>
  
  
  <p:identity message="I'm { p:document-property(.,'content-type')}"/>
  
  <p:validate-with-relax-ng>
    <p:with-input port="schema">
      <p:document href="../src/orbit-html.rnc"/>
    </p:with-input>
  </p:validate-with-relax-ng>
  
  <p:xslt>
    <p:with-input port="stylesheet" href="html-tuneup.xsl"/>
  </p:xslt>
  
  <p:xinclude/>
  
</p:declare-step>