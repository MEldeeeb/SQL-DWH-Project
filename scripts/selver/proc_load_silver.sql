

truncate table silver.crm_cust_info
insert into silver.crm_cust_info(
	cst_id ,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
select 
	cst_id,
	trim(cst_key) as cst_key,
	trim(cst_firstname) as cst_firstname ,
	trim(cst_lastname) as cst_lastname ,
	case 
		when trim(upper(cst_marital_status)) = 'M' then 'Married'
		when trim(upper(cst_marital_status)) = 'S' then 'Single'
		else 'n/a'
	end as cst_marital_status,
	case 
	when trim(upper (cst_gndr)) = 'F' then 'Female'
	when trim(upper (cst_gndr)) = 'M' then 'Male'
	else 'n/a'
	end as cst_gndr,
	cst_create_date
from (
	select 
		* ,
		row_number () over (partition by cst_id order by cst_create_date desc ) as flag_latest
		from bronze.crm_cust_info
		where cst_id is not null 
		) t 
where flag_latest = 1;
-----------------------------------------------------------------------------
INSERT INTO silver.crm_prd_info (
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
SELECT
	prd_id,
	REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, 
	SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,        
	trim(prd_nm) as prd_nm,
	ISNULL(prd_cost, 0) AS prd_cost,
	CASE 
		WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
		WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
		WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		ELSE 'n/a'
	END AS prd_line, 
	prd_start_dt,
	prd_end_dt 
FROM bronze.crm_prd_info;

-----------------------------------------------------------------------------