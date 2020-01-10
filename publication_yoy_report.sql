SELECT
dim_publication.name,
#dim_issue.iss_name,
DATE_FORMAT(dim_issue.issue_cover_date, '%M') 'Month/Year',
#CONCAT("$",FORMAT(sum(sales_fact.net),2)) as 'Total Net',
CONCAT("$",FORMAT(SUM(CASE WHEN ( orders_fact.probability = 100 AND dim_issue.issue_cover_date BETWEEN "2020-01-01" AND "2020-12-31") THEN sales_fact.net ELSE 0 END),2)) AS '2020 Total Net 100%',
CONCAT("$",FORMAT(SUM(CASE WHEN ( orders_fact.probability >= 90 AND dim_issue.issue_cover_date BETWEEN "2020-01-01" AND "2020-12-31") THEN sales_fact.net ELSE 0 END),2)) AS '2020 Total Net Above 90%',
CONCAT("$",FORMAT(SUM(CASE WHEN ( orders_fact.probability >= 10 AND dim_issue.issue_cover_date BETWEEN "2020-01-01" AND "2020-12-31") THEN sales_fact.net ELSE 0 END),2)) AS '2020 Total Net Above 10%',
CONCAT("$",FORMAT(SUM(CASE WHEN ( orders_fact.probability = 100 AND dim_issue.issue_cover_date BETWEEN "2019-01-01" AND "2019-12-31") THEN sales_fact.net ELSE 0 END),2)) AS '2019 Total Net 100%',
CONCAT("$",FORMAT(SUM(CASE WHEN ( orders_fact.probability = 100 AND dim_issue.issue_cover_date BETWEEN "2018-01-01" AND "2019-12-31") THEN sales_fact.net ELSE 0 END),2)) AS '2018 Total Net 100%',
CONCAT("$",FORMAT(SUM(CASE WHEN ( orders_fact.probability = 100 AND dim_issue.issue_cover_date BETWEEN "2017-01-01" AND "2018-12-31") THEN sales_fact.net ELSE 0 END),2)) AS '2017 Total Net 100%',
#CONCAT("$",FORMAT(SUM(CASE WHEN ( orders_fact.probability = "100" AND dim_issue.issue_cover_date BETWEEN "2016-01-01" AND "2017-01-01") THEN sales_fact.net ELSE 0 END),2)) AS '2016 Total Net 100%',
#CONCAT("$",FORMAT(SUM(CASE WHEN orders_fact.probability > "90" THEN sales_fact.net ELSE 0 END),2)) AS 'Total Net > 90%',
#CONCAT("$",FORMAT(SUM(CASE WHEN orders_fact.probability > "10" THEN sales_fact.net ELSE 0 END),2)) AS 'Total Net > 10%'

CONCAT("$",FORMAT(
SUM(CASE WHEN orders_fact.probability = "100" AND dim_issue.issue_cover_date BETWEEN "2018-01-01" AND "2019-01-01" THEN sales_fact.net ELSE 0 END) - SUM(CASE WHEN ( orders_fact.probability = "100" AND dim_issue.issue_cover_date BETWEEN "2017-01-01" AND "2018-01-01") THEN sales_fact.net ELSE 0 END)
,2))
AS '100% 2018 vs 2017 Revenue By Issue +/-'

/*
dim_issue.issue_cover_date,
sales_fact.company_id,
dim_company.company_name,
orders_fact.probability,
dim_adsize.ad_size_name,
sales_fact.net
*/
FROM dim_order_item
LEFT JOIN orders_fact on dim_order_item.order_number=orders_fact.order_id
LEFT JOIN sales_fact ON dim_order_item.line_item_key=sales_fact.line_item_key
LEFT JOIN dim_issue ON sales_fact.issue_id=dim_issue.issue_id
LEFT JOIN dim_publication ON sales_fact.pub_id=dim_publication.pub_id
LEFT JOIN dim_company ON sales_fact.company_id=dim_company.company_id
JOIN dim_adsize ON sales_fact.ad_size_id=dim_adsize.ad_size_id
where orders_fact.dead = 0
AND sales_fact.dead = 0
AND dim_order_item.dead = 0
AND dim_issue.issue_cover_date BETWEEN "2016-01-01" AND "2020-12-31"
#and orders_fact.probability = '100'
#AND dim_publication.name = "Construction Executive"
group by dim_publication.name, DATE_FORMAT(dim_issue.issue_cover_date, '%m') #WITH ROLLUP
ORDER BY dim_publication.type DESC, dim_publication.name ASC, DATE_FORMAT(dim_issue.issue_cover_date, '%m') ASC
