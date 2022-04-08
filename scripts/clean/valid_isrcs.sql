--create database if not exists clean
create or replace view clean.valid_isrcs as 

select distinct isrc from clean.valid_isrc_product_id_pair