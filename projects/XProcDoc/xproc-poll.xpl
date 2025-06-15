<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    version="3.0" type="zone:xproc-poll"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:zone="http://wendellpiez.com/xproc-zone/ns">
  
    <p:import href="src/tag-xml-linenos.xpl"/>
    
    <!--<p:output port="result" sequence="true"
        serialization="map{'indent': true() }" pipe="@make-index"/>-->
    
    <p:directory-list path="../.." max-depth="unbounded"
      include-filter="\.xpl$"/>
    
<!-- Removing the top-level 'lib' directory    -->
    
    <p:delete match="/c:directory/c:directory[@name='lib']"/>
    
    <p:for-each>
        <p:with-input select="/descendant::c:file"/>
        <p:variable name="filepath" select="/*/@name => resolve-uri(base-uri(.))"/>
        <p:load href="{ $filepath }" message="LOADING { $filepath }" content-type="text/plain"/>

        <zone:tag-xml-linenos/>
        
        
        
        <!--
        Now: filter down XProc
          match all p:*, p:inline/xsl:stylesheet
          flatten
            write element signature
            write relative repo path including line no
           
           https://github.com/wendellpiez/xproc-zone/blob/main/projects/XProcDoc/COLLECT-XPROC-STEPS.xpl#L40
           
        Next produce lookup
          group by XProc element type
            list by signature
              any signature may have multiple instances
                order by frequency?
            -->
    </p:for-each>
    
    <p:wrap-sequence wrapper="element-index"/>
    
    <p:xslt name="make-index">
        <p:with-input port="stylesheet" href="src/repo-xproc-index.xsl"/>
    </p:xslt>
    
    <p:xslt>
        <p:with-input port="stylesheet" href="src/render-index.xsl"/>
    </p:xslt>
    
    <p:store href="xproc-zone-element-index.html" message="SAVED xproc-zone-element-index.html"/>
    
</p:declare-step>