create or replace view clean.gran_sol as 

with prepared as (
    select
        *,
        "$path" as path,
        TRY_CAST("U.post. dev." as bigint) as "quantity corregido",
        TRY_CAST(REPLACE(REPLACE(substring("ventas netas sello", 1, length("ventas netas sello") - 1), '.', ''), ',','.') as double ) as "ventas netas sello corregido",
        TRY_CAST(REPLACE(REPLACE(substring("neto total", 1, length("neto total") - 1), '.', ''), ',','.') as double ) as "neto total corregido"
    from raw.gran_sol
)

SELECT
    "path" file,
    date_add('month', 1, TRY_CAST("Cod año - Mes" || '-01' AS date)) report_date,
    TRY_CAST("Cod año - Mes" || '-01' AS date) sale_date,
    TRY_CAST("U.post. dev." as bigint) quantity,
    'VENTA FISICA' sale_type,
    "neto total corregido" gross_revenue,
    "ventas netas sello corregido" net_revenue,
    nullif(case when "referencia" is not null and "referencia" != '' then 'MP' || lpad(try_cast(try_cast(regexp_replace("referencia", '([^0-9.])', '') as bigint) as varchar), 3, '0') end, '') as product_id,
    CAST(null AS varchar) as isrc,
    'Physical Store' platform,
    'GRAN_SOL' source,
    'España' country,
    CAST(null AS varchar) agency,
    false is_licencing,
    nullif(case when length(element_at(split(replace("titulo", '"', ''), ' '), 1)) = 2 
           then element_at(split(replace("titulo", '"', ''), ' '), 1) end, '') operation_type, 
    cast(NULL as varchar) stream_quality,
    'EUR' as source_currency,
    cast(NULL as varchar) as artist,
    cast(NULL as varchar) as album,
    nullif(case when length(element_at(split(replace("titulo", '"', ''), ' '), 1)) = 2 
           then substring(replace("titulo", '"', ''), 4, length(replace("titulo", '"', ''))) -- Removes the first 2 letters corresponding to the and the first space.
           else replace("titulo", '"', '') end, '') as song

FROM prepared

--file	
--report_date -> "Cod Año - MEs" siempre el 1 mas un mes
--sale_date -> "Cod Año - Mes" siempre el 1
--quantity -> "U. post. dev"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "neto total"
--net_revenue	-> "ventas netas sello"
--product_id	-> "Referencia"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Physical Store" matchear con plataforma_corregida
--"source"	-> GRAN_SOL
--country	-> 'Spain'
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"

-- CURRENCY TYPE EUR