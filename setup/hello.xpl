<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0" name="hello">

<p:documentation>ZONE RULES HALL PASS - copy this p:document to ../src/cicd-fileset_xproc3-rules.xpl and remove this element</p:documentation>
<p:documentation>
   <p:document href="../setup/hello.xpl"/>
</p:documentation>


    <p:documentation>ZONE RULES HALL PASS - copy this p:document to
        ../src/cicd-fileset_xproc3-rules.xpl and remove this element</p:documentation>
    <p:documentation>
        <p:document href="../setup/hello.xpl"/>
    </p:documentation>

    <p:output port="result" serialization="map{ 'omit-xml-declaration': true(), 'indent': true() }"/>

    <p:identity>
        <p:with-input>
            <greeting>Hello world!</greeting>
        </p:with-input>
    </p:identity>

</p:declare-step>