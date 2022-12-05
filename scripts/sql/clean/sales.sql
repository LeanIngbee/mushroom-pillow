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
union all
SELECT * from clean.altafonte_ventas_fisicas
union all
SELECT * from clean.gran_sol
union all
SELECT * from clean.la_cupula
union all
SELECT * from clean.ventas_a_tiendas_directas
union all
SELECT * from clean.ventas_web_antigua
union all
SELECT * from clean.ventas_web_nueva
union all
SELECT * from clean.ventas_web_vieja
union all
SELECT * from clean.kobalt
union all
SELECT * from clean.syncros