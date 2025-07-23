<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">

  <!-- Uses try/catch to capture errors in processing instead of halting -->

  <p:output sequence="true" serialization="map { 'indent': true() }"/>

  <p:for-each>
    <p:with-input select=" /p/string(.)">
      <p>[h]:[m02] [Pn</p>
      <p>[H]:[m02]:[s01]</p>
      <p>[H]:[m01]:[s01].[f001] [ZN,*-3]</p>
      <p>[FNn] [D1o] [MNn], [h]:[m01][Pn]</p>
      <p>[FN,*-3] [MN,*-3] [D] [Y]</p>
      <p>[Y0001]-[M01]-[D01]</p>
    </p:with-input>

    <p:variable name="this" select="."/>
    
    <p:try>
      <p:identity>
        <p:with-input>
          <format picture="{ $this }">{ format-dateTime( current-dateTime(), . ) }</format>
        </p:with-input>
      </p:identity>
      <p:catch name="failing">
        <p:identity message="FAILED PICTURE: { $this }">
          <p:with-input pipe="error@failing"/>
        </p:identity>
      </p:catch>
    </p:try>
  </p:for-each>

  <p:wrap-sequence wrapper="DATE_FORMATS"/>



</p:declare-step>
