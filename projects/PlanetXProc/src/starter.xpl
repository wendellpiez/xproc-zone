<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc">
  <!-- A pipeline is defined with p:declare-step -->
  
  <!-- First step reads a file from the file system -->
  <p:load href="../xproc-from-orbit.md" content-type="text/plain"/>
  
  <!-- Second step does its best to produce HTML from Markdown input -->
  <p:markdown-to-html/>

  <!-- Third step saves the result -->
  <p:store href="../out/xproc-from-orbit.html"/>
  
</p:declare-step>
