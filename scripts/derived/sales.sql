--create database if not exists derived
create or replace view derived.sales as 

select 
  file,
  report_date,
  sale_date,
  quantity, 
  sale_type,
  gross_revenue,
  net_revenue,
  coalesce(f.product_id, a.product_id) as product_id,
  coalesce(c.isrc, a.isrc) as isrc,
  song,
  album,
  artist,
  coalesce(g.platform_std, a.platform) as platform,
  source,
  coalesce(h.iso_code, a.country) as country,
  h.continent,
  agency,
  false as is_licencing,
  coalesce(i.operation_type_std, a.operation_type) as operation_type,
  stream_quality,
  filter(array[
    case when report_date is null then 'INVALID_REPORT_DATE' end,
    case when sale_date is null then 'INVALID_SALE_DATE' end,
    case when quantity is null then 'INVALID_QUANTITY' end,
    case when gross_revenue is null then 'INVALID_GROSS_REVENUE' end,
    case when net_revenue is null then 'INVALID_NEW_REVENUE' end,
    case when a.product_id is not null and d.product_id is null then 'INVALID_SOURCE_PRODUCT_ID' end,
    case when a.product_id is null and e.product_id is null then 'MISSING_SOURCE_PRODUCT_ID' end,
    case when a.isrc is null then 'MISSING_ISRC' 
         when c.isrc is null and b.isrc_std is not null then 'INVALID_CORRECTED_ISRC' 
         when c.isrc is null and b.isrc_std is null then 'INVALID_SOURCE_ISRC' 
         when a.product_id is not null and d.product_id is not null and f.product_id is null then 'PRODUCT_ID_NOT_MAPPED'
     end,
    case when a.platform is null or g.platform_std is null then 'PLATFORM_NOT_MAPPED' end,
    case when a.country is null or h.iso_code is null then 'COUNTRY_NOT_MAPPED' end,
    case when i.operation_type_std is null then 'OPERATION_TYPE_NOT_MAPPED' end
  ], x -> x is not null) as errors

from clean.sales a
left join clean.isrc_mapping b on a.isrc = b.isrc
left join clean.valid_isrcs c on c.isrc = coalesce(b.isrc_std, a.isrc)
left join clean.valid_product_ids d on d.product_id = a.product_id
left join clean.valid_isrc_product_id_pair e on a.product_id is null and e.isrc = coalesce(b.isrc_std, a.isrc) and e.is_default
left join clean.valid_isrc_product_id_pair f on f.isrc = c.isrc and f.product_id = coalesce(d.product_id, e.product_id)
left join clean.platform_mapping g on lower(a.platform) = g.platform
left join clean.country_mapping h on lower(a.country) = h.country
left join clean.operation_type_mapping i on lower(a.operation_type) = i.operation_type
left join clean.song_information j on j.isrc = c.isrc and j.product_id = f.product_id
