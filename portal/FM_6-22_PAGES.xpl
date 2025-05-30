<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://www.w3.org/1999/xhtml"
    xmlns:zone="http://wendellpiez.com/xproc-zone/ns">

   <!-- Pipeline produces two HTML file outputs from OSCAL source, for demonstration -->
   
   <!-- NB the XSLTs are specifically coded for this OSCAL - this is not generic handling -->

   
   <!-- Errors out if file is not present: run pipeline ../projects/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl -->
   <p:input port="source" href="../projects/USArmy_FM6-22/FM_6-22-OSCAL-working.xml"/>
   
   <!--<p:output port="result"/>-->
   
   <p:declare-step name="add-banner" type="zone:add-banner">
      <p:input port="source"/>
      <p:output port="result"/>
      <p:insert match="html/head" position="last-child">
         <p:with-input port="insertion" expand-text="false">
            <style type="text/css" xml:space="preserve">


#bannerbar { display: flex; justify-content: space-between; color: skyblue; padding-top: 0.2em }

#bannerbar a { color: skyblue; text-decoration: none; border: thin solid skyblue;
               background-color: #404F69; padding: 0.3em }
#bannerbar a:hover { text-decoration: underline }
.catalog#chapter4   #bannerbar a#fulltext { display: none }
.catalog#table_view #bannerbar a#tables   { display: none }
.catalog#draw_one   #bannerbar a#draw     { display: none }

            </style>
            <link rel="icon" type="image/svg+xml" href="../site/zed.svg"/>            
         </p:with-input>
      </p:insert>
      <p:insert position="first-child" match="html/body">
         <p:with-input port="insertion">
            <div id="bannerbar">
               <div id="pnav">
                  <a href="index.html">Project</a>
                  <a id="fulltext" href="FM_6-22-fulltext.html">Chapter 4</a>
                  <a id="tables"   href="FM_6-22-tables.html">Tables</a>
                  <a id="draw"     href="FM_6-22-draw_one.html">Draw one</a>
               </div>
               <div id="sitenav">
                  <a href="../index.html">XProc Zone</a>
                  <a href="https://github.com/wendellpiez/xproc-zone">Code</a>
               </div>
            </div>
         </p:with-input>
      </p:insert>
      <p:namespace-delete prefixes="oscal zone xs c" xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0" />
   </p:declare-step> 
   
   
   <p:variable name="outdir" select="'../docs/fm6-22'"/>
   
   <p:identity name="oscal-source" message="[FM_6-22_PAGES] Seeing source file { base-uri(/) }"/>
   
   <!-- These XSLT 1.0 stylesheets are coded to be forward-compatible with the XSLT 3.0 engine  -->
   <p:xslt name="fulltext-webpage">
      <p:with-input port="stylesheet" href="../projects/USArmy_FM6-22/src/www_fm22-6_fulltext.xsl"/>
   </p:xslt>
   
   <zone:add-banner/>
   
   <p:store href="{ $outdir }/FM_6-22-fulltext.html" serialization="map{ 'method': 'html' }" message="[FM_6-22_PAGES] p:store: { $outdir }/FM_6-22-fulltext.html ..."/>
   
   <!-- implicit p:sink as we start with new source port -->
   
   
   <p:xslt name="tables-webpage">
      <p:with-input port="source" pipe="@oscal-source"/>
      <p:with-input port="stylesheet" href="../projects/USArmy_FM6-22/src/www_fm22-6_tables.xsl"/>
   </p:xslt>
   
   <zone:add-banner/>
   
   <p:store href="{ $outdir }/FM_6-22-tables.html" serialization="map{ 'method': 'html' }" message="[FM_6-22_PAGES] p:store: { $outdir }/FM_6-22-tables.html ..."/>

   <!-- Further modifications make the 'tabular' view into the 'draw one' view -->
   
   <p:add-attribute match="html/body" attribute-name="id" attribute-value="draw_one"/>
   
   <p:delete match="section/h2 | section/h3"/>
   
   <!-- Deactivating  -->
   <p:delete match="details/@onfocus"/>
   
   <p:unwrap match="section"/>
   
   <p:insert match="html/head" position="last-child">
      <p:with-input port="insertion" expand-text="false">
         <style type="text/css" xml:space="preserve">

header { margin: auto; max-width: 40rem }
.control { display: none; margin: auto; width: fit-content }            
.control h3 { text-align: center }

.requirements.group, .group { border: none }
.requirements-group-title { display: none }

button#draw_one_now { margin: 1em auto; display: block; font-size: 120%;
  padding: 0.2em; border: thin inset grey }

#draw_one .control summary { font-size: 120%; font-weight: bold; text-align: center }

details.control { padding: 1em 2em }
.requirement div.part { margin-left: 0em }

         </style>
         <script type="text/javascript">

const controls = document.getElementsByClassName('control');

function getRandomControlId() {
  const randomIndex = Math.floor(Math.random() * controls.length);
  return controls[randomIndex].id;
}

function draw_one() {
   let anID = getRandomControlId();
   let aControl = document.getElementById(anID);
   [...controls].forEach(el => el.style.display = 'none');
   [...controls].forEach(el => el.open = false);
   aControl.style.display = 'block';
}
         </script>
      </p:with-input>
   </p:insert>
   
   <p:insert match="html/body/main" position="first-child">
      <p:with-input port="insertion" expand-text="false">
         <button id="draw_one_now" onclick="draw_one()" >DRAW</button>
      </p:with-input>
   </p:insert>
   
   <p:string-replace match="text()[normalize-space()]" replace="replace(string(.),'\s+',' ')"/>
   
   <p:store href="{ $outdir }/FM_6-22-draw_one.html" serialization="map{ 'method': 'html' }" message="[FM_6-22_PAGES] p:store: { $outdir }/FM_6-22-draw_one.html ..."/>
   
   
<!--1. hide everything with CSS
2. show all but one with CSS
3. implement button chooser - randomized table
-->
<!-- Now adding a script to add a random picker -->
   
</p:declare-step>