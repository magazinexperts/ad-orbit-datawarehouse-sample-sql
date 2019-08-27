/*
Notes:
Total 100% reflects only orders at 100%;
Total Potential Cash shows the non-weighted total of all orders and forecasts
Weighted Cash shows the weighted sum of sales and orders.
*/
SELECT
dim_publication.name as 'Publication',
dim_issue.iss_name as 'Issue',
#CONCAT(dim_rep.fname, " ", dim_rep.lname) as 'RepName',
CONCAT('$',FORMAT(sum(all_sales_data.total_booked), 2 ) ) as 'Total 100%',
CONCAT('$',FORMAT(sum(all_sales_data.net), 2 ) ) as 'Total Potential Cash',
CONCAT('$',FORMAT(sum(all_sales_data.weighted_cash), 2 ) )  as 'Weighted Cash'
from (
	SELECT 
	'sales_fact' as 'source',
	rep_id,
	pub_id,
	issue_id,
	probability,
	CASE WHEN ( probability = 100 ) THEN sales_fact.net ELSE 0 END as 'total_booked',
	net,
	round(net * (probability/100),2) as 'weighted_cash'

	FROM magazinexperts_dw.sales_fact
	where dead = 0
	AND net > 0

	UNION ALL

	SELECT 
	'forecast_fact' as 'source',
	rep_id,
	pub_id,
	issue_id,
	dim_confidence.confidence_percentage as 'probability',
    0 as 'total_booked',
	ROUND(cash,2) as 'net',
    #0 as 'sold',
    #ROUND(cash,2) as 'forecast',
	ROUND(weighted_cash,2) as 'weighted_cash'
	FROM magazinexperts_dw.forecast_fact
	LEFT JOIN dim_confidence ON forecast_fact.confidence_id=dim_confidence.confidence_id
	WHERE dead = 0
    AND dim_confidence.confidence_percentage != 0
    AND cash > 0
) all_sales_data
LEFT JOIN dim_issue ON all_sales_data.issue_id=dim_issue.issue_id
LEFT JOIN dim_publication ON dim_issue.pub_id=dim_publication.pub_id
WHERE dim_publication.dead = 0
AND dim_issue.dead = 0
AND dim_issue.report_date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY dim_issue.issue_id
ORDER BY dim_publication.name, dim_issue.report_date ASC
