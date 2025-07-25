-- 4. Creating a Stored Procedure for Applying a Discount Code

-- procedure creation
-- parameter->IN
-- begin
-- varibale declare
-- select 
-- set value 
-- check condition it exists
-- apply discount
-- update table 
-- else msg disply
-- end if
-- end 
drop procedure ApplyDiscount;
delimiter //
create procedure ApplyDiscount(
		in p_order_id int,
        in p_discount_code varchar(50)
	)
	begin
    declare v_discount decimal(5,2);
    declare v_total decimal(10,5);
    
    select discount_percentage into v_discount
    from discount_codes
    where code = p_discount_code and now() between start_date and end_date;
		
        if v_discount is not null then
        select total_amount into v_total
        from orders
        where id=p_order_id;
		
        set v_total=v_total-(v_total *(v_discount/100));
        update orders 
        set total_amount=v_total
        where id=p_order_id;
        
	else
		signal sqlstate '45000' set message_text="Invalid";
	end if;
    end //
    delimiter ;
    use tflecommerce;
        select* from discount_codes where code="DIWALI21";
        call ApplyDiscount(20,"HOLI23");
 
