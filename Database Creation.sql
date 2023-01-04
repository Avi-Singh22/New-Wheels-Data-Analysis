/*
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

-- Creating a Database named "vehdb"

CREATE DATABASE vehdb;

-- Calling the Database made in the previous step

USE vehdb;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- Writing the drop table queries to use if there is some error or mistake later on.
DROP TABLE IF EXISTS temp_t;		-- query for table temp_t
DROP TABLE IF EXISTS vehicles_t;	-- query for table vehicles_t
DROP TABLE IF EXISTS order_t; 		-- query for table order_t
DROP TABLE IF EXISTS customer_t; 	-- query for table customer_t
DROP TABLE IF EXISTS product_t; 	-- query for table product_t
DROP TABLE IF EXISTS shipper_t; 	-- query for table shipper_t                             

-- Queries to create the required tables- 
-- 1. Table named temp_t
CREATE TABLE temp_t (
	shipper_id INT, 
    shipper_name VARCHAR(50),
    shipper_contact_details VARCHAR(30),
    product_id INT,
    vehicle_maker VARCHAR(60),
    vehicle_model VARCHAR(60),
    vehicle_color VARCHAR(60),
    vehicle_model_year INT,
    vehicle_price DECIMAL(10,2),
    quantity INT, 
    discount DECIMAL(4,2),
    customer_id VARCHAR(25),
    customer_name VARCHAR(25),
    gender VARCHAR(15),
    job_title VARCHAR(50),
    phone_number VARCHAR(20),
    email_address VARCHAR(50),
    city VARCHAR(25),
    country VARCHAR(40),
    state VARCHAR(40),
    customer_address VARCHAR(50),
    order_date DATE,
    order_id VARCHAR(50),
    ship_date DATE,
    ship_mode VARCHAR(25),
	shipping VARCHAR(30),
    postal_code INT,
    credit_card_type VARCHAR(40),
    credit_card_number BIGINT,
    customer_feedback VARCHAR(20),
    quarter_number INT                    
); 

-- 2. Table named vehicles_t
CREATE TABLE vehicles_t (
	shipper_id INT, 
    shipper_name VARCHAR(50),
    shipper_contact_details VARCHAR(30),
    product_id INT,
    vehicle_maker VARCHAR(60),
    vehicle_model VARCHAR(60),
    vehicle_color VARCHAR(60),
    vehicle_model_year INT,
    vehicle_price DECIMAL(10,2),
    quantity INT, 
    discount DECIMAL(4,2),
    customer_id VARCHAR(25),
    customer_name VARCHAR(25),
    gender VARCHAR(15),
    job_title VARCHAR(50),
    phone_number VARCHAR(20),
    email_address VARCHAR(50),
    city VARCHAR(25),
    country VARCHAR(40),
    state VARCHAR(40),
    customer_address VARCHAR(50),
    order_date DATE,
    order_id VARCHAR(50),
    ship_date DATE,
    ship_mode VARCHAR(25),
	shipping VARCHAR(30),
    postal_code INT,
    credit_card_type VARCHAR(40),
    credit_card_number BIGINT,
    customer_feedback VARCHAR(20),
    quarter_number INT,
	PRIMARY KEY (order_id, customer_id, product_id, shipper_id)                    
); 

-- 3. Table named order_t
CREATE TABLE order_t (
	order_id VARCHAR(25),
	customer_id VARCHAR(25),
	shipper_id INT,
	product_id INT,
	quantity INT,
	vehicle_price DECIMAL(10,2),
	order_date DATE,
	ship_date DATE,
	discount DECIMAL(4,2),
	ship_mode VARCHAR(25),
	shipping VARCHAR(30),
	customer_feedback VARCHAR(20),
	quarter_number INT,
	PRIMARY KEY (order_id) 
);

-- 4. Table named customer_t
CREATE TABLE customer_t (
	customer_id VARCHAR(25),
    customer_name VARCHAR(25),
    gender VARCHAR(15),
    job_title VARCHAR(50),
    phone_number VARCHAR(20),
    email_address VARCHAR(50),
    city VARCHAR(25),
    country VARCHAR(40),
    state VARCHAR(40),
    customer_address VARCHAR(50),
	postal_code INT,
    credit_card_type VARCHAR(40),
    credit_card_number BIGINT,
	PRIMARY KEY (customer_id) 
);

-- 5. Table named product_t
CREATE TABLE product_t (
	product_id INT,
    vehicle_maker VARCHAR(60),
    vehicle_model VARCHAR(60),
    vehicle_color VARCHAR(60),
    vehicle_model_year INT,
    vehicle_price DECIMAL(10,2),
    PRIMARY KEY (product_id) 
); 

-- 6. Table named shipper_t
CREATE TABLE shipper_t (
	shipper_id INT, 
    shipper_name VARCHAR(50),
    shipper_contact_details VARCHAR(30),
    PRIMARY KEY (shipper_id)
);


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:

-- Writing the drop procedure queries to use if there is some error or mistake later on.

DROP PROCEDURE IF EXISTS vehicles_p; 	-- query for table vehicles_p
DROP PROCEDURE IF EXISTS order_p;		-- query for table order_p
DROP PROCEDURE IF EXISTS customer_p;	-- query for table customer_p
DROP PROCEDURE IF EXISTS product_p;		-- query for table product_p
DROP PROCEDURE IF EXISTS shipper_p;		-- query for table shipper_p

-- Queries to create the required stored procedures-
-- 1. Stored Procedure for vehicles_t
DELIMITER $$ 
CREATE PROCEDURE vehicles_p()
BEGIN
       INSERT INTO vehicles_t (
	shipper_id, 
    shipper_name,
    shipper_contact_details,
    product_id ,
    vehicle_maker ,
    vehicle_model ,
    vehicle_color ,
    vehicle_model_year ,
    vehicle_price,
    quantity, 
    discount,
    customer_id,
    customer_name,
    gender,
    job_title ,
    phone_number,
    email_address ,
    city,
    country ,
    state,
    customer_address,
    order_date ,
    order_id ,
    ship_date,
    ship_mode ,
	shipping,
    postal_code,
    credit_card_type ,
    credit_card_number ,
    customer_feedback ,
    quarter_number          
	) 
SELECT * FROM temp_t;
END;

-- 2. Stored Procedure for order_t
DELIMITER $$ 
CREATE PROCEDURE order_p()
BEGIN
       INSERT INTO order_t (
	order_id,
	customer_id,
	shipper_id,
	product_id,
	quantity,
	vehicle_price,
	order_date,
	ship_date,
	discount,
	ship_mode,
	shipping,
	customer_feedback,
	quarter_number     
	) 
SELECT 	order_id,
		customer_id,
		shipper_id,
		product_id,
		quantity,
		vehicle_price,
		order_date,
		ship_date,
		discount,
		ship_mode,
		shipping,
		customer_feedback,
		quarter_number  
FROM temp_t;
END;

-- 3. Stored Procedure for customer_t
DELIMITER $$ 
CREATE PROCEDURE customer_p()
BEGIN
       INSERT INTO customer_t (
	customer_id,
    customer_name,
    gender ,
    job_title,
    phone_number,
    email_address,
    city,
    country,
    state,
    customer_address,
	postal_code,
    credit_card_type,
    credit_card_number
	) 
SELECT 	DISTINCT customer_id,
		customer_name,
		gender ,
		job_title,
		phone_number,
		email_address,
		city,
		country,
		state,
		customer_address,
		postal_code,
		credit_card_type,
		credit_card_number
FROM temp_t;
END;

-- 4. Stored Procedure for product_t
DELIMITER $$ 
CREATE PROCEDURE product_p()
BEGIN
       INSERT INTO product_t (
	product_id,
    vehicle_maker,
    vehicle_model,
    vehicle_color,
    vehicle_model_year,
    vehicle_price  
	) 
SELECT 	distinct product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price   
FROM temp_t;
END;

-- 5. Stored Procedure for shipper_t
DELIMITER $$ 
CREATE PROCEDURE shipper_p()
BEGIN
       INSERT INTO shipper_t (
	shipper_id, 
    shipper_name,
    shipper_contact_details 
	) 
SELECT 	distinct shipper_id, 
		shipper_name,
		shipper_contact_details 
FROM temp_t;
END;

-- [6] Calling the stored procedures:

-- Writing queries for calling the stored procedures that will load the data into the tables according to our queries.

call vehicles_p();		-- Calling stored procedure vehicles_p to input data into table vehicles_t
call order_p();			-- Calling stored procedure order_p to input data into table order_t
call customer_p();		-- Calling stored procedure customer_p to input data into table customer_t
call product_p();		-- Calling stored procedure product_p to input data into table product_t
call shipper_p(); 		-- Calling stored procedure shipper_p to input data into table shipper_t


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
-- -> Ingest data into the temp_t table by importing the 4 csv files for each quarter.
-- -> After that, run all the Stored Procedures one-by-one to create a pupeline for data to be ingested into all the different tables.
-- -> Finally, call the stored procedures one-by-one to load the data from temp_t to all the different tables.

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:

-- Writing the drop view queries to use if there is some error or mistake later on.	

DROP VIEW IF EXISTS veh_prod_cust_v;	-- query for view veh_prod_cust_v	
DROP VIEW IF EXISTS veh_ord_cust_v;		-- query for view veh_ord_cust_v

-- 1. Query for view veh_prod_cust_v
CREATE VIEW veh_prod_cust_v AS
    SELECT
    ct.customer_id,
    ct.customer_name,
    ct.credit_card_type,
    ct.state,
    ot.order_id,
    ot.customer_feedback,
    pt.product_id,
    pt.vehicle_maker,
    pt.vehicle_model,
    pt.vehicle_color,
    pt.vehicle_model_year
FROM order_t ot 
	INNER JOIN product_t pt
	    ON ot.product_id = pt.product_id
	INNER JOIN customer_t ct
		ON ot.customer_id = ct.customer_id;

-- 2. Query for view veh_ord_cust_v
CREATE VIEW veh_ord_cust_v AS
    SELECT
    ct.customer_id,
    ct.customer_name,
    ct.city,
    ct.state,
    ct.credit_card_type,
    ot.order_id,
    ot.shipper_id,
    ot.product_id,
    ot.quantity,
    ot.vehicle_price,
    ot.order_date,
    ot.ship_date,
    ot.discount,
    ot.customer_feedback,
    ot.quarter_number
FROM order_t ot 
	INNER JOIN customer_t ct
		ON ot.customer_id = ct.customer_id;

-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------
