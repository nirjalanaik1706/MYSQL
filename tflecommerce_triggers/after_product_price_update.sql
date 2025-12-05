-- 4. Trigger to Log Changes to Product Prices

DELIMITER //
	CREATE TRIGGER after_product_price_update
    AFTER UPDATE ON products
    FOR EACH ROW
BEGIN
	insert into price_changes(product_id,old_price,new_price,change_date)
    values(OLD.id,OLD.price,NEW.price,NOW());
END //
DELIMITER ;
insert into price_changes(product_id,old_price,new_price,change_date)values(20,69.99,100.00,now());