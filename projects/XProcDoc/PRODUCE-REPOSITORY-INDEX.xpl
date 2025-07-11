<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
    xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:zone="http://wendellpiez.com/xproc-zone/ns">


    <p:import href="src/index-repository-xproc.xpl"/>

    <!--<p:output port="result" sequence="true"
        serialization="map{'indent': true() }" pipe="@make-index"/>-->
    <zone:index-repository-xproc/>
    
    <p:store serialization="map { 'indent': true() }" href="out/xproc-zone-xproc-index.html" message="[PRODUCE-REPOSITORY-INDEX] SAVED xproc-zone-element-index.html">
        <p:with-input pipe="result"/>
    </p:store>

</p:declare-step>