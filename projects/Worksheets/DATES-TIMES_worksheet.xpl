<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step  version="3.0"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:p="http://www.w3.org/ns/xproc"
   exclude-inline-prefixes="#all">


  <p:output port="result" serialization="map { 'indent': true(), 'omit-xml-declaration': true() }"/>
   
  <!-- Iterating over 'p' elements
       New pictures provide new pictures here for testing -->
  
  <!--XPath 3.0/3.1 Functions and Operators https://www.w3.org/TR/xpath-functions-31/#func-format-dateTime
  Saxon documentation https://www.saxonica.com/html/documentation12/functions/fn/format-dateTime.html-->
  
  
  <p:for-each>
     <p:with-input select="/p/string(.)">
       <p>[h]:[m02] [Pn]</p>
       <p>[H]:[m02]:[s01]</p>
        <p>[H]:[m01]:[s01].[f001] [ZN,*-3]</p>
        <p>[FNn] [D1o] [MNn], [h]:[m01][Pn]</p>
        <p>[FN,*-3] [MN,*-3] [D] [Y]</p>
        <p>[Y0001]-[M01]-[D01]</p>
     </p:with-input>
     
     <p:identity>
        <p:with-input>
          <format picture="{ . }">{ format-dateTime( current-dateTime(), . ) }</format>
        </p:with-input>
     </p:identity>
  </p:for-each>
   
   <p:wrap-sequence wrapper="DATETIME-FORMATS"/>
   
   
</p:declare-step>