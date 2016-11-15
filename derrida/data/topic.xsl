<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE data [
    <!ENTITY bf "http://id.loc.gov/ontologies/bibframe/">
    <!ENTITY ex "http://example.org/">
    <!ENTITY mads "http://www.loc.gov/mads/rdf/v1#">
    <!ENTITY owl "http://www.w3.org/2002/07/owl#">        
    <!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
    <!ENTITY skos "http://www.w3.org/2004/02/skos/core#">
    <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
    <!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <!ENTITY dctypes "http://purl.org/dc/dcmitype/">
	<!ENTITY oa "http://www.w3.org/ns/oa#">
	<!ENTITY schema "http://schema.org/">
	<!ENTITY rdau "http://rdaregistry.info/Elements/u/">
	<!ENTITY dcterms "http://purl.org/dc/terms/">	
	<!ENTITY inst "key('resourceKey', $work, $input)[@rel eq '&bf;instanceOf']">
	<!ENTITY item1 "[@rel eq '&bf;itemOf']/..">
	<!ENTITY item2 "key('resourceKey', &inst;/../@about, $input)">
	<!ENTITY item3 "key('resourceKey', &item2;/../@about, $input)&item1;">
	<!ENTITY wt "[span[@rel eq '&bf;workTitle']][local:match-work(@about)]">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://example.org/local/" exclude-result-prefixes="xs local"
    version="3.0">

    <xsl:function name="local:parse-topic" as="item()*">
        <xsl:param name="topic" as="element()*"/>
        <xsl:param name="scheme" as="element()*"/>                                
        <xsl:variable name="componentList" as="element()*">
            <xsl:sequence select="$topic/*[@rel eq '&mads;componentList']/*"/>
        </xsl:variable>
        <xsl:variable name="first" as="element()">
            <xsl:sequence select="$componentList/*[@rel eq '&rdf;first']"/>
        </xsl:variable>
        <xsl:variable name="rest" as="element()">
            <xsl:sequence select="$componentList/*[@rel eq '&rdf;rest']"/>
        </xsl:variable>
        

        <xsl:sequence
            select="
                (
                for $t in $topic/*
                return
                    (
                    (
                    if ($t[@property eq '&mads;elementValue']) then
                        (
                        local:get-type($t/ancestor::*[3][self::span]/@typeof/data(.), $scheme/@resource),
                        local:get-val($t[@property eq '&mads;elementValue']/string(.))
                        )
                    else
                        ()
                    ), local:parse-topic($t, $scheme)
                    )
                )"/>

    </xsl:function>

    <xsl:function name="local:get-type" as="item()">
        <xsl:param name="type" as="xs:string*"/>
        <xsl:param name="scheme" as="xs:string*"/>
        <type scheme="{$scheme}">
            <xsl:sequence select="$type"/>
        </type>
    </xsl:function>

    <xsl:function name="local:get-val" as="item()">
        <xsl:param name="val" as="xs:string*"/>
        <value>
            <xsl:sequence select="$val"/>
        </value>
    </xsl:function>

    <xsl:function name="local:get-pair" as="item()">
        <xsl:param name="pairs" as="element()*"/>
        <part>
            <xsl:sequence select="$pairs"/>
        </part>
    </xsl:function>


</xsl:stylesheet>
