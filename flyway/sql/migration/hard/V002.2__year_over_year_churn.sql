WITH drives_churned AS (
select *
from lyft_drivers
where end_date is not null
), n_churned_per_year AS (
select to_char(end_date, 'YYYY') as actually,count(*) over( partition by to_char(end_date, 'YYYY')) as n_churned
from drives_churned
), n_churned_per_previous_year AS(
select LAG(n_churned,1,0) over (order by ) as n_churned_previous
from n_churned_per_year
)
select *, CASE
WHEN  n_churned > n_churned_previous THEN "increase"
WHEN n_churned < n_churned_previous THEN "decrease"
ELSE "no_change"
END
from n_churned_per_previous_year