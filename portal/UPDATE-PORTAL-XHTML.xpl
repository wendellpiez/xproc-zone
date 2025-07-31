<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone" type="zone:UPDATE-PORTAL-XHTML"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- For autoupdating of XHTML portal sources.
         Use with caution! -->
  <p:import href="src/xproc-from-above-html.xpl"/>

  <!--1. Update xproc-lab/xproc-from-above.xhtml -->

  <zone:xproc-from-above-html/>

  <p:add-attribute match="body/section" attribute-name="class" attribute-value="panel"/>
  
  <p:rename match="section/h2 | section/h3" new-name="summary"/>
  
  <p:rename match="section" new-name="details"/>
  
  <!-- A bit of whitespace trimming from XInclude padding -->
  <p:string-replace match="pre[@class='eg']/text()[1]" replace="replace(string(.),'^\s+','')"/>
  
  <p:label-elements match="a[@class='eg']" name="href" attribute="href"
    label="'https://github.com/wendellpiez/xproc-zone/blob/main/projects/PlanetXProc/' || ."/>
  
  <p:store href="xproc-lab/xproc-from-above.xhtml"
    message="[UPDATE-PORTAL-XHTML] SAVING Updated xproc-lab/xproc-from-above.xhtml"
    serialization="map{ 'method': 'xml' }"/>

</p:declare-step>