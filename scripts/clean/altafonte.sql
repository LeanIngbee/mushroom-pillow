--create database if not exists clean
create or replace view clean.altafonte as 

SELECT
     "$path" file,
    TRY_CAST("concat"("fecha reporte", '-01') AS date) report_date,
    TRY_CAST("concat"("fecha_consumo", '-01') AS date) sale_date,
    TRY_CAST("suma de cantidad" AS bigint) quantity,
    'VENTA DIGITAL' sale_type,
    cast(NULL as double) gross_revenue, --ASK TOMAS IF NULL OR = NET_REVENUE
    TRY_CAST(REPLACE(REPLACE("suma de neto altafonte", '.', ''), ',','.') as double ) net_revenue,
    TRIM("referencia") product_id,
    TRIM("isrc") isrc,
    cast(NULL as varchar) platform,
    'ALTAFONTE' source,
    NULLIF("lower"(country), '') country,
    CAST(null AS varchar) agency,
    false is_licencing,
    NULLIF("lower"("tipo de ingreso"), '') operation_type,
    cast(NULL as varchar) stream_quality

FROM raw.altafonte