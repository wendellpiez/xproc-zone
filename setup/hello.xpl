<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    version="3.0">
    
    <p:output port="result" serialization="map{ 'omit-xml-declaration': true(), 'indent': true() }"/>
    
    <p:identity>
        <p:with-input>
            <greeting>Hello world!</greeting>
        </p:with-input>
    </p:identity>
    
</p:declare-step>