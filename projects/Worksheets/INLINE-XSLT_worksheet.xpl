<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:p="http://www.w3.org/ns/xproc" 
   version="3.0">

   <!--
   
   The trickiest thing with inline XSLT in XProc
   is text and attribute value template (TVT and AVT) expansion.
   
   This is because braces are taken to signal XProc value templates
   before they are considered XSLT value templates.
   
   given an expression  '{$solution}' is $solution a variable in the XSLT or the XProc? (Yes.)
   
   Consequently inside XSLT, we must use double braces to escape the TVTs in XProc
   to get effective TVTs in XSLT - confusing, not ideal. Because then quadrupling
   to escape them in both layers, etc.
   
   A better solution is to set p:expand-text="false" on a wrapper element, leaving the
   XSLT to manage its own templating.
   
   If tempted to deal with the multiple layers in order to inject XProc dynamically into
   your XSLT - consider addressing the XSLT properly with a parameter instead
   (as you would for out of line XSLT).
   
   Impressive, that you have managed to get this far.
   
   -->
   
   <p:output port="result" serialization="map { 'indent': true(), 'omit-xml-declaration': true() }"/>
   
   <p:xslt>
      <p:with-input port="source">
         <p:inline><name>Leonardo</name></p:inline>
      </p:with-input>
      <p:with-input port="stylesheet">
         <!--NOTE p:expand-text is false to turn off TVT evaluation inside -->
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0">
               <xsl:template match="/*" expand-text="true"><!-- this is xsl:expand-text -->
                  <GREETINGS>Hello { string(.) }, Happy { format-date(current-date(),'[FNn]') }!</GREETINGS>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   
</p:declare-step>