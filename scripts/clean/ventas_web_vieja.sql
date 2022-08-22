--   `reference` string, 
--   `order_detail_id` bigint, 
--   `order_id` bigint, 
--   `source` string, 
--   `platform` string, 
--   `sale_type` string, 
--   `current_state_id` bigint, 
--   `current_state` string, 
--   `invoice_date` string, 
--   `delivery_date` string, 
--   `system_creation_date` string, 
--   `id_address_invoice` bigint, 
--   `id_address_country` bigint, 
--   `country_iso_code` string, 
--   `product_id` bigint, 
--   `product_reference` string, 
--   `id_order_detail` bigint, 
--   `id_order` bigint, 
--   `id_order_invoice` bigint, 
--   `id_warehouse` bigint, 
--   `id_shop` bigint, 
--   `product_attribute_id` bigint, 
--   `product_name` string, 
--   `product_quantity` bigint, 
--   `product_quantity_in_stock` bigint, 
--   `product_quantity_refunded` bigint, 
--   `product_quantity_return` bigint, 
--   `product_quantity_reinjected` bigint, 
--   `product_price` double, 
--   `reduction_percent` double, 
--   `reduction_amount` double, 
--   `reduction_amount_tax_incl` double, 
--   `reduction_amount_tax_excl` double, 
--   `group_reduction` double, 
--   `product_quantity_discount` double, 
--   `product_ean13` bigint, 
--   `product_upc` string, 
--   `product_supplier_reference` string, 
--   `product_weight` double, 
--   `id_tax_rules_group` bigint, 
--   `tax_computation_method` bigint, 
--   `tax_name` string, 
--   `tax_rate` bigint, 
--   `ecotax` double, 
--   `ecotax_tax_rate` bigint, 
--   `discount_quantity_applied` bigint, 
--   `download_hash` string, 
--   `download_nb` bigint, 
--   `download_deadline` string, 
--   `total_price_tax_incl` double, 
--   `total_price_tax_excl` double, 
--   `unit_price_tax_incl` double, 
--   `unit_price_tax_excl` double, 
--   `total_shipping_price_tax_incl` double, 
--   `total_shipping_price_tax_excl` double, 
--   `purchase_supplier_price` double, 
--   `original_product_price` double, 
--   `original_wholesale_price` double, 
--   `id_shop_group` bigint, 
--   `id_carrier` bigint, 
--   `id_lang` bigint, 
--   `id_customer` bigint, 
--   `id_cart` bigint, 
--   `id_currency` bigint, 
--   `id_address_delivery` bigint, 
--   `secure_key` string, 
--   `payment` string, 
--   `conversion_rate` double, 
--   `module` string, 
--   `recyclable` bigint, 
--   `gift` bigint, 
--   `gift_message` string, 
--   `mobile_theme` bigint, 
--   `shipping_number` string, 
--   `total_discounts` double, 
--   `total_discounts_tax_incl` double, 
--   `total_discounts_tax_excl` double, 
--   `total_paid` double, 
--   `total_paid_tax_incl` double, 
--   `total_paid_tax_excl` double, 
--   `total_paid_real` double, 
--   `total_products` double, 
--   `total_products_wt` double, 
--   `total_shipping` double, 
--   `total_shipping_tax_incl` double, 
--   `total_shipping_tax_excl` double, 
--   `carrier_tax_rate` double, 
--   `total_wrapping` double, 
--   `total_wrapping_tax_incl` double, 
--   `total_wrapping_tax_excl` double, 
--   `round_mode` bigint, 
--   `round_type` bigint, 
--   `invoice_number` bigint, 
--   `delivery_number` bigint, 
--   `valid` bigint, 
--   `date_add` string, 
--   `date_upd` string

create or replace view clean.ventas_web_vieja as 
with prepared as (
    select
        *,
        "$path" as path,
        date_parse("system_creation_date", '%Y-%m-%d %H:%i:%s') as "sale_date",
        TRY_CAST(REPLACE(REPLACE("total_products", '.', ''), ',','.') as double ) as "gross_revenue",
        TRY_CAST(REPLACE(REPLACE("total_paid_tax_incl", '.', ''), ',','.') as double ) as "net_revenue"
    from raw.ventas_web_vieja
    where "current_state" in ('Entregado','Enviado', 'Pago aceptado')
) 
SELECT
    "path" as file,
    date_trunc('month', "sale_date") "report_date",
    "sale_date",
    1 as quantity,
    'VENTA FISICA' sale_type,
    "total_products" as gross_revenue,
    "total_paid_tax_incl" as net_revenue,
    "product_reference" as product_id,
    CAST(null AS varchar) as isrc,
    'Mushroom Pillow Store Web' platform,
    'VENTAS_WEB_VIEJA' source,
    "country_iso_code" country,
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


