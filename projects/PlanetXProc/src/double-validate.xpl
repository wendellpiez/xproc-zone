<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc">
  
  <!-- Reads an XML document -->
  <p:load href="../out/xproc-from-orbit.xml"/>
  
  <!-- A validation step with two input ports,  'source' and 'schema'
       and two output ports, 'result' and 'report' -->
  <p:validate-with-relax-ng name="TEI-structures" assert-valid="false">
    <p:with-input port="schema" href="orbital-promoted.rnc"/>
  </p:validate-with-relax-ng>
  
  <!-- Another validation step with similar ports -->
  <p:validate-with-schematron name="other-regularities" assert-valid="false">
    <p:with-input port="schema" href="orbital-stability.sch"/>
  </p:validate-with-schematron>
  
  <p:wrap-sequence wrapper="VALIDATION-REPORTS">
    <p:with-input>
      <!-- Connecting to the 'report' output ports from earlier steps -->
      <p:pipe port="report" step="TEI-structures"/>
      <p:pipe port="report" step="other-regularities"/>
    </p:with-input>
  </p:wrap-sequence>
  
  <!-- Saving the combined report -->
  <p:store href="../out/validation-reports.xml" serialization="map { 'indent': true() }"/>

</p:declare-step>