--create database if not exists clean
create or replace view clean.exchange_rates as 
select
 date_parse(date, '%Y-%m-%d') as "date",
 base, target, cast(rate as double) as rate
from raw.exchange_rates
