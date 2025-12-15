create database Account_db;
use Account_db;
create table account_info(
    Account_id int auto_increment primary key,
	Accounter_holder_name varchar(30),
    Account_type varchar(20),
    Account_balance varchar(10)
);

INSERT INTO account_info (Account_id, Accounter_holder_name, Account_type, Account_balance) VALUES

(1, 'Nirjala naik', 'Current', '27000'),
(2, 'Sahil kamble', 'Savings', '42000');
