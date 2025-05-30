<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:zone="http://wendellpiez.com/xproc-zone/ns"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">

   <p:import href="assemble-step-index.xpl"/>
   
   <p:option name="result-path" select="'out/xproc-step-list.html'"/>

   <!-- Produces XHTML -->
   <zone:assemble-step-index/>
   
   <p:store href="{ $result-path }" message="Saving XProc Crib Sheet results in { $result-path }"/>
   
   
</p:declare-step>