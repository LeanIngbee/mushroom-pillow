--create database if not exists clean
create or replace view clean.universal_francia as

select 
    "$path" as file,
    date_parse(element_at(split(nullif("Sales Period", ''), '-'), 1),'%Y%m') as report_date,
    date_parse(element_at(split(nullif("Sales Period", ''), '-'), 1),'%Y%m') as sale_date,
    try_cast(try_cast("Units" as double) as bigint) as quantity, 
    'VENTA DIGITAL' as sale_type,
    try_cast("Accounting Price" as double) as gross_revenue,
    try_cast("Royalty Amount" as double) as net_revenue,
    cast(null as varchar) as product_id,
    nullif("Product Number", '') as isrc,
    nullif(lower("Distributor"), '') as platform,
    'UNIVERSAL_FRANCIA' as source,
    coalesce(nullif(lower("Country"), ''), 'Unknown') as country,
    cast(null as varchar) as agency,
    false as is_licencing,
    COALESCE(nullif(lower("Sales Type"), ''), 'Other') as operation_type,
    nullif(lower("Sales Type"), '') as stream_quality,
    'EUR' as source_currency,
    cast("Artist Name" as varchar) as artist,
    cast(null as varchar) as album,
    nullif("Title", '') as song

from raw.universal_francia