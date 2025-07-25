<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc">
  <!-- A pipeline is defined with p:declare-step -->
  
  <!-- First, reads a file from the file system -->
  <p:load href="../xproc-from-orbit.md" content-type="text/plain"/>
  
  <!-- Does its best to produce HTML from Markdown input -->
  <p:markdown-to-html/>

  <!-- Saves the result -->
  <p:store href="../out/xproc-from-orbit.html"/>
  
</p:declare-step>