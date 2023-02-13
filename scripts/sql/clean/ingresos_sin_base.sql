--create database if not exists clean
create or replace view clean.ingresos_sin_base as 

select 
    "$path" as file,
    date_trunc('month', date_parse("Fecha", '%d/%m/%Y')) as report_date,
    date_trunc('month', date_parse("Fecha", '%d/%m/%Y')) as sale_date,
    1 as quantity, 
    nullif("Tipo de Ingreso", '') as sale_type,
    try_cast(replace(replace("Importe Bruto", '.', ''), ',', '.') as double) as gross_revenue,
    try_cast(replace(replace("Importe Neto", '.', ''), ',', '.') as double) as net_revenue,
    coalesce(
        nullif(case when "col5" is not null and "col5" != '' then 'MP' || lpad(try_cast(try_cast(regexp_replace("col5", '([^0-9.])', '') as bigint) as varchar), 3, '0') end, ''),
        nullif(case when "Referencia" is not null and "Referencia" != '' then 'MP' || lpad(try_cast(try_cast(regexp_replace("Referencia", '([^0-9.])', '') as bigint) as varchar), 3, '0') end, '')
    ) as product_id,
    nullif("ISRC", '') as isrc,
    nullif(lower("Fuente"), '') as platform,
    'INGRESOS_SIN_BASE' as source,
    COALESCE(NULLIF(lower("Pais"), ''), 'Unknown') country,
    cast(null as varchar) as agency,
    false as is_licencing,
    cast(null as varchar) as operation_type,
    cast(null as varchar) as stream_quality,
    'EUR' as source_currency,
    nullif("Artista", '') as artist,
    nullif("Album", '') as album,
    nullif("Track", '') as song

from raw.ingresos_sin_base
where nullif("Fecha", '') is not null