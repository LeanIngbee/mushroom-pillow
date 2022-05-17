--create database if not exists clean
create or replace view clean.valid_isrc_product_id_pair_temp as 

select distinct 
    isrc, 
    product_id, 
    max_by(is_default, priority) over (partition by isrc) and product_id = max_by(product_id, priority) over (partition by isrc) as is_default, 
    max(priority) over (partition by isrc) = 4 and max(priority) over (partition by product_id) = 4 as is_single

from (
    select max(isrc) as isrc, 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') as product_id, true as is_default, 4 as priority from raw.audio where tipo = 'Single' group by 2
    union
    select distinct isrc, 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') as product_id, true as is_default, 3 as priority from raw.product_id_mapping where isrc is not null and isrc != '' and product_id is not null and product_id != ''
    union
    select distinct isrc, 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') as product_id, true as is_default, 2 as priority from raw.video where isrc is not null and isrc != '' and product_id is not null and product_id != ''
    union
    select distinct isrc, 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') as product_id, substr(isrc, -5, 3) = substr(product_id, -3, 3) as is_default, 1 as priority from raw.audio where isrc is not null and isrc != '' and product_id is not null and product_id != ''
)
where product_id != 'MP000'