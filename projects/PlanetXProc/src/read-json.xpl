<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array">
  <!-- A pipeline is defined with p:declare-step -->

  <p:output serialization="map { 'indent': true(), 'omit-xml-declaration': true() }"/>

  <!-- Reads in a JSON literal (this time) -->
  <p:input port="source">
    <p:inline content-type="application/json" expand-text="false" xml:space="preserve">{    
"title": "TEI P4: Guidelines for Electronic Text Encoding and Interchange (XML-compatible edition)",
"date": "2004",
"contributors": [
  { "role": "editor",
    "indexName": "Sperberg McQueen, C. Michael",
    "displayName": "C. M. Sperberg-McQueen" },
  { "role": "editor, XML conversion",
    "indexName": "Burnard, Lou",
    "displayName": "Lou Burnard" },
  { "role": "XML conversion",
    "indexName": "Bauman, Syd",
    "displayName": "Syd Bauman" },
  { "role": "XML conversion",
    "indexName": "DeRose, Steven J.",
    "displayName": "Steven DeRose" },
  { "role": "XML conversion",
    "indexName": "Rahtz, Sebastian",
    "displayName": "Sebastian Rahtz" } ],
"archive": "https://www.tei-c.org/Vault/P4/doc/html/"
}
    </p:inline>
</p:input>

  <p:variable name="cit" select="."/>

  <!-- Makes an XDM sequence from the array contained in the map -->
  <!-- New in XPath 3.1, the ? lookup operator returns a value from a map by its key (property name) -->
  <p:variable name="contribs" select="array:flatten($cit?contributors)"/>

  <p:identity>
    <p:with-input>
      <citation>{ head($contribs)?indexName },{ ' and'[empty($contribs[3])] } {
        $contribs[2]?displayName }{ $contribs[3]!', et al' }. "{ $cit?title }", { $cit?date }. {
        $cit?archive ! (. || '.') }</citation>
    </p:with-input>
  </p:identity>

</p:declare-step>
