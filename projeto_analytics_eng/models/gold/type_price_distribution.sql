with listings as (
    select * from {{ ref('listings_silver') }}
),

property_price_distribution as (
    select
        property_type,
        avg(price) as average_price,
        min(price) as min_price,
        max(price) as max_price
    from
        listings
    group by
        property_type
)

select * from property_price_distribution
