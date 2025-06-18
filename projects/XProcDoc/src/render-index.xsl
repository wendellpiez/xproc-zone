<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0"  expand-text="true">
    
    <!-- Renders XProc index produced by repo-xproc-index.xsl -->
    
    <xsl:param name="repo-path" as="xs:anyURI">https://github.com/wendellpiez/xproc-zone/blob/main</xsl:param>
    
    <!-- projects/XProcDoc/COLLECT-XPROC-STEPS.xpl#L40-->
    <xsl:template priority="101" match="/*">
        <html>
            <head>
                <title>XProc Zone: Index to XProc</title>
                <xsl:call-template name="make-style"/>
            </head>
            <xsl:next-match/>
        </html>        
    </xsl:template>
    
    <xsl:template match="index">
        <body>
            <main class="xproc-index">
                <xsl:for-each-group select="entry" group-by="@name">
                    <xsl:sort select="current-grouping-key()"/>
                    <details class="elem">
                        <summary class="head">{ current-grouping-key() }</summary>
                        <xsl:apply-templates select="current-group()"/>
                    </details>
                </xsl:for-each-group>
            </main>
        </body>        
    </xsl:template>
    
    <xsl:template match="entry">
        <div class="entry">
            <p class="filepath"><a href="{ $repo-path }/{ @path }#L{ @line-no }">{ @path }</a></p>
            <p class="signature"><a href="{ $repo-path }/{ @path }#L{ @line-no }">{ normalize-space(.) }</a></p>
        </div>
    </xsl:template>
    
    <xsl:template name="make-style" expand-text="false">
        <style xml:space="preserve">

#directory { position: fixed; top: 4em; right: 1vw; background-color: gainsboro; border: thin solid black; max-height: 80vh  }
aside#directory { padding: 1.2em; margin: 0em; overflow-y: scroll; }
#directory p { margin: 0em; margin-top: 0.3em }

main { max-width: 50em }

div.linkout { float: right; font-size: 80% }


a { text-decoration: none; color: midnightblue }
a:hover { text-decoration: underline }

div.linkout a { padding: 0.4em; font-size: 80% }
div.linkout a:hover { outline: medium dotted steelblue }

button.cp { float: right }

.elem summary { font-size: 140%; margin-bottom: 0.6em }

.elem .entry { display: grid; align-items: center; grid-template-columns: 2fr 3fr; gap: 0.4em;
  background-color: lightsteelblue; border: thin solid black; padding: 0.2em; }
.elem .filepath { text-align: right }
.entry p { margin: 0.2em; padding: 0.4em }
.entry .signature { font-family: monospace; font-size: 128%; background-color: whitesmoke }

         </style>
    </xsl:template>
</xsl:stylesheet>