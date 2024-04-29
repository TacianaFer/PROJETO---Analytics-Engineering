with source_reviews as (
    select * from {{ source('airbnb_data_bronze', 'reviews_bronze') }}
),

final as (
    select
        id as review_id,
        listing_id,
        date,
        COALESCE(comments, 'Sem comentários') as comments
    from source_reviews
)

select * from final
