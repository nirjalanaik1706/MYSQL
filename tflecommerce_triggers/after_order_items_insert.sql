-- 1. Trigger to Update Stock After an Order is Placed

SELECT * FROM tflecommerce.order_items;
SELECT * FROM tflecommerce.products;
use tflecommerce;

delimiter //
create trigger after_order_items_insert
after insert on orders
for each row
begin
update products p 
join order_items oi on p.id=oi.item_id
set p.stock=p.stock-oi.quantity
where oi.id=new.id;
end //
delimiter ;
desc orders;


