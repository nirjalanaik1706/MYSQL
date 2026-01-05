create database transaction;
use transaction;

CREATE TABLE accounts (
    accountid INT PRIMARY KEY,
    balance DECIMAL(10,2) NOT NULL
);

INSERT INTO accounts (accountid, balance) VALUES
(1, 5000.00),
(2, 3000.00);


START TRANSACTION;

SELECT balance INTO @bal
FROM accounts
WHERE accountid=1
FOR UPDATE;


DELIMITER $$

CREATE PROCEDURE FundTransfer(
IN fromAcc INT,
IN toAcc INT,
IN amount DECIMAL(10,2)
)
BEGIN 
DECLARE bal DECIMAL(10,2);

IF @bal >= 1000 THEN
	UPDATE accounts
    SET balance=balance-1000
    WHERE accountid=1;
    
    UPDATE accounts
    SET balance=balance+1000
    WHERE accountid=2;
    
    COMMIT;
ELSE
	ROLLBACK;
END IF;
END $$

DELIMITER ;

CALL FundTransfer(1, 2, 200);
SELECT * FROM accounts;


