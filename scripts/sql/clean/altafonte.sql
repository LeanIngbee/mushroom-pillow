--create database if not exists clean
create or replace view clean.altafonte as 

SELECT
     "$path" file,
    TRY_CAST("concat"("fecha liquidacion", '-01') AS date) report_date,
    TRY_CAST("concat"("fecha_consumo", '-01') AS date) sale_date,
    TRY_CAST("suma de cantidad" AS bigint) quantity,
    'VENTA DIGITAL' sale_type,
    TRY_CAST(REPLACE(REPLACE("suma de bruto altafonte", '.', ''), ',','.') as double ) gross_revenue,
    TRY_CAST(REPLACE(REPLACE("suma de neto altafonte", '.', ''), ',','.') as double ) net_revenue,
    nullif(case when "mp" is not null and "mp" != '' then 'MP' || lpad(try_cast(try_cast(regexp_replace("mp", '([^0-9.])', '') as bigint) as varchar), 3, '0') end, '') as product_id,
    NULLIF(TRIM("isrc"), '') as isrc,
    NULLIF("lower"(TRIM("plataforma")), '') platform,
    'ALTAFONTE' source,
    COALESCE(NULLIF(lower(country), ''), 'Unknown') country,
    CAST(null AS varchar) agency,
    false is_licencing,
    NULLIF("tipo de operación", '') operation_type,
    cast(NULL as varchar) stream_quality,
    'EUR' as source_currency,
    nullif("artista", '') as artist,
    nullif("album", '') as album,
    nullif("track", '') as song

FROM raw.altafonte