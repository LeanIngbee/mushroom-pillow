--create database if not exists clean
create or replace view clean.valid_product_ids as 

select distinct product_id 
from raw.audio
where product_id is not null

union

select distinct product_id 
from raw.video
where product_id is not null