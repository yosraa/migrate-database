
-- Find the number of medals earned in each category by Chinese athletes from the 2000 to 2016 summer Olympics.
-- For each medal category, calculate the number of medals for each olympic games along with the total number of medals across all years.
-- Sort records by total medals in descending order.


with types_of_medals_in_specific_years as(
select year , medal, count(*) as n_medals
from olympics_athletes_events
where medal is not null
and team = 'China'
and year in (2000, 2004, 2008, 2012, 2016)
group by 1, 2
)
select medal,
sum(case when year= 2000 then n_medals else 0 END) as medals_2000
sum(case when year= 2004 then n_medals else 0 END) as medals_2000
sum(case when year= 2008 then n_medals else 0 END) as medals_2000
sum(case when year= 2012 then n_medals else 0 END) as medals_2000
sum(case when year= 2016 then n_medals else 0 END) as medals_2000
sum(n_medals) as total_medals
from types_of_medals_in_specific_years
group by 1
order by 7 DESC