<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
  
  xmlns:zone="http://wendellpiez.com/xproc-zone/ns"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">

   
   <!--<p:output serialization="map{'indent' : true()}" sequence="true"/>-->
   <!--<p:variable name="step-defs" select="id('req-steps')/xi:include"/>-->

   <!--The pipeline loads specification Docbook XML for XProc dynamically
   and pulls all the step declarations
   
   for indexing and linkbacks
   
   -->


   <p:for-each name="required-steps" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns="http://docbook.org/ns/docbook">
      <p:with-input select="//section[@xml:id='req-steps']//p:declare-step">
         <p:document href="https://spec.xproc.org/lastcall-2024-08/head/steps/specification.xml"
            content-type="text/xml"/>
      </p:with-input>
      <p:add-attribute match="p:declare-step" attribute-name="library" attribute-value="standard"/> 
   </p:for-each>
   
   <!-- we don't need to sink since the next step ignores the primary results anyway -->
   <p:sink/>

   <!-- Next pulling p:declare step from optional step definition files, as enumerated. -->
   
   <p:for-each name="additional-steps">
      <p:with-input select="/steps/string(.)">
         <p:inline>
            <steps>ixml</steps>
            <steps>mail</steps>
            <steps>file</steps>
            <steps>os</steps>
            <steps>paged-media</steps>
            <!--<steps>rdf</steps>-->
            <steps>run</steps>
            <steps>text</steps>
            <steps>validation</steps>
         </p:inline>
      </p:with-input>
      
      <p:variable name="spec-key" select="."/>
         
      <p:variable name="speclink" select="string(.)">
         <p:inline>https://raw.githubusercontent.com/xproc/3.0-steps/master/step-{.}/src/main/xml/specification.xml</p:inline>
      </p:variable>
      
      <p:load content-type="text/xml" href="{ $speclink }" message="[COLLECT-XPROC-STEPS] Loading { $speclink }"/>
      
      
      <p:xinclude/>
      <!--<p:try>
         <p:xinclude/>
         <p:catch>
            <p:identity/>
         </p:catch>
      </p:try>-->
      
      <p:add-attribute match="p:declare-step" attribute-name="library" attribute-value="{$spec-key}"/> 
      <p:filter  select="//p:declare-step"/>
      
   </p:for-each>
   
            
   <p:wrap-sequence wrapper="library">
      <p:with-input pipe="@required-steps @additional-steps"/>
      <!--<p:with-input port="source" pipe="@optional-steps"/>-->
   </p:wrap-sequence>
   
   <!-- Putting it all in no namespace to make the XSLT easier -->
   <p:namespace-delete prefixes="p"/>
   
   <p:store href="out/xproc-steps.xml"  serialization="map{'indent' : true()}"
      message="[COLLECT-XPROC-STEPS] Storing out/xproc-steps.xml"/>
   
   <p:sink message="[COLLECT-XPROC-STEPS] To produce HTML from this XML, run the pipeline PRODUCE-STEP-LIST.xpl"/>
   
</p:declare-step>