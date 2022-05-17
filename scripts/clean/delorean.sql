--create database if not exists clean
create or replace view clean.delorean as 

select 
    "$path" as file,
    date_parse(nullif("period date", ''),'%d/%m/%Y') as report_date,
    date_parse(nullif("sales date", ''),'%d/%m/%Y')as sale_date,
    try_cast(try_cast("quantity" as double) as bigint) as quantity, 
    'VENTA DIGITAL' as sale_type,
    try_cast(replace("Ingresos brutos", ',', '.') as double) as gross_revenue,
    try_cast(replace("Ingresos netos", ',', '.') as double) as net_revenue,
    cast(null as varchar) as product_id,
    nullif("track isrc", '') as isrc,
    nullif(lower("vendor"), '') as platform,
    'DELOREAN' as source,
    coalesce(nullif(lower("territoryname"), ''), 'Unknown') as country,
    cast(null as varchar) as agency,
    true as is_licencing,
    nullif(lower("analysis code description"), '') as operation_type,
    nullif(lower("analysis code description"), '') as stream_quality
from raw.delorean

-- DELOREAN - INSTRUCCIONES DE TOMAS
-- file	
-- report_date -> Period Date
-- sale_date -> Sales Date
-- quantity -> Quantity
-- sale_type ->  "VENTAS_DIGITALES"
-- gross_revenue	-> "Ingresos brutos"
-- net_revenue	-> "Ingresos netos"
-- product_id	-> va nulo
-- isrc	 -> va por "track ISRC"
-- song	-> XXXX (CALC)
-- album	-> XXXX (CALC)
-- artist	-> XXXX (CALC) (si no hay ningun match que ponga "delorean")
-- platform	-> "Vendor" matchear con plataforma_corregida
-- "source"	-> DELOREAN
-- country	-> "TerritoryName"
-- continent	-> XXXX (CALC)
-- agency	-> null
-- is_licencing	-> true
-- operation_type	-> "Analysis code description" (mapeo con operation_type_mapping)
-- stream_quality -> "Analysis code description"	

