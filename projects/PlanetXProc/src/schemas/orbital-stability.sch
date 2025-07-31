<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  >
  
  <sch:ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
  
  <sch:ns prefix="xi" uri="http://www.w3.org/2001/XInclude"/>
  
  <sch:pattern>
    <sch:rule context="tei:ref[starts-with(@target,'http')]"/>
      <sch:rule context="tei:ref">
        <sch:assert test="resolve-uri(@target,base-uri(.)) => doc-available()">Not seeing file <sch:value-of select="@target"/> named as ref/@target</sch:assert>
    </sch:rule>
    <sch:rule context="xi:include">
      <sch:assert test="@href => resolve-uri(base-uri(..)) => doc-available()">XInclude not finding any file at <sch:value-of select="@href"/></sch:assert>
    </sch:rule>
  </sch:pattern>
    
</sch:schema>