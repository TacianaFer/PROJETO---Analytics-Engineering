with source_calendar as (
    select * from {{ source('airbnb_data_bronze', 'calendar_bronze') }}
),

final_calendar as (
    select
        listing_id,
        date,
        case 
            when available = 't' then true 
            else false 
        end as available,
        extract(month from date) as month
    from source_calendar
)

select * from final_calendar
