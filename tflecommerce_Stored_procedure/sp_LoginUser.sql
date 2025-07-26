-- 2. Creating a Stored Procedure for User Login
delimiter //
create procedure LoginUser(
		IN p_username varchar(50),
        IN p_password varchar(255)
        )
	begin 
    select id,username,email
    from users
    where username=p_username and password =p_password;
    end //
    delimiter ;
    
    call LoginUser("nirjala naik","nirjala@17");