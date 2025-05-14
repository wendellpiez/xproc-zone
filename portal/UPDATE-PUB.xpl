<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    version="3.0"
    xmlns:zone="http://wendellpiez.com/xproc-zone/ns" type="zone:UPDATE-PUB">
    
    
    <p:import href="BUILD-PORTAL.xpl"/>
    
    
    <p:variable name="pubdir" select="'../pub'"/>
    
    <zone:BUILD-PORTAL name="populate-pub" pubdir="{ $pubdir }"/>
    
    <!-- Any other pipelines that build into pub should go here ... -->
    
    <p:file-copy href="site" target="{ $pubdir }"
        message="Copying ./site with files to { $pubdir } ..."/>
    
    <p:file-copy href="start-web-server.ps1" target="{ $pubdir }"
        message="Copying start-web-server.ps1 (for convenience)"/>
    
   <!-- potential TODO:
       whitespace normalizer
       copy images
       link checking
       git cleanup of $pubdir? -->
    
    
</p:declare-step>