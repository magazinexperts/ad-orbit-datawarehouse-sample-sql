
SET @start_date = '2018-01-01'; #start of month
SET @end_date = '2019-12-31'; #end of month
SELECT *
FROM dim_order_item 
LEFT JOIN orders_fact ON dim_order_item.order_number=orders_fact.order_id
LEFT JOIN dim_company ON orders_fact.company_id=dim_company.company_id
LEFT JOIN sales_fact ON dim_order_item.line_item_key=sales_fact.line_item_key
LEFT JOIN ad_tickets_fact ON sales_fact.line_item_key=ad_tickets_fact.line_item_key
LEFT JOIN dim_adsize ON sales_fact.ad_size_id=dim_adsize.ad_size_id
LEFT JOIN dim_issue ON sales_fact.issue_id=dim_issue.issue_id
LEFT JOIN dim_publication ON sales_fact.pub_id=dim_publication.pub_id
LEFT JOIN dim_ticket_status ON ad_tickets_fact.last_status_id=dim_ticket_status.status_id
LEFT JOIN dim_section ON sales_fact.section_id=dim_section.section_id
WHERE dim_order_item.dead = 0
AND orders_fact.dead = 0
AND dim_publication.dead = 0
AND orders_fact.probability = 100
AND sales_fact.probability = 100
#uncomment the next line to exclude free items
#AND sales_fact.net > 0 
AND dim_issue.report_date BETWEEN @start_date AND @end_date
