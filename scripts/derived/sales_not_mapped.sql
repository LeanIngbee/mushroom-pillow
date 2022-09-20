create or replace view derived.sales_not_mapped as 

with

unmapped_isrcs_counts as (
    select 
        isrc as value, artist, album, song, source,
        element_at(split(file, '/'), -1) as file, count() as rows, sum(net_revenue) as revenue
        
    from derived.sales_consolidated
    where errors like '%INVALID_ISRC%'
    group by 1, 2, 3, 4, 5, 6
),

unmapped_isrcs_file_examples as (
    select value, artist, album, song, source, sum(rows) as rows, sum(revenue) as revenue, 
    array_join(array_agg(file order by revenue desc), ', ') as file_examples
    from unmapped_isrcs_counts
    group by 1, 2, 3, 4, 5
),

unmapped_product_ids_counts as (
    select 
        product_id as value, artist, album, song, source,
        element_at(split(file, '/'), -1) as file, count() as rows, sum(net_revenue) as revenue
        
    from derived.sales_consolidated
    where errors like '%INVALID_PRODUCT_ID%'
    group by 1, 2, 3, 4, 5, 6
),

unmapped_product_ids_file_examples as (
    select value, artist, album, song, source, sum(rows) as rows, sum(revenue) as revenue, 
    array_join(array_agg(file order by revenue desc), ', ') as file_examples
    from unmapped_product_ids_counts
    group by 1, 2, 3, 4, 5
)

select * from (
    (
        select
            'ISRC' as field,
            value,
            source,
            max_by(artist, rows) as suggested_artist,
            max_by(album, rows) as suggested_album,
            max_by(song, rows) as suggested_song,
            sum(rows) as rows,
            sum(revenue) as revenue,
            max(file_examples) as file_examples
            
        from unmapped_isrcs_file_examples
        group by 1, 2, 3
        order by 8 desc
    )
    union all
    (
        select
            'product_id' as field,
            value,
            source,
            max_by(artist, rows) as suggested_artist,
            max_by(album, rows) as suggested_album,
            max_by(song, rows) as suggested_song,
            sum(rows) as rows,
            sum(revenue) as revenue,
            max(file_examples) as file_examples
            
        from unmapped_product_ids_file_examples
        group by 1, 2, 3
        order by 8 desc
    )
)
order by revenue desc