<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
    xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
    type="zone:index-repository-xproc">

    <p:import href="tag-xml-linenos.xpl"/>

    <p:output port="result" primary="true" pipe="@display-index"/>
    
    <p:output port="index-xml" primary="false" pipe="@make-index"/>
    
    <!-- .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. ... .. -->

    <p:directory-list path="../.." max-depth="unbounded" include-filter="\.xpl$"/>

    <!-- Removing the top-level 'lib' directory to avoid indexing xpl files therein -->
    <p:delete match="/c:directory/c:directory[@name='lib']"/>

    <p:for-each>
        <p:with-input select="/descendant::c:file"/>
        <p:variable name="filepath" select="resolve-uri(/*/@name, base-uri(.))"/>
        <p:load href="{ $filepath }" message="LOADING { $filepath }" content-type="text/plain"/>

        <zone:tag-xml-linenos/>
    </p:for-each>

    <p:wrap-sequence wrapper="element-index"/>

    <p:xslt name="make-index">
        <p:with-input port="stylesheet" href="repo-xproc-index.xsl"/>
    </p:xslt>

    <p:xslt name="display-index">
        <p:with-input port="stylesheet" href="render-index.xsl"/>
    </p:xslt>

</p:declare-step>