-- INITIALIZING DATABASE --

CREATE TABLE IF NOT EXISTS customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	address VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(2)
);


-- TABLES CREATED:
-- invoice (X)
-- salesperson (X)
-- mechanic (X)
-- service_ticket (X)
-- sesrvice_appt (X)
-- car_purchased (X)
-- customer (X)
-- car_on_lot
-- mechanic_invoice


CREATE TABLE IF NOT EXISTS invoice(
	invoice_id SERIAL PRIMARY KEY,
	invoice_amount NUMERIC(5,2) NOT NULL,
	invoice_type VARCHAR,
	description TEXT,
	date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	--fk: customer_id
	--fk: car_purchased
	--fk: salesperson_id
	--fk: mechani_id
	--fk: service_ticket_id
);

CREATE TABLE IF NOT EXISTS salesperson( 
	salesperson_id SERIAL PRIMARY KEY,
	sales_first_name VARCHAR,
	sales_last_name VARCHAR
);

CREATE TABLE IF NOT EXISTS mechanic( 
	mechanic_id SERIAL PRIMARY KEY,
	mechanic_first_name VARCHAR,
	mechanic_last_name VARCHAR
);

CREATE TABLE IF NOT EXISTS service_ticket( 
	service_ticket_id SERIAL PRIMARY KEY
	--fk: customer_id
	--fk: invoice_id
	--fk: mechanic_id
	--fk: salesperson_id
);

CREATE TABLE IF NOT EXISTS service_appt( 
	service_appt_id SERIAL PRIMARY KEY,
	appt_occured BOOLEAN NOT NULL
	--fk: service_ticket_id 
);

CREATE TABLE IF NOT EXISTS car_purchased(
	car_purchased_id SERIAL PRIMARY KEY,
	date_purchased TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	--fk: car_on_lot_id
	--fk: customer_id
	--fk: invoice_id
	--fk salesperson_id
);

CREATE TABLE IF NOT EXISTS customer(
	customer_id SERIAL PRIMARY KEY,
	customer_first_name VARCHAR,
	customer_last_name VARCHAR
	--fk: car_purchased_id
);

CREATE TABLE IF NOT EXISTS car_on_lot( 
	car_on_lot_id SERIAL PRIMARY KEY,
	car_make VARCHAR NOT NULL,
	car_model VARCHAR NOT NULL,
	car_year DATE NOT NULL,
	car_color VARCHAR NOT NULL,
	purchase_pending BOOLEAN NOT NULL,
	last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);
	
	
	
	
	
	