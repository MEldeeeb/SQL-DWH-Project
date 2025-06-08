
-- ===============================================================================
-- DDL Script: Create Gold Views
-- ===============================================================================

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================

if OBJECT_ID(' gold.dim_customer','V') is not null
	drop view  gold.dim_customer
go

create or alter view gold.dim_customer as 
select 
	row_number() over(order by ci.cst_id) as customer_key,
	ci.cst_id as customer_id,
	ci.cst_key as customer_num,
	ci.cst_firstname as first_name,
	ci.cst_lastname as last_name,
	cl.CNTRY as cuntry ,
	case 
		when ci.cst_gndr = 'n/a' then COALESCE(ca.GEN,'n/a')
		else ci.cst_gndr
	end as gender,
	ci.cst_marital_status as marital_status,
	ca.BDATE as birthdate,
	ci.cst_create_date as create_date
from 
	silver.crm_cust_info ci
left join 
	silver.erp_CUST_AZ12 ca  on ci.cst_key = ca.CID 
left join 
	silver.erp_LOC_A101 cl on  ci.cst_key = cl.CID ;
go

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
if OBJECT_ID('gold.dim_product','V') is not null
	drop view gold.dim_product 
go 

create or alter view gold.dim_product as  
select 
	ROW_NUMBER() over (order by pi.prd_key,pi.prd_start_dt) as product_key , 
	pi.prd_id as product_id,
	pi.cat_id as catigory_id,
	pi.prd_key as product_num,
	pi.prd_nm as product_name,
	ci.CAT as catigory,
	ci.SUBCAT as sup_catigory,
	ci.MAINTENANCE  as maintenance,
	pi.prd_cost as product_cost,
	pi.prd_line as product_line,
	pi.prd_start_dt as start_date
from 
	silver.crm_prd_info pi
left join 
	silver.erp_PX_CAT_G1V2 ci 
on pi.cat_id = ci.ID
where pi.prd_end_dt is null;
go

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
if OBJECT_ID('gold.fact_sales','V')is not null
	drop view gold.fact_sales ; 
go

create or alter view gold.fact_sales as 
SELECT 
	sd.sls_ord_num as order_number,
	pi.product_key as product_key,
	ci.customer_key as customer_key,  
	sd.sls_order_dt as order_date,
	sd.sls_ship_dt as shipping_date,
	sd.sls_due_dt as due_date,
	sd.sls_sales as sales_date,
	sd.sls_quantity as quantity ,
	sd.sls_price as total_price
FROM 
	silver.crm_sales_details sd
left join 
	gold.dim_product pi 
on sd.sls_prd_key = pi.product_num
left join 
	gold.dim_customer ci on sd.sls_cust_id = ci.customer_id;
go