<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
    xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
    type="zone:index-repository-xproc">

    <p:import href="tag-xml-linenos.xpl"/>

    <p:output port="result" primary="true" serialization="map { 'indent': true() }"/>
    
    <!-- .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. -->

    <p:directory-list path="../../.." max-depth="unbounded" include-filter="\.xpl$"/>

  <!--<p:filter select="/c:directory/c:directory[@name='lib']"/>-->

</p:declare-step>