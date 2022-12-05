--create database if not exists clean
create or replace view clean.syncros as

select 
    "$path" as file,
    date_parse(nullif("Fecha", ''),'%d/%m/%Y') as report_date,
    date_parse(nullif("Fecha", ''),'%d/%m/%Y') as sale_date,
    1 as quantity, 
    'SINCRONIZACIÓN PUBLISHING' as sale_type,
    try_cast(replace(replace("Publishing Imp Bruto", '.', ''), ',', '.') as double) as gross_revenue,
    try_cast(replace(replace("Publishing neto", '.', ''), ',', '.') as double) as net_revenue,
    cast("Referencia" as varchar) as product_id,
    nullif("ISRC", '') as isrc,
    nullif(lower("Nombre Recopilatorio"), '') as platform,
    'LICENCIAS Y SINCRONIZACIONES' as source,
    coalesce(nullif(lower("Pais"), ''), 'Unknown') as country,
    cast(null as varchar) as agency,
    true as is_licencing,
    COALESCE(nullif(lower("Tipo de Plataforma"), ''), 'Other') as operation_type,
    cast(null as varchar) as stream_quality,
    upper(nullif(replace("Moneda", ' ', ''), '')) as source_currency,
    nullif("Artista", '') as artist,
    nullif("Album", '') as album,
    nullif("Track", '') as song

from raw.syncros
where try_cast(replace(replace("Publishing Imp Bruto", '.', ''), ',', '.') as double) is not null
  and try_cast(replace(replace("Publishing neto", '.', ''), ',', '.') as double) is not null

union all

select 
    "$path" as file,
    date_parse(nullif("Fecha", ''),'%d/%m/%Y') as report_date,
    date_parse(nullif("Fecha", ''),'%d/%m/%Y') as sale_date,
    1 as quantity, 
    'SINCRONIZACIÓN MASTER' as sale_type,
    try_cast(replace(replace("Master Imp Bruto", '.', ''), ',', '.') as double) as gross_revenue,
    try_cast(replace(replace("Master neto", '.', ''), ',', '.') as double) as net_revenue,
    cast("Referencia" as varchar) as product_id,
    nullif("ISRC", '') as isrc,
    nullif(lower("Nombre Recopilatorio"), '') as platform,
    'LICENCIAS Y SINCRONIZACIONES' as source,
    coalesce(nullif(lower("Pais"), ''), 'Unknown') as country,
    cast(null as varchar) as agency,
    true as is_licencing,
    COALESCE(nullif(lower("Tipo de Plataforma"), ''), 'Other') as operation_type,
    cast(null as varchar) as stream_quality,
    upper(nullif(replace("Moneda", ' ', ''), '')) as source_currency,
    nullif("Artista", '') as artist,
    nullif("Album", '') as album,
    nullif("Track", '') as song

from raw.syncros
where try_cast(replace(replace("Master Imp Bruto", '.', ''), ',', '.') as double) is not null
  and try_cast(replace(replace("Master neto", '.', ''), ',', '.') as double) is not null

-- 3.Licencias y Sincronizaciones Consolidado - INSTRUCCIONES DE TOMAS
-- Tipo de venta --> mapea a sale_type? Si
-- Año Ingreso
-- Año Licencia
-- Fecha --> mapea a report_date y sale_date? Si a ambos!
-- Factura
-- Periodo Liquidación
-- Lleva IVA
-- Duración (meses)
-- Duración Sale off (meses) --> mapea a quantity? No quantity acá siempre sería 1 
-- Periodicidad Liquidación
-- Publishing recaudado por 3º
-- Publishing 
-- Master --> mapea a gross_revenue? No hay master y publishing importe bruto 
-- Moneda  --> mapea a currency si!
-- Tipo de Plataforma --> mapea a operation_type? Si
-- Nombre Recopilatorio --> mapea a platform? Si
-- ISRC --> mapea a isrc
-- ISWC
-- Track --> mapea a song
-- Album --> mapea a album
-- Artista --> mapea a artist
-- Licenciante
-- Pais de explotación
-- Pais --> mapea a country
-- Territorios de licencias
-- Referencia --> mapea a product_id
-- Tasa Interm.
-- Royalty Master
-- % control Mushroom Pillow
-- Royalty Publishing
 -- Master Imp Bruto 
 -- Publishing Imp Bruto 
 -- Publishing neto 
 -- Master Neto  --> mapea a net_revenue?
-- Fecha licencia
-- Fecha lanzamiento
 -- Contacto
-- False  --> mapea a is_licencing ?
-- ???  --> mapea a source? Si
-- null --> mapea a agency? Si
-- null --> mapea a stream_quality? Si
