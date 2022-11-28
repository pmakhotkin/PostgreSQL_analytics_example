SELECT distinct itemid,sum_price, 
sum_price/sum(sum_price) over ()::decimal As "ratio"
From
(SELECT distinct itemid,
Sum(price) over (partition by itemid) As "sum_price"
FROM statistic_view) as "subselect"
group by itemid,sum_price
Order by sum_price Desc Limit 3