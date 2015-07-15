<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:bf="http://bibframe.org/vocab/" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:cwb="http://libserv6.princeton.edu/exist/apps/catalogers-workbench" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:m21rdf00X="http://marc21rdf.info/elements/00X/" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="no"/>
    <xsl:template match="/">
        <root>
            <xsl:for-each-group select="rdf:RDF/*" group-by="@rdf:about">
                <xsl:result-document href="data/bf/store/inventory/bf/output2015-05-18-d/{concat(generate-id(), current-grouping-key()*10)}.xml" indent="no" encoding="UTF-8" method="xml">
                    <rdf:RDF>
                        <xsl:sequence select="current-group()"/>
                    </rdf:RDF>
                </xsl:result-document>
            </xsl:for-each-group>
        </root>
    </xsl:template>
</xsl:stylesheet>