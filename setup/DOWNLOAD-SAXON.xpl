<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">

   <!-- start prologue -->
   
      <!-- Pipeline runs standalone without external bindings or options. -->
   
   <!-- /end prologue -->
   
   <!-- Note - you get an ugly error if you already have Saxon! -->
   <!-- start subpipeline -->
   
   <p:variable name="download-path" select="'https://www.saxonica.com/download'"/>
   
   <p:variable name="jarfile" select="'saxon-he-12.6.jar'"/>
   
   <p:variable name="zip-name"  select="'SaxonHE12-6J.zip'"/>
   
   <!-- => is the XPath 'arrow operator' https://www.w3.org/TR/xpath-31/#id-arrow-operator -->
   <p:variable name="target-dir" select="'../lib/MorganaXProc-IIIse-1.6.4/MorganaXProc-IIIse_lib' => resolve-uri()"/>
   
   <p:variable name="prefix" select="'[DOWNLOAD-SAXON]'"/>
   
   <!-- It beginneth -->

   <p:load href="{ $download-path }/{ $zip-name }" message="{ $prefix } Acquiring Saxon from { $download-path }/{ $zip-name } ..."/>
   
   <p:store href="../lib/{ $zip-name }" message="{$prefix} Saving { $zip-name } (thank you to Mike Kay and Saxonica)"/>
   
   <!-- see p:unarchive here: https://spec.xproc.org/3.0/steps/#c.unarchive -->
   <p:unarchive message="{$prefix} Unzipping { $zip-name }"
      include-filter="{ $jarfile }"/>
      
   <p:store href="{ $target-dir }/{ $jarfile }" message="{$prefix} Saving { $target-dir }/{ $jarfile }"/>
   
   <p:identity message="{ $prefix } Test your XSLT transformation capability using the pipeline smoketest/TEST-XSLT.xpl"/>
   
</p:declare-step>