<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
  version="3.0" xmlns:svg="http://www.w3.org/2000/svg" xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <p:variable name="timestamp" select="current-dateTime() => format-dateTime('[Y0001][M01][D01]')"/>

  <p:xsl-formatter>
    <p:with-input port="source" href="src/aesop-fo.xml"/>
  </p:xsl-formatter>

  <p:store href="FOPtest_{ $timestamp }.pdf"/>

</p:declare-step>