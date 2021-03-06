--`mp_date` bigint, 
--`mp_ref_id` string, 
--`mp_ref_type` string, 
--`mp_artist` string, 
--`mp_title` string, 
--`mp_quantity` bigint, 
--`mp_amount_pre_tax` string

create or replace view clean.ventas_web_antigua as 
SELECT
    "$path" as file,
   	date_parse(cast("MP_Date" as varchar) || '-01' || '-01' ,'%Y-%m-%d') as "report_date",
	date_parse(cast("MP_Date" as varchar) || '-01' || '-01' ,'%Y-%m-%d') as "sale_date",
    TRY_CAST("MP_quantity" as bigint) quantity,
    'VENTA FISICA' sale_type,
    TRY_CAST(REPLACE(REPLACE("MP_Amount_pre_tax", '.', ''), ',','.') as double ) as gross_revenue,
    TRY_CAST(REPLACE(REPLACE("MP_Amount_pre_tax", '.', ''), ',','.') as double ) as net_revenue,
    CAST("Mp_Ref_ID" AS varchar) as product_id,
    CAST(null AS varchar) as isrc,
    'Mushroom Pillow Store Web' platform,
    'VENTAS_WEB_ANTIGUA' source,
    'España' country,
    CAST(null AS varchar) agency,
    false is_licencing,
    CAST(null AS varchar) operation_type,
    cast(null as varchar) stream_quality,
    'EUR' as source_currency
FROM raw.ventas_web_antigua

 --file	
--report_date -> igual a "sale date"
--sale_date -> 01-01-"Date" (solo tiene el ano)
--quantity -> "MP_Quantity"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "MP_Amount_pre_tax"
--net_revenue	-> "MP_Amount_pre_tax"
--product_id	-> "MP_ref_ID"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Mushroom Pillow Store Web" matchear con plataforma_corregida
--"source"	-> VENTAS_WEB_ANTIGUA
--country	-> 'ESPANA'
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"

-- EXCHANGE RATE EUR