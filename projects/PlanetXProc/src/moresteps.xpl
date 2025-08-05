<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc">
  
  <!-- Reads a file as plain text -->
  <p:load href="../xproc-from-orbit.md" content-type="text/plain"/>
  
  <!-- If the processor supports the step, Markdown is converted to HTML -->
  <p:markdown-to-html/>

  <!-- Applying an XSLT transformation using the indicated stylesheet -->
  <p:xslt>
    <p:with-input port="stylesheet" href="xslt/html-resuscitate.xsl"/>
  </p:xslt>
  
  <!-- Saves a file in the ../out/ folder -->
  <p:store href="../out/xproc-from-orbit.html"/>
  
</p:declare-step>
