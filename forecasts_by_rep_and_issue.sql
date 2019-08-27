SELECT
CONCAT(dim_rep.fname, " ", dim_rep.lname) as 'RepName',
dim_publication.name as 'Publication',
dim_issue.iss_name as 'Issue',
CONCAT('$',FORMAT(sum(cash), 2)) as 'Total Opportunities',
CONCAT('$',FORMAT(sum(weighted_cash), 2)) as 'Weighted Opportunities'
FROM forecast_fact
LEFT JOIN dim_issue on forecast_fact.issue_id=dim_issue.issue_id
LEFT JOIN dim_publication ON forecast_fact.pub_id=dim_publication.pub_id
LEFT JOIN dim_rep ON forecast_fact.rep_id=dim_rep.rep_id
WHERE forecast_fact.dead = 0
AND dim_issue.dead = 0
AND dim_publication.dead = 0
AND dim_issue.report_date BETWEEN '2019-01-01' AND '2019-12-31'
#AND dim_rep.dead = 0 #doesn't exist as of 2019-08-27
GROUP BY forecast_fact.rep_id, forecast_fact.issue_id
ORDER BY dim_rep.fname ASC, dim_publication.name ASC, dim_issue.report_date ASC
