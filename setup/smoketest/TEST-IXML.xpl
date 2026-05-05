<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  exclude-inline-prefixes="cx" name="TEST-IXML">
  
  <!-- Demonstrates an Invisible XML parse applied to a static text. -->

  
  <p:output port="result" serialization="map { 'indent': true(), 'omit-xml-declaration': true() }"/>
  
  <!-- Also try with cx:processor="markup-blitz" -->
  <p:invisible-xml>
    <p:with-input port="grammar">
       <p:document href="src/punct-text.ixml" content-type="text/plain"/>
       <!--<p:document href="src/tiny.ixml" content-type="text/plain"/>-->
    </p:with-input>
    <p:with-input port="source">
       <p:inline content-type="text/plain">5 May 2025</p:inline>
    </p:with-input>
  </p:invisible-xml>

</p:declare-step>
