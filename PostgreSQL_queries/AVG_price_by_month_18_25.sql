SELECT
(sum(price)/((max(date) - min(date))/30))/ count(distinct userid) as "AVG_BY_MONTH"
from statistic_view
where age >= 18 and age <=25