Partial mysqldump export


	mysql_export_partial.sh -u user 
							-p password 
							-h hostname 
							-d database_to_export 
							-f filename_to_save_dump 
							-s string_to_not_like


Example:
Export all databases not starting with string 'ez'

	mysql_export_partial.sh -u root 
							-p some_password 
							-h 192.168.1.1 
							-d my_database 
							-f my_database_without_ez_tables.sql 
							-s ez%