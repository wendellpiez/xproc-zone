<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">

   <!-- SchXSLT is at https://github.com/schxslt/schxslt
        It is an XSLT-based Schematron processor -->
   
   <!-- /end prologue -->
   <!-- start subpipeline -->
   
   <p:variable name="download-path" select="'https://github.com/schxslt/schxslt/releases/download/v1.10.1'"/>
   <!--<p:variable name="download-path" select="'.'"/>-->
   <p:variable name="archive-basename"  select="'schxslt-1.10.1'"/>
   
   <p:variable name="libdir" select="resolve-uri('../lib/', static-base-uri())"/>
   
   
   <p:variable name="zip-name"  select="$archive-basename || '-xproc.zip'"/>
   <p:variable name="target-dir" select="resolve-uri($archive-basename, $libdir)"/>

   <p:variable name="prefix" select="'[DOWNLOAD-SCHXSLT]'"/>
   
   <!-- It beginneth -->

   <p:load href="{ $download-path }/{ $zip-name }" message="{ $prefix } p:load: { $download-path }/{ $zip-name } ..."/>
   
   <p:store href="{ $libdir || $zip-name }" message="{$prefix} Saving { $zip-name } (thanks David Maus!)"/>
   
   <!-- see p:unarchive here: https://spec.xproc.org/3.0/steps/#c.unarchive -->
   <p:unarchive message="{$prefix} Unzipping { $zip-name }"/>
      
   <p:for-each message="{$prefix} Unzipping into directory { $target-dir }">
      <p:variable name="base" select="p:document-property(.,'base-uri')"/>
      <p:variable name="local-path" select="$base => substring-after( $archive-basename)"/>
      <p:variable name="path-here" select="($target-dir || $local-path)"/>

      <!--<p:identity message="Seeing a file at { $base } for { $path-here }"/>-->
      <p:store href="{ $path-here }" message="{$prefix} Saving { $path-here }"/>
   </p:for-each>
   
   <p:identity message="{ $prefix } Test your Schematron capability using the pipeline smoketest/TEST-SCHEMATRON.xpl"/>
   
</p:declare-step>