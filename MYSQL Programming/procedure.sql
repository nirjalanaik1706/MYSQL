create database bankingdb;
use bankingdb;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address TEXT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    AccountNumber VARCHAR(20) UNIQUE NOT NULL,
    AccountType ENUM('SAVINGS', 'CURRENT') DEFAULT 'SAVINGS',
    Balance DECIMAL(15, 2) DEFAULT 0.00,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE Operations (
    OperationID INT PRIMARY KEY AUTO_INCREMENT,
    FromAccountID INT,
    ToAccountID INT,
    Amount DECIMAL(15, 2) NOT NULL,
    OperationType ENUM('TRANSFER', 'DEPOSIT', 'WITHDRAWAL') NOT NULL,
    OperationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('PENDING', 'SUCCESS', 'FAILED') DEFAULT 'SUCCESS',
    FOREIGN KEY (FromAccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (ToAccountID) REFERENCES Accounts(AccountID)
);


INSERT INTO Customers (FullName, Email, Phone, Address)
VALUES 
('Ravi Tambade', 'ravi@example.com', '9876543210', 'Pune, Maharashtra'),
('Tejas Kulkarni', 'tejas@example.com', '9988776655', 'Mumbai, Maharashtra'),
('Sneha Joshi', 'sneha@example.com', '9123456780', 'Nagpur, Maharashtra');



INSERT INTO Accounts (CustomerID, AccountNumber, AccountType, Balance)
VALUES 
(1, 'ACC1001', 'SAVINGS', 50000.00),
(1, 'ACC1002', 'CURRENT', 150000.00),
(2, 'ACC2001', 'SAVINGS', 25000.00),
(3, 'ACC3001', 'SAVINGS', 80000.00);

-- Fund Transfer from Ravi's Savings (ACC1001) to Tejas (ACC2001)

INSERT INTO Operations (FromAccountID, ToAccountID, Amount, OperationType)
VALUES 
(1, 3, 5000.00, 'TRANSFER');

--  Deposit into Sneha's account

INSERT INTO Operations (FromAccountID, ToAccountID, Amount, OperationType)
VALUES 
(NULL, 4, 10000.00, 'DEPOSIT');


-- Withdrawal from Ravi’s Current account

INSERT INTO Operations (FromAccountID, ToAccountID, Amount, OperationType)
VALUES 
(2, NULL, 7000.00, 'WITHDRAWAL');



-- Optional Query: Verify Data


-- List customers and their accounts
SELECT c.FullName, a.AccountNumber, a.Balance
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID;

-- View all transactions
SELECT o.OperationID, a1.AccountNumber AS FromAcc, a2.AccountNumber AS ToAcc, 
       o.Amount, o.OperationType, o.OperationDate
FROM Operations o
LEFT JOIN Accounts a1 ON o.FromAccountID = a1.AccountID
LEFT JOIN Accounts a2 ON o.ToAccountID = a2.AccountID;


-- Create Procedure --
DELIMITER //

CREATE PROCEDURE FundTransfer(
   IN FromAcc INT,
   IN ToAcc INT,
   IN Amount DECIMAL(15,2)
)
BEGIN
   DECLARE SendAmount DECIMAL(15,2);

   SELECT Balance INTO SendAmount 
   FROM Accounts 
   WHERE AccountID = FromAcc 
   FOR UPDATE;

   IF SendAmount < Amount THEN
      ROLLBACK;
   ELSE
      UPDATE Accounts 
      SET Balance = Balance - Amount 
      WHERE AccountID = FromAcc;

      UPDATE Accounts 
      SET Balance = Balance + Amount 
      WHERE AccountID = ToAcc;

      INSERT INTO Operations (FromAccountID, ToAccountID, Amount, OperationType)
      VALUES (FromAcc, ToAcc, Amount, 'Transfer');

      COMMIT;
   END IF;
END //

DELIMITER ;
call FundTransfer(1,3,2345);
drop procedure FundTransfer;
-- drop procedure FundTransfer;