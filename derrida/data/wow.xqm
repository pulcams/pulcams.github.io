xquery version "3.1";

module namespace wow = "http://bibfram.es/cwb/wow";

declare function wow:wow(
    $name as item()*,
    $text as item()*
) as item()* {
    let $name := distinct-values($name)
    return
        if ($name[1]) then                    
            let $r := 
                replace($text, $name[1], "&lt;span&gt;"||$name[1]||"&lt;/span&gt;")
            return 
                wow:wow($name[position() > 1], $r)
        else parse-xml-fragment($text)
            
            
    
    
        
     
           
};


        