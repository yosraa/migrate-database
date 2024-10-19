with uber_request as
(
	select *,distance_to_travel / monetary_cost  as distance_per_dollar
	from uber_request_logs
)
,uber_request_moth as
(
	 select *, to_char(CAST(request_date AS date),'YYYY-MM') as added_month
from uber_request
), uber_request_date as(
	select * ,  avg(distance_per_dollar )over (PARTITION BY added_month) as distance_per_dollar_per_month
	from uber_request_moth
), distance as(
	select *, ROUND(abs(distance_per_dollar - distance_per_dollar_per_month):: NUMERIC,2) as res
from uber_request_date

)
select distinct (added_month), res
from distance
