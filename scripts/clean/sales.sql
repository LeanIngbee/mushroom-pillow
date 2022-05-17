--create database if not exists clean
create or replace view clean.sales as 

select * from clean.ingrooves
union all
select * from clean.believe
union all
select * from clean.altafonte
union all
select * from clean.sony_discos
union all
select * from clean.delorean
union all
select * from clean.universal_suecia