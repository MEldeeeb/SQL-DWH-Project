create or alter procedure bronze.load_into_bronz as
begin
	begin try 
	
		print '===========================================================================';
		print '                        Loading Data into bronze layer                     ';
		print '===========================================================================';

	
		print '---------------------------------------------------------------------------';
		print '                           Loading CRM tables                              ';
		print '---------------------------------------------------------------------------';

		declare @start_date datetime, @end_date datetime , @patch_start datetime , @patch_end datetime 


		set @patch_start = GETDATE()
		set @start_date = GETDATE()
		print '--> Truncating table: bronze.crm_cust_info';
		Truncate table bronze.crm_cust_info ; 
		print'--> Inserting Data Into: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_crm\cust_info.csv"
		with(
			firstrow = 2,
			FIELDTERMINATOR  = ',',
			tablock 
		);
		set @end_date = GETDATE();
		print 'Loading duration: ' + cast (DATEDIFF(second,@end_date,@start_date) as nvarchar) + ' seconds';
		print'---------------------------------------------------------------------------';



		
		set @start_date = GETDATE();
		print '--> Truncating table: bronze.crm_prd_info';
		Truncate table bronze.crm_prd_info ;
		print'--> Inserting Data Into: bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_crm\prd_info.csv"
		with(
			firstrow = 2,
			FIELDTERMINATOR  = ',',
			tablock 
		);
		set @end_date = GETDATE();
		print 'Loading duration: ' + cast (DATEDIFF(second,@end_date,@start_date) as nvarchar) + ' seconds';
		print'---------------------------------------------------------------------------';



		
		set @start_date = GETDATE();
		print '--> Truncating table: bronze.crm_sales_details';
		Truncate table bronze.crm_sales_details ; 
		print'--> Inserting Data Into: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_crm\sales_details.csv"
		with(
			firstrow = 2,
			FIELDTERMINATOR  = ',',
			tablock 
		);
		set @end_date = GETDATE();
		print 'Loading duration: ' + cast (DATEDIFF(second,@end_date,@start_date) as nvarchar) + ' seconds';

		

		print'---------------------------------------------------------------------------';
		print '					       Loading ERP tables								 ';
		print'---------------------------------------------------------------------------';

		set @start_date = GETDATE();
		print '--> Truncating table: bronze.erp_CUST_AZ12';
		Truncate table bronze.erp_CUST_AZ12 ; 
		print'--> Inserting Data Into: bronze.erp_CUST_AZ12'
		bulk insert bronze.erp_CUST_AZ12
		from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_erp\CUST_AZ12.csv"
		with(
			firstrow = 2,
			FIELDTERMINATOR  = ',',
			tablock 
		);
		set @end_date = GETDATE();
		print 'Loading duration: ' + cast (DATEDIFF(second,@end_date,@start_date) as nvarchar) + ' seconds';
		print'---------------------------------------------------------------------------';



		
		set @start_date = GETDATE();
		print '--> Truncating table: bronze.erp_LOC_A101';
		Truncate table bronze.erp_LOC_A101 ; 

		print'--> Inserting Data Into: bronze.erp_LOC_A101'
		bulk insert bronze.erp_LOC_A101
		from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_erp\LOC_A101.csv"
		with(
			firstrow = 2,
			FIELDTERMINATOR  = ',',
			tablock 
		);
		set @end_date = GETDATE();
		print 'Loading duration: ' + cast (DATEDIFF(second,@end_date,@start_date) as nvarchar) + ' seconds';
		print'---------------------------------------------------------------------------';



	
		set @start_date = GETDATE();
		print '--> Truncating table: bronze.erp_PX_CAT_G1V2';
		Truncate table bronze.erp_PX_CAT_G1V2 ; 
		print'--> Inserting Data Into: bronze.erp_PX_CAT_G1V2'
		bulk insert bronze.erp_PX_CAT_G1V2
		from "D:\ITI matrial\Week_12_DWH\SQL-DWH-Project\datasets\source_erp\PX_CAT_G1V2.csv"
		with(
			firstrow = 2,
			FIELDTERMINATOR  = ',',
			tablock 
		);
		set @end_date = GETDATE()
		print 'Loading duration: ' + cast (DATEDIFF(second,@end_date,@start_date) as nvarchar) + ' seconds';
		set @patch_end = GETDATE()
		print'---------------------------------------------------------------------------';
		print 'Total Loading duration to load all data in bronze layer: ' + cast (DATEDIFF(second,@patch_end,@patch_start) as nvarchar) + ' seconds';
		print'---------------------------------------------------------------------------';
	

	end try 
	begin catch 
		print '===========================================================================';
		print '                  Error occured during loading bronze layer               ' ;
		print 'ERROR MESSAGE' + ERROR_MESSAGE();
		print 'ERROR NUMBER'  + cast (ERROR_NUMBER() as varchar(50));
		print 'ERROR STATE'   + cast (ERROR_STATE() as varchar(50));
		print '===========================================================================';
	end catch 
end

exec  bronze.load_into_bronz ;