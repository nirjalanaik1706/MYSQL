-- 1. Creating a Stored Procedure for User Registration
use tflecommerce;
delimiter //
create procedure RegisterUsers(
		IN p_username varchar(50),
        IN p_password varchar(255),
        IN p_email varchar (100),
        IN p_address varchar(255)
	)
    begin
    insert into users(username,password,email,address)
    values(p_username,p_password,p_email,p_address);
    end //
    delimiter ;
    
    call RegisterUsers("nirjala naik","nirjala@17","nirjala.naik@gmail.com","kolhapur");
  
    