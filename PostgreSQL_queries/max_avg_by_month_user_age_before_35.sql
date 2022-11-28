SELECT
distinct date_part('month',date) As "month",
AVG(price) over (partition by date_part('month',date)) as "AVG_by_Month"
FROM statistic_view
where age >=35
order by AVG(price) over (partition by date_part('month',date)) Desc
Limit 1