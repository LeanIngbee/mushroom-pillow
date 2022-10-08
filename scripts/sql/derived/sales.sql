--create database if not exists derived
create or replace view derived.sales as 

select 
  file,
  report_date,
  sale_date,
  quantity, 
  sale_type,
  source_currency,
  gross_revenue,
  net_revenue,
  gross_revenue * (case when source_currency = 'EUR' then 1 else cast(1. / rate as double) end) as gross_revenue_eur,
  net_revenue * (case when source_currency = 'EUR' then 1 else cast(1. / rate as double) end) as net_revenue_eur,
  coalesce(f.product_id, d.product_id, a.product_id) as product_id,
  coalesce(f.isrc, c.isrc, a.isrc) as isrc,
  coalesce(j.song, a.song) as song,
  coalesce(j.album, a.album) as album,
  coalesce(j.artist, a.artist) as artist,
  coalesce(g.platform_std, a.platform) as platform,
  source,
  coalesce(h.iso_code, a.country) as country,
  h.continent,
  agency,
  is_licencing,
  coalesce(l.product_type, i.operation_type_std, a.operation_type) as operation_type,
  stream_quality,
  filter(array[
    case when report_date is null then 'INVALID_REPORT_DATE' end,
    case when sale_date is null then 'INVALID_SALE_DATE' end,
    case when quantity is null then 'INVALID_QUANTITY' end,
    case when gross_revenue is null then 'INVALID_GROSS_REVENUE' end,
    case when net_revenue is null then 'INVALID_NEW_REVENUE' end,
    case when coalesce(f.isrc, c.isrc, a.isrc) is null then 'MISSING_ISRC'
         when coalesce(f.isrc, c.isrc) is null then 'INVALID_ISRC'
     end,
    case when coalesce(f.product_id, d.product_id, a.product_id) is null then 'MISSING_PRODUCT_ID'
         when coalesce(f.product_id, d.product_id) is null then 'INVALID_PRODUCT_ID'
     end,
    case when f.isrc is null 
          and (coalesce(f.product_id, d.product_id, a.product_id) is not null and 
               coalesce(f.isrc, c.isrc, a.isrc) is not null)
         then 'INVALID_ISRC_PRODUCT_ID_PAIR' end,
    case when a.platform is null or g.platform_std is null then 'PLATFORM_NOT_MAPPED' end,
    case when a.country is null or h.iso_code is null then 'COUNTRY_NOT_MAPPED' end,
    case when l.product_type is null and i.operation_type_std is null then 'OPERATION_TYPE_NOT_MAPPED' end
  ], x -> x is not null) as errors

from clean.sales a
left join clean.isrc_mapping b on a.isrc = b.isrc
left join clean.valid_isrcs c on c.isrc = coalesce(b.isrc_std, a.isrc)
left join clean.valid_product_ids d on d.product_id = a.product_id

-- This join aims to 1) Fetch the default product_id for the isrc if no valid product_id was given.
--                   2) Fetch the single isrc for the product_id if no valid isrc was given and the album is a single.
left join clean.valid_isrc_product_id_pair e on (d.product_id is null and e.isrc = c.isrc and e.is_default) -- Matches default mappings for an isrc.
                                                   or (c.isrc is null and e.product_id = d.product_id and e.is_single)  -- Matches singles for a product_id.

-- This join is to unify the (product_id, isrc) pair preferring the one formed from the valid product_id and the valid isrc give
-- or falling back to the pair given by the previous join.
left join clean.valid_isrc_product_id_pair f on f.isrc = coalesce(c.isrc, e.isrc) and f.product_id = coalesce(d.product_id, e.product_id)

left join clean.platform_mapping g on lower(a.platform) = g.platform
left join clean.country_mapping h on lower(a.country) = h.country
left join clean.operation_type_mapping i on lower(a.operation_type) = i.operation_type

left join clean.media_information j on (j.isrc = f.isrc and j.product_id = f.product_id) -- Usual match of the (product_id, isrc) pair. This is the happy path.
                                          or (f.isrc is null and c.isrc is null and j.isrc is null and j.product_id = d.product_id)
                                          or (f.isrc is null and d.product_id is null and j.product_id is null and j.isrc = c.isrc)

left join clean.exchange_rates k on k.date = a.report_date and a.source_currency = k.target

left join clean.product_types l on l.product_id = coalesce(f.product_id, d.product_id, a.product_id)