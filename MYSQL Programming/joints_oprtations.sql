USE bankingdb;
SELECT * FROM accounts;
SELECT * FROM customers;
-- inner join
select c.FullName, a.AccountNumber, a.Balance from Customers c 
join accounts a on a.CustomerID = c.CustomerID;

-- left  join
select c.FullName, a.AccountNumber, a.Balance from Customers c 
left join accounts a on a.CustomerID = c.CustomerID;
 -- Full join

 -- right join
 select c.FullName,a.AccountNumber,a.Balance from accounts a
 right join customers c on a.CustomerID=c.CustomerID;
 -- full join
select c.FullName, a.AccountNumber, a.Balance from Customers c 
left join accounts a on a.CustomerID = c.CustomerID
 UNION
 select c.FullName,a.AccountNumber,a.Balance from accounts a
 right join customers c on a.CustomerID=c.CustomerID;
 
 
 
 
 