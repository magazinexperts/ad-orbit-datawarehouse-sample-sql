SELECT 
coalesce((lower(contacts.email)),'') as 'Email Address',
coalesce(contacts.firstname,'') as 'First Name',
coalesce(contacts.lastname,'') as 'Last Name',
coalesce(contacts.contact_id,'') as 'Maghub Contact ID',
coalesce(companies.company_id,'') as 'Maghub Company ID',
coalesce(companies.primary_rep_name,'') as 'Primary Rep',
coalesce(contacts.lead_status,'') as 'Lead Status',
coalesce(contacts.lead_source,'') as 'Lead Source',
coalesce(substring_index(companies.primary_category," : ",1),'') as 'Primary Category',
coalesce(companies.type,'') as 'Company Role',
coalesce(companies.company_name,'') as 'Company'
#coalesce(df1.dynamic_field_value,'') as 'Dynamic Field Name' /* Clone this for each dynamic field */
#add phone
FROM dim_contact contacts
LEFT JOIN `dim_company` companies ON contacts.company_id=companies.company_id
/*
The next line is also needed for each dynamic field
*/
#LEFT JOIN dynamic_field_values_fact df1 ON contacts.contact_id=df1.dynamic_field_key_id AND df1.dynamic_field_key = 'contact_8' #Dynamic Field Name
/*replace 'default@email' with your system' default email */ 
WHERE substring_index(contacts.`email`,"@",-1) NOT IN ('default@email')
AND contacts.`dead` != '1'
LIMIT 50000