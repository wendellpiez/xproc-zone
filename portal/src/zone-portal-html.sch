<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   <!-- Binding XHTML namespace to 'html' prefix -->
   <sch:ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
   
   <sch:pattern>
      <sch:rule context="html:html">
         <sch:assert sqf:fix="add-head" test="html:head">HTML requires a 'head'</sch:assert>
         <sqf:fix id="add-head">
            <sqf:description>
               <sqf:title>Add a stub head</sqf:title>
            </sqf:description>
            <sqf:add position="first-child">
               <head>
                  <title>Lesson: ...</title>
                  <meta charset="utf-8"/>
               </head>
            </sqf:add>
         </sqf:fix> </sch:rule>
      <sch:rule context="html:head"> 
         <sch:assert sqf:fix="add-meta" test="html:meta/@charset='utf-8'">Document character set should be marked UTF-8</sch:assert>
         <sqf:fix id="add-meta">
            <sqf:description>
               <sqf:title>Add a meta charset='utf-8'</sqf:title>
            </sqf:description>
            <sqf:add position="last-child">
               <meta charset="utf-8"/>
            </sqf:add>
         </sqf:fix>  
      </sch:rule>
      <sch:rule context="html:head/html:title">
         <sch:let name="nominal-title" value="/*/html:body/html:main/$header(.)"/>
         <sch:let name="retagged-title" value=" 'XProc Zone - ' || $nominal-title/string(.) "/>
         <sch:let name="exception" value="empty($nominal-title) or (/html:html/@id='index' and (. = 'The XProc Zone'))"/>
         <sch:assert sqf:fix="reset-pagetitle" test="(. = $retagged-title) or $exception">Page title looks wrong: expecting '<sch:value-of select="$retagged-title"/>'</sch:assert>
         <sqf:fix id="reset-pagetitle">
            <sqf:description>
               <sqf:title>Make the title '<sch:value-of select="$retagged-title"/>'</sqf:title>
            </sqf:description>
            <sqf:replace target="html:title" node-type="element" select="$retagged-title"/>
         </sqf:fix> 
      </sch:rule>
      <sch:rule context="html:body">
         <sch:assert role="warning" test="@id='page'" sqf:fix="assign-page-id">If not marked @id='page', theme handling will not apply -</sch:assert>
         <sqf:fix id="assign-page-id">
            <sqf:description>
               <sqf:title>Assign @id 'page'</sqf:title>
            </sqf:description>
            <sqf:add node-type="attribute" select="'page'" target="id"/>
         </sqf:fix>  
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:body/html:main/html:img[@id='logo']"/>
      <sch:rule context="html:li/html:p">
         <sch:report test="true()">p cannot appear inside li - only single-line list items are supported</sch:report>
      </sch:rule>
      <sch:rule context="html:html | html:head | html:meta | html:title | html:link |
         html:body | html:main | html:header |
         html:section |
         html:p | html:ul | html:ol | html:li | html:pre | html:details | html:summary"/>
      <sch:rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6"/>
      <sch:rule context="html:b | html:i | html:code | html:a | html:q | html:em | html:span"/>
      <sch:rule context="html:table | html:thead | html:tbody | html:tr | html:th | html:td"/>
      <sch:rule context="html:body/html:img | html:section/html:img | html:div"/>
      <sch:rule context="*">
         <sch:report test="true()">Element <sch:name/> is not expected in this HTML profile.</sch:report>
      </sch:rule>
   </sch:pattern>
   
   <xsl:variable name="header" as="function(*)"  
      select="function($e as element()) as element()?
              { $e ! (.|child::html:header)/(html:h1, html:h2, html:h3, html:h4, html:h5, html:h6)[1] }"/>
   
   <sch:pattern id="errant-text">
      <sch:rule context="html:section | html:body">
         <sch:assert test="text()[matches(., '\S')] => empty()">Element <name/> has loose text contents.</sch:assert>
         
