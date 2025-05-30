<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:zone="http://wendellpiez.com/xproc-zone/ns">

   <p:import href="../projects/XProcDoc/assemble-step-index.xpl"/>
   
   
   <p:variable name="outdir" select="'../docs/xproc-lab'"/>
   
   <!-- Produces XHTML -->
   <zone:assemble-step-index/>
   
   <p:insert match="html/head" position="last-child">
      <p:with-input port="insertion" expand-text="false">
         <link rel="stylesheet" href="../site/zone-main.css"/>
         <style type="text/css" xml:space="preserve">


#bannerbar { display: flex; justify-content: space-between; color: skyblue; padding-top: 0.2em }

#bannerbar a { color: skyblue; text-decoration: none; border: thin solid skyblue;
               background-color: #404F69; padding: 0.3em }
#bannerbar a:hover { text-decoration: underline; color: cyan }

            </style>
         <link rel="icon" type="image/svg+xml" href="../site/zed.svg"/>            
      </p:with-input>
   </p:insert>
   
   <p:insert match="html/body" position="first-child">
      <p:with-input port="insertion">
         <div id="bannerbar">
            <div id="pnav">
               <a href="index.html">XProc Lab</a>
            </div>
            <div id="sitenav">
               <a href="../index.html">XProc Zone</a>
               <a href="https://github.com/wendellpiez/xproc-zone">Code</a>
            </div>
         </div>
      </p:with-input>
   </p:insert>
   
   <p:delete match="details/@open"/>
   
   <p:label-elements match="aside[@class='directory']//a" attribute="onclick" label="'document.getElementById(''' || substring-after(@href,'#') || ''').open=true;'"/>
   
   <p:insert match="body/main/div[1]" position="after">
      <p:with-input port="insertion">
         <button onclick="document.querySelectorAll('details.step').forEach(d => d.open = true); ">Open All</button>
         <button style="margin-left: 1em" onclick="document.querySelectorAll('details.step').forEach(d => d.open = false);">Close All</button>
      </p:with-input>
   </p:insert>
   
   <p:namespace-delete prefixes="zone xs c"/>
   
   
   <p:store href="{ $outdir }/xproc-crib-sheet.html" message=" p:store: { $outdir }/xproc-crib-sheet.html ..."/>
   
   
</p:declare-step>