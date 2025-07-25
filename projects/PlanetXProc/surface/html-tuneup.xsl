<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xpath-default-namespace="http://www.w3.org/1999/xhtml"
  version="3.0">

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:template match="head">
    <xsl:copy>
      <title>XProc from Orbit</title>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="p[matches(.,'^\?.*\?$')]" expand-text="true">
    <xsl:variable name="tag" expand-text="true">{ normalize-space(.) => replace('\?','') }</xsl:variable>
    <div class="eg_block">
      <h5 class="eg_label">Example <a class="eg_link" href="../{ $tag }">{ $tag }</a></h5>
      <pre class="transclude" id="example_{ replace($tag,'\..*$','') }">
      <xi:include parse="text" href="../{ $tag }" xmlns:xi="http://www.w3.org/2001/XInclude"/>
    </pre>
    </div>
  </xsl:template>

</xsl:stylesheet>
