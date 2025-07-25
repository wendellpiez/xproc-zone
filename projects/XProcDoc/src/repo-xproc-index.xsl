<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" expand-text="true" version="3.0"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:zone="http://wendellpiez.com/ns/xproc-zone">

    <xsl:template priority="1001" match="/*">
        <index>
            <xsl:next-match/>
        </index>
    </xsl:template>
    
    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template priority="101" match="p:* | p:inline/xsl:*">
        <entry line-no="{ @xproc._.zone._.line-no }" name="{ name(.) }" path="{ ancestor-or-self::*/@xproc._.zone._.path }">
            <xsl:apply-templates select="." mode="signature"/>
        </entry>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- not including first step (wrapper element) in signature -->
    <xsl:template match="." mode="signature" expand-text="true">
        <xsl:text>{ ancestor-or-self::*[parent::*]/name() => string-join('/') }</xsl:text>
        <xsl:apply-templates select="@*" mode="#current"/>
    </xsl:template>
    
    <xsl:template mode="signature" match="@*"/>
    
    <xsl:template mode="signature" match="@href">[@{ local-name()}]</xsl:template>
    
    <xsl:template mode="signature"
        match="@name | @pipe | @port | @as | @match | @new-name | @label">[@{ local-name()}='{ . }']</xsl:template>

</xsl:stylesheet>