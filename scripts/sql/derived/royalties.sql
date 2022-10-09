create or replace view derived.royalties as 

select 
  case when periodicity = 'anual' then date_format(date_trunc('year', report_date), '%Y-%m')
       when periodicity = 'semestral' and date_format(report_date, '%m') < '07' then date_format(date_trunc('year', report_date), '%Y-%m')
       when periodicity = 'semestral' and date_format(report_date, '%m') = '07' then date_format(date_trunc('year', report_date), '%Y-%m')
  end as invoice_period_start,
  case when periodicity = 'anual' then date_format(date_trunc('year', report_date) + interval '1' year, '%Y-%m')
       when periodicity = 'semestral' and date_format(report_date, '%m') < '07' then date_format(date_trunc('year', report_date) + interval '6' month, '%Y-%m')
       when periodicity = 'semestral' and date_format(report_date, '%m') = '07' then date_format(date_trunc('year', report_date) + interval '1' year, '%Y-%m')
  end as invoice_period_end,
  periodicity,
  contact_name,
  contact_email,
  artist,
  album,
  song,
  a.isrc,
  a.product_id,
  platform,
  country,
  operation_type,
  royalties_rate,
  sum(quantity) as quantity,
  sum(net_revenue) as net_revenue,
  sum(net_revenue * royalties_rate) as royalties

from derived.sales_consolidated a
join clean.royalties_media b on a.isrc = b.isrc and a.product_id = b.product_id
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
order by 1 desc, 2 desc, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 desc