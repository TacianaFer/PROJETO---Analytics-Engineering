with source_reviews as (
    select
        review_id,
        listing_id
    from {{ ref('reviews_silver') }}
),

source_listings as (
    select
        listing_id,
        review_scores_rating,
        host_id
    from {{ ref('listings_silver') }}
),

reviews_with_ratings as (
    select
        r.review_id,
        r.listing_id,
        l.host_id,
        l.review_scores_rating
    from
        source_reviews r
    join
        source_listings l
    on
        r.listing_id = l.listing_id
),

host_reviews as (
    select
        host_id,
        count(case when review_scores_rating >= 4 then 1 else null end) as positive_reviews,
        count(case when review_scores_rating < 4 then 1 else null end) as negative_reviews
    from
        reviews_with_ratings
    group by
        host_id
)

select * from host_reviews
