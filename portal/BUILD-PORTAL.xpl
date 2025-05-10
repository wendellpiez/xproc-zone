<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    version="3.0"
    xmlns:zone="http://wendellpiez.com/xproc-zone/ns">
    
    <p:import href="portal-page.xpl"/>
    
    <!--<p:output port="result" serialization="map{ 'omit-xml-declaration': true(), 'indent': true() }"/>-->
    
    
    
    
    <p:for-each>
        <p:with-input select="/">
            <p:document href="index.xhtml" content-type="application/xml"/>
            <p:document href="xproc-pages.xhtml" content-type="application/xml"/>            
            <p:document href="style-guide.xhtml" content-type="application/xml"/>            
        </p:with-input>
        
        <p:variable name="base" select="p:document-property(.,'base-uri')"/>
        <p:variable name="sitepath" select="resolve-uri('.')"/>
        <!--$filepath is the path to the file, relative to the current directory (of this pipeline) -->
        
        <!-- For paths, the expectation is that all sources are inside the 'portal' directory -->
        <p:variable name="filepath" select="substring-after( $base, $sitepath )"/>
        <!--filedir is '.' plus the relative path to the directory of the file-->
        <p:variable name="filedir" select="'.' || (tokenize($filepath)[not(position() eq last())] ! ('/' || .))"/>
        <!-- $pagename is the base name of the file, w/o suffix 'xhtml' -->
        <p:variable name="pagename" select="tokenize( $filepath,'/' )[last()] => replace('\.[^\.]+$','')"/>
        
        <p:variable name="path-to-root" select="'.' || (tokenize($filepath,'/')[not(position() eq 1)] ! '/..' )"/>
        
        <p:variable name="target-path" select="('../pub', $filedir, ($pagename || '.html')) => string-join('/')"/>
        
        <!--<p:identity message=" Processing page '{ $pagename}' at path { $filepath }"/>
    <p:identity message="From the root, { $filepath } is in { $filedir }"/>
    <p:identity message="path-to-root: { $path-to-root }"/>
    <p:identity message="We'll write a file here: { $target-path } "/>-->
        
        <zone:portal-page path-to-root="{ $path-to-root }"/>
        <p:store href="{ $target-path }" message="Storing { $target-path }"
          serialization="map{ 'method': 'html' }"/>
        <!--<p:sink message="Sank { $target-path }"/>-->
    </p:for-each>
    
    <!--<p:file-copy href="site" target="../pub/site"
      message="Copying ./site with files ..."/>-->
    
    
</p:declare-step>