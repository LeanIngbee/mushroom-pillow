--create database if not exists clean
create or replace view clean.country_mapping as 

select distinct 
    lower(country) as country, 
    iso_code, 
    continent 
    
from raw.country