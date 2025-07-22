create database tfl;
use tfl;
CREATE TABLE employees (
    userId INT,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    contact VARCHAR(15) UNIQUE
);
INSERT INTO employees (userId, firstname, lastname, email, contact) VALUES
(1, 'ravi', 'tambade', 'ravi.tambade@example.com', '9000000000'),
(2, 'kajal', 'ghule', 'kajal.ghule@example.com', '9000000001'),
(3, 'nirjala', 'naik', 'nirjala.naik@example.com', '9000000002'),
(4, 'sahil', 'kamble', 'sahil.kamble@example.com', '9000000003'),
(5, 'sanika', 'bhor', 'sanika.bhor@example.com', '9000000004'),
(6, 'sumit', 'bhor', 'sumit.bhor@example.com', '9000000005'),
(7, 'nikita', 'bansode', 'nikita.bansode@example.com', '9000000006'),
(8, 'pranita', 'mane', 'pranita.mane@example.com', '9000000007'),
(9, 'rutuja', 'mokale', 'rutuja.mokale@example.com', '9000000008'),
(10, 'pankaj', 'bhor', 'pankaj.bhor@example.com', '9000000009'),
(11, 'sarthak', 'walake', 'sarthak.walake@example.com', '9000000010'),
(12, 'naina', 'surve', 'naina.surve@example.com', '9000000011'),
(13, 'nikhil', 'navale', 'nikhil.navale@example.com', '9000000012'),
(14, 'sarthak', 'kadam', 'sarthak.kadam@example.com', '9000000013');
select *from employees;
