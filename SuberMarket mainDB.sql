drop database if exists subermarket;
create database SuberMarket;
use SuberMarket;
drop table if exists Branch_Manage;
CREATE TABLE Branch_Manage (
    Branch_id INT auto_increment,
    Branch_address varchar(50),
    primary key(Branch_id,Branch_address),
    unique key Branch_address_UNIQUE (Branch_address,Branch_id)
    ,key key_1 (Branch_id,Branch_address)
);
drop table if exists Addreess_Branch;
CREATE TABLE Addreess_Branch (
    Manager_id int ,
    Branch_address varchar(50),
    Branch_name varchar(50),
    key networks_fk1 (Branch_address),
   constraint networks_fk1 FOREIGN KEY (Branch_address)
        REFERENCES Branch_Manage(Branch_address)
        ON DELETE CASCADE
);
drop table if exists Employee_;
create table Employee_(
Employee_id int auto_increment,
Employee_phone varchar(15),
primary key(Employee_id,Employee_phone)
,unique key Employee_phone_UNIQUE (Employee_phone)
    ,key key_1 (Employee_id,Employee_phone)
);

drop table if exists Employee_Info;
create table Employee_Info(
Employee_name varchar(50),
Employee_sallary double,
Employee_phone varchar(15)primary key ,
Branch_id int,
#references Employee_(Employee_phone),
key networks_fk2 (Employee_phone),
   constraint networks_fk2 FOREIGN KEY (Employee_phone)
        REFERENCES Employee_(Employee_phone)
        ON DELETE CASCADE
,key networks_fk3 (Branch_id),
constraint networks_fk3 FOREIGN KEY (Branch_id)REFERENCES Branch_Manage(Branch_id)ON DELETE CASCADE
);

drop table if exists Log_in;
create table Log_in(
E_Password varchar(50),
E_id int references Employee_(Employee_id),
# we will make third input in form represent Branch_id we will not store as it stored in Employee 
# we will just compare the input without store with Employee.Branch_id
primary key(E_id,E_Password)
);

drop trigger if exists Ins_Employee_Sallary;
delimiter $
create trigger Ins_Employee_Sallary 
before insert on Employee_Info
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

drop table if exists Address_Supplier;
create table Address_Supplier(
Supplier_id int auto_increment ,
Supplier_address varchar(50),
primary key(Supplier_id,Supplier_address),
unique key Supplier_address_UNIQUE (Supplier_address),
    key key_2 (Supplier_id,Supplier_address)
);
drop table if exists Supplier_AddressToPhone;
create table Supplier_AddressToPhone(
Supplier_address varchar(15) ,
Supplier_phone varchar(50),
primary key(Supplier_phone,Supplier_address),
#references Employee_(Employee_phone),
key networks_fk4 (Supplier_address),
   constraint networks_fk4 FOREIGN KEY (Supplier_address)
        REFERENCES Address_Supplier(Supplier_address)
        ON DELETE CASCADE
);

drop table if exists Supplier_PhoneToEmail;
create table Supplier_PhoneToEmail(
Supplier_phone varchar(50),
Supplier_email varchar(50),
primary key(Supplier_phone,Supplier_email),
unique key Supplier_email_UNIQUE (Supplier_email),
    key key_3 (Supplier_phone,Supplier_email)
    ,key networks_fk5 (Supplier_phone),
   constraint networks_fk5 FOREIGN KEY (Supplier_phone)
        REFERENCES Supplier_AddressToPhone(Supplier_phone)
        ON DELETE CASCADE
);

drop table if exists Supplier_EmailToName;
create table Supplier_EmailToName(
Supplier_email varchar(50),
Supplier_name varchar(50),
primary key(Supplier_email),
unique key Supplier_email_UNIQUE (Supplier_email),
    key key_3 (Supplier_name,Supplier_email)
    ,key networks_fk6 (Supplier_email),
   constraint networks_fk6 FOREIGN KEY (Supplier_email)
        REFERENCES Supplier_PhoneToEmail(Supplier_email)
        ON DELETE CASCADE
);

drop table if exists Product_Main_Info;
create table Product_Main_Info(
Product_id int auto_increment,
product_name varchar(50),
primary key(Product_id,product_name),
unique key(product_name),
    key key_2 (Product_id,product_name)
);

drop table if exists Product_Info;
create table Product_Info(
product_name varchar(50) primary key,
product_type varchar(50),
product_price double,
product_Market_Price double,
product_quantity int,
#unique key product_name_UNIQUE (product_name),
    key key_2 (product_name)
    ,key networks_fk7 (product_name),
   constraint networks_fk7 FOREIGN KEY (product_name)
        REFERENCES Product_Main_Info(product_name)
        ON DELETE CASCADE
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
        REFERENCES Address_Supplier(Supplier_id)
        ON DELETE CASCADE,
	key key_2 (Product_id)
    ,key networks_fk10 (Product_id),
   constraint networks_fk10 FOREIGN KEY (Product_id)
        REFERENCES Product_Main_Info(Product_id)
        ON DELETE CASCADE
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
        REFERENCES Branch_Manage(Branch_address)
        ON DELETE CASCADE
);

drop table if exists Buy;#bridge between Product and Bill
create table Buy(
	Bill_id int references Bill(Bill_id),
    Product_id int references Product(Product_id),
    Product_Amount int,
    primary key(Bill_id,Product_id)
    ,key networks_fk12 (Bill_id),
   constraint networks_fk12 FOREIGN KEY (Bill_id)
        REFERENCES Bill(Bill_id)
        ON DELETE CASCADE
    ,key networks_fk13 (Product_id),
   constraint networks_fk13 FOREIGN KEY (Product_id)
        REFERENCES Product_Main_Info(Product_id)
        ON DELETE CASCADE
);