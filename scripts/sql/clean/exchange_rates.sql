--create database if not exists clean
create or replace view clean.exchange_rates as 
select
    date_parse(date, '%Y-%m-%d') as "date",
    base, 
    target, 
    min_by(cast(rate as double), date) as rate

from raw.exchange_rates
group by 1, 2, 3
