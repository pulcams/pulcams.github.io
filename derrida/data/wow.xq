xquery version "3.1";

import module namespace wow = "http://bibfram.es/cwb/wow" at "wow.xqm";

let $name := (
    <span property="http://www.w3.org/ns/oa#exact"
          datatype="http://www.w3.org/2001/XMLSchema#string">Eva Rosenblum</span>,
    <span property="http://www.w3.org/ns/oa#exact"
          datatype="http://www.w3.org/2001/XMLSchema#string">Jacques Derrida</span>,
    <span property="http://www.w3.org/ns/oa#exact"
          datatype="http://www.w3.org/2001/XMLSchema#string">Jacques Derrida</span>,
    <span property="http://www.w3.org/ns/oa#exact"
          datatype="http://www.w3.org/2001/XMLSchema#string">Eva Rosenblum</span>
        )
let $text :=      
    <span property="http://www.w3.org/ns/oa#text"
          datatype="http://www.w3.org/2001/XMLSchema#string">Au Professeur Jacques Derrida avec mon cordial hommage Eva Rosenblum</span>
return 
   <test>{wow:wow($name, $text)}</test>