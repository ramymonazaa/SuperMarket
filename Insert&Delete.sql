use subermarket;

drop function if exists ins_branch;
delimiter $
create function ins_branch(branch_address varchar(50),branch_name varchar(50),Manager_id int) returns bool
begin
	insert into Branch_Manage values(null,branch_address);
    insert into Addreess_Branch values(Manager_id,branch_address,branch_name);
    return true;
end$
delimiter ;
set @ok=ins_branch(1,'elcola',1);
call Show_Branch_Manage();
call Show_Addreess_Branch();

drop function if exists ins_supplier;
delimiter $
create function ins_supplier(Supplier_address varchar(50),Supplier_phone varchar(50),Supplier_email varchar(50),Supplier_name varchar(50)) returns bool
begin
    insert into Address_Supplier values(null,Supplier_address);
    insert into Supplier_AddressToPhone values(Supplier_address,Supplier_phone);
    insert into Supplier_PhoneToEmail values(Supplier_phone,Supplier_email);
    insert into Supplier_EmailToName values(Supplier_email,Supplier_name);
    return true;
end$
delimiter ;
set @su=ins_supplier('sohag','0155','wfq','ali');
call Show_Address_Supplier;
call Show_Supplier_AddressToPhone;
call Show_Supplier_PhoneToEmail;
call Show_Supplier_EmailToName;


drop function if exists ins_bill;
delimiter $
create function ins_bill(Bill_Date datetime,Bill_Price varchar(50),Branch_Address varchar(50)) returns bool
begin
	insert into Bill values(null,Bill_Date,Bill_Price,Branch_Address);
    return true;
end$
delimiter ;
set @bil=ins_bill('14-4-2017','44','1');#possible problem
call Show_Bill();

drop function if exists ins_employee;
delimiter $
create function ins_employee (Employee_Phone varchar(50),Employee_Name varchar(50),Employee_Sallary varchar(50)) returns bool
begin
	insert into employee_ values(null,Employee_Phone);
    insert into employee_info values(Employee_Name,Employee_Sallary,Employee_Phone,null);
    return true;
end$
delimiter ;
set @emp=ins_employee('01121','youssef','3000');
select * from employee_;
select * from employee_info;

drop function if exists ins_product;
delimiter $
create function ins_product (pro_name varchar(50),pro_type varchar(50),pro_price double,pro_market_price double,pro_quantity int) returns bool
begin
	insert into Product_Main_Info values(null,pro_name);
    insert into Product_Info values(pro_name,pro_type,pro_price,pro_market_price,pro_quantity);
    return true;
end$
delimiter ;
set @prod= ins_product('name','type',3.2,3.5,2);
select * from Product_Main_Info1;
select * from Product_Main_Info2;

drop procedure if exists del_product;
delimiter $
create procedure del_product (pro_name varchar(50))
begin
	delete from Product_Main_Info where product_name = pro_name;
    #delete from Product_Info where product_name = pro_name;
end$
delimiter ;
call Show_Product_Main_Info();
call del_product('name');

drop procedure if exists del_employee;
delimiter $
create procedure del_employee (Employee_Phone varchar(50),Employee_Name varchar(50))
begin
	delete from Employee_ where Employee_phone=Employee_Phone and Employee_name=Employee_Name;
    delete from Employee_info where Employee_phone=Employee_Phone and Employee_name=Employee_Name;
end$
delimiter ;
call del_employee('01121','youssef');

drop procedure if exists del_bill;
delimiter $
create procedure del_bill (id int)
begin
	delete from Bill where Bill_id=id;
end$
delimiter ;
call del_bill(2);
call Show_Bill();