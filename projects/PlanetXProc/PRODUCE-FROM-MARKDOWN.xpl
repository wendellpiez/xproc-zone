<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone">
  
  <!-- This pipeline is the same as src/producer.xpl, except providing
       an error when p:markdown-to-html is not available -->
  
  <!--  Imports a pipeline (step declaration or library) -->
  <p:import href="src/_make-orbital-markup.xpl"/>
  
  <!--Error early if we can't do it-->
  
  <!-- Loads a file as plain text -->
  <p:load href="xproc-from-orbit.md" content-type="text/plain"/>

  <!-- Error early if we can't do it -->
  <p:if test="p:step-available('p:markdown-to-html') => not()">
    <p:error code="NOMDSUPP">
      <p:with-input>
        <p:inline>Sorry, unable to run Markdown conversion - try XML Calabash</p:inline>
      </p:with-input>
    </p:error>
  </p:if>
  
  <!-- Makes HTML, if possible (supported in XML Calabash) -->
  <p:markdown-to-html use-when="p:step-available('p:markdown-to-html')"/>

  <!-- Calls an imported step -->
  <zone:make-orbital-markup/>
  
  <!-- Saves the result -->
  <p:store href="xproc-from-orbit.xml" message="SAVING xproc-from-orbit.xml ..."
    serialization="map { 'indent': true() }"/>
  
</p:declare-step>