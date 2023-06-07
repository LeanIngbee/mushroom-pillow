--create database if not exists clean
create or replace view clean.gastos_sin_base as 

select 
    "$path" as file,
    date_format(date_trunc('year', date_parse("Fecha", '%d/%m/%Y')), '%Y') as year,
    - try_cast("Importe" as double) as cost,
    "Tipo" as category,
    "Detalle" as subcategory

from raw.gastos_sin_base