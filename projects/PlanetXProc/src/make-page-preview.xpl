<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
  xmlns="http://www.w3.org/1999/xhtml">
  
  <!-- Requires XML Calabash for p:markdown-to-html -->
  
  <p:import href="_make-orbital-markup.xpl"/>
  
  <p:load href="../xproc-from-orbit.md" content-type="text/plain"/>
  
  <p:markdown-to-html/>

  <zone:make-orbital-markup/>
  
  
  
  <p:cast-content-type content-type="application/xml"/>
  
  <!-- Designating the HTML namespace, unprefixed -->
  
  
  <p:insert match="html/head" position="last-child">
    <p:with-input port="insertion" expand-text="false">
      <style type="text/css" xml:space="preserve">

aside.eg_set { display: flex; gap: 0.7em;
    flex-flow: row wrap;
    align-items: flex-start; }

div.eg_block { flex: auto; max-width: fit-content;
  background-color: whitesmoke; border: medium solid midnightblue; padding: 0.3em;
  margin-top: 0.8em }

div.eg_block h5:first-child { margin-top: 0em }

p, ul { max-width: 54em }

      </style>
    </p:with-input>
  </p:insert>
  
  <p:store href="../out/xproc-from-orbit.html"/>
  
</p:declare-step>