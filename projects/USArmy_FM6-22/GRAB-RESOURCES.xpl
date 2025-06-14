<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   type="zone:GRAB-RESOURCES"
   name="GRAB-RESOURCES" xmlns:zone="http://wendellpiez.com/xproc-zone/ns">

<p:documentation>ZONE RULES HALL PASS - copy this p:document to ../../src/cicd-fileset_xproc3.xpl and remove this element</p:documentation>
<p:documentation>
   <p:document href="../projects/USArmy_FM6-22/GRAB-RESOURCES.xpl"/>
</p:documentation>

   

   <!-- Purpose: update local copies of some OSCAL resources from its release repository -->
   
   <!-- RNG for NISO STS is here: https://niso-sts.org/downloadables/RNGs/v1-2/NISO-STS-interchange-1-2-MathML3-RNG.zip
   
   See decision tree at https://niso-sts.org/DTDs-XSDs-RNGs-1-2.html
   -->
   <p:variable name="download-path" select="'https://github.com/usnistgov/OSCAL/releases/download/v1.1.2'"/>
  
   <!-- A $prefix is used to tag messages, expected to match the process type -->
   <p:variable name="prefix" select="'[' || 'GRAB-RESOURCES' || ']'"/>
   
   <p:for-each message="{$prefix} Saving resources in ./lib ...">
      <!-- iterating over each 'resource' as a discrete document node -->
      <p:with-input>
         <p:document href="{$download-path}/oscal_catalog_schema.xsd"/>
         <!--<p:document href="{$download-path}/oscal_profile_schema.xsd"/>-->
      </p:with-input>
      <p:variable name="filename" select="p:document-property(.,'base-uri') ! replace(.,'.*/','')"/>
      
      <!-- No exception handling since a failed load often produces a result
           making it difficult to anticipate what a failure looks like - -->
      <!-- NB - A Schematron error comes back as soon as this is out of line with /*/@type i.e. the file name
           - starting the @message with { $prefix } silences the error, but please reset $prefix -->
      
      <p:store message="{$prefix} ... saving { $filename }"
               href="lib/{ $filename }"/>
   </p:for-each>
   
</p:declare-step>