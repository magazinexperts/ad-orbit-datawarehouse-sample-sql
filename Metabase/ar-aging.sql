SELECT
SUM(CASE   
WHEN ( invoice_duedate > CURDATE() ) THEN cash_due
ELSE 0 END) AS 'Current',
SUM(CASE   
WHEN ( invoice_duedate = CURDATE() ) THEN cash_due
ELSE 0 END) AS 'Due Today',
SUM(CASE  
WHEN ( invoice_duedate BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND DATE_SUB(CURDATE(), INTERVAL 1 DAY) ) THEN cash_due
ELSE 0 END) AS '1-30 Days Past Due',
SUM(CASE  
WHEN ( invoice_duedate BETWEEN DATE_SUB(CURDATE(), INTERVAL 60 DAY) AND DATE_SUB(CURDATE(), INTERVAL 31 DAY) ) THEN cash_due
ELSE 0 END) AS '31-60 Days Past Due',
SUM(CASE    
WHEN ( invoice_duedate BETWEEN DATE_SUB(CURDATE(), INTERVAL 90 DAY) AND DATE_SUB(CURDATE(), INTERVAL 61 DAY) ) THEN cash_due
ELSE 0 END) AS '61-90 Days Past Due',
SUM(CASE   
WHEN ( invoice_duedate BETWEEN DATE_SUB(CURDATE(), INTERVAL 120 DAY) AND DATE_SUB(CURDATE(), INTERVAL 91 DAY) ) THEN cash_due
ELSE 0 END) AS '91-120 Days Past Due',
SUM(CASE  
WHEN ( invoice_duedate BETWEEN DATE_SUB(CURDATE(), INTERVAL 150 DAY) AND DATE_SUB(CURDATE(), INTERVAL 121 DAY) ) THEN cash_due
ELSE 0 END) AS '121-150 Days Past Due',
SUM(CASE  
WHEN ( invoice_duedate BETWEEN DATE_SUB(CURDATE(), INTERVAL 180 DAY) AND DATE_SUB(CURDATE(), INTERVAL 151 DAY) ) THEN cash_due
ELSE 0 END) AS '151-180 Days Past Due',
SUM(CASE  
WHEN ( invoice_duedate < DATE_SUB(CURDATE(), INTERVAL 181 DAY)  ) THEN cash_due
ELSE 0 END) AS '181+ Days Past Due'

FROM invoice_fact
Where cash_due > 0
