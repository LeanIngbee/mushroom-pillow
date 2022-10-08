--create database if not exists clean
create or replace view clean.valid_isrcs as 

select distinct isrc 
from raw.audio
where isrc is not null

union 

select distinct isrc 
from raw.video
where isrc is not null