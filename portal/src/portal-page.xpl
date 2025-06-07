<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:zone="http://wendellpiez.com/xproc-zone/ns"
    type="zone:portal-page" name="portal-page">

    <p:option name="path-to-root" select="'.'"/>
    
    <p:input port="source">
        <p:document href="../index.xhtml" content-type="application/xml"/>
    </p:input>
    
    <p:output port="result" serialization="map{ 'indent': true() }"/>
    
    <!-- |  :  ||  :  |  :  ||  :  |  :  ||  :  |  :  ||  :  |  :  ||  :  |  :  ||  :  |  :  ||  :  |  :  ||  :  |  :  ||  :  | -->
    <p:variable name="pagename" select="tokenize( base-uri(/*),'/' )[last()] => replace('\.[^\.]+$','')"/>
    
    <p:insert position="after" match="html/head/title">
        <p:with-input port="insertion" expand-text="true">
            <script type="text/javascript" src="{ $path-to-root }/site/zone-themeTime.js"/>
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
            <link rel="stylesheet"            href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&amp;family=Noto+Serif:ital,wght@0,100..900;1,100..900&amp;display=swap" />
            <link rel="icon" type="image/svg+xml" href="{ $path-to-root }/site/zed.svg"/>
        </p:with-input>
    </p:insert>
    
    <p:insert position="last-child" match="html/body">
        <p:with-input port="insertion">
            <hr class="hr"/>
            <footer class="in-a-row">
                <!-- Add your name here! -->
                <div><b><a href="{ $path-to-root}">XProc Zone</a></b> was designed and built by Wendell&#xA0;Piez, 2025</div>
                <div>
                    <a href="https://github.com/wendellpiez/xproc-zone">Clone the Zone</a>
                </div>
            </footer>
        </p:with-input>
    </p:insert>
    
    <p:insert position="first-child" match="html/body">
        <p:with-input port="insertion">
            <div id="bannerbar">
                <div id="sitenav">
                    <a href="https://github.com/wendellpiez/xproc-zone">XProc Zone Codebase</a>
                </div>
                <div id="themepick">
                    <!-- Using the interface defined in zone-themeTime.js -->
                    <p class="dawn set" ><a href="?by=dawn" >dawn</a></p>
                    <p class="day set"  ><a href="?by=day"  >day</a></p>
                    <p class="dusk set" ><a href="?by=dusk" >dusk</a></p>
                    <p class="night set"><a href="?by=night">night</a></p>
                    <p class="set"      ><a href="?by=now"  >now</a></p>
                    <p class="set none" ><a href="?by=none" >none</a></p>
                </div>
            </div>
        </p:with-input>
    </p:insert>
    
    <p:insert position="first-child" match="html/body/main">
        <p:with-input port="insertion">
            <p:document href="../site/zed.svg" />
        </p:with-input>
    </p:insert>
    
    
    <p:if test="not( $pagename='index' and $path-to-root='.' )">
        <p:insert position="after" match="html/body/div/div[@id='sitenav']/a[1]">
            <p:with-input port="insertion">
                <p:inline> | <a href="{ $path-to-root }/index.html">Home</a></p:inline>
            </p:with-input>
        </p:insert>
    </p:if>
    
    <p:add-attribute match="html/body" attribute-name="id" attribute-value="page"/>
    
    <p:add-attribute match="html/body" attribute-name="onload" attribute-value="setTheme()"/>

    <!-- Marking internal links to be targeted in href rewrites cf rewriteInternalLinks() in zone-themeTime.js -->
    <p:add-attribute match="a[not(@class='clean')][not(matches(@href,'^https?:'))]"  attribute-name="class" attribute-value="internal"/>
    
    <!-- But not on theme picker anchors - so we remove @class -->
    <p:delete match="div[@id='themepick']//a/@class"/>
    
    <!-- Now we rewrite links to point to .html for the plain deployment -->
    <p:label-elements match="a[@class='internal']" attribute="href" label="replace(@href,'xhtml$','html')"/>
    
    <p:delete match="/processing-instruction()"/>
    
    <p:string-replace match="text()[normalize-space()]" replace="replace(string(.),'\s+',' ')"/>
    
    <p:namespace-delete prefixes="c zone"/>
    
</p:declare-step>