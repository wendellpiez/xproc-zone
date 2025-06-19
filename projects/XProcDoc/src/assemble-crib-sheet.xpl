<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:zone="http://wendellpiez.com/xproc-zone/ns"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="zone:assemble-crib-sheet">

<!--Inputs must be available for this pipeline to run!

//p:load/@href | //p:with-input/@href | //p:document/@href

https://spec.xproc.org/lastcall-2024-08/head/xproc/specification.xml
https://xproc.org/specifications.html
xproc-steps.xml - produced by running pipeline COLLECT-XPROC-STEPS.xpl
src/declarations-html.xsl

-->
   
   
<!-- Depends on source data produced by COLLECT-XPROC-STEPS.xpl - you will get an error if that pipeline is not run first -->
<!-- For later: an integrated pipeline that runs both together -->

   <p:output port="result" serialization="map { 'indent': true() }"/>

   <p:group name="compound-step-links" xmlns:db="http://docbook.org/ns/docbook">
      <p:output port="result"/>
      <p:load  href="https://spec.xproc.org/lastcall-2024-08/head/xproc/specification.xml"/>
      <p:for-each>
         <p:with-input select="/descendant::db:para[@xml:id='p.subpipeline']/db:tag[not(.='p:variable')]"/>
         <p:rename match="db:tag" new-name="a"/>
         <p:add-attribute attribute-name="href"
            attribute-value="https://spec.xproc.org/lastcall-2024-08/head/xproc/#{string(.) => translate(':','.')}"/>
         <p:add-attribute match="a" attribute-name="target" attribute-value="specs"/>
         <p:wrap match="/*" wrapper="code"/>
         <p:wrap match="/*" wrapper="li"/>
      </p:for-each>
      <p:wrap-sequence wrapper="ul"/>
      <p:wrap-sequence wrapper="div"/>
      <p:insert match="/*" position="first-child">
         <p:with-input port="insertion">
            <h2>Core <b>compound steps</b></h2>
         </p:with-input>
      </p:insert>
      <p:namespace-delete prefixes="db xs zone"/>
      <p:namespace-rename to="http://www.w3.org/1999/xhtml" apply-to="elements"/>
      <p:cast-content-type content-type="application/xhtml+xml"/>
   </p:group>

   <!-- p:sink is implicit here b/c next step starts with new primary source -->
   
   <!-- Before we splice in foreign contents, we rewrite a little - adding a/@target enabling links
     open in a target window ... we could do this with XSLT but the XProc step is easier. -->
   <p:group name="links-rewritten">
      <p:load href="https://xproc.org/specifications.html"/>

      <p:add-attribute match="html:a" attribute-name="target" attribute-value="specs"/>
   </p:group>

   <!-- Next: XSLT to produce HTML for the step digest, with links back to the Recs
        and XSpec for this XSLT -->
   <p:group name="produce-page">
     <p:load href="../out/xproc-steps.xml"/>

      <p:xslt message="[XPROC-STEP-INDEX-HTML] Producing HTML from XML step list xproc-steps.xml">
         <p:with-input port="stylesheet" href="declarations-html.xsl"/>
      </p:xslt>

      <!-- Grabbing the list of links to optional step definitions straight from the page on line -  -->
      <!-- Assigning HTML namespace to unprefixed names -->
      <p:insert match="div[@id='specification-links']" xmlns="http://www.w3.org/1999/xhtml"
         position="last-child" message="[XPROC-STEP-INDEX-HTML] Inserting reference links">
         <p:with-input port="insertion" select="/descendant::ul[5]" pipe="@links-rewritten"/>
      </p:insert>

      <!-- Reaching back to insert the toc links from above -->
      <p:insert match="section[@id='introduction']" xmlns="http://www.w3.org/1999/xhtml"
         position="after" message="[XPROC-STEP-INDEX-HTML] Inserting compound step links">
         <p:with-input port="insertion" select="/*" pipe="result@compound-step-links"/>
      </p:insert>
   </p:group>
   
   
</p:declare-step>