<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:bf="http://bibframe.org/vocab/" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:cwb="http://libserv6.princeton.edu/exist/apps/catalogers-workbench" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:m21rdf00X="http://marc21rdf.info/elements/00X/" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="no"/>
    <xsl:template match="/">
        <rdf:RDF>
            <xsl:apply-templates mode="title"/>
            <xsl:apply-templates mode="holdings"/>
            <xsl:apply-templates mode="item"/>
        </rdf:RDF>
    </xsl:template>
    <xsl:template match="cwb:table" mode="title">
        <bf:Instance rdf:about="{position()}">
            <m21rdf00X:M00806>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="generate-id(.)"/>
                    <xsl:number/>
                    <xsl:text>M00806</xsl:text>
                </xsl:attribute>
            </m21rdf00X:M00806>
            <rdf:type rdf:resource="http://bibframe.org/vocab/Serial"/>
            <owl:sameAs>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="generate-id(.)"/>
                    <xsl:number/>
                    <xsl:text>sameAs</xsl:text>
                </xsl:attribute>
            </owl:sameAs>
            <bf:instanceOf>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="generate-id(.)"/>
                    <xsl:number/>
                    <xsl:text>instanceOf</xsl:text>
                </xsl:attribute>
            </bf:instanceOf>
            <bf:instanceTitle>
                <bf:Title>
                    <xsl:attribute name="rdf:about">
                        <xsl:value-of select="generate-id(.)"/>
                        <xsl:number/>
                    </xsl:attribute>
                    <bf:titleType/>
                    <bf:titleValue>
                        <xsl:value-of select="cwb:title"/>
                    </bf:titleValue>
                    <bf:subtitle>
                        <xsl:value-of select="cwb:subTitle"/>
                    </bf:subtitle>
                    <bf:partTitle/>
                    <bf:partNumber/>
                    <bf:formDesignation/>
                    <bf:titleVariationDate/>
                </bf:Title>
            </bf:instanceTitle>
            <bf:edition/>
            <bf:publication>
                <bf:Provider>
                    <xsl:attribute name="rdf:about">
                        <xsl:value-of select="generate-id(.)"/>
                        <xsl:number/>
                        <xsl:text>Provider</xsl:text>
                    </xsl:attribute>
                    <bf:providerName>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="generate-id(.)"/>
                            <xsl:number/>
                            <xsl:text>providerName</xsl:text>
                        </xsl:attribute>
                    </bf:providerName>
                    <bf:providerPlace>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="generate-id(.)"/>
                            <xsl:number/>
                            <xsl:text>providerPlace</xsl:text>
                        </xsl:attribute>
                    </bf:providerPlace>
                    <bf:providerRole>publisher</bf:providerRole>
                    <m21rdf00X:M00807-10/>
                    <m21rdf00X:M00811-14/>
                    <bf:copyrightDate/>
                </bf:Provider>
            </bf:publication>
            <bf:mediaCategory rdf:resource="http://id.loc.gov/vocabulary/mediaTypes/n"/>
            <bf:carrierCategory rdf:resource="http://id.loc.gov/vocabulary/carriers/nc"/>
            <bf:extent>volumes</bf:extent>
            <bf:illustrationNote/>
            <bf:dimensions/>
            <bf:modeOfIssuance>serial</bf:modeOfIssuance>
            <m21rdf00X:M008CR18>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="generate-id(.)"/>
                    <xsl:number/>
                    <xsl:text>M008CR18</xsl:text>
                </xsl:attribute>
            </m21rdf00X:M008CR18>
            <m21rdf00X:M008CR19>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="generate-id(.)"/>
                    <xsl:number/>
                    <xsl:text>M008CR19</xsl:text>
                </xsl:attribute>
            </m21rdf00X:M008CR19>
            <bf:note/>
            <bf:note>Numbering peculiarities:</bf:note>
            <bf:note>Description based on: ; title from </bf:note>
            <bf:note>Latest issue consulted:</bf:note>
            <bf:serialFirstIssue>Began with:</bf:serialFirstIssue>
            <bf:otherPhysicalFormat>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="generate-id(.)"/>
                    <xsl:number/>
                    <xsl:text>otherPhysicalFormat</xsl:text>
                </xsl:attribute>
            </bf:otherPhysicalFormat>
            <bf:issn>
                <bf:Identifier>
                    <xsl:attribute name="rdf:about">
                        <xsl:value-of select="generate-id(.)"/>
                        <xsl:number/>
                        <xsl:text>Indentifier</xsl:text>
                    </xsl:attribute>
                    <bf:identifierValue/>
                </bf:Identifier>
            </bf:issn>
        </bf:Instance>
    </xsl:template>
    <xsl:template match="cwb:table" mode="holdings">
        <bf:HeldMaterial rdf:about="{position()}">
            <bf:holdingFor>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="generate-id(.)"/>
                    <xsl:number/>
                    <xsl:text>holdingFor</xsl:text>
                </xsl:attribute>
            </bf:holdingFor>
            <bf:heldBy rdf:resource="http://id.loc.gov/vocabulary/organizations/njp"/>
            <bf:shelfMarkLcc/>
            <bf:subLocation>rcppa</bf:subLocation>
            <bf:enumerationAndChronology>
                <xsl:for-each select="cwb:firstIssue">
                    <xsl:if test="cwb:desig1/cwb:textPart != ''">
                        <xsl:value-of select="cwb:desig1/cwb:textPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig1/cwb:numPart != ''">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="cwb:desig1/cwb:numPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig2/cwb:textPart != ''">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="cwb:desig2/cwb:textPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig2/cwb:numPart != ''">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="cwb:desig2/cwb:numPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig3/cwb:textPart != ''">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="cwb:desig3/cwb:textPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig3/cwb:numPart != ''">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="cwb:desig3/cwb:numPart"/>
                    </xsl:if>
                    <xsl:for-each select="cwb:date[.//text()]">
                        <xsl:text> (</xsl:text>
                        <xsl:if test="cwb:day != ''">
                            <xsl:value-of select="cwb:day"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:if test="cwb:month != ''">
                            <xsl:value-of select="cwb:month"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:if test="cwb:year != ''">
                            <xsl:value-of select="cwb:year"/>
                        </xsl:if>
                        <xsl:text>)</xsl:text>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each select="cwb:lastIssue">
                    <xsl:if test="cwb:desig1/cwb:textPart != ''">
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="cwb:desig1/cwb:textPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig1/cwb:numPart != ''">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="cwb:desig1/cwb:numPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig2/cwb:textPart != ''">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="cwb:desig2/cwb:textPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig2/cwb:numPart != ''">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="cwb:desig2/cwb:numPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig3/cwb:textPart != ''">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="cwb:desig3/cwb:textPart"/>
                    </xsl:if>
                    <xsl:if test="cwb:desig3/cwb:numPart != ''">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="cwb:desig3/cwb:numPart"/>
                    </xsl:if>
                    <xsl:for-each select="cwb:date[.//text()]">
                        <xsl:text> (</xsl:text>
                        <xsl:if test="cwb:day != ''">
                            <xsl:value-of select="cwb:day"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:if test="cwb:month != ''">
                            <xsl:value-of select="cwb:month"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:if test="cwb:year != ''">
                            <xsl:value-of select="cwb:year"/>
                        </xsl:if>
                        <xsl:text>)</xsl:text>
                    </xsl:for-each>
                </xsl:for-each>
            </bf:enumerationAndChronology>
            <xsl:if test="cwb:lacks != ''">
                <bf:enumerationAndChronology>
                    <xsl:text>LACKS: </xsl:text>
                    <xsl:value-of select="cwb:lacks"/>
                </bf:enumerationAndChronology>
            </xsl:if>
        </bf:HeldMaterial>
    </xsl:template>
    <xsl:template match="cwb:table" mode="item">
        <bf:HeldItem rdf:about="{position()}">
            <bf:barcode/>
            <bf:componentOf>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="generate-id(.)"/>
                    <xsl:number/>
                    <xsl:text>componentOf</xsl:text>
                </xsl:attribute>
            </bf:componentOf>
            <bf:note>
                <xsl:value-of select="cwb:numItems"/>
                <xsl:text> items</xsl:text>
            </bf:note>
        </bf:HeldItem>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>