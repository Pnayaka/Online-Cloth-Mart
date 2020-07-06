DROP DATABASE IF EXISTS onlineshopping;
CREATE DATABASE onlineshopping;
USE onlineshopping;

CREATE TABLE category (
	id INT AUTO_INCREMENT,
	name VARCHAR(50),
	description VARCHAR(255),
	image_url VARCHAR(50),
	is_active BOOLEAN,
	CONSTRAINT pk_category_id PRIMARY KEY (id) 

);

CREATE TABLE user_detail (
	id INT AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	role VARCHAR(50),
	enabled BOOLEAN,
	password VARCHAR(60),
	email VARCHAR(100),
	contact_number VARCHAR(15),	
	CONSTRAINT pk_user_id PRIMARY KEY(id)
);

CREATE TABLE product (
	id INT AUTO_INCREMENT,
	code VARCHAR(20),
	name VARCHAR(50),
	brand VARCHAR(50),
	description VARCHAR(255),
	unit_price DECIMAL(10,2),
	quantity INT,
	is_active BOOLEAN,
	category_id INT,
	supplier_id INT,
	purchases INT DEFAULT 0,
	views INT DEFAULT 0,
	CONSTRAINT pk_product_id PRIMARY KEY (id),
 	CONSTRAINT fk_product_category_id FOREIGN KEY (category_id) REFERENCES category (id),
	CONSTRAINT fk_product_supplier_id FOREIGN KEY (supplier_id) REFERENCES user_detail(id)	
);	

-- the address table to store the user billing and shipping addresses
CREATE TABLE address (
	id INT AUTO_INCREMENT,
	user_id int,
	address_line_one VARCHAR(100),
	address_line_two VARCHAR(100),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(10),
	is_billing BOOLEAN,
	is_shipping BOOLEAN,
	CONSTRAINT fk_address_user_id FOREIGN KEY (user_id ) REFERENCES user_detail (id),
	CONSTRAINT pk_address_id PRIMARY KEY (id)
);

-- the cart table to store the user cart top-level details
CREATE TABLE cart (
	id INT AUTO_INCREMENT,
	user_id int,
	grand_total DECIMAL(10,2),
	cart_lines int,
	CONSTRAINT fk_cart_user_id FOREIGN KEY (user_id ) REFERENCES user_detail (id),
	CONSTRAINT pk_cart_id PRIMARY KEY (id)
);
-- the cart line table to store the cart details
CREATE TABLE cart_line (
	id INT AUTO_INCREMENT,
	cart_id int,
	total DECIMAL(10,2),
	product_id int,
	product_count int,
	buying_price DECIMAL(10,2),
	is_available boolean,
	CONSTRAINT fk_cartline_product_id FOREIGN KEY (product_id ) REFERENCES product (id),
	CONSTRAINT pk_cartline_id PRIMARY KEY (id)
);


-- the order detail table to store the order
CREATE TABLE order_detail (
	id INT AUTO_INCREMENT,
	user_id int,
	order_total DECIMAL(10,2),
	order_count int,
	shipping_id int,
	billing_id int,
	order_date date,
	CONSTRAINT fk_order_detail_user_id FOREIGN KEY (user_id) REFERENCES user_detail (id),
	CONSTRAINT fk_order_detail_shipping_id FOREIGN KEY (shipping_id) REFERENCES address (id),
	CONSTRAINT fk_order_detail_billing_id FOREIGN KEY (billing_id) REFERENCES address (id),
	CONSTRAINT pk_order_detail_id PRIMARY KEY (id)
);

-- the order item table to store order items
CREATE TABLE order_item (
	id INT AUTO_INCREMENT,
	order_id int,
	total DECIMAL(10,2),
	product_id int,
	product_count int,
	buying_price DECIMAL(10,2),
	CONSTRAINT fk_order_item_product_id FOREIGN KEY (product_id) REFERENCES product (id),
	CONSTRAINT fk_order_item_order_id FOREIGN KEY (order_id) REFERENCES order_detail (id),
	CONSTRAINT pk_order_item_id PRIMARY KEY (id)
);


