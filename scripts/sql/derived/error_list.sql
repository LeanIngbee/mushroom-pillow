--create database if not exists derived
create or replace view derived.error_list AS
select 
    error, 
    source, 
    count(*) as amount_of_records, 
    round(sum(net_revenue), 2) as net_revenue 

from derived.sales
cross join UNNEST(errors) as t(error) 
group by error, source 
order by net_revenue desc