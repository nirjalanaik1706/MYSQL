create database JOINTS;
use JOINTS;
create table category(category_id int auto_increment primary key, 
					  category_name varchar(40), 
                      description varchar(200));

INSERT INTO category (category_name, description) VALUES
	('Beverages', 'Tea, coffee, soft drinks, juices'),
	('Snacks', 'Namkeen, chips, biscuits'),
	('Sweets', 'Ladoo, barfi, gulab jamun');

create table product(product_id int, 
	product_name varchar(30),
	category_id int,
	price varchar(10),
 foreign key (category_id) references category(category_id));
 
INSERT INTO product (product_id, product_name, price) VALUES
(1, 'Chocolates', '150'),
(2, 'Biscuits', '50'),
(3, 'Chips', '30'),
(4, 'Cake', '200'),
(5, 'Juice', '60'),
(6, 'Sandwich', '120');