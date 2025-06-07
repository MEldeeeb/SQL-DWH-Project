

IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
	drop table silver.crm_cust_info ; 
go
create table silver.crm_cust_info(
	cst_id int ,
	cst_key nvarchar(50) ,
	cst_firstname nvarchar(50) ,
	cst_lastname nvarchar(50) ,
	cst_marital_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date date ,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
go


----------------------------------------------------------
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
	drop table silver.crm_prd_info ; 
go
CREATE TABLE silver.crm_prd_info (
    prd_id          INT,
    cat_id          NVARCHAR(50),
    prd_key         NVARCHAR(50),
    prd_nm          NVARCHAR(50),
    prd_cost        INT,
    prd_line        NVARCHAR(50),
    prd_start_dt    DATE,
    prd_end_dt      DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
go


----------------------------------------------------------
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
	drop table silver.crm_prd_info ; 
go
create table silver.crm_prd_info(
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt date,
	sls_ship_dt date,
	sls_due_dt date,
	sls_sales int,
	sls_quantity int,
	sls_price int,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
go 


----------------------------------------------------------
IF OBJECT_ID('silver.erp_CUST_AZ12', 'U') IS NOT NULL
	drop table silver.erp_CUST_AZ12 ; 
go
create table silver.erp_CUST_AZ12(
	CID nvarchar(50),
	BDATE date,
	GEN nvarchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
go 


----------------------------------------------------------
IF OBJECT_ID('silver.erp_LOC_A101', 'U') IS NOT NULL
	drop table silver.erp_LOC_A101 ; 
go

create table silver.erp_LOC_A101(
	CID nvarchar(50),
	CNTRY nvarchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
go


----------------------------------------------------------
IF OBJECT_ID('silver.erp_PX_CAT_G1V2', 'U') IS NOT NULL
	drop table silver.erp_PX_CAT_G1V2 ; 
go

create table silver.erp_PX_CAT_G1V2(
	ID nvarchar(50),
	CAT nvarchar(50),
	SUBCAT nvarchar(50),
	MAINTENANCE nvarchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
go