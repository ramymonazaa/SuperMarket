drop function if exists ins_branch;
delimiter $
create function ins_branch(branch_address varchar(50),branch_name varchar(50),Manager_id int) returns bool
begin
	insert into Branch values(null,Manager_id,branch_address,branch_name);
    return true;
end$
delimiter ;
set @ok=ins_branch('assiut','elcola',1);
call Show_Branch();
delimiter $
drop function if exists ins_Bill;
create function ins_Bill(Bill_date datetime,Bill_Total_Price double,Branch_address varchar(50)) returns bool
begin
	insert into Bill values(null,Bill_date,Bill_Total_Price,Branch_address);
    return true;
end$
delimiter ;
set @ok=ins_Bill(now(),null,'assiut');
call Show_bills();
call Show_products();
insert into Product values(null,'alaa','suger',3.5,4,100);
insert into Buy values(2,1,10);
select *from Buy;
delete from Buy where Bill_id=2;
delete from Bill where Bill_id=2;
