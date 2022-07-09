--create database if not exists clean
create or replace view clean.isrc_mapping as 

select 
    isrc,
    max(isrc_std) as isrc_std 

from(
    select distinct
        isrc, 
        isrc_std 

    from raw.isrc_mapping
)
group by 1