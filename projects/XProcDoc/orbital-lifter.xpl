<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">
    
    <!-- XML Calabash provides p:markdown-to-html -->
  
    <p:output serialization="map{ 'indent': true() }"/>
    
    <p:load href="xproc-from-orbit.md"
      content-type="text/plain"/>
    
    <p:markdown-to-html/>
  
    <p:cast-content-type content-type="application/xml"/>
    
</p:declare-step>