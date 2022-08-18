-- KOBALT - INSTRUCCIONES DE TOMAS

-- NOTA ALGUNOS RECORDS NO TIENEN ISRC.
-- ACA HAY QUE ENCONTRAR ALGUNA FORMA ALTERNATIVA DE ENCONTRAR EL ARTISTA, QUE VIENE CON EL NOMBRE
-- EN "RECORDING_ARTIST" Y A VECES EL TEMA EN "RECORDING_TITLE"

--create database if not exists clean
create or replace view clean.kobalt as 

select 
    "$path" as file,
    try_cast('20' || substr(trim(period), 5, 2) || '-' || substr(trim(period), 2, 2) || '-01' as date) as report_date,
    try_cast("retailer reporting period" || '-01' as date) as sale_date,
    try_cast(try_cast("quantity net" as double) as bigint) as quantity, 
    'VENTA DIGITAL' as sale_type,
    try_cast(replace("net amount", ',', '.') as double) as gross_revenue,
    try_cast(replace("amount after fees", ',', '.') as double) as net_revenue,
    nullif(case when "product / catalog #" is not null and "product / catalog #" != '' then 'MP' || lpad(try_cast(try_cast(regexp_replace("product / catalog #", '([^0-9.])', '') as bigint) as varchar), 3, '0') end, '') as product_id,
    nullif(isrc, '') as isrc,
    nullif(lower("retailer"), '') as platform,
    nullif('INGROOVES', '') as source,
    COALESCE(NULLIF(lower("territory"), ''), 'Unknown') country,
    cast(null as varchar) as agency,
    false as is_licencing,
    nullif("sales classification", '') as operation_type,
    nullif("sales description" , '') as stream_quality,
    'USD' as source_currency
from raw.kobalt

--file	
--report_date -> 01-"Statement PEriod"
--sale_date -> ROYALTY_PERIOD_END_DATE (tomar el 01 ingresado el dia)
--quantity -> Mandarle 1
--sale_type ->  "COMUNICACION_PUBLICA"
--gross_revenue	-> "SOURCE_AMOUNT"
--net_revenue	-> "DISTRIBUTED_AMOUNT" (maoxmens 13,5 de diferencia con revenue apra chequear)
--product_id	-> no incluye
--isrc	 -> columna "ISRC" 
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Unknown" (no aplica)
--"source"	-> KOBALT
--country	-> "TERRITORY"
--continent	-> XXXX (CALC)
--agency	-> "BATCH_DESCRIPTION"
--is_licencing	-> false
--operation_type	-> "RIGHT_TYPE" (mapeo con operation_type_mapping) deberian estar si no estan los agregamos
--stream_quality -> "N/A"	
