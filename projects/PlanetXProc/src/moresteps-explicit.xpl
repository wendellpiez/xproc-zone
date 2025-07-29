<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc">
  
  <!-- Reads a file as plain text -->
  <p:load name="loading" href="../xproc-from-orbit.md" content-type="text/plain"/>
  
  <!-- If the processor supports the step, Markdown is converted to HTML -->
  <p:markdown-to-html name="making-html">
    <p:with-input port="source">
      <p:pipe port="result" step="loading"/>
    </p:with-input>
  </p:markdown-to-html>

  <!-- Applying an XSLT transformation using the nominated stylesheet -->
  <p:xslt name="transforming">
    <p:with-input port="source">
      <p:pipe port="result" step="making-html"/>
    </p:with-input>
    <p:with-input port="stylesheet">
      <p:document href="xslt/html-resuscitate.xsl"/>
    </p:with-input>
  </p:xslt>
  
  <p:store href="../out/xproc-from-orbit.xml">  
    <p:with-input port="source">
      <p:pipe port="result" step="transforming"/>
    </p:with-input>
  </p:store>
  
</p:declare-step>