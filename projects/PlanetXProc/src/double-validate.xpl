<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc">
  
  <!-- Reads an XML document -->
  <p:load href="../xproc-from-orbit.xml"/>
  
  <!-- A validation step with two input ports, 'source' and 'schema'
       and two output ports, 'result' and 'report'
       sc https://spec.xproc.org/master/head/validation/#c.validate-with-relax-ng-->  
  <p:validate-with-relax-ng     assert-valid="false" name="TEI-structures">
    <p:with-input port="schema" href="schemas/orbital-promoted.rnc"/>
  </p:validate-with-relax-ng>
  
  <!-- Another validation step with similar ports -->
  <p:validate-with-schematron   assert-valid="false" name="other-regularities">
    <p:with-input port="schema" href="schemas/orbital-stability.sch"/>
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