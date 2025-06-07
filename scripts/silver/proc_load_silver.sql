

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
---------------------------------------------------------------------------------------------------------------------------------------
truncate table silver.crm_prd_info
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
	cast(prd_start_dt as date) S,
	CAST( DATEADD(DAY, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) as date) as prd_end_dt 
FROM bronze.crm_prd_info;

---------------------------------------------------------------------------------------------------------------------------------------
truncate table silver.crm_sales_details
insert into silver.crm_sales_details (
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
select 
	trim(sls_ord_num) as sls_ord_num,
	trim(sls_prd_key) as sls_prd_key,
	sls_cust_id,
	case 
		when sls_order_dt = 0 or len(sls_order_dt) != 8 then null
		else cast(cast( sls_order_dt as char(8)) as date ) 
	end as sls_order_dt,

	case 
		when sls_ship_dt = 0 or len(sls_ship_dt) != 8 then null
		else cast(cast( sls_ship_dt as char(8)) as date ) 
	end as sls_ship_dt,
	case 
		when sls_due_dt = 0 or len(sls_due_dt) != 8 then null
		else cast(cast( sls_due_dt as char(8)) as date ) 
	end as sls_due_dt,
	case 
		when sls_sales <= 0 or sls_sales is null or sls_sales != sls_quantity * sls_price then sls_quantity * sls_price
		else sls_sales
	end as sls_sales,
	isnull (sls_quantity,0) as sls_quantity,
	case 
		when sls_price is null or sls_price <= 0 then sls_sales / nullif(sls_quantity,0)
		else sls_price 
	end as sls_price
from bronze.crm_sales_details
