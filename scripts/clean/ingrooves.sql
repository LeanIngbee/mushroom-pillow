--create database if not exists clean
create or replace view clean.ingrooves as 

select 
    "$path" as file,
    try_cast('20' || substr(trim(period), 5, 2) || '-' || substr(trim(period), 2, 2) || '-01' as date) as report_date,
    try_cast("retailer reporting period" || '-01' as date) as sale_date,
    try_cast(try_cast("quantity net" as double) as bigint) as quantity, 
    'VENTA DIGITAL' as sale_type,
    try_cast(replace("net amount", ',', '.') as double) as gross_revenue,
    try_cast(replace("amount after fees", ',', '.') as double) as net_revenue,
    nullif(case when "product / catalog #" is not null and "product / catalog #" != '' then 'MP' || lpad(try_cast(try_cast(regexp_replace("product / catalog #", '([^0-9.])', '') as bigint) as varchar), 3, '0') end, '') as product_id,
    nullif(isrc, '') as isrc,
    nullif(lower("retailer"), '') as platform,
    nullif('INGROOVES', '') as source,
    COALESCE(NULLIF(lower("territory"), ''), 'Unknown') country,
    cast(null as varchar) as agency,
    false as is_licencing,
    nullif("sales classification", '') as operation_type,
    nullif("sales description" , '') as stream_quality

from raw.ingrooves