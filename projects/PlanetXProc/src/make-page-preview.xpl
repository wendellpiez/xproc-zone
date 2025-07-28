<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-inline-prefixes="#all">
  
  <!-- Run refresh-xml.xpl to refresh the XML production from Markdown source -->
  
  <p:load href="../xproc-from-orbit.xml" message="LOADING xproc-from-orbit.xml"/>
  
  <!-- Precautionary validation -->
  <p:validate-with-relax-ng assert-valid="true">
    <p:with-input port="schema">
      <p:document href="schemas/orbital-promoted.rnc"/>
    </p:with-input>
  </p:validate-with-relax-ng>
  
  <!-- Scrubbing whitespace text around XInclude -->
  <p:delete match="tei:eg/text()"/>
  
  <p:xinclude/>
  
  <!-- Renders back down into HTML again -->
  <p:xslt>
    <p:with-input port="stylesheet" href="../src/xslt/orbital-lander.xsl"/>
  </p:xslt>
  
  <p:insert match="html/head" position="last-child">
    <p:with-input port="insertion" expand-text="false">
      <style type="text/css" xml:space="preserve">

aside.eg_set { display: flex; gap: 0.7em;
    flex-flow: row wrap;
    align-items: flex-start; }

div.eg_block { flex: auto; max-width: fit-content;
  background-color: whitesmoke; border: medium solid midnightblue; padding: 0.3em;
  margin-top: 0.8em }

p, ul { max-width: 54em }

      </style>
    </p:with-input>
  </p:insert>
  
  <p:store href="../out/xproc-from-orbit.html" message="SAVING ../out/xproc-from-orbit.html"/>
  
</p:declare-step>