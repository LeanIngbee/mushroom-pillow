-- LA CUPULA
-- VENTAS DIGITALES

create or replace view clean.la_cupula as 
SELECT
    "$path" as file,
   	date_parse("Fecha reporte",'%d/%m/%Y') as "report_date",
	date_parse("Fecha venta",'%d/%m/%Y') as "sale_date",
    TRY_CAST("units" as bigint) quantity,
    'VENTA DIGITAL' sale_type,
    try_cast(replace("bruto eur", ',', '.') as double) gross_revenue,
    try_cast(replace("neto eur", ',', '.') as double)  net_revenue,
    CAST(null AS varchar) as product_id,
    nullif("isrc", '') as isrc,
    "channel" platform,
    'LA_CUPULA' source,
    "Country" country,
    CAST(null AS varchar) agency,
    false is_licencing,
    CAST(null AS varchar) operation_type,
    cast(NULL as varchar) stream_quality,
    'EUR' as source_currency,
    nullif("display_artist", '') as artist,
    cast(null as varchar) as album,
    nullif("track", '') as song

FROM raw.la_cupula

-- Inferir todo
-- en vez de tener paises tiene country codes