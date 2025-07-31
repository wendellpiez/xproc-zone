<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
  xmlns:xvrl="http://www.xproc.org/ns/xvrl"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  type="zone:tei-all-validate"
  xmlns:tei="http://www.tei-c.org/ns/1.0">
  
  <!-- Validating XML input against TEI schema found on line -->
  
  <!-- Instance won't be valid without TEI scaffolding, so we provide that as input -->
  <p:input port="source">
    <p:inline>
      <TEI xmlns="http://www.tei-c.org/ns/1.0">
        <teiHeader>
          <fileDesc>
            <titleStmt>
              <title>XProc from Above</title>
            </titleStmt>
            <publicationStmt>
              <p>Published under MIT license - reuse under terms of the XProc Zone.</p>
            </publicationStmt>
            <sourceDesc>
              <p>Authored by Wendell Piez, 2025, with respect, and thanks for reading.</p>
            </sourceDesc>
          </fileDesc>
        </teiHeader>
        <text/>
      </TEI>
    </p:inline>
  </p:input>
  
  <p:insert match="/*/tei:text" position="first-child">
    <p:with-input port="insertion" href="../xproc-from-orbit.xml"/>
  </p:insert>
  
  <p:xinclude/>
  
  <p:validate-with-relax-ng assert-valid="false" message="VALIDATING against tei_all on line - WML!">
    <p:with-input port="schema">
      <!-- Since we need the @content-type we can't use p:with-input/@href -->
      <p:document content-type="application/xml"
        href="https://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng"/>
    </p:with-input>
    <!--https://www.tei-c.org/release/xml/tei/schema/relaxng/tei.rng-->
  </p:validate-with-relax-ng>

  <!-- Picking up the 'report' port instead of default (primary) port ('result') -->
  <p:identity>
    <p:with-input pipe="report"/>
  </p:identity>
  
  <p:variable name="is-invalid" select="not(/xvrl:report/xvrl:digest/@valid = 'true')"/>
  
  <p:store message="SAVING VALIDATION REPORT - xproc-from-orbit.xml is found{ ' NOT'[$is-invalid] } to be valid"
    href="../out/validation-report_tei.xml" serialization="map { 'indent': true() }"/>

</p:declare-step>