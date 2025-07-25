<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
   type="zone:cicd-fileset_XProc3_repo-validations"
   name="cicd-fileset_XProc3_repo-validations"
   >

   <!-- Pipeline to be called as subpipeline, delivering a list of XProcs -->
   
   <!-- next up: produce live index in ../portal/XPROC-LAB_PAGES.xpl
        (calling  ../projects/XProcDoc/src/index-repository-xproc.xpl)
      
      from this file list, not from a dynamic directory list
   
   cicd: 1 a Schematron verifies that no files in this list are missing
           (ensures early error from GHA when files are not committed)
         2. A batch Schematron runs over all XProc listed here
         3. Portal XProcs are run including Index generation
         
       -->
   
   <p:documentation>Defining a set of files for Schematron (Zone Rules) evaluation.
      Listing any and all files in the repository subject to these Schematron tests under CI/CD.</p:documentation>
      
   <p:input port="source" sequence="true">
      <p:document href="../lib/GRAB-SAXON.xpl"/>
      <p:document href="../lib/GRAB-SCHXSLT.xpl"/>
      <p:document href="../lib/GRAB-XSPEC.xpl"/>

      <p:document href="../setup/hello.xpl"/>
      <p:document href="../portal/BUILD-PORTAL.xpl"/>
      <p:document href="../portal/src/portal-page.xpl"/>

      <p:document href="../setup/DOWNLOAD-SAXON.xpl"/>
      <p:document href="../setup/DOWNLOAD-SCHXSLT.xpl"/>
      <p:document href="../setup/DOWNLOAD-XSPEC.xpl"/>
      <p:document href="../setup/smoketest/TEST-XPROC3.xpl"/>
      <p:document href="../setup/smoketest/TEST-XSLT.xpl"/>
      <p:document href="../setup/smoketest/TEST-SCHEMATRON.xpl"/>
      <p:document href="../setup/smoketest/TEST-XSPEC.xpl"/>

      <p:document href="../projects/XProcDoc/PRODUCE-REPOSITORY-INDEX.xpl"/>
      <p:document href="../projects/XProcDoc/COLLECT-XPROC-STEPS.xpl"/>
      <p:document href="../projects/XProcDoc/PRODUCE-STEP-LIST.xpl"/>

   </p:input>
 
   <p:output port="xproc-files" sequence="true"/>
   
   <!-- /prologue -->
   
   <p:identity/>
   
</p:declare-step>
