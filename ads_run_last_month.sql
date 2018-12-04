SELECT 
dim_issue.iss_name,
dim_issue.issue_id,
dim_company.company_name,
dim_adsize.ad_size_name,
orders_fact.probability,
dim_issue.issue_material_date
FROM dim_order_item
JOIN orders_fact ON dim_order_item.order_number=orders_fact.order_id
JOIN dim_company ON orders_fact.company_id=dim_company.company_id
JOIN sales_fact ON dim_order_item.line_item_key=sales_fact.line_item_key
JOIN dim_adsize ON sales_fact.ad_size_id=dim_adsize.ad_size_id
JOIN dim_issue ON sales_fact.issue_id=dim_issue.issue_id
JOIN dim_publication ON sales_fact.pub_id=dim_publication.pub_id
WHERE dim_order_item.dead = 0
AND orders_fact.dead = 0
AND sales_fact.dead = 0
AND dim_publication.dead = 0
AND dim_issue.issue_press_date BETWEEN DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 1 MONTH), '%Y-%m-%d 23:59:59')
# Fill this out!
AND dim_publication.name IN ('PUBLICATION_NAMES SEPARATED BY COMMAS')
ORDER BY dim_publication.type ASC, dim_publication.name ASC, dim_issue.issue_press_date ASC
