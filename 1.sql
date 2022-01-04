drop database if exists SuperMarket;
create database SuperMarket;
use SuperMarket;
drop table if exists Branch;
create table Branch(
Branch_id int auto_increment primary key,
Manager_id int ,
Branch_address varchar(50),
Branch_name varchar(50),
unique key Branch_address_UNIQUE (Branch_address,Branch_id)
    ,key key_1 (Branch_id,Branch_address)
);
drop table if exists Employee;
create table Employee(
Employee_id int auto_increment primary key,
Employee_name varchar(50),
Employee_sallary double,
Employee_phone varchar(15),
Branch_id int 
,key networks_fk3 (Branch_id),
constraint networks_fk3 FOREIGN KEY (Branch_id)REFERENCES Branch(Branch_id)ON DELETE CASCADE ON update cascade
,unique key Employee_phone_UNIQUE (Employee_phone)
    ,key key_1 (Employee_id,Employee_phone,Employee_name)
);
drop table if exists Log_in;
create table Log_in(
E_Password varchar(50),
E_id int references Employee(Employee_id),
# we will make third input in form represent Branch_id we will not store as it stored in Employee 
# we will just compare the input without store with Employee.Branch_id
primary key(E_id,E_Password)
);
drop trigger if exists Ins_Employee_Sallary;
delimiter $
create trigger Ins_Employee_Sallary 
before insert on Employee
for each row 
begin
if new.Employee_sallary<2000 then
set new.Employee_sallary=2000;
end if;
if new.Employee_sallary>10000 then
set new.Employee_sallary=10000;
end if;
end $
delimiter ;
drop table if exists Supplier;
create table Supplier(
Supplier_id int auto_increment primary key,
Supplier_name varchar(50),
Supplier_phone varchar(50),
Supplier_address varchar(50),
Supplier_email varchar(50),
unique key Supplier_UNIQUE (Supplier_address),
    key key_2 (Supplier_id,Supplier_address)
);

drop table if exists Product;
create table Product(
Product_id int auto_increment primary key,
product_name varchar(50),
product_type varchar(50),
product_price double,
product_Market_Price double,
product_quantity int,
unique key(product_name),
    key key_2 (Product_id,product_name)
);
drop table if exists Supplies;#bridge between Supplier and Product
create table Supplies(
	Supplier_id int,
    Product_id int,
    Product_amount int,
    primary key(Supplier_id,Product_id),
    key key_4 (Supplier_id)
    ,key networks_fk8 (Supplier_id),
   constraint networks_fk8 FOREIGN KEY (Supplier_id)
        REFERENCES Supplier(Supplier_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
	key key_2 (Product_id)
    ,key networks_fk10 (Product_id),
   constraint networks_fk10 FOREIGN KEY (Product_id)
        REFERENCES Product(Product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
drop trigger if exists Ins_Supplies;
delimiter $
create trigger Ins_Supplies 
before insert on Supplies#require to check that amoun of product less than product quantity
for each row 
begin
if new.Product_amount<1 then
set new.Product_amount=1;
end if;
update  Product set product_quantity=product_quantity-Product_amount;
end $
delimiter ;

drop table if exists Bill;
create table Bill(
Bill_id int auto_increment primary key,
Bill_date datetime,
Bill_Total_Price double,
Branch_address varchar(50),
key key_2 (Branch_address,Bill_id)
    ,key networks_fk11 (Branch_address),
   constraint networks_fk11 FOREIGN KEY (Branch_address)
        REFERENCES Branch(Branch_address)
        ON DELETE CASCADE ON UPDATE CASCADE
);

drop table if exists Buy;#bridge between Product and Bill
create table Buy(
	Bill_id int,
    Product_id int ,
    Product_Amount int,
    primary key(Bill_id,Product_id)
    ,key networks_fk12 (Bill_id),
   constraint networks_fk12 FOREIGN KEY (Bill_id)
        REFERENCES Bill(Bill_id)
        ON DELETE CASCADE ON UPDATE CASCADE
    ,key networks_fk13 (Product_id),
   constraint networks_fk13 FOREIGN KEY (Product_id)
        REFERENCES Product(Product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

