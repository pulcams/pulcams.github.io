<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
    <!ENTITY bf "http://id.loc.gov/ontologies/bibframe/">
    <!ENTITY ex "http://example.org/">
    <!ENTITY mads "http://www.loc.gov/mads/rdf/v1#">
    <!ENTITY owl "http://www.w3.org/2002/07/owl#">        
    <!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
    <!ENTITY skos "http://www.w3.org/2004/02/skos/core#">
    <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
    <!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
    <!ENTITY dctypes "http://purl.org/dc/dcmitype/">
    <!ENTITY oa "http://www.w3.org/ns/oa#">
    <!ENTITY schema "http://schema.org/">
    <!ENTITY rdau "http://rdaregistry.info/Elements/u/">
    <!ENTITY dcterms "http://purl.org/dc/terms/">	
    <!ENTITY dc "http://purl.org/dc/elements/1.1/">
    <!ENTITY inst "key('resourceKey', $work, $input)[@rel eq '&bf;instanceOf']">
    <!ENTITY item1 "[@rel eq '&bf;itemOf']/..">
    <!ENTITY item2 "key('resourceKey', &inst;/../@about, $input)">
    <!ENTITY item3 "key('resourceKey', &item2;/../@about, $input)&item1;">
    <!ENTITY wt "[span[@rel eq '&bf;workTitle']][local:match-work(@about)]">

]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://example.org/local/"
    xmlns:ev="http://www.w3.org/2001/xml-events"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:sr="http://www.w3.org/2005/sparql-results#"
    xmlns:xf="http://www.w3.org/2002/xforms" exclude-result-prefixes="xs local"
    version="3.0">

    <xsl:strip-space elements="*"/>

    <xsl:output indent="yes" method="xhtml" omit-xml-declaration="no"/>


    <xsl:key name="aboutKey" match="span" use="@about"/>
    <xsl:key name="relKey" match="span" use="@rel"/>
    <xsl:key name="propertyKey" match="span" use="@property"/>
    <xsl:key name="typeofKey" match="span" use="@typeof"/>
    <xsl:key name="resourceKey" match="span" use="@resource"/>
    <xsl:key name="oKey" match="sr:binding[@name eq 'oLabel']/sr:literal"
        use="../../sr:binding[@name eq 'viaf']/sr:literal"/>

    <xsl:variable name="input" select="."/>
    <xsl:variable name="o" select="doc('occupation.xml')"/>

    <xsl:include href="topic.xsl"/>
    <xsl:include href="functx-1.0-doc-2007-01.xsl"/>

    <xsl:function name="local:get-title" as="item()*">
        <xsl:param name="predicate" as="element()*"/>
        <title>
            <xsl:value-of
                select="
                    key('aboutKey', $predicate/@resource, $input)/
                    (if (not(span[@property eq '&bf;label'])) then
                        span[@property eq '&bf;titleValue']
                    else
                        span[@property eq '&bf;label'])"
            />
        </title>
    </xsl:function>

    <xsl:template match="/span[@data-graph]">
        <xsl:processing-instruction name="xml-stylesheet">
            <xsl:text>type="text/xsl" href="../static/xsltforms/build/xsltforms.xsl"</xsl:text>           
        </xsl:processing-instruction>        
        <xsl:processing-instruction name="xsltforms-options">
            <xsl:text>debug="no"</xsl:text>           
        </xsl:processing-instruction>
        <xsl:processing-instruction name="css-conversion">
            <xsl:text>no</xsl:text>            
        </xsl:processing-instruction>
        <html xmlns:ev="http://www.w3.org/2001/xml-events"
            xmlns:foaf="http://xmlns.com/foaf/0.1/"
            xmlns:marc="http://www.loc.gov/MARC21/slim"
            xmlns:oa="http://www.w3.org/ns/oa#"
            xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
            xmlns:sr="http://www.w3.org/2005/sparql-results#"
            xmlns:xf="http://www.w3.org/2002/xforms" rdf:firefox="true"
            sr:firefox="true">
            <head>
                <title>Wow</title>
                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
                <!-- Optional theme -->
                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css"/>
                <style type="text/css">
                    <![CDATA[
                    .selected-ph{
                        background-color: yellow;
                        
                    }
                    .selected-pr{
                        background-color: blue;
                        color:white !important;
                    }
                    .selected-l{
                        background-color: green;
                        color:white !important;
                    }
                    .selected-l.selected-ph.selected-pr{
                        background-color: rgb(126, 132, 140) !important;
                        color:white;
                    }
                    .selected-l.selected-ph{
                        background-color: rgb(132, 132, 0) !important;
                        color:white;
                    }
                    .selected-l.selected-pr{
                        background-color: rgb(0, 132, 140) !important;
                        color:white;
                    }
                    .selected-ph.selected-pr{
                        background-color: rgb(132, 0, 139) !important;
                        color:white;
                    }
                    .swatch-label{
                        margin-left: 5px;
                        margin-right: 5px;
                    }
                    .filter-label{
                        margin-right: 10px;
                        font-weight: 800;
                    
                    }
                    .thumbnail{
                    
                        color: black;
                    }
                    .thumbnail p{
                    
                    }
                    .img-thumbnail{
                    
                    
                    }
                    .anno {
                        min-height:80px;
                        
                    }
                    #legend{
                    
                        margin-bottom: 20px;
                    }
                    #filter{
                    
                        margin-bottom: 20px;
                    }
                    #ph-swatch{
                        height: 20px;
                        width: 20px;
                        background-color: yellow;
                        display: inline-block;
                        border: solid black 1px;
                    }
                    #pr-swatch{
                        height: 20px;
                        width: 20px;
                        background-color: blue;
                        display: inline-block;
                        border: solid black 1px;
                    }
                    #l-swatch{
                        height: 20px;
                        width: 20px;
                        background-color: green;
                        display: inline-block;
                        border: solid black 1px;
                    }
                    #ph-pr-swatch{
                        height: 20px;
                        width: 20px;
                        background-color: rgb(132, 0, 139);
                        display: inline-block;
                        border: solid black 1px;
                    }
                    #ph-l-swatch{
                        height: 20px;
                        width: 20px;
                        background-color: rgb(132, 132, 0);
                        display: inline-block;
                        border: solid black 1px;
                    }
                    #pr-l-swatch{
                        height: 20px;
                        width: 20px;
                        background-color: rgb(0, 132, 140);
                        display: inline-block;
                        border: solid black 1px;
                    }
                    #ph-pr-l-swatch{
                        height: 20px;
                        width: 20px;
                        background-color: rgb(126, 132, 140);
                        display: inline-block;
                        border: solid black 1px;
                    }]]>
                </style>
                <xf:model id="default-model">
                    <xf:instance id="sparql-1">
                        <data xmlns="">
                            <query>
                                <![CDATA[
PREFIX bf: <http://loc.gov/bibframe/vocab#>
PREFIX dcterms: <http://purl.org/dc/terms/>                        
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>                      
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX dbo: <http://dbpedia.org/ontology/>

construct {<http://dbpedia.org/resource/Jacques_Derrida> dbo:abstract ?o} 
where {
    <http://dbpedia.org/resource/Jacques_Derrida> dbo:abstract ?o .
    filter(lang(?o) = "en")
}
limit 100                      
]]>
                            </query>
                        </data>
                    </xf:instance>
                    <xf:instance id="sparql-2">
                        <data xmlns="">
                            <query>
                                <![CDATA[
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX dbp: <http://dbpedia.org/property/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wikibase: <http://wikiba.se/ontology#>
PREFIX bf: <http://bibframe.org/vocab/>
PREFIX bd: <http://www.bigdata.com/rdf#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?creator2 ?viaf ?cLabel ?oLabel 
WHERE 
{
  {
    ?anno dcterms:creator ?creator .
    #?creator skos:prefLabel ?label .
    FILTER(?creator != <http://library.princeton.edu>)
    BIND(substr(str(?creator), 22) AS ?viaf)
  }  
  {
    SERVICE <https://query.wikidata.org/sparql>
    {
      ?creator2 wdt:P214 ?viaf .
      ?creator2 rdfs:label ?cLabel .
      #?creator2 a <http://dbpedia.org/class/yago/LiteraryCritic110266016> . # <http://dbpedia.org/ontology/Philosopher>       
      ?creator2 wdt:P106 ?o .   
      ?o rdfs:label ?oLabel .
      FILTER(lang(?cLabel) = "en")
      FILTER(lang(?oLabel) = "en")
      
    }    
  }
} 
GROUP BY ?creator2 ?viaf ?cLabel ?oLabel
#ORDER BY DESC(?oCount) ?oLabel ?cLabel
]]>
                            </query>
                        </data>
                    </xf:instance>

                    <xf:instance id="sparql-3">
                        <data xmlns="">
                            <query>
                                <![CDATA[
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX dbp: <http://dbpedia.org/property/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wikibase: <http://wikiba.se/ontology#>
PREFIX bf: <http://bibframe.org/vocab/>
PREFIX bd: <http://www.bigdata.com/rdf#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oa: <http://www.w3.org/ns/oa#>

SELECT ?anno ?creator2 ?cLabel ?text ?prefix ?suffix ?exact ?source
WHERE 
{
  {
    ?anno dcterms:creator ?creator .
    #?creator skos:prefLabel ?label 
    ?anno oa:hasBody ?body .
    ?body oa:text ?text .
    ?meta oa:hasTarget ?target .
    ?meta oa:hasBody ?metaBody .
    ?metaBody oa:hasSource ?source .
    ?target oa:hasSource ?anno .
    ?target oa:hasSelector ?select .
    ?select oa:prefix ?prefix .
    ?select oa:suffix ?suffix .
    ?select oa:exact ?exact .
    FILTER(?creator != <http://library.princeton.edu>)
    BIND(substr(str(?creator), 22) AS ?viaf)
  }  
  {
    SERVICE <https://query.wikidata.org/sparql>
    {
      ?creator2 wdt:P214 ?viaf .
      ?creator2 rdfs:label ?cLabel .
      #?creator2 a <http://dbpedia.org/class/yago/LiteraryCritic110266016> . # <http://dbpedia.org/ontology/Philosopher>       
      #?creator2 wdt:P106 ?o .   
      #?o rdfs:label ?oLabel .
      FILTER(lang(?cLabel) = "en")
      #FILTER(lang(?oLabel) = "en")
    }    
  }
} 
#GROUP BY ?oCount ?creator2 ?cLabel ?oLabel
#ORDER BY DESC(?oCount) ?oLabel ?cLabel
]]>
                            </query>
                        </data>
                    </xf:instance>

                    <xf:instance id="graph">
                        <data xmlns="">
                            <results/>
                        </data>
                    </xf:instance>

                    <xf:instance id="o" src="occupation.xml"/>

                    <xf:instance id="agent">
                        <data xmlns="">
                            <xsl:for-each
                                select="$o//sr:binding[@name eq 'viaf']/sr:literal">
                                <agent
                                    o="{
                                    for $x in key('oKey', ., $o)[true()]
                                    return                    
                                    if (contains($x, ' ')) then replace($x, '\s', '-') else $x
                                    }"
                                    check="false">
                                    <xsl:value-of select="."/>
                                </agent>
                            </xsl:for-each>
                        </data>
                    </xf:instance>

                    <xf:instance id="bool">
                        <data xmlns="">
                            <ph>false</ph>
                            <pr>false</pr>
                            <l>false</l>
                        </data>
                    </xf:instance>

                    <xf:instance id="tags">
                        <data xmlns="">
                            <tags/>
                        </data>
                    </xf:instance>

                    <xf:instance id="tag-template">
                        <data xmlns="">
                            <tag index="">
                                <name/>
                                <prefix/>
                                <suffix/>
                            </tag>
                        </data>
                    </xf:instance>

                    <xf:submission encoding="UTF-8" id="sparql-query-2"
                        method="get" ref="instance('sparql-2')/*"
                        replace="instance"
                        resource="http://localhost:3030/derrida/query"
                        serialization="application/x-www-form-urlencoded"
                        instance="graph" targetref="results">
                        <xf:header>
                            <xf:name>Accept</xf:name>
                            <xf:value>application/rdf+xml</xf:value>
                        </xf:header>
                        <xf:action ev:event="xforms-submit-error">
                            <xf:message ev:event="xforms-submit-error"
                                level="modal"> Submission failed (<xf:output
                                    value="event('response-status-code')"
                                />)</xf:message>
                        </xf:action>
                        <xf:action ev:event="xforms-submit-done"
                            iterate="instance('graph')/*/*/*">
                            <!--<xf:message ev:event="modal"> Success (<xf:output value="event('response-status-code')"/>) </xf:message>-->

                            <xf:insert context="instance('tags')/tags"
                                origin="instance('tag-template')/tag"/>

                            <xf:action iterate="context()">
                                <xf:setvalue
                                    ref="instance('tags')/tags/tag/name"
                                    value="context()/sr:binding[@name = 'exact']/sr:literal"
                                />
                            </xf:action>



                        </xf:action>

                    </xf:submission>
                    <!--<xf:action ev:event="xforms-model-construct-done">
                        <xf:send submission="sparql-query-2"/>
                    </xf:action>-->

                    <xf:bind id="philos" ref="instance('bool')/ph"
                        type="xs:boolean"/>
                    <xf:bind id="prof" ref="instance('bool')/pr"
                        type="xs:boolean"/>
                    <xf:bind id="lib" ref="instance('bool')/l" type="xs:boolean"/>
                    <!--<xf:bind id="t" ref="instance('bool')/t" type="xs:boolean"/>-->

                </xf:model>
            </head>
            <body>
                <div class="container">
                    <h1>Dedications in the Derrida Library</h1>
                    <br/>
                    <xf:group id="content">
                        <span property="foaf:primaryTopic"
                            resource="http://viaf.org/viaf/88958529"/>
                        <!--<p style="font-style: italic;">This webpage demonstrates
                            some basic features of Linked Open Data. It uses
                            SPARQL to retrieve a brief biography from DBpedia,
                            and it contains embedded RDFa markup as well as a
                            link to an RDF/XML representation of the data.
                                <code>owl:sameAs</code> has been used to create
                            additional linkages.</p>-->
                        <div class="row" style="margin-bottom: 20px;"
                            about="http://viaf.org/viaf/88958529">
                            <!--<h2 property="foaf:name">Jacques Derrida</h2>-->
                            <div class="col-md-4">

                                <div style="width: 250px; height: 289px;"
                                    property="foaf:depiction"
                                    resource="https://upload.wikimedia.org/wikipedia/commons/9/99/Derrida-by-Pablo-Secca.jpg"
                                    typeof="foaf:Image">
                                    <a
                                        title="By Pablosecca (Own work) [CC BY 3.0 (http://creativecommons.org/licenses/by/3.0)], via Wikimedia Commons"
                                        href="https://commons.wikimedia.org/wiki/File%3ADerrida-by-Pablo-Secca.jpg">
                                        <img alt="Derrida-by-Pablo-Secca"
                                        src="https://upload.wikimedia.org/wikipedia/commons/9/99/Derrida-by-Pablo-Secca.jpg"
                                        rev="rdfs:seeAlso"/>
                                    </a>
                                </div>
                                <div style="margin-bottom: 1%;" rel="owl:sameAs">
                                    <span style="text-align:center;"
                                        resource="http://dbpedia.org/resource/Jacques_Derrida">
                                        <a
                                        href="http://dbpedia.org/resource/Jacques_Derrida"
                                        >Derrida in DBPedia</a>
                                    </span>
                                    <span style="text-align:center;"> | </span>
                                    <span style="text-align:center;"
                                        resource="https://www.wikidata.org/wiki/Q130631">
                                        <a
                                        href="https://www.wikidata.org/wiki/Q130631"
                                        >Derrida in Wikidata</a>
                                    </span>
                                </div>
                            </div>
                            <!--<p style="font-style: italic;" class="col-md-8">This
                                webpage demonstrates a basic features of Linked
                                Open Data. It uses VIAF IDs and SPARQL to
                                retrieve information from Wikidata about the
                                occupations of the people who sent inscribed
                                books to Derrida. </p>-->
                            <div class="col-md-8"
                                style="border: solid black 1px;">
                                <h3>Who were the librarians who gave books to
                                    Derrida?</h3>
                                <p style="font-style: italic;"> Check a box to
                                    highlight the items with dedications from
                                    authors who were active in one or more of
                                    these occupations.</p>
                                <xf:group id="filter">
                                    <xf:input bind="philos" incremental="true">
                                        <xf:label/>
                                    </xf:input>
                                    <span class="filter-label">Philosopher </span>
                                    <xf:input bind="prof" incremental="true">
                                        <xf:label/>
                                    </xf:input>
                                    <span class="filter-label">Professor </span>
                                    <xf:input bind="lib" incremental="true">
                                        <xf:label/>
                                    </xf:input>
                                    <span class="filter-label">Librarian </span>
                                </xf:group>
                                <div id="legend">

                                    <span id="ph-swatch"/>
                                    <span class="swatch-label"
                                        >Philosopher</span>

                                    <span id="pr-swatch"/>
                                    <span class="swatch-label">Professor</span>

                                    <span id="l-swatch"/>
                                    <span class="swatch-label">Librarian</span>

                                    <span id="ph-pr-swatch"/>
                                    <span class="swatch-label">Philosopher &amp;
                                        professor</span>

                                    <span id="pr-l-swatch"/>
                                    <span class="swatch-label">Professor &amp;
                                        librarian</span>

                                    <span id="ph-pr-l-swatch"/>
                                    <span class="swatch-label">Philosopher,
                                        professor, &amp; librarian</span>
                                </div>
                            </div>
                            <xf:var name="results"
                                value="instance('graph')/sr:sparql/sr:results"/>
                            <xf:var name="o"
                                value="distinct-values($results/sr:result/sr:binding[@name = 'oLabel']/sr:literal)"/>


                            <!--<div id="facets">
                        <div id="philosophers">
                            <h3>Occupations</h3>
                            <!-\-<xf:repeat ref="$o">
                                <p>
                                    <xf:output value="."/>
                                </p>
                            </xf:repeat>  -\->
                        </div>
                    </div>

                    <xf:repeat ref="$o">
                        <p>
                            <xf:output value="."/>                            
                            <xf:output
                                value="concat(' (', count(distinct-values(../../../sr:result[sr:binding[@name = 'oLabel']/sr:literal = context()])), ')')"/>
                            <xf:repeat
                                ref="distinct-values(../../../sr:result[sr:binding[@name = 'oLabel']/sr:literal = context()]/sr:binding[@name = 'cLabel']/sr:literal)">
                                <xf:output value="."/>
                            </xf:repeat>
                        </p>
                    </xf:repeat>-->

                            <!--<xf:var name="anno" value="distinct-values($results/sr:result/sr:binding[@name = 'anno']/sr:uri)"/>
                            
                            
                            <xf:repeat ref="$anno" id="r-anno">
                                <xf:var name="context" value="context()"/>-->
                            <!--<xf:var name="text" value="sr:binding[@name = 'text']/sr:literal"/>
                        <xf:var name="exact" value="sr:binding[@name = 'exact']/sr:literal"/>                        
                        <xf:var name="source" value="sr:binding[@name = 'source']/sr:uri"/>
                        <p>
                            <xf:output value="substring-before($text, $exact)"/>
                            <a href="{$source}">
                                <xf:output value="sr:binding[@name = 'exact']/sr:literal"/>    
                            </a>
                            <xf:output value="substring-after($text, $exact)"/>
                        </p>-->

                            <!--<xf:repeat ref="distinct-values(../../../sr:result[sr:binding[@name = 'anno']/sr:uri = context()]/sr:binding[@name = 'text']/sr:literal)">
                            <xf:var name="text" value="sr:binding[@name = 'text']/sr:literal"/>
                            <xf:var name="exact" value="sr:binding[@name = 'exact']/sr:literal"/>
                            <xf:var name="source" value="../../../sr:result[sr:binding[@name = 'anno']/sr:uri = $context]/sr:binding[@name = 'source']/sr:uri"/>
                            
                                <xf:output value="$source"/>
                            
                            <p>
                                    
                            </p>
                            
                            
                        </xf:repeat>-->
                            <!-- <xf:var name="text" value="distinct-values(../../../sr:result[sr:binding[@name = 'anno']/sr:uri = context()]/sr:binding[@name = 'text']/sr:literal)"/>
                                <xf:var name="source" value="distinct-values(../../../sr:result[sr:binding[@name = 'anno']/sr:uri = context()]/sr:binding[@name = 'source']/sr:uri)"/>
                                <xf:var name="exact" value="distinct-values(../../../sr:result[sr:binding[@name = 'anno']/sr:uri = context()]/sr:binding[@name = 'exact']/sr:literal)"/>
                                -->



                            <hr/>
                            <!--</xf:repeat>-->












                        </div>
                    </xf:group>
                    <xf:group id="notice"> </xf:group>


                    <div class="row clearfix">
                        <xsl:apply-templates mode="gallery"/>
                    </div>
                    <xsl:apply-templates/>
                    <xsl:result-document href="instance-titles/index.html">
                        <html>
                            <head>
                                <title>Instance titles</title>
                            </head>
                            <body>
                                <h1>Instance titles</h1>
                                <xsl:apply-templates mode="list-instance-titles">
                                    <xsl:sort
                                        select="*[@property eq '&bf;titleValue']"
                                    />
                                </xsl:apply-templates>

                            </body>
                        </html>
                    </xsl:result-document>
                    <xsl:result-document href="work-titles/index.html">
                        <html>
                            <head>
                                <title>Work titles</title>
                            </head>
                            <body>
                                <h1>Work titles</h1>
                                <xsl:apply-templates mode="list-work-titles">
                                    <xsl:sort
                                        select="*[@property eq '&bf;titleValue']"
                                    />
                                </xsl:apply-templates>
                            </body>
                        </html>
                    </xsl:result-document>
                </div>
                <!-- Latest compiled and minified JavaScript -->
                <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"/>
                <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="*[@typeof eq '&ex;Page']">
        <div class="page">

            <xsl:for-each select="*[@rel eq '&foaf;depiction']/@resource">
                <img class="img-thumbnail img-responsive"
                    src="../resource/image/thumbnail/{substring-before(substring-after(., 'img/'), '.jpg')}.png"
                />
            </xsl:for-each>

            <xsl:sequence select="."/>
            <xsl:apply-templates
                select="key('aboutKey', *[@rel eq '&dcterms;isPartOf']/@resource)"
                mode="page"/>
            <xsl:apply-templates
                select="key('aboutKey', key('resourceKey', @about)[@rel eq '&oa;hasTarget']/following-sibling::*[@rel eq '&oa;hasBody']/@resource)"
                mode="body"/>
        </div>
    </xsl:template>

    <xsl:template match="*[@typeof eq '&ex;Page']" mode="gallery">


        <xsl:for-each select="*[@rel eq '&foaf;depiction']/@resource">
            <xsl:variable name="page" as="element()">
                <xsl:sequence
                    select="key('resourceKey', ../../@about)[@rel eq '&oa;hasTarget']"
                />
            </xsl:variable>
            <xsl:variable name="creator">
                <xsl:sequence
                    select="$page/../*[@rel eq '&dcterms;creator']/@resource/substring(., 22)"
                />
            </xsl:variable>
            
            <div class="col-md-3" style="min-height:485px;">

                <a
                    href="resource/image/thumbnail/{substring-before(substring-after(., 'img/'), '.jpg')}.png"
                    class="thumbnail {
                    for $x in key('oKey', $creator, $o)[true()]
                    return                    
                        if (contains($x, ' ')) then replace($x, '\s', '-') else $x
                        } {{choose(instance('agent')/agent[. = '{$creator}'][contains(@o, 'philosopher')] and instance('bool')/ph = 'true', 'selected-ph', '')}} {{choose(instance('agent')/agent[. = '{$creator}'][contains(@o, 'professor') or contains(@o, 'university-teacher')] and instance('bool')/pr = 'true', 'selected-pr', '')}} {{choose(instance('agent')/agent[. = '{$creator}'][contains(@o, 'librarian')] and instance('bool')/l = 'true', 'selected-l', '')}}">

                    <p>
                        <!--<xsl:value-of
                            select="//*[@typeof eq '&bf;Title'][key('resourceKey', @about)[key('resourceKey', ../../@about)[key('resourceKey', ../../@about)[key('resourceKey', *[@rel eq '&dcterms;isPartOf'])]]]]/*[@property eq '&bf;label']"/>-->
                        <xsl:value-of
                            select="key('aboutKey', key('aboutKey', key('aboutKey', ../../*[@rel eq '&dcterms;isPartOf']/@resource)/*[@rel eq '&bf;itemOf']/@resource)/*[@rel eq '&schema;sameAs']/@resource)[not(contains(@typeof, '&bf;Instance'))]/*[@property eq '&dc;title']"
                        />
                    </p>
                    <img class="img-responsive img-thumbnail"
                        src="resource/image/thumbnail/{substring-before(substring-after(., 'img/'), '.jpg')}.png"
                    />
                </a>
                <p class="anno">
                    <xsl:apply-templates
                        select="key('aboutKey', key('resourceKey', ../../@about)/../*[@rel eq '&oa;hasTarget']/../*[@rel eq '&oa;hasBody']/@resource)"
                        mode="body"/>
                </p>                


            </div>
        </xsl:for-each>


    </xsl:template>

    <xsl:template match="*[@typeof eq '&bf;Item']" mode="page">
        <div class="item">
            <xsl:sequence select="."/>
            <xsl:apply-templates
                select="key('aboutKey', *[@rel eq '&bf;itemOf']/@resource)"
                mode="item"/>
        </div>
    </xsl:template>

    <xsl:template match="*[@typeof eq '&bf;Instance']" mode="item">
        <div class="instance">
            <xsl:sequence select="."/>
            <xsl:for-each select="*[@rel eq '&schema;sameAs']">
                <xsl:sequence select="."/>
                <xsl:apply-templates select="key('aboutKey', @resource)"
                    mode="instance"/>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@typeof, '&bf;Instance') or @typeof eq '']"
        mode="instance">
        <xsl:sequence select="."/>
        <div class="instanceTitle">
            <xsl:apply-templates
                select="
                    if (contains(@typeof, '&bf;Instance')) then
                        key('aboutKey', *[@rel eq '&bf;instanceTitle']/@resource)
                    else
                        ()"
                mode="title"/>
        </div>
        <div class="work">
            <xsl:apply-templates
                select="
                    if (contains(@typeof, '&bf;Instance')) then
                        key('aboutKey', *[@rel eq '&bf;instanceOf']/@resource)
                    else
                        ()"
                mode="work"/>
        </div>
        <xsl:apply-templates
            select="
                if (contains(@typeof, '&bf;Instance')) then
                    key('aboutKey', *[@rel eq '&bf;instanceTitle']/@resource)
                else
                    ()"
            mode="list-titles"/>
    </xsl:template>

    <xsl:template match="*[contains(@typeof, '&bf;Title')]" mode="title">
        <xsl:sequence select="."/>
    </xsl:template>

    <xsl:template
        match="*[contains(@typeof, '&bf;Title')][key('resourceKey', @about)[@rel eq '&bf;instanceTitle']]"
        mode="list-instance-titles">
        <div id="instance-title-{position()}">
            <h2>
                <xsl:value-of select="*[@property eq '&bf;titleValue']"/>
            </h2>
            <xsl:sequence select="."/>

        </div>
        <!--<xsl:perform-sort select=".">
            <xsl:sort select="*[@property eq '&bf;titleValue']"/>
        </xsl:perform-sort>-->

    </xsl:template>

    <xsl:template
        match="*[contains(@typeof, '&bf;Title')][key('resourceKey', @about)[@rel eq '&bf;workTitle']]"
        mode="list-work-titles">
        <div id="work-title-{position()}">
            <h2>
                <xsl:value-of select="*[@property eq '&bf;titleValue']"/>
            </h2>
            <xsl:sequence select="."/>

        </div>
        <!--<xsl:perform-sort select=".">
            <xsl:sort select="*[@property eq '&bf;titleValue']"/>
        </xsl:perform-sort>-->

    </xsl:template>

    <xsl:template match="*[contains(@typeof, '&bf;Work')]" mode="work">
        <xsl:sequence select="."/>
        <div class="workTitle">
            <xsl:apply-templates
                select="
                    if (contains(@typeof, '&bf;Work')) then
                        key('aboutKey', *[@rel eq '&bf;workTitle']/@resource)
                    else
                        ()"
                mode="title"/>
        </div>
        <div class="series">
            <xsl:apply-templates
                select="
                    if (contains(@typeof, '&bf;Work')) then
                        key('aboutKey', *[@rel eq '&bf;series']/@resource)
                    else
                        ()"
                mode="series"/>
        </div>
        <div class="topic">
            <xsl:for-each select="*[@rel eq '&bf;subject']">
                <xsl:apply-templates
                    select="key('aboutKey', @resource)[contains(@typeof, '&bf;Topic')]"
                    mode="topic"/>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@typeof, '&bf;Work')]" mode="series">
        <xsl:sequence select="."/>
    </xsl:template>

    <xsl:template match="*[contains(@typeof, '&bf;Topic')]" mode="topic">
        <xsl:variable name="pairs">
            <xsl:sequence
                select="local:parse-topic(span, span/span[@rel eq '&mads;isMemberOfMADSScheme'])"
            />
        </xsl:variable>
        <xsl:if test="$pairs/*">
            <div class="subject">
                <xsl:sequence
                    select="
                        for-each-pair($pairs/type, $pairs/value, function ($x, $y) {
                            local:get-pair(($x,
                            $y))
                        })"
                />
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*[contains(@typeof, '&oa;TextualBody')]" mode="body">
        <xsl:variable name="exact">
            <exact>
                <xsl:for-each
                    select="key('resourceKey', @about)/preceding-sibling::*[@typeof eq '&oa;TextQuoteSelector']/*[@property eq '&oa;exact']">
                    <name
                        viaf="{distinct-values(../../following-sibling::*[@rel eq '&oa;hasBody']/*[@rel eq '&oa;hasSource']/@resource/data(.))}">
                        <xsl:sequence select="string(.)"/>
                    </name>
                </xsl:for-each>
            </exact>
        </xsl:variable>
        <xsl:variable name="text">
            <xsl:sequence select="*[@property eq '&oa;text']"/>
        </xsl:variable>

        <xsl:apply-templates select="$text" mode="tagging">
            <xsl:with-param name="exact" select="$exact" tunnel="yes"/>
        </xsl:apply-templates>

    </xsl:template>

    <xsl:template match="*[@property eq '&oa;text']" mode="tagging">
        <xsl:param name="exact" tunnel="yes"/>
        <xsl:sequence
            select="parse-xml-fragment(local:tag-names($exact/*/*, string(.)))"/>
        <!--<xsl:sequence select="$exact"/>-->

    </xsl:template>

    <xsl:function name="local:tag-names" as="xs:string*">
        <xsl:param name="name" as="item()*"/>
        <xsl:param name="text" as="item()"/>
        <!--<xsl:variable name="name" select="distinct-values($name)"/>-->


        <xsl:choose>
            <xsl:when test="$name[1]">
                <xsl:variable name="r">
                    <xsl:sequence
                        select="replace($text, $name[1], concat('&lt;a href=&quot;', $name[1]/@viaf, '&quot;>', $name[1], '&lt;/a>'))"
                    />
                </xsl:variable>
                <xsl:sequence
                    select="local:tag-names($name[position() gt 1], $r)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence
                    select="if (contains($text, '&amp;')) then replace($text, '&amp;', '&amp;amp;') else $text"
                />
            </xsl:otherwise>
        </xsl:choose>
        <!--<xsl:sequence select="$name[1]"/>-->
    </xsl:function>

    <xsl:template match="@* | node()"/>
    <xsl:template match="@* | node()" mode="gallery"/>
    <xsl:template match="@* | node()" mode="list-instance-titles"/>
    <xsl:template match="@* | node()" mode="list-work-titles"/>

</xsl:stylesheet>
