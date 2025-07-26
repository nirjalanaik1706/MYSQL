-- 3. Creating a Stored Procedure for Updating User Information
drop procedure UpdateInfo;
delimiter //
create procedure UpdateInfo(
		IN p_id int,
        IN p_email varchar(100),
        IN p_address varchar(255)
	)
    begin
		update users
        set email=p_email,address=p_address
        where id=p_id;
	end //
delimiter ;
call UpdateInfo(1,"sahil@gmail.com","surli,satara");
        