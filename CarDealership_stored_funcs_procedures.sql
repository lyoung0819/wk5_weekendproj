-- CAR DEALERSHIP STORED ACTIONS --


-- >> STORED PROCEDURES << 
-- 1. When a car is purchased:
--        remove from car_on_lot and add to car_purchased


-- >> STORED FUNCTIONS << 
-- 1. Add data to a table 
-- 2. Look up: how many cars there are of a certain make
-- 3. Look up: service history by ticket_id OR appt_id
-- 4. Loop up: customer info from car purchased 
-- 5. Look up: car info from customer 
-- 6. Look up: mechanics who worked on any given invoice
-- 7. Look up: salesperson who helped with car purchase


INSERT INTO car_on_lot (
	car_make,
	car_model,
	car_color,
	purchase_pending,
	car_year
) VALUES (
	'Volkswagen',
	'Jetta',
	'Black',
	TRUE,
	2021
);



INSERT INTO customer (
	customer_first_name,
	customer_last_name
) VALUES (
	'Jane',
	'Doe'
);



SELECT * FROM invoice i;
INSERT INTO invoice(
	invoice_amount,
	invoice_type,
	description,
	customer_id,
	car_purchased_id,
	salesperson_id,
	mechanic_id,
	service_ticket_id 
) VALUES (
	40,000.50,
	'sale',
	'car purchased',
	3,
	NULL,
	1,
	2
);



SELECT * FROM car_on_lot col;
SELECT * FROM invoice i;
SELECT * FROM customer c;

INSERT INTO car_on_lot(
	car_make,
	car_model,
	car_color,
	purchase_pending,
	car_year 
) VALUES ( 
	'Chevrolet',
	'Malibu',
	'Purple',
	FALSE,
	2022
);

INSERT INTO customer(
	customer_first_name,
	customer_last_name,
	car_purchased_id 
) VALUES ( 
	'Lexie',
	'Young',
	NULL  
);


SELECT * FROM invoice i;
INSERT INTO invoice(
	invoice_amount,
	invoice_type,
	description,
	customer_id,
	car_purchased_id,
	salesperson_id,
	mechanic_id,
	service_ticket_id
) VALUES (
	55,000.00,
	'sale',
	'car purchased',
	9,
	NULL,
	1, 
	1,
	NULL
);