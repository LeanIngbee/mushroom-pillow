--select * from derived.profit_and_losses
--create database if not exists derived
create or replace view derived.profit_and_losses as 

with

ppb as (
     select 
          date_format(report_date, '%Y') as year,
          sum(gross_revenue_eur) as amount,
          'Direct Catalog' as concept,
          'PP&B' as detail,
          '1.1.1' as ordering

     from derived.sales_consolidated
     where sale_type = 'COMUNICACION_PUBLICA' and not is_licencing
     group by 1
),

synchronizations as (
     select 
          date_format(report_date, '%Y') as year,
          sum(gross_revenue_eur) as amount,
          'Direct Catalog' as concept,
          'Synchronizations' as detail,
          '1.1.4' as ordering

     from derived.sales_consolidated
     where sale_type in ('SINCRONIZACIÓN PUBLISHING', 'SINCRONIZACIÓN MASTER', 'Sincronizaciones') --and not is_licencing
     group by 1
),

digital_sales as (
     select 
          date_format(report_date, '%Y') as year,
          sum(gross_revenue_eur) as amount,
          'Direct Catalog' as concept,
          'Digital Sales' as detail,
          '1.1.5' as ordering

     from derived.sales_consolidated
     where sale_type in ('VENTA DIGITAL', 'Ventas Digitales') and not is_licencing
     group by 1
),

physical_sales as (
     select 
          date_format(report_date, '%Y') as year,
          sum(gross_revenue_eur) as amount,
          'Direct Catalog' as concept,
          'Physical Sales' as detail,
          '1.1.6' as ordering

     from derived.sales_consolidated
     where sale_type in ('VENTA FISICA') and not is_licencing
     group by 1
),

direct_catalog as (
     select 
          year,
          sum(amount) as amount,
          'Direct Catalog' as concept,
          'Direct Catalog' as detail,
          '1.1' as ordering

     from (
          select * from ppb
          union all
          select * from synchronizations
          union all
          select * from digital_sales
          union all
          select * from physical_sales
     )
     group by 1
),

licenced_catalog as (
     select 
          date_format(report_date, '%Y') as year,
          sum(gross_revenue_eur) as amount,
          'Licenced Catalog' as concept,
          'Licenced Catalog' as detail,
          '1.2' as ordering

     from derived.sales_consolidated
     where is_licencing
     group by 1
),

income as (
     select
          year,
          sum(amount) as amount,
          'Ingresos' as concept,
          'Ingresos' as detail,
          '1' as ordering

     from (
          select * from direct_catalog
          union all
          select * from licenced_catalog
     )
     group by 1
),

direct_cost as (
     select 
          substring(invoice_period_start, 1, 4) as year,
          sum(royalties_eur) as amount,
          'Direct Cost' as concept,
          'Direct Cost' as detail,
          '2' as ordering

     from derived.royalties
     group by 1
),

gross_margin as (
     select 
          year,
          sum(amount) as amount,
          'Gross Margin' as concept,
          'Gross Margin' as detail,
          '3' as ordering

     from (
          select year, amount from income
          union all
          select year, - amount from direct_cost
     )
     group by 1
),

structure as (
     select
          year,
          sum(cost) as amount,
          'Structure & Distribution' as concept,	
          'Structure' as detail,
          '4.1.1' as ordering

     from clean.pagos_y_cobros
     where subcategory = 'Administración'
     group by 1
),

distribution as (
    select 
        date_format(report_date, '%Y') as year,
        sum(gross_revenue) - sum(net_revenue) as amount,
        'Structure & Distribution' as concept,
		'Distribution' as detail,
		'4.1.3' as ordering
        
    from derived.sales_consolidated
    where sale_type = 'COMUNICACION_PUBLICA'
       or sale_type in ('SINCRONIZACIÓN PUBLISHING', 'SINCRONIZACIÓN MASTER', 'Sincronizaciones')
       or sale_type in ('VENTA DIGITAL', 'Ventas Digitales')
       or sale_type in ('VENTA FISICA')
       or is_licencing = true
    group by 1
),

structure_and_distribution as (
     select
          year,
          sum(amount) as amount,
		  'Structure & Distribution' as concept,
          'Structure & Distribution' as detail,
          '4.1' as ordering
    
     from (
          select * from structure
          union all
          select * from distribution
     )
     group by 1
),

