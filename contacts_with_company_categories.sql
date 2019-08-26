SELECT 
*
FROM magazinexperts_dw.dim_contact contacts
LEFT JOIN dim_company companies ON contacts.company_id=companies.company_id
LEFT JOIN (
SELECT 
GROUP_CONCAT(category SEPARATOR ';') as 'Categories',company_id FROM dim_company_categories
GROUP BY company_id
) as company_categories on companies.company_id=company_categories.company_id

WHERE contacts.dead != '1'
AND companies.dead != '1'
LIMIT 50000
