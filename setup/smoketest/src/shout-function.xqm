module namespace zone = "http://wendellpiez.com/ns/xproc-zone";

(: Simple function providing string manipulation :)
declare function zone:SHOUT ($s as xs:string?) as xs:string? { upper-case($s) || '!!!' };

(: ox:SHOUT('Hey world') :)