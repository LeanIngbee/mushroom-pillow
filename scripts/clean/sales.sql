--create database if not exists clean
create or replace view clean.sales as 

select * from clean.ingrooves
union all
select * from clean.believe