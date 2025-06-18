<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:zone="http://wendellpiez.com/xproc-zone/ns"
   type="zone:cicd-fileset_XProc3_repo-validations"
   name="cicd-fileset_XProc3_repo-validations"
   >

   <!-- Pipeline to be called as subpipeline, delivering a list of XProcs -->
   
   <p:documentation>Defining a set of files for Schematron (Zone Rules) evaluation.
      Listing any and all files in the repository subject to these Schematron tests under CI/CD.</p:documentation>
      
   <p:input port="source" sequence="true">
      <!--<p:document href="../lib/GRAB-SAXON.xpl"/>
      <p:document href="../lib/GRAB-SCHXSLT.xpl"/>
      <p:document href="../lib/GRAB-XSPEC.xpl"/>-->
      
      <!--<p:document href="../setup/hello.xpl"/>-->
      <p:document href="../portal/BUILD-PORTAL.xpl"/>
      <p:document href="../portal/src/portal-page.xpl"/>
      
      <p:document href="../setup/DOWNLOAD-SAXON.xpl"/>
      <p:document href="../setup/DOWNLOAD-SCHXSLT.xpl"/>
      <p:document href="../setup/DOWNLOAD-XSPEC.xpl"/>
      <p:document href="../setup/smoketest/TEST-XPROC3.xpl"/>
      <p:document href="../setup/smoketest/TEST-XSLT.xpl"/>
      <p:document href="../setup/smoketest/TEST-SCHEMATRON.xpl"/>
      <p:document href="../setup/smoketest/TEST-XSPEC.xpl"/>
      
   </p:input>
 
   <p:output port="xproc-files" sequence="true"/>
   
   <!-- /prologue -->
   
   <p:identity/>
   
</p:declare-step>
