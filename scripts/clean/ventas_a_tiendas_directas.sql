create or replace view clean.ventas_a_tiendas_directas as 
SELECT
    "$path" as file,
   	CASE WHEN "Fecha" like '__/__/____' then 
        "date_trunc"('month', "date_parse"("Fecha", '%d/%m/%Y')) 
    else 
        date_add('day', cast("Fecha" as bigint), date_parse('1899-12-30', '%Y-%m-%d')) --Excel standard conversion
    end as "report_date",
    CASE WHEN "Fecha" like '__/__/____' then 
        "date_trunc"('month', "date_parse"("Fecha", '%d/%m/%Y')) 
    else 
        date_add('day', cast("Fecha" as bigint), date_parse('1899-12-30', '%Y-%m-%d')) --Excel standard conversion
    end as "sale_date",
    TRY_CAST(TRY_CAST(replace("cantidad", ',', '.') as double) as bigint) quantity,
    'VENTA FISICA' sale_type,
    TRY_CAST(REPLACE(REPLACE("Total", '.', ''), ',','.') as double ) as gross_revenue,
    TRY_CAST(REPLACE(REPLACE("Total", '.', ''), ',','.') as double ) as net_revenue,
    CAST("Referencia" AS varchar) as product_id,
    CAST(null AS varchar) as isrc,
    'Mushroom Pillow Store' platform,
    'VENTAS_A_TIENDAS' source,
    'España' country,
    CAST(null AS varchar) agency,
    false is_licencing,
    CAST(null AS varchar) operation_type,
    cast(null as varchar) stream_quality,
    'EUR' as source_currency
FROM raw.ventas_a_tiendas_directas

--file	
--report_date -> 01-"sale_date"
--sale_date -> "Fecha" (sin planchar)
--quantity -> "Cantidad neta"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "Total"
--net_revenue	-> "Total"
--product_id	-> "Referencia"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Mushroom Pillow Store" matchear con plataforma_corregida
--"source"	-> VENTAS_A_TIENDAS
--country	-> 'ESPANA'
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"

-- EXCHANGE RATE EUR

--CAMPOS SOURCE

--`nº factura asociada` string, 
--`pendiente de facturar` string, 
--`año` bigint, 
--`fecha` string, 
--`cliente` string, 
--`referencia` string, 
--`merch/cd` string, 
--`artista` string, 
--`album` string, 
--`cantidad` string, 
--`pvp` string, 
--`total` string, 
--`tipo de merch` string, 
--`detalle` string




