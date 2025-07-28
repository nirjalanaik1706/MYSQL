-- 3.Trigger to Automatically Set Order Status to 'Shipped' After Shipping Date is Updated
delimiter //
	CREATE TRIGGER after_shipping_date_update
	AFTER UPDATE ON orders
	FOR EACH ROW
BEGIN 
		IF NEW.shipping_date IS NOT NULL AND OLD.shipping_date IS NULL
    THEN
		UPDATE orders
		SET status="Shipped"
		WHERE id=NEW.id;
	END IF;
end //
delimiter ;