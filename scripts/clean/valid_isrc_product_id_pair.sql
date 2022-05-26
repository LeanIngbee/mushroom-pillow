--create database if not exists clean
create or replace view clean.valid_isrc_product_id_pair_temp as 

with

default_mappings as (
    select isrc, min('MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0')) as product_id
    from raw.product_id_mapping 
    where isrc is not null and isrc != '' and product_id is not null and product_id != ''
    group by 1
),

singles as (
    select min(isrc) as isrc, 
    'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') as product_id
    from raw.audio where tipo = 'Single' and isrc is not null and isrc != '' and product_id is not null and product_id != '' 
    group by 2
),

product_ids_with_only_one_isrc as (
    select min(isrc) as isrc, 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') as product_id
    from raw.audio 
    where isrc is not null and isrc != '' and product_id is not null and product_id != '' 
    group by 2 
    having count(distinct isrc) = 1
),

isrcs_with_only_one_product_id as (
    select isrc, min('MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0')) as product_id
    from raw.audio 
    where isrc is not null and isrc != '' and product_id is not null and product_id != '' 
    group by 1
    having count(distinct 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0')) = 1
),

videos as (
    select distinct isrc, 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') as product_id
    from raw.video 
    where isrc is not null and isrc != '' and product_id is not null and product_id != ''
),

isrcs_that_contain_the_product_id_in_the_last_digits as (
    select distinct isrc, 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') as product_id
    from raw.audio 
    where tipo != 'Single' and isrc is not null and isrc != '' and product_id is not null and product_id != ''
      and substr(isrc, -5, 3) = substr(product_id, -3, 3)
),

album_pairs_in_audio_file as (
    select distinct isrc, 'MP' || lpad(try_cast(try_cast(regexp_replace(product_id, '([^0-9.])', '') as bigint) as varchar), 3, '0') as product_id
    from raw.audio 
    where tipo != 'Single' and isrc is not null and isrc != '' and product_id is not null and product_id != ''
),

pairs as (
    select 
        isrc, 
        product_id, 
        max(priority) as priority,
        max(is_default) as is_default, 
        max(is_single) as is_single

    from (
        select *, true as is_default, false as is_single, 7 as priority from default_mappings
        union
        select *, true as is_default, true as is_single, 6 as priority from singles
        union
        select *, true as is_default, true as is_single, 5 as priority from product_ids_with_only_one_isrc
        union
        select *, true as is_default, false as is_single, 4 as priority from isrcs_with_only_one_product_id
        union
        select *, true as is_default, false as is_single, 3 as priority from videos
        union
        select *, true as is_default, false as is_single, 2 as priority from isrcs_that_contain_the_product_id_in_the_last_digits
        union
        select *, false as is_default, false as is_single, 1 as priority from album_pairs_in_audio_file
    )
    where product_id != 'MP000'
    group by 1, 2
)

select distinct
    isrc,
    product_id,
    is_single,
    -- Force only one default mapping for each isrc.
    max_by(is_default, priority) over (partition by isrc) and priority = max(priority) over (partition by isrc) as is_default,
    priority

from pairs