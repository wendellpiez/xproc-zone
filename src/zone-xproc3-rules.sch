<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:zone="http://wendellpiez.com/xproc-zone/ns"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
   xmlns:p="http://www.w3.org/ns/xproc">
   
   <!-- Purpose:: Schematron rule set for XProc 3 authors to provide write-time support for pesky rules
        including help with local rules -->

   <!-- *Not* for checking XProc correctness - to do that, run it -->

   <sch:ns prefix="p" uri="http://www.w3.org/ns/xproc"/>
   <sch:ns prefix="c" uri="http://www.w3.org/ns/xproc-step"/>
   <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
   
   <sch:let name="filename" value="(/*/base-uri() => tokenize('/'))[last()]"/>
   <sch:let name="basename" value="replace($filename, '\..*$', '')"/>
   <sch:let name="tag" value="'[' || $basename || ']'"/>
   <sch:let name="tag-regex" value="'^\[#*\s*(' || $basename || ')\]'"/>
   
   
<!-- Rules being enforced:

      A warning is given if the file is not listed in TEST-XPROC-SET.xpl for CI/CD runtime
      
      The XProc is version 3.0
      The assigned type /*/@type should match the file name, in the http://wendellpiez.com/xproc-zone/ns namespace
      with prefix 'zone' (stay out of trouble)
      The name /*/@name should also match the file name
      
      No PIs appear anywhere (we can work out exceptions if needed)
      
      Messages are tagged - leading with either a literal [STEP-NAME], or a variable reference
      
      p:load and p:store events provide messages
      
      Anything referenced with href resolves
        - to turn this off for the pipeline, list the XProc by name among processes named in $unlinked-xprod 

   -->
   
   <sch:let name="fileset-doc" value="document('cicd-fileset_xproc3.xpl')"/>
   <sch:let name="listed-uris" value="$fileset-doc/p:*/p:input[@port='source']/p:document/@href ! resolve-uri(.,base-uri(../..))"/>
   
   <sch:let name="resource-baseURI"  value="base-uri(/*)"/>
   <sch:let name="fileset-path"      value="base-uri($fileset-doc)"/>
   <sch:let name="repo-path"         value="resolve-uri('..', $fileset-path)"/>
   <sch:let name="resource-repoPath" value="substring-after($resource-baseURI, $repo-path)"/>
   <sch:let name="fileset-relPath"   value="substring-after($fileset-path, $repo-path)"/>

   <sch:let name="resource-fileset-path" value="( (tokenize($fileset-relPath,'/')  [position() ne last()] ! '../') => string-join('') ) || $resource-repoPath"/>
   <sch:let name="fileset-resource-path" value="( (tokenize($resource-repoPath,'/')[position() ne last()] ! '../') => string-join('') ) || $fileset-relPath"/>
   
   <sch:let name="okay-ns-prefixes" value="'','p','c','zone','xml','xsl','x','xs','html','svrl','xvrl'"/>
   
   <sch:pattern>
      <sch:rule context="/*">
         <!--<sch:report test="false()">
           resource at: <sch:value-of select="$resource-baseURI"/>
           fileset seen at: <sch:value-of select="$fileset-path"/>
           repo path: <sch:value-of select="$repo-path"/>
           resource path (in repo): <sch:value-of select="$resource-repoPath"/>
           fileset relative path: <sch:value-of select="$fileset-relPath"/>
           resource-fileset-path: <sch:value-of select="$resource-fileset-path"/>
           fileset-resource-path: <sch:value-of select="$fileset-resource-path"/>
         </sch:report>-->
         
         <sch:assert sqf:fix="sqf-exempt-from-zonerules-check" role="warning" test="base-uri(.) = $listed-uris or exists(p:documentation[contains(.,'HALL PASS') and contains(.,'ZONE RULES')])">file <sch:value-of select="$filename"/> isn't listed in validation set maintained in <sch:value-of select="$fileset-resource-path"/> - should it be?</sch:assert>
         <sch:let name="unexpected-prefixes" value="in-scope-prefixes(.)[not(.=$okay-ns-prefixes)]"/>
         <sch:report test="$unexpected-prefixes => exists()">This repo is keeping a list of recognized namespace prefixes, which does not include <sch:value-of select="$unexpected-prefixes => string-join(', ')"/></sch:report>
         <sch:assert sqf:fix="sqf-make-version-3"   test="@version = '3.0'">Expecting XProc 3.0, not <sch:value-of select="@version"/></sch:assert>
      </sch:rule>
      <sch:rule context="p:documentation[contains(.,'HALL PASS') and contains(.,'ZONE RULES')]">
         <sch:assert test="not(base-uri(/*) = $listed-uris)" role="warning">Zone rules exemption pass is not needed: this file is listed in the testing file set <sch:value-of select="$fileset-resource-path"/></sch:assert>
      </sch:rule>
      
      <sch:rule context="*[exists(@message)]">
         <sch:let name="parent-label" value="'[' || ../@name || ']'"/>
         <sch:let name="parent-label-regex" value="'^\[#*\s*(' || ../@name || ')\]'"/>
         <sch:assert sqf:fix="sqf-prepend-message-tag"
            test="matches(@message,$tag-regex) or (matches(@message, $parent-label-regex)) or starts-with(@message,'{')">Message should start with tag <sch:value-of select="$tag"/> or label <sch:value-of select="$parent-label"/></sch:assert>
         <sqf:fix id="sqf-prepend-message-tag">
            <sqf:description>
               <sqf:title>Prepend the message with '<sch:value-of select="$tag"/>'</sqf:title>
            </sqf:description>
            <sqf:add node-type="attribute" select="$tag || ' ' || @message" target="message"/>
         </sqf:fix>         
      </sch:rule>    
   </sch:pattern>

   <sch:pattern>
      <sch:rule context="p:declare-step">
         <sch:let name="local" value="exists(ancestor::p:declare-step)"/>
         <sch:let name="type-prefix" value="substring-before(@type, ':')"/>
         <sch:let name="type-uri" value="namespace-uri-for-prefix($type-prefix, .)"/>
         <sch:let name="typename-given" value="@type/tokenize(., ':')[last()]"/>
         
         <sch:assert sqf:fix="sqf-repair-step-type" test="empty(@type) or $local or contains($basename, $typename-given) or contains($typename-given, $basename) or exists(/p:library)">Unexpected declared type <sch:value-of select="$typename-given"/> for the file named <sch:value-of select="$filename"/></sch:assert>
         <sch:assert sqf:fix="sqf-repair-step-type" test="empty(@type) or $type-uri = 'http://wendellpiez.com/xproc-zone/ns'">XProc step @type is not given in namespace 'http://wendellpiez.com/xproc-zone/ns'</sch:assert>
         <sch:assert sqf:fix="sqf-repair-step-name sqf-name-step-main" test="empty(@name) or (@name = ('main',$basename)) or exists(/p:library) or $local">XProc step @name does not match the file name '<sch:value-of select="$filename"/>'</sch:assert>
      </sch:rule>
      
     <sch:rule context="p:load | p:store">
        <sch:assert sqf:fix="sqf-add-message" test="matches(@message,'\S')" role="warning">XProc <sch:name/> should emit a message</sch:assert>
        <sqf:fix id="sqf-add-message">
           <sqf:description>
              <sqf:title>Add a message</sqf:title>
           </sqf:description>
           <sqf:add node-type="attribute" select="$tag || ' ' || name() || ': ' || @href || ' ...'" target="message"/>
        </sqf:fix>         
     </sch:rule>
      
      <sch:rule context="p:with-input">
         <sch:assert sqf:fix="sqf-remove-port" test="(count(../p:with-input) gt 1) or not(@port='source')">p:with-input can be anonymous when it binds to the primary input: no @port designation is needed.</sch:assert>
      </sch:rule>
            
   </sch:pattern>
   
   <!-- Any files to be reprieved from linking rules should be listed here, by /*/@name  -->
   <sch:let name="unlinked-xproc" value="('CONVERT-XML-REFERENCE-SET')"/>
   
   <!-- Brute-forcing into full paths for path checking -->
   <sch:let name="all-hrefs" value="//*[matches(@href, '^[^\}\{]+$')]/resolve-uri(@href, base-uri(.))"/>
   
   <sch:pattern>
      <!-- Pre-empting for p:store and anything inside p:documentation -->
      <sch:rule context="p:store"/>
      <sch:rule context="p:documentation//*"/>
      <sch:rule context="p:*[starts-with(@href,'http')]"/>
      <!-- Not matching elements with href that contain { or } -->
      <sch:rule context="p:*[matches(@href, '^[^\}\{]+$')]">
         <sch:let name="exception" value="(/*/@name = $unlinked-xproc) or (tokenize(@href,'/')='lib')"/>
         <sch:let name="expanded-uri" value="resolve-uri(@href, base-uri(.))"/>
         <sch:assert test="$exception or ($expanded-uri => unparsed-text-available())">No resource found at <sch:value-of
            select="@href"/></sch:assert>
         <sch:assert test="count($all-hrefs[. = $expanded-uri]) = 1" role="warning">Resolved URI is referenced elsewhere</sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sqf:fixes>
      <sqf:fix id="sqf-make-version-3">
         <sqf:description>
            <sqf:title>Assign version 3.0</sqf:title>
         </sqf:description>
         <sqf:add node-type="attribute" select="'3.0'" target="version"/>
      </sqf:fix>
      
      <sqf:fix id="sqf-exempt-from-zonerules-check">
         <sqf:description>
            <sqf:title>Declare an exemption for this file from zone rules checking</sqf:title>
         </sqf:description>
         <sqf:add match="/*" position="first-child" xml:space="preserve">