audio_production as (
     select
          year,
          sum(cost) as amount,
          'Production & Promotion' as concept,
          'Producción Audio' as detail,
          '4.2.1' as ordering

     from clean.pagos_y_cobros
     where subcategory = 'Producción Audio'
     group by 1
),

video_production as (
     select
          year,
          sum(cost) as amount,
          'Production & Promotion' as concept,
          'Producción Visual' as detail,
          '4.2.2' as ordering

     from clean.pagos_y_cobros
     where subcategory = 'Producción Visual'
     group by 1
),

others_production as (
     select
          year,
          sum(cost) as amount,
          'Production & Promotion' as concept,
          'Otros producción' as detail,
          '4.2.3' as ordering

     from clean.pagos_y_cobros
     where subcategory = 'Otros producción'
     group by 1
),

physical_fabrication as (
     select
          year,
          sum(cost) as amount,
          'Production & Promotion' as concept,
          'Fabricación Física' as detail,
          '4.2.4' as ordering

     from clean.pagos_y_cobros
     where category = 'Fabricación Física'
     group by 1
),

promotion as (
     select
          year,
          sum(cost) as amount,
          'Production & Promotion' as concept,
          'Promoción' as detail,
          '4.2.5' as ordering

     from clean.pagos_y_cobros
     where category = 'Promoción'
     group by 1
),

others as (
     select
          year,
          sum(cost) as amount,
          'Production & Promotion' as concept,
          'Others' as detail,
          '4.2.6' as ordering

     from clean.pagos_y_cobros
     where category = 'Others'
     group by 1
),

production_and_promotion as (
     select
          year,
          sum(amount) as amount,
          'Production & Promotion' as concept,
          'Production & Promotion' as detail,
          '4.2' as ordering

     from (
          select * from audio_production
          union all
          select * from video_production
          union all
          select * from others_production
          union all
          select * from physical_fabrication
          union all
          select * from promotion
          union all
          select * from others
     )
     group by 1
),

operation_costs as (
     select
          year,
          sum(amount) as amount,
          'Operations Cost' as concept,
          'Operations Cost' as detail,
          '4' as ordering

     from (
          select * from structure_and_distribution
          union all
          select * from production_and_promotion
     )
     group by 1
),

ebitda as (
     select 
          year,
          sum(amount) as amount,
          'EBITDA' as concept,
          'EBITDA' as detail,
          '5' as ordering

     from (
          select year, amount from gross_margin
          union all
          select year, - amount from operation_costs
     )
     group by 1
),

ebt as (
     select 
          year,
          sum(amount) as amount,
          'EBT' as concept,
          'EBT' as detail,
          '7' as ordering

     from (
          select year, amount from ebitda
          --union all
          --select year, - amount from operation_costs
     )
     group by 1
),

tax as (
     select 
          year,
          0.25 * amount as amount,
          'Tax' as concept, 
          'Tax' as detail,
          '8' as ordering

     from ebt
),

net_profit as (
     select 
          year,
          sum(amount) as amount,
          'Net Profit' as concept,
          'Net Profit' as detail,
          '9' as ordering

     from (
          select year, amount from ebt
          union all
          select year, - amount from tax
     )
     group by 1
),

catalog_purchase as (
     select
          year,
          sum(cost) as amount,
          'Compra Catalogo' as concept,
          'Compra Catalogo' as detail,
          '9.1' as ordering

     from clean.pagos_y_cobros
     where category = 'Compra catálogo'
     group by 1
),

investments as (
     select * from catalog_purchase
)

select substr(ordering, 1, 1) as concept_ordering, ordering as detail_ordering, concept, detail, year, amount 
from (
	select * from ppb
	union all
	select * from synchronizations
	union all
	select * from digital_sales
	union all
	select * from physical_sales
	union all
	select * from direct_catalog
	union all
	select * from licenced_catalog
	union all
	select * from income
	union all
	select * from direct_cost
	union all
	select * from gross_margin
	union all
	select * from structure
	union all
	select * from distribution
	union all
	select * from structure_and_distribution
	union all
	select * from audio_production
	union all
	select * from video_production
	union all
	select * from others_production
	union all
	select * from physical_fabrication
	union all
	select * from promotion
	union all
	select * from others
	union all
	select * from production_and_promotion
	union all
	select * from operation_costs
	union all
	select * from ebitda
	union all
	select * from ebt
	union all
	select * from tax
	union all
	select * from net_profit
	union all
	select * from catalog_purchase
	union all
	select * from investments
)
order by year desc, ordering