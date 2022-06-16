--   `order id` string, 
--   `sale id` string, 
--   `date` string, 
--   `order` string, 
--   `transaction type` string, 
--   `sale type` string, 
--   `sales channel` string, 
--   `pos location` string, 
--   `billing country` string, 
--   `billing region` string, 
--   `billing city` string, 
--   `shipping country` string, 
--   `shipping region` string, 
--   `shipping city` string, 
--   `product type` string, 
--   `product vendor` string, 
--   `product` string, 
--   `variant` string, 
--   `variant sku` string, 
--   `net quantity` bigint, 
--   `gross sales` string, 
--   `discounts` string, 
--   `returns` string, 
--   `net sales` string, 
--   `shipping` string, 
--   `taxes` string, 
--   `total sales` string

create or replace view clean.ventas_web_nueva as 
with prepared as (
    select
        *,
        "$path" as path,
        date_parse(substring("date", 1, length("date")-6), '%Y-%m-%dT%H:%i:%s') as "sale_date",
        TRY_CAST(REPLACE(REPLACE("total sales", '.', ''), ',','.') as double ) as "total sales parsed",
        TRY_CAST(REPLACE(REPLACE("total sales", '.', ''), ',','.') as double ) as "shipping parsed"
    from raw.ventas_web_nueva
) 
SELECT
    "path" as file,
    date_trunc('month', "sale_date") "report_date",
    "sale_date",
    TRY_CAST("Net quantity" as bigint) quantity,
    'VENTA FISICA' sale_type,
    "total sales parsed" as gross_revenue,
    "total sales parsed" - "shipping parsed" as net_revenue,
    CAST("Variant SKU" AS varchar) as product_id,
    CAST(null AS varchar) as isrc,
    'Mushroom Pillow Store Web' platform,
    'VENTAS_WEB_NUEVA' source,
    "billing country" country,
    CAST(null AS varchar) agency,
    false is_licencing,
    CAST(null AS varchar) operation_type,
    cast(null as varchar) stream_quality,
    'EUR' as source_currency
FROM prepared

--file	
--report_date -> 01-"sale_date"
--sale_date -> "Date" (Sin planchar)
--quantity -> "Net Quantity"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "Total Sales"
--net_revenue	-> "Total Sales" - "Shipping"
--product_id	-> "Variant SKU"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC)
--artist	-> XXXX (CALC) 
--platform	-> "Mushroom Pillow Store Web" matchear con plataforma_corregida
--"source"	-> VENTAS_WEB_NUEVA
--country	-> "Billing Country"
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"

-- EXCHANGE RATE = EUR


