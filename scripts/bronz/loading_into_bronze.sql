create or alter procedure bronze.load_into_bronz as
begin
	Truncate table bronze.crm_cust_info ; 
	bulk insert bronze.crm_cust_info
	from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_crm\cust_info.csv"
	with(
		firstrow = 2,
		FIELDTERMINATOR  = ',',
		tablock 
	);
 

	Truncate table bronze.crm_prd_info ; 
	bulk insert bronze.crm_prd_info
	from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_crm\prd_info.csv"
	with(
		firstrow = 2,
		FIELDTERMINATOR  = ',',
		tablock 
	);


	Truncate table bronze.crm_sales_details ; 
	bulk insert bronze.crm_sales_details
	from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_crm\sales_details.csv"
	with(
		firstrow = 2,
		FIELDTERMINATOR  = ',',
		tablock 
	);


	Truncate table bronze.erp_CUST_AZ12 ; 
	bulk insert bronze.erp_CUST_AZ12
	from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_erp\CUST_AZ12.csv"
	with(
		firstrow = 2,
		FIELDTERMINATOR  = ',',
		tablock 
	);



	Truncate table bronze.erp_LOC_A101 ; 
	bulk insert bronze.erp_LOC_A101
	from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_erp\LOC_A101.csv"
	with(
		firstrow = 2,
		FIELDTERMINATOR  = ',',
		tablock 
	);



	Truncate table bronze.erp_PX_CAT_G1V2 ; 
	bulk insert bronze.erp_PX_CAT_G1V2
	from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_erp\PX_CAT_G1V2.csv"
	with(
		firstrow = 2,
		FIELDTERMINATOR  = ',',
		tablock 
	);
end

exec  bronze.load_into_bronz ;