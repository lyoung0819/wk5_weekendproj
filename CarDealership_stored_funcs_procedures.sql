-- CAR DEALERSHIP STORED ACTIONS --


-- >> STORED PROCEDURES << 
-- 1. Add a new car to the car lot (add_to_car_lot)
-- 2. Add a new customer (add_new_customer)
-- 3. Create new invoice (!!!NOT WORKING PROPERLY!!!)
-- 4. When a car is purchased, migrate info from car_on_lot to car_purchased 
-- 5. Remove a car from the car_on_lot table (!!!NOT WORKING PROPERLY!!!)

-- >> STORED FUNCTIONS << 
-- 1. Look up: how many cars there are of a certain make
-- 2. Look up: service history by ticket_id OR appt_id


-----------------------------------------------------------------------------------
-- STORED PROCEDURES: 

-- 1. Add a new car to the car lot
CREATE OR REPLACE PROCEDURE add_to_car_lot(make VARCHAR, model VARCHAR, color VARCHAR, purchase_pending BOOLEAN, year_made INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO car_on_lot(
	car_make,
	car_model,
	car_color,
	purchase_pending,
	car_year
) VALUES (
	make,
	model,
	color,
	purchase_pending,
	year_made
);	
END;
$$;
-- to execute procedure: 
CALL add_to_car_lot('Chevrolet', 'Blazer', 'Brown', FALSE, 2001);

-----------------

-- 2. Add a new customer (add_new_customer)
SELECT * FROM customer c;

INSERT INTO customer (
	customer_first_name,
	customer_last_name
) VALUES (
	'Linda',
	'Prindle'
);


CREATE OR REPLACE PROCEDURE add_new_customer(first_name VARCHAR, last_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO customer (
	customer_first_name,
	customer_last_name
) VALUES (
	first_name,
	last_name
);	
END;
$$;

-- to execute procedure:

CALL add_new_customer('Benjamin', 'Button');

-----------------
-- 3. Create new invoice 

SELECT * FROM invoice i;
SELECT * FROM customer c;
SELECT * FROM car_on_lot col;


CREATE OR REPLACE PROCEDURE new_invoice(invoice_amount NUMERIC(8,2), invoice_type VARCHAR, description TEXT, customer_id INTEGER, car_on_lot_id INTEGER, salesperson_id INTEGER, mechanic_id INTEGER, service_ticket_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO invoice (
		invoice_amount,
		invoice_type,
		description,
		customer_id,
		car_on_lot_id,
		salesperson_id,
		mechanic_id,
		service_ticket_id 
	) VALUES (
		invoice_amount,
		invoice_type,
		description,
		customer_id,
		car_on_lot_id,
		salesperson_id,
		mechanic_id,
		service_ticket_id);
END;
$$;

-- Whenever I execute the procedure it does not work, however it worked when I manually input the information. 

SELECT * FROM invoice;
	
CALL new_invoice(31,000, 'sale', 'car purchased', 2, 5, 1, NULL, NULL);
-- SQL Error [42883]: ERROR: procedure new_invoice(integer, integer, unknown, unknown, integer, integer, integer, unknown, unknown) does not exist
--  Hint: No procedure matches the given name and argument types. You might need to add explicit type casts.
--  Position: 6

-- Error position: line: 114 pos: 5
-----------------

-- 4. (Invoice must first be made) When a car is purchased, use this function to migrate the car info from car_on_lot to car_purchased: 

SELECT * FROM car_on_lot col;


CREATE OR REPLACE PROCEDURE copy_to_car_purchased(car_on_lot_id INTEGER, customer_id INTEGER, invoice_id INTEGER, salesperson_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO car_purchased(
		car_on_lot_id,
		customer_id,
		invoice_id,
		salesperson_id 
	) VALUES (
		car_on_lot_id,
		customer_id,
		invoice_id,
		salesperson_id); 
END;
$$;


-- to execute procedure:
CALL copy_to_car_purchased(2, 10, 6, 1);
SELECT * FROM car_purchased cp;

-----------------
-- 5. Remove a car from the car_on_lot table (!!! NOT WORKING !!!)

CREATE OR REPLACE PROCEDURE remove_from_lot(lot_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM car_on_lot
	WHERE car_on_lot_id = lot_id;
END;
$$;

SELECT * FROM car_on_lot col;

-- Function was created fine, but when I call it, I recieve the below error: 

CALL remove_from_lot(2);
-- SQL Error [23503]: ERROR: update or delete on table "car_on_lot" violates foreign key constraint "car_purchased_car_on_lot_id_fkey" on table "car_purchased"
--  Detail: Key (car_on_lot_id)=(2) is still referenced from table "car_purchased".
--  Where: SQL statement "DELETE FROM car_on_lot
--	WHERE car_on_lot_id = lot_id"
-- PL/pgSQL function remove_from_lot(integer) line 3 at SQL statement



----------------------------------------------------------------------------------------

-- >> STORED FUNCTIONS << 
-- 1. Look up: how many cars there are of a certain make
CREATE OR REPLACE FUNCTION total_makes(make VARCHAR)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE make_count INTEGER;
BEGIN
	SELECT count(*)
	INTO make_count
	FROM car_on_lot
	WHERE car_make = make
	GROUP BY car_make;
	RETURN make_count;
END;
$$;

-- to execute function: 
SELECT total_makes('Jeep');


-----------------

-- 2. Look up: service history by appt_id



SELECT * 
FROM service_ticket st
JOIN service_appt sa
ON sa.service_ticket_id = st.service_ticket_id;


CREATE OR REPLACE FUNCTION look_up_service_appt(ticket_id INTEGER)
RETURNS TABLE ( -- define what the TABLE looks like
	service_ticket_id INTEGER,
	customer_id INTEGER,
	invoice_id INTEGER,
	mechanic_id INTEGER,
	salesperson_id INTEGER,
	service_appt_id INTEGER,
	appt_occured BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN 
	SELECT * 
	FROM service_ticket st
	JOIN service_appt sa
	ON sa.service_ticket_id = st.service_ticket_id;
END;
$$;

SELECT look_up_service_appt(1);

-- Not sure why I keep getting this error?
-- SQL Error [42601]: ERROR: query has no destination for result data
--  Hint: If you want to discard the results of a SELECT, use PERFORM instead.
--  Where: PL/pgSQL function look_up_service_appt(integer) line 3 at SQL statement