--create database if not exists derived
create view derived.error_list AS

with

select 
    error, 
    source, 
    count(*) as amount_of_records, 
    round(sum(net_revenue), 2) as net_revenue 

from derived.sales
cross join UNNEST(errors) as t(error) 
group by error, source 
order by net_revenue desc