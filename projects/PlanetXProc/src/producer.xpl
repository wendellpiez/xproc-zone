<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone">
  
  <!-- Step 0: Not really a step, this imports another pipeline (step declaration or library) -->
  <p:import href="_make-orbital-markup.xpl"/>
  
  <!-- Step 1: Loads a file as plain text -->
  <p:load href="../xproc-from-orbit.md" content-type="text/plain"/>

  <!-- Step 2: Makes HTML, if possible (supported in XML Calabash) -->
  <p:markdown-to-html/>

  <!-- Step 3: Calls an imported step -->
  <zone:make-orbital-markup/>
  
  <!-- Step 4: Saves the result -->
  <p:store href="../xproc-from-orbit.xml" message="SAVING xproc-from-orbit.xml ..."
    serialization="map { 'indent': true() }"/>
  
</p:declare-step>
