--create database if not exists clean
create or replace view clean.sony_discos as 

with prepared as (
    select
        *,
        "$path" as "path",
        substring(replace(regexp_extract("$path", '[^/]+$'),'.csv',''), 1,4) as "report_year",
        substring(replace(regexp_extract("$path", '[^/]+$'),'.csv',''), 5,6) as "report_segment",
        substring("período", 1,4) as "sale_year",
        substring("período", 6,2) as "sale_segment"
    from raw.sony_discos 
)
select 
    "path" as file,
    try_cast(p.report_year || '-' || 
		case p.report_segment 
            when '1H' then '01'
			when '2H' then '07'
			when 'H1' then '01'
			when 'H2' then '07'
		end
	|| '-01' as date) as report_date,
    try_cast(p.sale_year || '-' || 
		case p.sale_segment 
			when '1H' then '01'
            when '2H' then '07'
            when 'H1' then '01'
			when 'H2' then '07'
            when '1Q' then '01'
            when '2Q' then '04'
            when '3Q' then '07'
            when '4Q' then '10'
            when 'Q1' then '01'
            when 'Q2' then '04'
            when 'Q3' then '07'
            when 'Q4' then '10'
            when '' then '01'
            when null then '01'
        else p.sale_segment
		end
	|| '-01' as date) as sale_date,
    try_cast(try_cast("unidades a pagar" as double) as bigint) as quantity, 
    case lower("Canal") when 'pp&b' then 'COMUNICACION PUBLICA' else 'VENTA DIGITAL' end as sale_type,
    try_cast(replace("precio", ',', '.') as double) * "unidades a pagar" * ("participación en el contrato" / 100) as gross_revenue,
    try_cast(replace("royalty a pagar", ',', '.') as double) as net_revenue,
    cast(null as varchar) as product_id,
    nullif("track number", '') as isrc,
    nullif(lower("proveedor"), '') as platform,
    'SONY_DISCOS' as source,
    coalesce(nullif(lower("territorio de venta"), ''), 'Unknown') as country,
    cast(null as varchar) as agency,
    true as is_licencing,
    nullif(lower("canal"), '') as operation_type,
    nullif(lower("canal"), '') as stream_quality
from prepared p

-- SONY DISCOS - INSTRUCCIONES DE TOMAS
-- file	
-- report_date -> archivo
-- sale_date -> Período (1er dia) (H o Q)
-- quantity -> unidades a pagar
-- sale_type -> "VENTAS_DIGITALES" salvo que "Canal" diga "pp&b" , en ese caso "COMUNICACION_PUBLICA"
-- gross_revenue	-> precio * unidad * (participacion / 100)
-- net_revenue	-> royalty a pagar
-- product_id	-> va nulo
-- isrc	 -> va por track number
-- song	-> XXXX (CALC)
-- album	-> XXXX (CALC)
-- artist	-> XXXX (CALC)
-- platform	-> Proveedor
-- "source"	-> SONY_DISCOS
-- country	-> Territorio de Venta
-- continent	-> XXXX (CALC)
-- agency	-> null
-- is_licencing	-> true
-- operation_type	-> canal
-- stream_quality -> mezclado con canal	