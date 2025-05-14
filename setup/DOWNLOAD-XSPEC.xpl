<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">
   
   <!-- XSpec is an XSLT-based unit testing framework
        for XSLT, XQuery and Schematron -->
   
   <!--https://github.com/xspec/xspec/archive/refs/tags/v3.0.3.zip-->

   <!-- /end prologue -->
   <!-- start subpipeline -->
   
   <p:variable name="archive-basename"  select="'xspec-3.2.2'"/>
   
   <p:variable name="download" select="'https://github.com/xspec/xspec/archive/refs/tags/v3.2.2.zip'"/>
   <!--<p:variable name="download" select="'xspec-3.0.3.zip'"/>-->
   
   <p:variable name="zip-name"  select="$archive-basename || '.zip'"/>
   
   <p:variable name="libdir" select="resolve-uri('../lib', static-base-uri())"/>

   <p:variable name="prefix" select="'[DOWNLOAD-XSPEC]'"/>
   
   <!-- It beginneth -->

   <p:load href="{ $download }" message="{ $prefix } Loading { $download } ..."/>
   
   <p:store href="{ $libdir }/{ $zip-name }" message="{$prefix} Saving { $zip-name } (thanks XSpec contributors!)"/>
   <!--<p:identity message="{$prefix} to save { $zip-name }"/>-->
   
   <!-- see p:unarchive here: https://spec.xproc.org/3.0/steps/#c.unarchive -->
   <p:unarchive message="{$prefix} Unzipping { $zip-name }" exclude-filter="example.xml"/>
      
   <p:for-each message="{$prefix} Unzipping into directory { $libdir }">
      <p:variable name="base" select="p:document-property(.,'base-uri')"/>
      <p:variable name="local-path" select="substring-after($base, $archive-basename)"/>
      <p:variable name="target-path" select="$libdir || '/' || $archive-basename || $local-path"/>

      <!--<p:identity message="{$prefix} Seeing { $target-path} for { $base }"/>-->
      <p:store href="{ $target-path }" message="{$prefix} Saving { $target-path }"/>
   </p:for-each>
   
   <p:identity message="{ $prefix } Test your XSpec capability using smoketest/TEST-XSPEC.xpl"/>
   
</p:declare-step>