use SuperMarket;
drop procedure if exists Search_Product_ByID;
delimiter $
create procedure Search_Product_ByID(id int)
begin	
    select * from Product where Product_id=id;
end$
delimiter ;
drop procedure if exists Search_Employee_ByID;
delimiter $
create procedure Search_Employee_ByID(id int)
begin
	select * from Employee where Employee_id=id;
end$
delimiter ;

drop procedure if exists Search_Supplier_ByID;
delimiter $
create procedure Search_Supplier_ByID(id int)
begin
	select * from Supplier where Supplier_id=id;
end$
delimiter ;
