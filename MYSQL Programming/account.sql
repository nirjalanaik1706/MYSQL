create database Account_db;
use Account_db;
create table account_info(
    Account_id int auto_increment primary key,
	Accounter_holder_name varchar(30),
    Account_type varchar(20),
    Account_balance varchar(10)
);

INSERT INTO account_info (Account_id, Accounter_holder_name, Account_type, Account_balance) VALUES
(1, 'Naina surve', 'Savings', '15000'),
(2, 'Nirjala naik', 'Current', '27000'),
(3, 'Sahil kamble', 'Savings', '42000'),
(4, 'Sarthak walke', 'Current', '34000'),
(5, 'Vikram Singh', 'Savings', '18000');