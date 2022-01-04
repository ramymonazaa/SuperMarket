use SuperMarket;
drop procedure if exists Show_employees;
delimiter $
create procedure Show_employees()
begin
	select * from Employee;
end$
delimiter ;
drop procedure if exists Show_branch;
delimiter $
create procedure Show_branch()
begin
	select * from Branch;
end$
delimiter ;

drop procedure if exists Show_products;
delimiter $
create procedure Show_products()
begin
	select * from Product;
end$
delimiter ;

drop procedure if exists Show_bills;
delimiter $
create procedure Show_bills()
begin
	select * from Bill;
end$
delimiter ;

drop procedure if exists Show_suppliers;
delimiter $
create procedure Show_suppliers()
begin
	select * from Supplier;
end$
delimiter ;