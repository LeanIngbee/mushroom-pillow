--create database if not exists clean
create or replace view clean.pagos_y_cobros as 

select  
    nullif("Año", '') as year,
    try_cast(replace(replace("importe PAID", '.', ''), ',', '.') as double) as cost,
    "Rubro" as category,
    "Subrubro" as subcategory

from raw.pagos_y_cobros
where date_parse(nullif("Año", ''), '%Y') is not null 
  and try_cast(replace(replace("importe PAID", '.', ''), ',', '.') as double) is not null
  and nullif("Rubro", '') is not null
  and nullif("Subrubro", '') is not null