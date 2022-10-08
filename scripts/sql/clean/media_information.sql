--create database if not exists clean
--create or replace view clean.media_information as 

with

information_for_regular_records as (
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
),

information_for_singles as (
    select 
        isrc,
        product_id,
        min_by("main title", isrc) as song, 
        min_by("album title", isrc) as album, 
        min_by("artist name", isrc) as artist,
        min_by("tipo", isrc) as type
        
    from raw.audio
    where isrc is not null and isrc != '' and product_id is not null and product_id != '' and "tipo" = 'Single'
    group by 1, 2
),

information_for_null_isrc_records as (
    select 
        cast(null as varchar) as isrc,
        product_id,
        cast(null as varchar) as song, 
        min_by("album title", isrc) as album, 
        min_by("artist name", isrc) as artist,
        min_by("tipo", isrc) as type
        
    from raw.audio
    where isrc is not null and isrc != '' and product_id is not null and product_id != '' and "tipo" != 'Single'
    group by 2
),

information_for_null_product_id_records as (
    select 
        isrc,
        cast(null as varchar) as product_id,
        min("main title") as song, 
        cast(null as varchar) as  album, 
        min("artist name") as artist,
        cast(null as varchar) as type
        
    from raw.audio
    where isrc is not null and isrc != '' and product_id is not null and product_id != '' and "tipo" != 'Single'
    group by 1
    having count(distinct product_id) > 1
),

information_for_isrcs_with_only_one_product_id as (
    -- The same case as information_for_null_product_id_records, but we can actually complete the album information.
    select 
        isrc,
        min(product_id) as product_id,
        min("main title") as song, 
        min("album title") as album, 
        min("artist name") as artist,
        cast(min("tipo") as varchar) as type
        
    from raw.audio
    where isrc is not null and isrc != '' and product_id is not null and product_id != '' and "tipo" != 'Single'
    group by 1
    having count(distinct product_id) = 1
),

videos as (
    select 
        a.isrc,
        a.product_id,
        min(coalesce(a."video title", b."main title")) as song, 
        min(coalesce(a."album agrupado", b."album title")) as album, 
        min(coalesce(a."artist name", b."artist name")) as artist,
        cast(min(b."tipo") as varchar) as type
        
    from raw.video a
    left join raw.audio b on a.audio_isrc = b.isrc and a.product_id = b.product_id
    where a.isrc is not null and a.isrc != '' and a.product_id is not null and a.product_id != ''
    group by 1, 2
)

select
    isrc,
    product_id,
    max_by(song, length(song)) as song, 
    max_by(album, length(album)) as album, 
    max_by(artist, length(artist)) as artist,
    max_by(type, length(type)) as type

from (
    select * from information_for_regular_records
    union
    select * from information_for_singles
    union
    select * from information_for_null_isrc_records
    union
    select * from information_for_null_product_id_records
    union
    select * from information_for_isrcs_with_only_one_product_id
    union
    select * from videos
)
group by 1, 2