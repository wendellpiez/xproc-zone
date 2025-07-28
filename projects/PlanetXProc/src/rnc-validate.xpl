<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
  xmlns:xvrl="http://www.xproc.org/ns/xvrl"
  type="zone:double-validate">
  
  <!-- Hard-coded to validate ../out/xproc-from-orbit.xml with orbital-promoted.rnc -->
  
  <p:validate-with-relax-ng assert-valid="false">
    <p:with-input port="source" href="../out/xproc-from-orbit.xml"/>
    <p:with-input port="schema" href="orbital-promoted.rnc"/>
  </p:validate-with-relax-ng>

  <!-- Picking up the 'report' port instead of default (primary) port ('result') -->
  <p:identity>
    <p:with-input pipe="report"/>
  </p:identity>
  
  <p:variable name="is-invalid" select="not(/xvrl:report/xvrl:digest/@valid = 'true')"/>
  
  <p:store message="SAVING VALIDATION REPORT - xproc-from-orbit.xml is found{ 'NOT'[$is-invalid] } to be valid"
    href="../out/validation-report_rnc.xml" serialization="map { 'indent': true() }"/>

</p:declare-step>