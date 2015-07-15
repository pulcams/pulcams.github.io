<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:bf="http://bibframe.org/vocab/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:cwb="http://libserv6.princeton.edu/exist/apps/catalogers-workbench" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:relators="http://id.loc.gov/vocabulary/relators/" xmlns:marcxml="http://www.loc.gov/MARC21/slim" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:madsrdf="http://www.loc.gov/mads/rdf/v1#" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cwb-search="http://libserv6.princeton.edu/exist/apps/catalogers-workbench/search" exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    <xsl:param name="local-uri" as="xs:string">http://libserv6.princeton.edu/exist/apps/catalogers-workbench/</xsl:param>
    <xsl:template match="cwb:results">
        <rdf:RDF>
            <xsl:apply-templates/>
        </rdf:RDF>
    </xsl:template>
    <xsl:template match="*[@cwb-search:selected = 'true']">
        <xsl:apply-templates>
            <xsl:with-param name="record-pos" as="xs:integer" select="position()" tunnel="yes"/>
            <xsl:with-param name="bibID" select="marcxml:record/marcxml:controlfield[@tag = '001']" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="marcxml:record[../@cwb-search:selected = 'true']">
        <xsl:param name="record-pos" as="xs:integer" tunnel="yes"/>
        <xsl:param name="bibID" as="xs:integer" tunnel="yes"/>
        <xsl:sequence select="cwb:bfWork(., $bibID, $record-pos)"/>
        <xsl:sequence select="cwb:bfInstance(., $bibID, $record-pos)"/>
    </xsl:template>
    <xsl:function name="cwb:bfWork" as="element()">
        <xsl:param name="record" as="element()"/>
        <xsl:param name="bibID" as="xs:integer"/>
        <xsl:param name="pos" as="xs:integer"/>
        <bf:Work rdf:about="{concat($local-uri, $bibID, '-', $pos)}">
            <bf:workTitle rdf:resource="{concat($local-uri, $bibID, '-', $pos, '-', 'workTitle')}"/>
        </bf:Work>
    </xsl:function>
    <xsl:function name="cwb:bfInstance" as="element()">
        <xsl:param name="record" as="element()"/>
        <xsl:param name="bibID" as="xs:integer"/>
        <xsl:param name="pos" as="xs:integer"/>
        <xsl:variable name="uri-val" select="$local-uri, $pos"/>
        <bf:Instance rdf:about="{concat($local-uri, $bibID, '-', $pos)}">
            <bf:instanceTitle rdf:resource="{concat($local-uri, $bibID, '-', $pos, '-', 'instanceTitle')}"/>
        </bf:Instance>
    </xsl:function>
    <xsl:template match="text()"/>
</xsl:stylesheet>