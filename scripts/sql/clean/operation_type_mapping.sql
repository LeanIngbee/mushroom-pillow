--create database if not exists clean
create or replace view clean.operation_type_mapping as 

select distinct 
    lower(operation_type) as operation_type, 
    lower(operation_type_std) as operation_type_std 

from raw.operation_type