<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:zone="http://wendellpiez.com/xproc-zone/ns"
   type="zone:XQUERY_worksheet" name="XQUERY_worksheet">

   <!-- Showing invocation of XQuery, in line -->
   
   <p:input port="source">
      <p:inline content-type="text/plain">Hello World!</p:inline>
   </p:input>
   
   <p:output port="result"/>
   
   <p:text-replace pattern="!" replacement="!!!"/>
   
   <p:identity message="Made a modification: '{ . }'"/>

   <p:xquery>
      <p:with-input port="query">
         <!-- Without content-type p:inline assumes XML -->
         <p:inline content-type="text/plain">. || ' and Welcome!'</p:inline>
      </p:with-input>
      <!-- What also works is XQuery that happens also to be XML ... such as
         <p:with-input port="query">
           <p:inline expand-text="false"><root>{ substring(.,2) }</p:inline>
      </p:with-input>-->
   </p:xquery>
   
   <p:identity message="Made a modification modification '{ . }'"/>
   
</p:declare-step>