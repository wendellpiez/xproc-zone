<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
   xmlns:p="http://www.w3.org/ns/xproc" 
   version="3.0">

   <p:option name="CYPHER" select="'PYSXZTBKWFQGEVUOJLACDNHRIM'"/>
   
   <p:variable name="ALPHABET" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
   
   <!-- plain-old sequence of strings -->
   <p:variable name="en" select="('one', 'two', 'three')"/> 

   <!-- sequence of strings pulled from markup -->
   <p:variable name="jp" select="/yomi/string(.)">
      <p:inline>
         <yomi>ichi</yomi>
         <yomi>ni</yomi>
         <yomi>san</yomi>
      </p:inline>
   </p:variable> 
   
   <!-- To use AVTs, declare the string as an XPath over a provided context (text node) -->
   <p:variable name="dichtung" select="string(.)">
      <p:inline>Aug Englisch haben Sie { $en => string-join(', ') } was auf Japonish geht { $jp => string-join(', ') }.</p:inline>
   </p:variable>
   
   <!-- Binding an anonymous function to a variable
   
   instead of using p:import-functions, available only in paid processors
   (XML Calabash w/ Saxon-EE, Morgana XProc-IIIee -->
   
<!-- XPath anonymous functions providing bespoke functionality - syntax
     (albeit not a realistic example since we don't really need a function for this) -->
   <p:variable name="decoder-ring" as="function(*)"
      select="function($s as xs:string) as xs:string { translate($s,$CYPHER, $ALPHABET) }"/>
   
   <p:variable name="in" select="'KZGGU HULGX!'"/>

   <!-- Hard core! rewrite sequence (a,b,c,d,..,e,f,.,g) as (a,b,c,e,f,g)
     sequence of any number of '.' comes back as '.'
     initial '..' are kept -->
   <p:variable name="collapse-steps" as="function(*)"
      select="function($steps as xs:string*) as xs:string* {
         fold-left( $steps, (), function($seq , $s) {
            if (not($steps != '.')) then '.' (: edge case for sequences of '.' - emit a '.' :)
            else if ($s='.') then $seq (: keeping path unchanged :)
            else if ($s='..' and ($seq != '..')) then ($seq => reverse() => tail() => reverse())
              (: removing last step unless there was no prior step except '..' :)
            else ($seq, $s) } ) }"/>
   
   <p:variable name="collapse-uri" as="function(*)" select="
      function($path as xs:anyURI) as xs:anyURI
        { $path => tokenize('/') => $collapse-steps() => string-join('/'} }"/>
   
   <p:identity>
      <p:with-input>
         <EVALUATION>
            <EN>{ string-join($en,', '} }</EN>
            <JP>{ string-join($jp,', '} }</JP>
            <dichtung>{ $dichtung }</dichtung>
            <secret>{ $in => $decoder-ring() }</secret>
            <path>{ static-base-uri(/) => $collapse-uri()</path>
         </EVALUATION>
      </p:with-input>
   </p:identity>
     
</p:declare-step>