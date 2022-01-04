use subermarket;

drop procedure if exists Search_Branch_Manage_ByID;
delimiter $
create procedure Search_Branch_Manage_ByID(id int)
begin	
    select * from Branch_Manage where Branch_id=id;
end$
delimiter ;

drop procedure if exists Search_Addreess_Branch_ByAddress;
delimiter $
create procedure Search_Addreess_Branch_ByAddress(Addreess_Branch_id varchar(50))
begin	
    select Manager_id,Branch_name from Addreess_Branch where Addreess_Branch=Addreess_Branch_id;
end$
delimiter ;


drop procedure if exists Search_Product_Main_Info_ByID;
delimiter $
create procedure Search_Product_Main_Info_ByID(id int)
begin	
    select * from Product_Main_Info where Product_id=id;
end$
delimiter ;

drop procedure if exists Search_Product_Info_ByName;
delimiter $
create procedure Search_Product_Info_ByName(product_name_id varchar(50))
begin	
    select * from Product_Info where product_name=product_name_id;
end$
delimiter ;


drop procedure if exists Search_Employee__ByID;
delimiter $
create procedure Search_Employee__ByID(id int)
begin
	select * from Employee_ where Employee_id=id;
end$
delimiter ;

drop procedure if exists Search_Employee_Info_ByPhone;
delimiter $
create procedure Search_Employee_Info_ByPhone(Employee_Info_phone int)
begin
	select Employee_sallary,Employee_name,Branch_id from Employee_Info where Employee_phone=Employee_Info_phone;
end$
delimiter ;

#begint supplier

drop procedure if exists Search_Address_Supplier_ByID;
delimiter $
create procedure Search_Address_Supplier_ByID(id int)
begin
	select * from Address_Supplier where Supplier_id=id;
end$
delimiter ;

drop procedure if exists Search_Supplier_AddressToPhone_BySupplier_address;
delimiter $
create procedure Search_Supplier_AddressToPhone_BySupplier_address(Supplier_address varchar(50))
begin
	select Supplier_phone from Supplier_AddressToPhone where Supplier_address=Supplier_address;
end$
delimiter ;

drop procedure if exists Search_Supplier_PhoneToEmail_BySupplier_phone;
delimiter $
create procedure Search_Supplier_PhoneToEmail_BySupplier_phone(Supplier_phone varchar(50))
begin
	select (Supplier_email) from Supplier_PhoneToEmail where Supplier_phone=Supplier_phone;
end$
delimiter ;

drop procedure if exists Search_Supplier_EmailToNmae_BySupplier_email;
delimiter $
create procedure Search_Supplier_EmailToName_BySupplier_email(Supplier_email varchar(50))
begin
	select Supplier_name from Supplier_EmailToName where Supplier_email=Supplier_email;
end$
delimiter ;

#end supplier

drop procedure if exists Bill_ById;
delimiter $
create procedure Bill_ById(Bill_id int)
begin
	select * from Bill where Bill_id=Bill_id;
end$
delimiter ;
