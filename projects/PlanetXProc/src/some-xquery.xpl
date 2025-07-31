<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-inline-prefixes="#all">

  <p:output serialization="map { 'indent': true() }"/>

  <p:load href="../xproc-from-orbit.xml"/>

  <p:xquery>
    <p:with-input port="query" expand-text="false">
      <LINKLIST>{ //tei:ref/ <a href="{ @target }">{ string(.) }</a> }</LINKLIST>
    </p:with-input>
  </p:xquery>

  <p:namespace-delete prefixes="tei"/>

</p:declare-step>
