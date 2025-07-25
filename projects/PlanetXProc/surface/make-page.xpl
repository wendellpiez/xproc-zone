<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone">
  
  <!--  Imports a pipeline (step declaration or library) -->
  <p:import href="_enhance-md-html.xpl"/>
  
  <!-- Loads a file as plain text -->
  <p:load href="../xproc-from-orbit.md" content-type="text/plain"/>
  
  <!-- Makes HTML, if possible (supported in XML Calabash) -->
  <p:markdown-to-html/>

  <!-- Calls an imported step -->
  <zone:enhance-md-html/>
  
  <!-- Saves the result -->
  <p:store href="../out/xproc-from-orbit.html"
    serialization="map { 'method': 'xml', 'omit-xml-declaration': true() }"/>
  
</p:declare-step>