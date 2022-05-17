--create database if not exists clean
create or replace view clean.media_information as 

select 
    isrc,
    product_id,
    max_by("main title", length("main title")) as song, 
    max_by("album title", length("album title")) as album, 
    max_by("artist name", length("artist name")) as artist,
    max_by("tipo", length("tipo")) as type
    
from raw.audio
where isrc is not null and isrc != '' and product_id is not null and product_id != '' and "tipo" != 'Single'
group by 1, 2

union

select 
    min(isrc) as isrc,
    product_id,
    min_by("main title", isrc) as song, 
    min_by("album title", isrc) as album, 
    min_by("artist name", isrc) as artist,
    min_by("tipo", isrc) as type
    
from raw.audio
where isrc is not null and isrc != '' and product_id is not null and product_id != '' and "tipo" = 'Single'
group by 2