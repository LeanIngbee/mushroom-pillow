--create database if not exists clean
create or replace view clean.product_types as 

select 
    "ref. agrupada" as product_id, 
    max("Formato") as product_type
    
from raw.product_types
group by 1