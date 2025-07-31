<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
  version="3.0" xmlns="http://www.w3.org/1999/xhtml"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone" type="zone:xproc-from-above-html"
  name="xproc-from-above-html">

  <!-- Produces HTML for xproc-from-orbit (TEI) XML source kept in project folder -->
  <p:output content-types="application/xml"/>

  <!-- Reads XML source and XIncludes sample files -->
  <p:xinclude name="xincluding">
    <p:with-input href="../../projects/PlanetXProc/xproc-from-orbit.xml"/>
  </p:xinclude>

  <p:xslt name="html-from-orbit">
    <p:with-input port="stylesheet" href="../../projects/PlanetXProc/src/xslt/orbital-lander.xsl"/>
  </p:xslt>

  
  
  <!-- Inserts this into the XHTML source ('host') file -->
  <p:insert match="/*/body/main" name="xhtml-page">
    <p:with-input port="source">
      <p:document content-type="application/xml"  
        href="../../projects/PlanetXProc/xproc-from-above.xhtml"/>
    </p:with-input>
    <p:with-input port="insertion" pipe="result" select="/*/body/*"/>
  </p:insert>
  
</p:declare-step>
