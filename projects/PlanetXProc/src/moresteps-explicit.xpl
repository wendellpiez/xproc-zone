<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc">
  
  <!-- Reads a file as plain text -->
  <p:load name="loading" href="../xproc-from-orbit.md" content-type="text/plain"/>
  
  <!-- If the processor supports the step, Markdown is converted to HTML -->
  <p:markdown-to-html name="making-html">
    <p:with-input port="source" pipe="result@loading"/>
  </p:markdown-to-html>

  <!-- Applying an XSLT transformation using the nominated stylesheet -->
  <p:xslt name="transforming">
    <p:with-input port="source" pipe="result@making-html"/>
    <p:with-input port="stylesheet" href="../src/html-resuscitate.xsl"/>
  </p:xslt>
  
  <!-- Saves a file in the ../out folder -->
  <!-- Saves a file in the ../out folder -->
  <p:store href="../out/xproc-from-orbit.xml">  
    <p:with-input port="source" pipe="result@transforming"/>
  </p:store>
  
</p:declare-step>