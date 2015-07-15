<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:bf="http://bibframe.org/vocab/" xmlns:cwb="http://libserv6.princeton.edu/exist/apps/catalogers-workbench" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="/">
        <root>
            <xsl:for-each-group select="root/rdf:RDF" group-by="normalize-space(bf:Title/bf:titleValue)">
                <!--<xsl:result-document href="data/bf/store/inventory/bf/output/{current-grouping-key()}.xml" encoding="UTF-8" method="xml">-->
                <rdf:RDF>
                    <xsl:sequence select="current-group()"/>
                </rdf:RDF>
                <!--</xsl:result-document>-->
            </xsl:for-each-group>
        </root>
    </xsl:template>
</xsl:stylesheet>