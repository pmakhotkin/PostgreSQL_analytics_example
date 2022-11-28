SELECT itemid
From
(SELECT distinct itemid,
Sum(price) over (partition by itemid) As "sum_price"
FROM statistic_view
where date_part('year',date) = date_part('year',CURRENT_DATE)) as "subselect"
Order by sum_price Desc Limit 1