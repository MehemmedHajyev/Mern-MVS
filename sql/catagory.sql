CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    code INT NOT NULL,
    name VARCHAR(50) NOT NULL,
	parent_id INT,
    deleted INT DEFAULT 0
);
create unique index uc_Categories on categories(code, name, deleted);

CREATE TABLE unit_types (
    id SERIAL PRIMARY KEY,
    code INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    deleted INT DEFAULT 0
);
create unique index uc_Unit_Types on unit_types(code, name, deleted);

CREATE TABLE currency (
    id SERIAL PRIMARY KEY,
    code INT NOT NULL,
    name VARCHAR(50) NOT NULL,
	amount DECIMAL(8, 2) NOT NULL,
	deleted INT DEFAULT 0
);
create unique index uc_Currency on currency(code, name, deleted);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
	category_id INT NOT NULL,
	FOREIGN KEY (category_id) REFERENCES categories(id),
	quantity DECIMAL(8, 2) NOT NULL,
	unit_type_id INT NOT NULL,
	FOREIGN KEY (unit_type_id) REFERENCES unit_types(id),
	price DECIMAL(8, 2) NOT NULL,
	currency_id INT NOT NULL,
	FOREIGN KEY (currency_id) REFERENCES currency(id),
	deleted INT DEFAULT 0
);
create unique index uc_Products on products(name, category_id, unit_type_id, currency_id, deleted);

CREATE TABLE genders (
    id SERIAL PRIMARY KEY,
    code INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    deleted INT DEFAULT 0
);
create unique index uc_Genders on genders(code, name, deleted);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
	lastname VARCHAR(50) NOT NULL,
	patronymic VARCHAR(50),
	gender_id INT NOT NULL,
	FOREIGN KEY (gender_id) REFERENCES genders(id),
	pin_code VARCHAR(7) NOT NULL,
	email VARCHAR(50),
	phone_number VARCHAR(12) NOT NULL,
    deleted INT DEFAULT 0
);
create unique index uc_Customers on customers(pin_code, deleted);

CREATE TABLE order_statuses (
    id SERIAL PRIMARY KEY,
    code INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    deleted INT DEFAULT 0
);
create unique index uc_Order_Statuses on order_statuses(code, name, deleted);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(id),
	order_status_id INT NOT NULL,
	FOREIGN KEY (order_status_id) REFERENCES order_statuses(id),
	order_date DATE NOT NULL,
    deleted INT DEFAULT 0
);

CREATE TABLE orders_products (
    id SERIAL PRIMARY KEY,
	order_id INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(id),
	product_id INT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES products(id),
	product_quantity DECIMAL(8, 2) NOT NULL,
    deleted INT DEFAULT 0
);
create unique index uc_Orders_Products on orders_products(order_id, product_id, deleted);

INSERT INTO categories (code, name, parent_id) VALUES
	(1001, 'Electronics', NULL), --1
	(1002, 'Mobile Phones', 1), --2
	(1003, 'Laptops', 1), --3
	(2001, 'Food', NULL), --4
	(2002, 'Fruits', 4), --5
	(2003, 'Vegetables', 4); --6

INSERT INTO unit_types (code, name) VALUES
	(1001, 'Piece'),
	(1002, 'Kilogram'),
	(1003, 'Liter');

INSERT INTO currency (code, name, amount) VALUES
	(1001, 'AZN', 1),
	(1002, 'USD', 1.70),
	(1003, 'EUR', 1.82),
	(1004, 'TRY', 0.052);

INSERT INTO products (name, category_id, quantity, unit_type_id, price, currency_id) VALUES
	('Samsung Galaxy A33', 2, 100, 1, 359.99, 2),
	('Apple', 5, 50, 2, 3.5, 1),
	('Tomato', 6, 40, 2, 1.7, 1);

INSERT INTO genders (code, name) VALUES
	(1001, 'Male'),
	(1002, 'Female');

INSERT INTO customers (firstname, lastname, patronymic, gender_id, pin_code, email, phone_number) VALUES
	('Sheyda', 'Sultan', 'Amrah', 2, '7Q22U55', 'sheydasultan.99@gmail.com', '994708090214'),
	('John', 'Doe', NULL, 1, '123AND7', NULL, '994504444445');

INSERT INTO order_statuses (code, name) VALUES
	(1001, 'Pending'),
    (1002, 'Processing'),
    (1003, 'Completed'),
    (1004, 'Cancelled');

INSERT INTO orders (customer_id, order_status_id, order_date) VALUES
	(1, 2, CURRENT_DATE),
    (2, 3, CURRENT_DATE),
	(1, 1, CURRENT_DATE);

INSERT INTO orders_products (order_id, product_id, product_quantity) VALUES
	(1, 1, 1),
	(2, 3, 2.5),
	(3, 2, 4.2);
SELECT * FROM orders_products;