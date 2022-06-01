--create database if not exists clean
create or replace view clean.universal_suecia as

select 
    "$path" as file,
    date_parse(nullif("fecha informe", ''),'%d/%m/%Y') as report_date,
    try_cast(substring("período", 1, 4) || '-' || substring("período", 5,2) || '-01' as date) as sale_date,
    try_cast(try_cast("unidades de ventas" as double) as bigint) as quantity, 
    'VENTA DIGITAL' as sale_type,
    try_cast(replace("importe de precio base", ',', '.') as double) as gross_revenue,
    try_cast(replace("importe de royalties", ',', '.') as double) as net_revenue,
    cast(null as varchar) as product_id,
    nullif("número de catálogo local", '') as isrc,
    nullif(lower("Distribuidor"), '') as platform,
    'UNIVERSAL_SUECIA' as source,
    coalesce(nullif(lower("país"), ''), 'Unknown') as country,
    cast(null as varchar) as agency,
    true as is_licencing,
    COALESCE(nullif(lower("tipo de venta"), ''), 'Other') as operation_type,
    nullif(lower("tipo de venta"), '') as stream_quality
from raw.universal_suecia

-- UNIVERSAL SUECIA CONSOLIDADO  - INSTRUCCIONES DE TOMAS
--file	
--report_date -> Fecha informe
--sale_date -> Período
--quantity -> Unidades de ventas
--sale_type ->  "VENTAS_DIGITALES"
--gross_revenue	-> "Importe de precio base"
--net_revenue	-> "Importe de Royalties"
--product_id	-> va nulo
--isrc	 -> va por "Número de catálogo local"
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Distribuidor" matchear con plataforma_corregida
--"source"	-> UNIVERSAL_SUECIA
--country	-> "País"
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> true
--operation_type	-> "Tipo de venta" (mapeo con operation_type_mapping)
--stream_quality -> "Tipo de venta"	
