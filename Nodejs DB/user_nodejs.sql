CREATE DATABASE customers;

USE customers;

CREATE TABLE users(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(30) ,
contact VARCHAR(30),
PRIMARY KEY(id)
);
use customers;
INSERT INTO users VALUES ("Amit Sharma", "9876543210");
INSERT INTO users VALUES (2, "Sahil Kamble", "7972520102");
INSERT INTO users VALUES (3, "Neha Patil", "9123456789");
INSERT INTO users VALUES (4, "Rohit Verma", "9012345678");
INSERT INTO users VALUES (5, "Priya Singh", "8899776655");
INSERT INTO users VALUES (6, "Kunal Deshmukh", "9988776655");
INSERT INTO users VALUES (7, "Sneha Kulkarni", "9090909090");
INSERT INTO users VALUES (8, "Rahul Joshi", "9321456780");
INSERT INTO users VALUES (9, "Pooja Mehta", "9556677889");
INSERT INTO users VALUES (10, "Aniket More", "9765432109");

USE customers;

DELIMITER //

CREATE PROCEDURE getUsers()
BEGIN
    SELECT * FROM users;
END //

DELIMITER ;

DELIMITER //
call getUsers();

CREATE PROCEDURE addUser(
    IN uname VARCHAR(30),
    IN ucontact VARCHAR(30)
)
BEGIN
    INSERT INTO users(name, contact)
    VALUES (uname, ucontact);
END //



DELIMITER //
CREATE PROCEDURE updateUser(
    IN uid INT,
    IN uname VARCHAR(30),
    IN ucontact VARCHAR(30)
)
BEGIN
    UPDATE users
    SET name = uname, contact = ucontact
    WHERE id = uid;
END //
DELIMITER ;
call  updateUser(1,"sahil","797245632");
DELIMITER ;

DELIMITER //
create procedure deleteUser(
In uid int)
begin
delete from users where id=uid;
end //
delimiter ;
call deleteUser(4);

DELIMITER //
create procedure getSpecificUser(
IN uid INT)
begin
select * from users where id=uid;
end //
delimiter ;
call getSpecificUser(1);



DELIMITER $$
DROP PROCEDURE IF EXISTS getUserName $$

CREATE PROCEDURE getUserName (
    IN user_id INT,
    OUT user_name VARCHAR(100),
    OUT user_contact VARCHAR(10)
)
BEGIN
    SELECT name, contact
    INTO user_name, user_contact
    FROM users
    WHERE id = user_id;
END $$

DELIMITER ;


CALL getUserName(1, @name, @contact);
SELECT @name, @contact;