-- adding three categories
INSERT INTO `category` (`id`, `name`, `description`, `image_url`, `is_active`) VALUES
(1, 'Kurtas', 'This is description for Kurtas category!', 'CAT_1.png', 1),
(3, 'Tops', 'This is description for Tops category!', 'CAT_3.png', 1),
(4, 'Casual Trousers', 'This is some description for Casual Trousers!', 'CAT_1.png', 1),
(5, 'Dresses', 'This is some description for Dresses!', 'CAT_2.png', 1),
(6, 'Casual Shirts', 'This is some description for Casual Shirts!', 'CAT_1.png', 1),
(7, 'Mens T-Shirts', 'This is some description for Mens T-Shirts!', 'CAT_2.png', 1),
(8, 'Category 1', 'This is some description for Category 1!', 'CAT_1.png', 1),
(9, 'Category 2', 'This is some description for Category 1!', 'CAT_2.png', 1),
(12, 'Category 3', 'This is some description for Category 1!', 'CAT_1.png', 1);

-- adding three users 
INSERT INTO `user_detail` (`id`, `first_name`, `last_name`, `role`, `enabled`, `password`, `email`, `contact_number`) VALUES
(1, 'ADMIN', '', 'ADMIN', 1, '$2a$06$ORtBskA2g5Wg0HDgRE5ZsOQNDHUZSdpJqJ2.PGXv0mKyEvLnKP7SW', 'vk@gmail.com', '8888888888'),
(2, 'Ravindra', 'Jadeja', 'SUPPLIER', 1, '$2a$06$bzYMivkRjSxTK2LPD8W4te6jjJa795OwJR1Of5n95myFsu3hgUnm6', 'rj@gmail.com', '9999999999'),
(3, 'Ravichandra', 'Ashwin', 'SUPPLIER', 1, '$2a$06$i1dLNlXj2uY.UBIb9kUcAOxCigGHUZRKBtpRlmNtL5xtgD6bcVNOK', 'ra@gmail.com', '7777777777'),
(4, 'Khozema', 'Nullwala', 'USER', 1, '$2a$06$4mvvyO0h7vnUiKV57IW3oudNEaKPpH1xVSdbie1k6Ni2jfjwwminq', 'kn@gmail.com', '7777777777'),
(5, 'Parikshith', 'Nayaka S K', 'USER', 1, '$2a$10$9t.3u0RF00lsLHFkXFCkCOKl0zAjSdXUWq3.l02tgw4hyFEzr7yhO', 'pn@gmail.com', '9663177904'),
(6, 'Vijay', 'Kumar', 'SUPPLIER', 1, '$2a$10$wAJ5RiNdmWH9.SEBsV65qOJZ5Xuws7qvCXxpoxoFVF0LTweKMzVfa', 'vj@gmail.com', '8888888888');

-- adding five products
INSERT INTO `product` (`id`, `code`, `name`, `brand`, `description`, `unit_price`, `quantity`, `is_active`, `category_id`, `supplier_id`, `purchases`, `views`) VALUES
(1, 'PRDABC123DEFX', 'Ives', 'Ivesle', 'Women Olive Green Solid Shirt Style Top', '1099.00', 4, 1, 3, 2, 0, 2),
(2, 'PRDDEF123DEFX', 'Vishudh', 'Vishudh', 'Women Black & Golden Printed Straight Kurta', '1149.00', 7, 1, 1, 3, 0, 1),
(3, 'PRDPQR123WGTX', 'Roadster', 'Roadster', 'Men Brown Printed Round Neck T-shirt', '499.00', 5, 1, 7, 2, 0, 1),
(4, 'PRDMNO123PQRX', 'HIGHLANDER', 'HIGHLANDER', 'Men Black Tapered Fit Solid Chinos', '1549.00', 3, 1, 4, 2, 0, 0),
(5, 'PRDABCXYZDEFX', 'Roadster', 'Roadster', 'Men Black & Grey Regular Fit Shadow Check Casual Shirt', '1299.00', 4, 1, 6, 3, 0, 0),
(6, 'PRD0661CAB562', 'U&F', 'U&F', 'Maroon & Olive Green Floral Print Maxi Shirt Dress', '1699.00', 6, 1, 5, 1, 0, 1);

