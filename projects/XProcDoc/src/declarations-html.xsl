<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   xmlns:zone="http://wendellpiez.com/xproc-zone/ns" xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="#all" expand-text="true" version="3.0">

<!-- This stylesheet is overloaded with logic that could be
     separated into modules - while the purpose here is to
     generate a standalone HTML page, even if subject to
     further modifications.
   
   So for now we keep everything in one place (here).
   
   Producing HTML, CSS and Javascript all together and interlinked. -->


   <xsl:variable name="page-title">XProc 3.0/3.1 Step List</xsl:variable>

   <xsl:template match="/*">
      <html>
         <head>
            <title>{ $page-title }</title>
            <xsl:call-template name="make-style"/>
            <xsl:call-template name="make-script"/>
         </head>
         <body>
            <aside id="directory">
               <xsl:apply-templates select="//declare-step" mode="directory">
                  <xsl:sort select="@type"/>
               </xsl:apply-templates>
            </aside>
            <main>
               <xsl:call-template name="lede"/>
               <xsl:for-each-group select="declare-step" group-by="(@library, 'standard')[1]">
                  <section class="library" id="{current-grouping-key()}">
                     <h2>{ current-grouping-key() ! upper-case(.) } library</h2>
                     <xsl:apply-templates select="current-group()"/>
                  </section>
               </xsl:for-each-group>
            </main>
         </body>
      </html>
   </xsl:template>

   <xsl:function name="zone:morgana-supports" as="xs:boolean">
      <xsl:param name="step" as="element(declare-step)"/>
      <!-- Morgana coverage is documented at https://www.xml-project.com/morganaxproc-iiise.html -->
      <xsl:sequence
         select="$step/@library = ('standard', 'validation', 'file', 'ixml') and not($step/@type = 'p:validate-with-nvdl')"
      />
   </xsl:function>

   <xsl:template match="declare-step" mode="directory">
      <p class="index">
         <xsl:apply-templates select="." mode="internal-link"/>
      </p>
   </xsl:template>

   <xsl:template match="declare-step">
      <details id="{ zone:step-name(.) }"
         class="step { @library[.='standard']/' standard' } { if (zone:morgana-supports(.)) then 'supported' else 'unsupported'}"
         open="open">
         <summary>
            <div class="linkout">
               <xsl:apply-templates select="." mode="specification-link">
                  <xsl:with-param name="linktext">
                     <b>{ @library }</b>
                     <xsl:text> library</xsl:text>
                  </xsl:with-param>
               </xsl:apply-templates>
            </div>
            <xsl:text>{ @type} </xsl:text>
         </summary>
         <xsl:if test="zone:morgana-supports(.) => not()">
            <p class="warning">Unsupported in MorganaXProc-IIIse</p>
         </xsl:if>
         <xsl:apply-templates select="." mode="syntax-map"/>
         <xsl:apply-templates select="child::output" mode="syntax-map"/>
         <xsl:apply-templates select="." mode="input-table"/>
         <xsl:apply-templates select="." mode="output-table"/>
         <xsl:apply-templates select="." mode="options-table"/>
      </details>
   </xsl:template>

   <xsl:variable name="copy-button">
      <button class="cp" onclick="copyToClipboard(this.nextElementSibling)"
         onmouseover="this.nextElementSibling.classList.add('seeme')"
         onmouseout="this.nextElementSibling.classList.remove('seeme')">Copy</button>
   </xsl:variable>

   <xsl:template match="declare-step" mode="syntax-map">
      <xsl:call-template name="syntax-block">
         <xsl:with-param name="codeblock">
            <xsl:text>&lt;{ @type} name="DO_{ zone:step-name(.) }"</xsl:text>
            <xsl:apply-templates mode="#current" select="option">
               <xsl:sort select="@name"/>
            </xsl:apply-templates>
            <xsl:text>{ if (empty(input)) then '/>' else '>'}</xsl:text>
            <xsl:apply-templates mode="#current" select="input">
               <xsl:sort select="@primary" order="descending"/>
               <xsl:sort select="@required" order="descending"/>
               <xsl:sort select="@port"/>
            </xsl:apply-templates>
            <xsl:if test="exists(input)">
               <xsl:text>&#xA;&lt;/{ @type}&gt;</xsl:text>
            </xsl:if>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   
   <xsl:template match="declare-step/output" mode="syntax-map">
      <xsl:variable name="implicit" select="empty(../output except .)"/>
      <xsl:variable name="stp" select="replace(../@type, '^p:', '')"/>
      <xsl:call-template name="syntax-block">
         <xsl:with-param name="codeblock">
            <span>
               <xsl:call-template name="add-flashing">
                  <xsl:with-param name="idfr">{ $stp }-{ (@port,'result')[1] }-output</xsl:with-param>
               </xsl:call-template>
               <xsl:text>&lt;p:with-input port="..." pipe="{@port[not($implicit)]}@DO_{ zone:step-name(parent::declare-step) }"/></xsl:text>
            </span>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>

   <xsl:template name="syntax-block">
      <xsl:param name="codeblock"/>
      <div class="syntax-block">
         <xsl:variable name="implicit" select="empty(../output except .)"/>
         <xsl:copy-of select="$copy-button"/>
         <pre class="syntax-map">
            <xsl:sequence select="$codeblock"/>
         </pre>
      </div>
   </xsl:template>

   
   <xsl:template match="declare-step/option" mode="syntax-map">
      <xsl:variable name="stp" select="replace(../@type,'^p:','')"/>
      <xsl:variable name="idfr">{ $stp }-{ @name }-{ local-name() }</xsl:variable>
      <xsl:text>&#xA;  </xsl:text>
      <span>
         <xsl:call-template name="add-flashing">
            <xsl:with-param name="idfr" select="$idfr"/>
         </xsl:call-template>
         <xsl:if test="@required = 'true' or empty(../option except .)">
            <xsl:attribute name="class">required</xsl:attribute>
         </xsl:if>

         <xsl:text>{@name}="</xsl:text>
         <span class="ss">[{ @as }]</span>
         <xsl:text>{ @select!(' ' || .) }"</xsl:text>
      </span>
   </xsl:template>

   <xsl:template match="declare-step/input" mode="syntax-map">
      <xsl:variable name="stp" select="replace(../@type,'^p:','')"/>
      <xsl:variable name="idfr">{ $stp }-{ (@port,'source')[1] }-input</xsl:variable>
      <xsl:text>&#xA;  </xsl:text>
      <span>
         <xsl:call-template name="add-flashing">
            <xsl:with-param name="idfr" select="$idfr"/>
         </xsl:call-template>
         <xsl:text>&lt;p:with-input</xsl:text>
         <xsl:for-each select="@*">
            <xsl:text> { local-name() }="{ . }"</xsl:text>
         </xsl:for-each>
         <xsl:text>/></xsl:text>
      </span>
   </xsl:template>

   <xsl:function name="zone:step-name" as="xs:string?">
      <xsl:param name="step" as="element(declare-step)"/>
      <xsl:sequence select="$step ! substring-after(@type, 'p:')"/>
   </xsl:function>


   <xsl:template match="declare-step[@library = 'standard']" mode="specification-link" priority="10">
      <xsl:param name="linktext">{ @type }</xsl:param>
      <a class="steplink speclink" target="spec"
         href="https://spec.xproc.org/3.0/steps/#c.{zone:step-name(.)}">
         <xsl:sequence select="$linktext"/>
      </a>
      <xsl:call-template name="xprecref-link"/>
   </xsl:template>

   <xsl:template match="declare-step" mode="specification-link">
      <xsl:param name="linktext">{ @type }</xsl:param>
      <a class="steplink speclink" target="spec"
         href="https://spec.xproc.org/master/head/{@library}/#c.{zone:step-name(.)}">
         <xsl:sequence select="$linktext"/>
      </a>
      <xsl:call-template name="xprecref-link"/>
   </xsl:template>

   <xsl:template name="xprecref-link">
      <!--Still getting some 404s -->
      <a class="steplink speclink" target="spec"
         href="https://xprocref.org/3.1/p.{zone:step-name(.)}.html">XProcRef description</a>
   </xsl:template>


   <xsl:template match="declare-step" mode="internal-link">
      <a href="#{zone:step-name(.)}"
         class="steplink internal{ @library[.='standard']/' standard-step' } {
         if (zone:morgana-supports(.)) then 'supported' else 'unsupported' }">{ @type }</a>
   </xsl:template>

   <xsl:template match="declare-step/*">
      <p class="{local-name()}{ @primary[.='true']/' primary' }{ @required[.='true']/' required' }">
         <xsl:text>{ local-name() }</xsl:text>
         <xsl:for-each select="@*">
            <xsl:text> { local-name() }="</xsl:text>
            <code>{.}</code>
            <xsl:text>"</xsl:text>
         </xsl:for-each>
      </p>
   </xsl:template>

   <xsl:variable name="truestr" select="'true', 'yes', 'YES', 'y', 'Y', '1'"/>

   <!-- @ : @ ::: @ : @ ::: @ : @ ::: @ : @ ::: @ : @ ::: @ : @ ::: @ : @ -->

   

   <xsl:template match="declare-step" mode="input-table">
      <xsl:if test="exists(input)">
         <div class="inputs framed">
            <h3 class="h"><code>{ @type }</code> input{ input[2]/'s' }</h3>
            <table class="frame">
               <xsl:call-template name="port-key-line"/>
               <xsl:apply-templates select="input" mode="#current">
                  <xsl:sort select="@primary" order="descending"/>
                  <xsl:sort select="@required" order="descending"/>
                  <xsl:sort select="@port"/>
               </xsl:apply-templates>
            </table>
         </div>
      </xsl:if>
   </xsl:template>

   <xsl:template name="port-key-line">
      <tr class="keyrow">
         <th class="port key">port</th>
         <th class="content-types key">content types</th>
         <th class="sequence key">sequence?</th>
         <th class="isprimary key">primary?</th>
      </tr>
   </xsl:template>

   <xsl:template match="declare-step" mode="output-table">
      <xsl:if test="exists(output)">
         <div class="outputs framed">
            <h3 class="h"><code>{ @type }</code> output{ output[2]/'s' }</h3>
            <table class="frame">
               <xsl:call-template name="port-key-line"/>
               <xsl:apply-templates select="output" mode="#current">
                  <xsl:sort select="@primary" order="descending"/>
                  <xsl:sort select="@port"/>
               </xsl:apply-templates>
            </table>
         </div>
      </xsl:if>
   </xsl:template>

   <xsl:template match="input" mode="input-table">
      <xsl:call-template name="make-io-row">
         <xsl:with-param name="solo" select="empty(../input except .)"/>
      </xsl:call-template>
   </xsl:template>
   
   <xsl:template name="make-io-row">
      <xsl:param name="solo" as="xs:boolean" select="false()"/>
      <xsl:variable name="is-primary" select="@primary = 'true' or $solo"/>
      <xsl:variable name="stp" select="replace(../@type,'^p:','')"/>
      <xsl:variable name="ptn" select="( @port, self::output/'result', self::input/'source')[1]"/>
      <xsl:variable name="idfr">{ $stp }-{ $ptn }-{ local-name() }</xsl:variable>
      <tr class="input row{ @required[.=$truestr]/' required' }{
         if ($is-primary) then ' primary' else ' secondary'}">
         <xsl:call-template name="add-flashing">
            <xsl:with-param name="idfr" select="$idfr"/>
            <xsl:with-param name="marking">row</xsl:with-param>
         </xsl:call-template>
         <td class="port">{ @port } </td>
         <td class="content-types">{ @content-types } </td>
         <td class="sequence{ (@sequence/'',' inferred')[1] }">{ (@sequence,'(false)')[1] } </td>
         <td class="isprimary{ (' inferred'[$solo],@primary/'',' inferred')[1] }">{ ('(true)'[$solo],@primary,'(false)')[1] } </td>
      </tr>
   </xsl:template>
   
   <xsl:template match="output" mode="output-table">
      <xsl:call-template name="make-io-row">
         <xsl:with-param name="solo" select="empty(../output except .)"/>
      </xsl:call-template>
   </xsl:template>
   
   <xsl:template match="declare-step" mode="options-table">
      <xsl:if test="exists(option)">
         <div class="options framed">
            <h3 class="h"><code>{ @type }</code> option{ option[2]/'s' }</h3>
            <table class="frame">
               <tr class="keyrow">
                  <th class="name key">name</th>
                  <th class="datatype key">data type</th>
                  <th class="default key">default</th>
               </tr>
               <xsl:apply-templates select="option" mode="#current">
                  <xsl:sort select="@name"/>
               </xsl:apply-templates>
            </table>
         </div>
      </xsl:if>
   </xsl:template>

   <xsl:template name="add-flashing">
      <xsl:param name="idfr" required="true"/>
      <xsl:param name="marking">syntax</xsl:param><!-- or 'row' -->
      <xsl:variable name="target" select="if ($marking='syntax') then 'row' else 'syntax'"/>
      <!--<xsl:variable name="typ" select="replace(../@type,'^p:','')"/>
      <xsl:variable name="nm" select="(@name,@port)[1]"/>-->
      
      <xsl:attribute name="id">{$idfr}-{ $marking }</xsl:attribute>
      <xsl:attribute name="onmouseover">brightenOn('{$idfr}-{$target}')</xsl:attribute>
      <xsl:attribute name="onmouseout">brightenOff('{$idfr}-{$target}')</xsl:attribute>
      
      <!--<xsl:attribute name="mouseover">document.getElementById('{$idfr}-{$target}').addClass('brightened')</xsl:attribute>
      <xsl:attribute name="mouseout">document.getElementById('{$idfr}-{$target}').removeClass('brightened')</xsl:attribute>-->
   </xsl:template>
   
   <xsl:template match="option" mode="options-table" expand-text="true">
      <xsl:variable name="stp" select="replace(../@type,'^p:','')"/>
      <xsl:variable name="idfr">{ $stp }-{ @name }-option</xsl:variable>
      <tr class="row option{ @required[.=$truestr]/' required' }">
         <xsl:call-template name="add-flashing">
            <xsl:with-param name="idfr" select="$idfr"/>
            <xsl:with-param name="marking">row</xsl:with-param>
         </xsl:call-template>
            
         <td class="name">{ @name } </td>
         <td class="datatype">{ @as } </td>
         <td class="default{ @required[.=$truestr]/' required' }">{ if (@required=$truestr) then
            'REQUIRED' else (@select,'()')[1] } </td>
      </tr>
   </xsl:template>

   <!-- @ : @ ::: @ : @ ::: @ : @ ::: @ : @ ::: @ : @ ::: @ : @ ::: @ : @ -->
   
   
   <xsl:template name="make-style" expand-text="false">
      <style xml:space="preserve">