<p:documentation>ZONE RULES HALL PASS - copy this p:document to <sch:value-of select="$fileset-resource-path"/> and remove this element</p:documentation>
<p:documentation>
   <p:document href="{ $resource-fileset-path }"/>
</p:documentation>
</sqf:add>
      </sqf:fix>
      
      <sqf:fix id="sqf-repair-step-type">
         <sqf:description>
            <sqf:title>Assign the file base name '<sch:value-of select="$basename"/>' as the nominal type, in namespace 'http://wendellpiez.com/xproc-zone/ns'</sqf:title>
         </sqf:description>
         <sqf:add match="/*" node-type="attribute" select="'zone:' || $basename" target="type"/>
         <sqf:add match="/*" node-type="attribute" select="'http://wendellpiez.com/xproc-zone/ns'" target="xmlns:zone"/>
      </sqf:fix>
      
      <sqf:fix id="sqf-repair-step-name">
         <sqf:description>
            <sqf:title>Assign the file base name '<sch:value-of select="$basename"/>' as the step name</sqf:title>
         </sqf:description>
         <sqf:add match="/*" node-type="attribute" select="$basename" target="name"/>
      </sqf:fix>
      <sqf:fix id="sqf-name-step-main">
         <sqf:description>
            <sqf:title>Name the step 'main'</sqf:title>
         </sqf:description>
         <sqf:add match="/*" node-type="attribute" select="'main'" target="name"/>
      </sqf:fix>
      
      <sqf:fix id="sqf-remove-port">
         <sqf:description>
            <sqf:title>Remove the port binding on p:with-input</sqf:title>
         </sqf:description>
         <sqf:delete match="@port"/>
         
      </sqf:fix>
   </sqf:fixes>
</sch:schema>