<!-- 
            FOR TUTORIAL
            <sch:assert test="exists(self::html:section) or child::html:section[$header(.)='Goals']">Body must have a "Goals" section</sch:assert>
         <sch:assert test="not($header(.)='Goals') or empty(preceding-sibling::html:section)">A (single) "Goals" section should come first</sch:assert>
         <sch:assert test="not($header(.)='Prerequisites') or empty(preceding-sibling::html:section[not($header(.)='Goals')])">A "Prerequisites" section can come only directly after "Goals"</sch:assert>
         <sch:assert test="not($header(.)='Resources') or empty(preceding-sibling::html:section[not($header(.)=('Goals','Prerequisites'))])">A "Resources" section can come after only "Goals" and "Prerequisites"</sch:assert>-->
         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:section/* | html:body/*">
         <sch:assert test="exists(self::html:section|self::html:div) or empty(preceding-sibling::html:section)">Element not expected following a section</sch:assert>
         <sch:report test="preceding-sibling::node()[1]/self::text()[matches(.,'\S')] => exists()" role="warning">Look there ...</sch:report>
      </sch:rule>
      <sch:rule context="html:div[@class]">
         <sch:assert test="@class = ('block', 'panel')" role="warning">Unrecognized div @class '<sch:value-of select="@class"/>'</sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:section">
         <sch:assert test="exists(parent::html:body|parent::html:main|parent::html:section|parent::html:div)"><sch:name/> found out of place</sch:assert>
      </sch:rule>
      <sch:rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
         <sch:let name="exception" value="exists(parent::html:header) or @class='subtitle'"/>
         <sch:let name="deep" value="count(ancestor::html:body | ancestor::html:section | ancestor::html:div)"/>
         <sch:let name="fixup" value="'h' || $deep"/>
         <sch:assert sqf:fix="retag-header" test="$exception or ( number(replace(local-name(), '\D', '')) = $deep )"><sch:name/> found out of place - try
               <sch:value-of select="$fixup"/></sch:assert>
         <sch:assert test="empty(parent::* except (parent::html:body|parent::html:main|parent::html:section|parent::html:div|parent::html:header))">Not expecting to see <sch:name/> here</sch:assert>
         
         <sqf:fix id="retag-header">
            <sqf:description>
               <sqf:title>Retag the section head as <sch:value-of select="$fixup"/></sqf:title>
            </sqf:description>
            <sqf:replace node-type="element" target="html:{$fixup}">
               <sqf:copy-of select="child::node()"/>
            </sqf:replace>
         </sqf:fix>  
      </sch:rule>
      
   </sch:pattern>
   
   <sch:let name="okay-spans" value="'nowrap'"/>
   
   <sch:pattern>
      <sch:rule context="html:span">
         <sch:assert test="@class=$okay-spans">span is not marked with a known class: we recognize <sch:value-of select="string-join($okay-spans,',')"/></sch:assert>
      </sch:rule>
      <sch:rule context="html:a">        
         <!--<sch:rule context="html:a[matches(@href,'^https?:')] | html:a[matches(@href,'/$')]"/>-->
         <sch:let name="internal" value="not(matches(@href,'^https?:/')) and matches(@href,'\.xhtml$')"/>
         <sch:let name="excepting" value="matches(@href,'^https?:') or matches(@href,'/$')"/>
         <sch:assert test="not($internal) or $excepting or unparsed-text-available(resolve-uri(@href,base-uri(.)))">Not seeing anything at href <sch:value-of select="@href"/></sch:assert>
            
         <sch:assert test="normalize-space(.) => boolean()">Anchor is missing link contents</sch:assert>
         <!--<sch:assert sqf:fix="tag-lessonUnit-link" test="@class='LessonUnit' or not($internal)">Link to lesson should be given @class='LessonUnit'</sch:assert>
         <sqf:fix id="tag-lessonUnit-link">
            <sqf:description>
               <sqf:title>Tag the link with class='LessonUnit'</sqf:title>
            </sqf:description>
            <sqf:add node-type="attribute" select="'LessonUnit'" target="class"/>
         </sqf:fix>-->  
      </sch:rule>
   </sch:pattern>


</sch:schema>