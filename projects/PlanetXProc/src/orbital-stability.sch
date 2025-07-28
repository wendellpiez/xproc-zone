<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:tei="http://www.tei-c.org/ns/1.0">
  
  <sch:ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
  
  <sch:pattern>
    <sch:rule context="tei:ref[starts-with(@target,'http')]"/>
      <sch:rule context="tei:ref">
        <sch:assert test="resolve-uri(@target,base-uri(.)) => doc-available()">Not seeing file <sch:value-of select="@target"/> named as ref/@target</sch:assert>
    </sch:rule>
  </sch:pattern>
  
  
</sch:schema>