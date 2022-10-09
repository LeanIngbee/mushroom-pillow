--create database if not exists clean
create or replace view clean.platform_mapping as 

select distinct 
    lower(platform) as platform, 
    platform_std 
    
from raw.platform