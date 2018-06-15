SELECT iss_name, `Issue Net` FROM (
SELECT
ad_sales.iss_name,
dim_issue.report_date,
CONCAT("$", FORMAT(sum(net), 2)) as 'Issue Net'
FROM ad_sales
left JOIN dim_issue on ad_sales.iss_name=dim_issue.iss_name
where pub_name = 'YOUR PUBLICATION NAME HERE'
#limited to current year, comment out for all
AND dim_issue.report_date  BETWEEN DATE_FORMAT(NOW(), '%Y-01-01 00:00:00') AND DATE_FORMAT(LAST_DAY(NOW()), '%Y-12-31 23:59:59')
# Probability can be = '100' or ='90' or > '90'
AND probability = '100'
group by ad_sales.iss_name
WITH ROLLUP
) t
ORDER BY -t.iss_name DESC, t.report_date ASC
