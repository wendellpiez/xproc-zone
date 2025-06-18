<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" exclude-inline-prefixes="#all"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:p="http://www.w3.org/ns/xproc">

  <!--
   
   Poll files in a directory
     opening each one
     counts its elements
   -->

  <p:output port="result" serialization="map { 'indent': true() }" primary="true"/>

  <p:output port="dir-listing" primary="false" pipe="result@dir-list"
    serialization="map { 'indent': true() }"/>



  <p:variable name="dir-path" select="resolve-uri('.')"/>

  <!-- Listing xpl files in the current directory, recursively -->
  <p:directory-list name="dir-list" path="{ $dir-path }"
    include-filter="\.xpl$" max-depth="unbounded"/>

  <!-- Load each one -->
  <p:for-each>
    <p:with-input select="//c:file"/>

    <p:load href="{ resolve-uri( /*/@name, base-uri(.) ) }"/>

    <p:identity>
      <p:with-input>
        <file path="{ substring-after( base-uri(/*), $dir-path ) }" element-count="{count(//*)}"/>
      </p:with-input>
    </p:identity>
  </p:for-each>

  <p:wrap-sequence wrapper="ELEMENT-COUNTS"/>

</p:declare-step>