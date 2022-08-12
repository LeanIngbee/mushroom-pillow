-- KOBALT - INSTRUCCIONES DE TOMAS

-- NOTA ALGUNOS RECORDS NO TIENEN ISRC.
-- ACA HAY QUE ENCONTRAR ALGUNA FORMA ALTERNATIVA DE ENCONTRAR EL ARTISTA, QUE VIENE CON EL NOMBRE
-- EN "RECORDING_ARTIST" Y A VECES EL TEMA EN "RECORDING_TITLE"

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

create or replace view clean.kobalt as 

with prepared as (
    select
        *,
        "$path" as "path",
        date_parse("statement_period", '%b %Y') as "report_date",
        date_parse("royalty_period_end_date", '%d-%b-%y') as "sale_date",
        try_cast("source_amount" as double) as "gross_revenue",
        try_cast("distributed_amount" as double) as "net_revenue"
    from raw.kobalt 
)
select 
    "path" as file,
    report_date as "report_date",
    date_trunc('month', sale_date) as "sale_date",
    try_cast(1 as bigint) as quantity, 
    'COMUNICACION_PUBLICA' as sale_type,
    gross_revenue as gross_revenue,
    net_revenue as net_revenue,
    cast(null as varchar) as product_id,
    "isrc" as isrc,
    'unknown' as platform,
    'KOBALT' as source,
    coalesce(nullif(lower("territory"), ''), 'Unknown') as country,
    nullif("batch_description", '') as agency,
    false as is_licencing,
    nullif(lower("right_type"), '') as operation_type,
    'N/A' as stream_quality,
    'EUR' as source_currency
from prepared p