<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  version="3.0" xmlns="http://www.w3.org/1999/xhtml">

  <!-- Tests an HTML production run with $noisy = true() -->

  <!-- Reads XML source and XIncludes sample files -->
  <p:xinclude>
    <p:with-input href="../xproc-from-orbit.xml"/>
  </p:xinclude>

  <p:xslt parameters="map { 'noisy': true() }">
    <p:with-input port="stylesheet" href="xslt/orbital-lander.xsl"/>
  </p:xslt>
    
</p:declare-step>
