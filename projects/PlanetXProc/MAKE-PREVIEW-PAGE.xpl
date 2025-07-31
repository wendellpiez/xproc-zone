<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  version="3.0" xmlns="http://www.w3.org/1999/xhtml">

  
  
  
  <!-- Reads XML source and XIncludes sample files -->
  <p:xinclude name="xincluding">
    <p:with-input href="xproc-from-orbit.xml"/>
  </p:xinclude>

  <p:xslt name="html-from-orbit">
    <p:with-input port="stylesheet" href="src/xslt/orbital-lander.xsl"/>
  </p:xslt>
  
  <p:string-replace match="pre[@class='eg']/text()[1]" replace="replace(string(.),'^\s+','')"/>
  
  <p:label-elements match="a[@class='eg']" name="href" attribute="href" label="'../' || ."/>
  
  <!-- Inserts this into the XHTML source ('host') file -->
  <p:insert match="/*/body/main" name="xhtml-page">
    <p:with-input port="source">
      <p:document content-type="application/xml"  
        href="../../projects/PlanetXProc/xproc-from-above.xhtml"/>
    </p:with-input>
    <p:with-input port="insertion" pipe="result" select="/*/body/*"/>
  </p:insert>
  
 
  <p:delete match="ul[@class='buttonbar']"/>
  
  <p:store href="out/xproc-from-orbit.html" message="SAVING ../out/xproc-from-orbit.html"/>
  
</p:declare-step>
