EXEC bronze.load_bronze
IF OBJECT_ID('bronze.load_bronze','P') IS NOT NULL
	DROP PROCEDURE bronze.load_bronze;

GO
CREATE PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '====================================================';
		PRINT 'Loading Bronze layer';
		PRINT '====================================================';

		PRINT '----------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------------------';
	
		SET @start_time = GETDATE();
		PRINT 'Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT 'Inserting Data Into Table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Spade\Downloads\Source_CRM\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		PRINT '-----------------'

		SET @start_time = GETDATE();
		PRINT 'Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT 'Inserting Data Into Table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Spade\Downloads\Source_CRM\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			fieldterminator = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		PRINT '-----------------'

		SET @start_time = GETDATE();
		PRINT 'Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT 'Inserting Data Into Table: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Spade\Downloads\Source_CRM\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			fieldterminator = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		PRINT '-----------------'


		PRINT '----------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT 'Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT 'Inserting Data Into Table: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Spade\Downloads\Source_ERP\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			fieldterminator = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		PRINT '-----------------'

		SET @start_time = GETDATE();
		PRINT 'Truncating Table: bronze.erp_CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;

		PRINT 'Inserting Data Into Table: bronze.erp_CUST_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\Spade\Downloads\Source_ERP\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			fieldterminator = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		PRINT '-----------------'

		SET @start_time = GETDATE();
		PRINT 'Truncating Table: bronze.erp_PX_CAT_GlV2';
		TRUNCATE TABLE bronze.erp_PX_CAT_GlV2;

		PRINT 'Inserting Data Into Table: bronze.erp_PX_CAT_GlV2';
		BULK INSERT bronze.erp_PX_CAT_GlV2
		FROM 'C:\Users\Spade\Downloads\Source_ERP\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			fieldterminator = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		PRINT '-----------------'

		SET @batch_end_time = GETDATE();
		PRINT '===================================================='
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '===================================================='
		PRINT '    - Total Load Duration: ' + CAST (DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'Seconds'
		PRINT '===================================================='

	END TRY
	BEGIN CATCH
		PRINT '====================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE:' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER:' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR STATE:' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '====================================================';

	END CATCH
END
