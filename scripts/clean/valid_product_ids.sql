--create database if not exists clean
create or replace view clean.valid_product_ids as 

select distinct product_id from clean.valid_isrc_product_id_pair