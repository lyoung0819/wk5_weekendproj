-- INITIALIZING DATABASE...


-- TABLES BEING CREATED...
-- invoice (X)
-- salesperson (X)
-- mechanic (X)
-- service_ticket (X)
-- sesrvice_appt (X)
-- car_purchased (X)
-- customer (X)
-- car_on_lot (X)
-- mechanic_invoice


CREATE TABLE IF NOT EXISTS invoice(
	invoice_id SERIAL PRIMARY KEY,
	invoice_amount NUMERIC(5,2) NOT NULL,
	invoice_type VARCHAR,
	description TEXT,
	date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
);

CREATE TABLE IF NOT EXISTS service_appt( 
	service_appt_id SERIAL PRIMARY KEY,
	appt_occured BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS car_purchased(
	car_purchased_id SERIAL PRIMARY KEY,
	date_purchased TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
	
-- TABLES ADDED

-- FOREIGN KEYS BEING ADDED... 

ALTER TABLE invoice ADD COLUMN IF NOT EXISTS customer_id INTEGER NOT NULL;
ALTER TABLE invoice ADD COLUMN IF NOT EXISTS car_purchased_id INTEGER;
ALTER TABLE invoice ADD COLUMN IF NOT EXISTS salesperson_id INTEGER NOT NULL;
ALTER TABLE invoice ADD COLUMN IF NOT EXISTS mechanic_id INTEGER;
ALTER TABLE invoice ADD COLUMN IF NOT EXISTS service_ticket_id INTEGER;

ALTER TABLE service_ticket ADD COLUMN IF NOT EXISTS customer_id INTEGER NOT NULL;
ALTER TABLE service_ticket ADD COLUMN IF NOT EXISTS invoice_id INTEGER NOT NULL;
ALTER TABLE service_ticket ADD COLUMN IF NOT EXISTS mechanic_id INTEGER NOT NULL;
ALTER TABLE service_ticket ADD COLUMN IF NOT EXISTS salesperson_id INTEGER NOT NULL;

ALTER TABLE service_appt ADD COLUMN IF NOT EXISTS service_ticket_id INTEGER;

ALTER TABLE car_purchased ADD COLUMN IF NOT EXISTS car_on_lot_id INTEGER;
ALTER TABLE car_purchased ADD COLUMN IF NOT EXISTS customer_id INTEGER NOT NULL;
ALTER TABLE car_purchased ADD COLUMN IF NOT EXISTS invoice_id INTEGER NOT NULL;
ALTER TABLE car_purchased ADD COLUMN IF NOT EXISTS salesperson_id INTEGER NOT NULL;




-- FOREIGN KEYS BEING ASSIGNED...

-- invoice Table:
	--fk: customer_id
ALTER TABLE invoice
ADD FOREIGN KEY(customer_id) REFERENCES customer(customer_id);

	--fk: car_purchased
ALTER TABLE invoice 
ADD FOREIGN KEY(car_purchased_id) REFERENCES car_purchased(car_purchased_id); 

	--fk: salesperson_id
ALTER TABLE invoice 
ADD FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id); 

	--fk: mechanic_id
ALTER TABLE invoice 
ADD FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id); 

	--fk: service_ticket_id
ALTER TABLE invoice 
ADD FOREIGN KEY(service_ticket_id) REFERENCES service_ticket(service_ticket_id); 

-- service_ticket Table:
	--fk: customer_id
ALTER TABLE service_ticket 
ADD FOREIGN KEY(customer_id) REFERENCES customer(customer_id);

	--fk: invoice_id
ALTER TABLE service_ticket 
ADD FOREIGN KEY(invoice_id) REFERENCES invoice(invoice_id);

	--fk: mechanic_id
ALTER TABLE service_ticket 
ADD FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id);

	--fk: salesperson_id
ALTER TABLE service_ticket 
ADD FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id);


-- service_appt Table:
	--fk: service_ticket_id 
ALTER TABLE service_appt 
ADD FOREIGN KEY(service_ticket_id) REFERENCES service_ticket(service_ticket_id);


-- car_purchased Table:
	--fk: car_on_lot_id
ALTER TABLE car_purchased
ADD FOREIGN KEY(car_on_lot_id) REFERENCES car_on_lot(car_on_lot_id);
	--fk: customer_id
ALTER TABLE car_purchased
ADD FOREIGN KEY(customer_id) REFERENCES customer(customer_id);
	--fk: invoice_id
ALTER TABLE car_purchased
ADD FOREIGN KEY(invoice_id) REFERENCES invoice(invoice_id);
	--fk salesperson_id
ALTER TABLE car_purchased
ADD FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id);



-- customer Table:
	--fk: car_purchased_id