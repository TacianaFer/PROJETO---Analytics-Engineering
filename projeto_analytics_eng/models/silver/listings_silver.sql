with source_listings as (
    select * from {{ source('airbnb_data_bronze', 'listings_bronze') }}
),

final_listings as (
    select
        id as listing_id,
        host_id,
        price,
        property_type,
        COALESCE(review_scores_rating, 0) as review_scores_rating
    from
        source_listings
)

select * from final_listings
