use subermarket;

drop procedure if exists Show_Branch_Manage;
delimiter $
create procedure Show_Branch_Manage()
begin	
    select * from Branch_Manage;
end$
delimiter ;

drop procedure if exists Show_Addreess_Branch;
delimiter $
create procedure Show_Addreess_Branch()
begin	
    select Manager_id,Branch_name from Addreess_Branch;
end$
delimiter ;


drop procedure if exists Show_Product_Main_Info;
delimiter $
create procedure Show_Product_Main_Info()
begin	
    select * from Product_Main_Info ;
end$
delimiter ;

drop procedure if exists Show_Product_Info;
delimiter $
create procedure Show_Product_Info()
begin	
    select * from Product_Info;
end$
delimiter ;


drop procedure if exists Show_Employee_;
delimiter $
create procedure Show_Employee_()
begin
	select * from Employee_;
end$
delimiter ;

drop procedure if exists Show_Employee_Info;
delimiter $
create procedure Show_Employee_Info()
begin
	select Employee_sallary,Employee_name,Branch_id from Employee_Info;
end$
delimiter ;

#begint supplier

drop procedure if exists Show_Address_Supplier;
delimiter $
create procedure Show_Address_Supplier()
begin
	select * from Address_Supplier;
end$
delimiter ;

drop procedure if exists Show_Supplier_AddressToPhone;
delimiter $
create procedure Show_Supplier_AddressToPhone()
begin
	select Supplier_phone from Supplier_AddressToPhone;
end$
delimiter ;

drop procedure if exists Show_Supplier_PhoneToEmail;
delimiter $
create procedure Show_Supplier_PhoneToEmail()
begin
	select (Supplier_email) from Supplier_PhoneToEmail;
end$
delimiter ;

drop procedure if exists Show_Supplier_EmailToName;
delimiter $
create procedure Show_Supplier_EmailToName()
begin
	select Supplier_name from Supplier_EmailToName;
end$
delimiter ;

#end supplier

drop procedure if exists Show_Bill;
delimiter $
create procedure Show_Bill()
begin
	select * from Bill;
end$
delimiter ;
