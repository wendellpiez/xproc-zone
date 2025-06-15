<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
    xmlns:c="http://www.w3.org/ns/xproc-step" exclude-inline-prefixes="c"
    xmlns:zone="http://wendellpiez.com/xproc-zone/ns" type="zone:tag-xml-linenos"
    name="main">

    <p:input port="source" content-types="text/plain">
        <p:document content-type="text/plain" href="file:/C:/Users/wapie/Documents/Github/xproc-zone/projects/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl"/>
    </p:input>

    <p:output port="result" serialization="map{ 'indent': true() }"/>

    <!-- <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> -->

    <p:variable name="project-dir" select="resolve-uri('../../..',static-base-uri())"/>
    <p:variable name="filepath" select="p:document-property(.,'base-uri') => p:urify() => substring-after($project-dir)"/>
    <p:variable name="TAGO" select="'(&lt;\i\c*)'"/>

    <!--<p:identity name="source-xml"/>-->
    
    <!-- Annotating with the filename also places the 'zone' namespace
         on the document element. -->
    <!--<p:label-elements match="/*" attribute="zone:path" label="base-uri(/*) => substring-after('{$project-dir}')"/>
    
    <p:delete match="@zone:line-no"/>-->
    
    <!--<p:if test="not(in-scope-prefixes(/*)='zone' and
        namespace-uri-for-prefix('zone', /*)='http://wendellpiez.com/xproc-zone/ns')">
        <p:identity message="FAILING to provide line numbering on { base-uri(/*) } ..."/>
    </p:if>-->
        
    <!-- Start by serializing the XML -->
    <!--<p:cast-content-type content-type="text/plain"/>-->
    
    <!-- Next we break apart lines -->
    <p:for-each>
        <p:with-input select="tokenize(string(.),'\n')"/>
        <!-- A replacement expression provides the line position
             in attribute syntax for injection into each start tag
        The attribute is in no namespace to relieve dependence on namespaces for parsing
        and uses an unlikely name -->
        <p:variable name="repl" select="string(.)">
            <p:inline>$1 xproc._.zone._.line-no="{ p:iteration-position() }"</p:inline>
        </p:variable>
        <!-- Each document being a string - not even a text node -
             serializing it unescaped is a bit tricky - so instead
             we make an XML fragment containing the literal XML syntax
             on that line as modified by the replacement -->
        <p:identity>
            <p:with-input>
                <p:inline>{ . => replace($TAGO,$repl) } </p:inline>
                <!-- final space prevents erroring on empty string -->
            </p:with-input>
        </p:identity>
        <!-- Now we cast back to a string by replacing the XML with its value -->
        <p:string-replace match="/" replace="string(.)"/>
    </p:for-each>
    
    <!-- ... and given this sequence we can join back all the lines -->
    <p:text-join/>
    
    <!-- before parsing the lineno-tagged XML -->
    <p:try>
      <p:cast-content-type content-type="application/xml"/>
      <p:catch>
          <!-- Failing for any reason we can fall back -->
          <p:identity>
              <p:with-input pipe="source@main"/>
          </p:identity>
      </p:catch>
    </p:try>

    <p:add-attribute match="/*" attribute-name="xproc._.zone._.path" attribute-value="{ $filepath }"/>

</p:declare-step>