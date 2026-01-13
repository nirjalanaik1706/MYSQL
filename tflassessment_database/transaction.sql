create database transaction;
use transaction;

CREATE TABLE accounts (
    accountid INT PRIMARY KEY,
    balance DECIMAL(10,2) NOT NULL
);

INSERT INTO accounts (accountid, balance) VALUES
(1, 5000.00),
(2, 3000.00);


DELIMITER $$

CREATE PROCEDURE FundTransfer(
    IN fromAcc INT,
    IN toAcc INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE bal DECIMAL(10,2);

    START TRANSACTION;

    SELECT balance INTO bal
    FROM accounts
    WHERE accountid = fromAcc;

    IF bal >= amount THEN

        UPDATE accounts
        SET balance = balance - amount
        WHERE accountid = fromAcc;

        UPDATE accounts
        SET balance = balance + amount
        WHERE accountid = toAcc;

        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END $$

DELIMITER ;

CALL FundTransfer(2, 1, 3000);
SELECT * FROM accounts;


