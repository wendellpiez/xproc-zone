<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:zone="http://wendellpiez.com/xproc-zone/ns">


<!-- REQUIRES CONNECTIVITY - set your proxy server -->
   <p:import href="../projects/XProcDoc/src/assemble-step-list.xpl"/>
   
   <p:import href="../projects/XProcDoc/src/index-repository-xproc.xpl"/>
   
   <p:declare-step type="zone:xproc-lab-equipment">
      
      <p:input  port="source"/>
      <p:output port="result"/>
      
   <p:insert match="html/head" position="last-child">
      <p:with-input port="insertion" expand-text="false">
         <link rel="stylesheet"            href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&amp;family=Noto+Serif:ital,wght@0,100..900;1,100..900&amp;display=swap" />
         <link rel="stylesheet" href="../site/zone-main.css"/>
         <style type="text/css" xml:space="preserve">

details#directory { padding-right: 1em; max-height: inherit; min-width: 20vw }
#directory-listing { overflow-y: scroll; box-sizing: border-box; max-height: 80vh; margin-top: 0.6em }

div#details-controls { position: fixed; top: 4em; right: 1rem }
    
button#closeAll { display: none }

#introduction { border: thin solid black; margin-bottom: 1em }

#bannerbar { display: flex; justify-content: space-between; color: skyblue; padding-top: 0.2em; }

#bannerbar div,
#bannerbar p { margin: 0em; background-color: #404F69; color: skyblue }

#bannerbar div { padding: 0.3em; border: thin solid skyblue }


#bannerbar a { color: skyblue; }
#bannerbar a:hover { text-decoration: underline; color: cyan }

code { font-size: larger; padding: 0.2em;
       background-color: #DDC6CA }

main.xproc-index { max-width: inherit;

  .panel { max-width: 72em }
  .elem .entry { max-width: inherit }

}

.lab a { color: midnightblue }

            </style>
         <link rel="icon" type="image/svg+xml" href="../site/zed.svg"/>            
      </p:with-input>
   </p:insert>
   
   <p:add-attribute match="/html/body" attribute-name="class" attribute-value="lab"/>
   
   <p:insert match="html/body" position="first-child">
      <p:with-input port="insertion">
         <div id="bannerbar">
            <div id="pnav">
               <p><a href="index.html">XProc Lab</a></p>
            </div>
            <div id="sitenav">
               <span>XProc Zone </span>
               <a class="internal" href="../index.html">Home</a>
               <span> | </span>
               <a href="https://github.com/wendellpiez/xproc-zone">Code</a>
            </div>
         </div>
      </p:with-input>
   </p:insert>
   
      <p:insert position="last-child" match="html/body">
         <p:with-input port="insertion">
            <hr class="hr"/>
            <footer class="in-a-row">
               <!-- Add your name here! -->
               <div><b><a href="{ ../index.html }">XProc Zone</a></b> was designed and built by Wendell&#xA0;Piez, 2025</div>
               <div>
                  <a href="https://github.com/wendellpiez/xproc-zone">Clone the Zone</a>
               </div>
            </footer>
         </p:with-input>
      </p:insert>
   </p:declare-step>
   
<!-- ADVENTURES AWAIT THE BOLD -->
   
   
   <p:variable name="outdir" select="'../docs/xproc-lab'"/>
   
   <!-- Produces XHTML -->
   <zone:index-repository-xproc name="repo-index"/>
   
   <zone:xproc-lab-equipment name="equip-repo-index"/>
   
   <p:add-attribute match="details[@class='elem']" attribute-name="class" attribute-value="elem panel"/>
   
   <p:insert match="main" position="first-child">
      <p:with-input port="insertion">
         <h1>Index to XProc in the Zone</h1>
         <p>This index is produced from the XProc source data using XProc.</p>
      </p:with-input>
   </p:insert>   
   
   <p:store href="{ $outdir }/zone-xproc-index.html" message=" p:store: { $outdir }/zone-xproc-index.html ..."/>
   
   <!-- this is implicit but we put it here anyway -->
   <p:sink/>
      
   <!-- Produces XHTML -->
   <zone:assemble-step-list/>
   
   <zone:xproc-lab-equipment name="equip-step-list"/>
   
   <p:rename match="section[@id='introduction']" new-name="details"/>   
   
   <p:rename match="aside[@id='directory']" new-name="div"/>
   
   <p:wrap match="*[@id='directory']" wrapper="details"/>
   
   <p:namespace-rename to="http://www.w3.org/1999/xhtml" apply-to="elements"/>

   <p:add-attribute match="details[div/@id='directory']" attribute-name="id" attribute-value="directory"/>
   
   <p:add-attribute match="details[@id='directory']/div" attribute-name="id" attribute-value="directory-listing"/>
   
   
   <p:insert match="details[@id='directory']" position="first-child">
      <p:with-input port="insertion">
         <summary>index</summary>
      </p:with-input>
   </p:insert>
   
   <p:insert match="details[@id='introduction']" position="first-child">
      <p:with-input port="insertion">
         <summary>Description</summary>
      </p:with-input>
   </p:insert>
   
   
   <p:delete match="details/@open"/>
   
   <p:label-elements match="details[@id='directory']//a" attribute="onclick" label="'document.getElementById(''' || substring-after(@href,'#') || ''').open=true;'"/>
   
   <p:insert match="details[@id='directory']" position="before">
      <p:with-input port="insertion">
         <div id="details-controls">
            <button id="openAll"
               onclick="this.nextElementSibling.style.display = 'inline-block'; this.style.display='none'; document.querySelectorAll('details.step').forEach(d => d.open = true);"
               >Open All</button>
            <button id="closeAll" style="margin-left: 1em"
               onclick="this.previousElementSibling.style.display = 'inline-block'; this.style.display='none'; document.querySelectorAll('details.step').forEach(d => d.open = false);"
               >Close All</button>
         </div>
      </p:with-input>
   </p:insert>
   
   <p:variable name="known-steps" select="/descendant::details[@class='elem']">
      <p:pipe step="repo-index"/>
   </p:variable>
   
   <p:xslt parameters="map { 'index-elements': $known-steps }">
      <p:with-input port="stylesheet">
         <!--NOTE p:expand-text is false to turn off TVT evaluation inside -->
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xpath-default-namespace="http://www.w3.org/1999/xhtml">
               <!-- $index-elements is a set of details with div[@class='entry'] children -->
               <xsl:param name="index-elements" as="element()*" required="true"/>
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:template match="*[@class='linkout'][../../@id = $index-elements/@id]" expand-text="true">
                  <xsl:variable name="myID" select="../../@id"/>
                  <xsl:variable name="thisIndex" select="$index-elements[ @id = $myID ]"/>
                  <xsl:variable name="lnkstr">example{ $thisIndex/div[@class='entry'][2]/'s' }</xsl:variable>
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <a class="steplink speclink" href="zone-xproc-index.html#{ $myID }">{ $lnkstr }</a>
                     <xsl:apply-templates/>
                  </xsl:copy>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   <p:namespace-delete prefixes="zone xs c"/>
   
   <p:store href="{ $outdir }/xproc-step-list.html" message=" p:store: { $outdir }/xproc-step-list.html ..."/>
   
</p:declare-step>