<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:zone="http://wendellpiez.com/xproc-zone/ns">

   <p:import href="src/assemble-step-list.xpl"/>
   
   <p:option name="result-path" select="'out/xproc-step-list.html'"/>

   <!-- Produces XHTML -->
   <zone:assemble-step-list/>
   
   <p:store href="{ $result-path }" message="Saving XProc Step List results in { $result-path }"/>
   
</p:declare-step>