with calendar as (
    select * from {{ ref('calendar_silver') }}
),

occupancy_rate as (
    select
        month,
        (1 - avg(case when available then 1 else 0 end)) * 100 as occupancy_rate
    from 
        calendar
    group by 
        month
)

select * from occupancy_rate
