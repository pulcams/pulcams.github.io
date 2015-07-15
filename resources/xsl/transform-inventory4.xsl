<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:bf="http://bibframe.org/vocab/" xmlns:cwb="http://libserv6.princeton.edu/exist/apps/catalogers-workbench" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="/">
        <root>
            <xsl:for-each select="root/rdf:RDF">
                <xsl:sequence select="rdf:RDF[last()]"/>
            </xsl:for-each>
        </root>
    </xsl:template>
</xsl:stylesheet>