--create database if not exists clean
create or replace view clean.believe as 

select 
    "$path" as file,
    case when try_cast(report_date as date) is not null then try_cast(report_date as date) else date_parse(report_date, '%d/%m/%Y') end as report_date,
    case when try_cast(sale_date as date) is not null then try_cast(sale_date as date) else date_parse(sale_date, '%d/%m/%Y') end as sale_date,
    try_cast(try_cast(quantity as double) as bigint) as quantity, 
    'VENTA DIGITAL' as sale_type,
    try_cast(replace(amount, ',', '.') as double) as gross_revenue,
    try_cast(replace(net_amount, ',', '.') as double) as net_revenue,
    nullif(case when product_id is not null and product_id != '' then 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') end, '') as product_id,
    nullif(replace(isrc, '-', ''), '') as isrc,
    nullif(lower(platform), '') as platform,
    nullif('BELIEVE', '') as source,
    nullif(lower(country), '') as country,
    cast(null as varchar) as agency,
    false as is_licencing,
    nullif(lower(operation_type), '') as operation_type,
    nullif(lower(platform), '') as stream_quality

from raw.believe