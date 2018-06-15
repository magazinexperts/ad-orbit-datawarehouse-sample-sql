SELECT
dim_company.company_name,
dim_service.service_name,
dim_service.category,
service_tickets_fact.ticket_details,
service_tickets_fact.contact_id,
CONCAT(dim_rep.fname, " ", dim_rep.lname) as 'Ticket Rep',
service_tickets_fact.line_item_key,
service_tickets_fact.ticket_id,
sales_fact.net,
sales_fact.probability,
sales_fact.event_date,
sales_fact.quantity,
dim_ticket_status.status_name
FROM service_tickets_fact
LEFT JOIN dim_order_item ON service_tickets_fact.line_item_key=dim_order_item.line_item_key
LEFT JOIN dim_service ON service_tickets_fact.service_id=dim_service.service_id
LEFT JOIN dim_ticket_status ON service_tickets_fact.last_status_id=dim_ticket_status.status_id
LEFT JOIN dim_rep ON service_tickets_fact.assigned_rep_id=dim_rep.rep_id
LEFT JOIN sales_fact ON service_tickets_fact.line_item_key=sales_fact.line_item_key
LEFT JOIN dim_company ON dim_order_item.company_id=dim_company.company_id
WHERE dim_order_item.dead = 0
AND dim_order_item.order_type = 'service'
AND (dim_ticket_status.status_name != 'Done' OR dim_ticket_status.status_name is null)
ORDER BY event_date ASC