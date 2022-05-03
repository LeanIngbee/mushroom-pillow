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
    TRIM("mp") product_id,
    TRIM("isrc") isrc,
    NULLIF("lower"(TRIM("plataforma")), '') platform,
    'ALTAFONTE' source,
    COALESCE(NULLIF(lower(country), ''), 'Unknown') country,
    CAST(null AS varchar) agency,
    false is_licencing,
    NULLIF("tipo de operación", '') operation_type,
    cast(NULL as varchar) stream_quality

FROM raw.altafonte