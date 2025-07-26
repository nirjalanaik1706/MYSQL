-- 3. Creating a Stored Procedure for Updating User Information

DROP PROCEDURE IF EXISTS UpdateUserInfo;
DELIMITER //

CREATE PROCEDURE UpdateUserInfo(
    IN p_user_id INT,
    IN p_email VARCHAR(100),
    IN p_address VARCHAR(255)
)
BEGIN
    UPDATE users
    SET email = p_email, address = p_address
    WHERE id = p_user_id;
END //

DELIMITER ;

CALL UpdateUserInfo(1, 'nirjala@gmailcom', 'kolhapur');

