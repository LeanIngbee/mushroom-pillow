--create database if not exists clean
create or replace view clean.song_information as 

select 
    isrc,
    product_id,
    max_by("main title", length("main title")) as song, 
    max_by("album title", length("album title")) as album, 
    max_by("artist name", length("artist name")) as artist 
    
from raw.audio
where isrc is not null and product_id is not null
group by 1, 2