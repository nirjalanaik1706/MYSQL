-- 2. Trigger to Prevent Deletion of a Product with Existing Orders
delimiter //
CREATE TRIGGER before_product_delete
	BEFORE DELETE ON products
	FOR EACH ROW
BEGIN
	IF EXISTS (
		SELECT 1 
		from order_item oi
		where oi.order_id=old.id
        )
		THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cannot delete product with existing orders.';
	END IF;
	END //
    delimiter ;