#directory { position: fixed; top: 6em; right: 1rem; background-color: gainsboro; border: thin solid black; max-height: 80vh  }
aside#directory { padding: 1.2em; margin: 0em; overflow-y: scroll;  top: 4em; }
#directory p { margin: 0em; margin-top: 0.3em }

main { max-width: 50em }

div.linkout { float: right; font-size: 80% }

.ss { font-family: sans-serif; font-size: 75% }
details.step { background-color: whitesmoke; outline: thin solid black; padding: 0.8em; margin-top: 1em }
details.step.supported { background-color: #c6cadd }
details.step *:last-child  { margin-bottom: 0em }
.step summary { font-size: 130%; font-family: sans-serif }
.boxed { outline: thin solid black; background-color: white; padding: 0.4em; max-width: fit-content }
pre.syntax-map { outline: thin solid black; background-color: white; padding: 1em; max-width: fit-content; margin-right: 4em }
pre.syntax-map.seeme { outline: medium dotted black; background-color: #a3b4ff  }
div.syntax-block { max-width: fit-content }
p.warning { font-style: italic }

div.framed { padding: 0.4em; border: thin outset black; margin-top: 2em; background-color: gainsboro }
/* span all columns */
div.framed .h { margin: 0.4em 0em } 

table.frame { min-width: 60%; border-collapse: collapse; font-size: smaller;
border-top: thin solid black; border-bottom: thin solid black }

.frame {

   th, td { border-left: thin outset black; border-right: thin outset black; padding: 0.4rem }
   th { font-family: sans-serif; font-weight: normal }

   .primary, .required { font-weight: bold }

   td.name, td.port, td.default { font-family: monospace; font-size: 120% }
   .required { font-family: inherit }
   .key { outline: none; background-color: darkblue; color: gainsboro;
     font-family: sans-serif; font-size: smaller; font-weight: bold; border-bottom: thin solid black }
   .inferred { font-size: smaller; text-align: center; font-weight: normal }
}

a { text-decoration: none; color: midnightblue }
a:hover { text-decoration: underline }
p.index a { display: inline-block; border: thin outset black; border-bottom: medium solid black; background-color: white; padding: 0.2em }
p.index a:hover { text-decoration: underline; outline: medium solid grey }

div.linkout a { padding: 0.4em; font-size: 80% }
div.linkout a:hover { outline: medium dotted steelblue }

.unsupported { color: grey }
button.cp { float: right }


.brightened { background-color: #C2BCAB }

.row:hover { background-color: #C2BCAB }

pre.syntax-map span:hover { background-color: #C2BCAB }

         </style>
   </xsl:template>

   <xsl:template name="make-script" expand-text="false">
      <!-- replace with navigator.clipboard.writeText, which returns a promise - or not? our use is pretty secure     -->
      <script>
         /* selects textarea#linkcopy and copies it to the system clipboard */
         function copyToClipboard(block) {
         window.getSelection().selectAllChildren(block);
         document.execCommand('copy');
         }
         
         function brightenOn(elemID) {
         console.log('brightening' + elemID);
         document.getElementById(elemID).classList.add('brightened');
         }
         
         function brightenOff(elemID) {
         console.log('unbrightening' + elemID);
         document.getElementById(elemID).classList.remove('brightened');
         }
         
      </script>
   </xsl:template>

   <xsl:template name="lede">
      <h1>{ $page-title }</h1>
      <section id="introduction">
         <p>This directory to XProc steps was generated by querying the specification documents.
            Because those documents have machined consistency (having been maintained and produced
            in XProc), it is feasible for an automated, testable process to stitch them all together
            with links to them and to similarly derived documents, such as Erik Siegel's invaluable
               <a href="http://xprocref.org">XProcRef</a>.</p>
         <p><i>Standard</i> steps in this list are the core atomic steps required by the <a
               href="https://spec.xproc.org/master/head/xproc/">XProc Specification</a> for all
            XProc engines.</p>
         <p>Additionally the page lists all the steps defined in community specifications but not
            required for compliance.</p>
         <p>At the top, find links for the core compound steps, <code>for-each</code>,
               <code>try/catch</code> etc.</p>
         <p>The following documents define the optional, community-standard steps (and are also
            linked from their steps):</p>
         <div id="specification-links">
            <!-- insertion point for specification links -->
         </div>
         <p>The step list here is derived from the XProc code base and may show steps not yet added
            to the published specification, because still in process.</p>
         <details class="boxed">
            <summary>To use</summary>
            <p>XProc Steps are shown with links to their definitions in libraries and references, at
               top right.</p>
            <p>Visual indications (grey fading) show if a step is not implemented or not yet offered
               in <a href="https://www.xml-project.com/morganaxproc-iiise.html"
                  >MorganaXProc-IIIse</a>. Because the logic determining this property may fall
               behind the product offering, some diligence is also called for. (XML Calabash
               offerings are not yet so marked: please refer to <a
                  href="https://www.xmlcalabash.com/">its documentation</a>.)</p>
            <p>The <button>Copy</button> buttons provide for copying code blocks to the user's
               clipboard (on up-to-date browsers).</p>
         </details>

      </section>
   </xsl:template>
</xsl:stylesheet>