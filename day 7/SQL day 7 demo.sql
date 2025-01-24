use ITI

declare @x int
set @x=10
select @x

declare @x int
select @x=10
select @x

declare @x int=10
select @x

declare @x int=(select avg(st_age) from Student)
select @x

declare @y int
select @y=st_age from Student where st_id=10
select @y

declare @y int,@name varchar(20)
select @y=st_age,@name=st_fname from student where st_id=10
select @y,@name

declare @z int
update Student set st_fname='ali',@z=dept_id
where st_id=7
select @z

declare @t table(x int,y varchar(20))
insert into @t
select st_id,st_fname from student where St_Address='alex'
select * from @t

declare @x int=4
select top(@x) * from Student

select 'select * from student'

execute('select * from student')

--------------------------------------------------------

select @@SERVERNAME

select @@version

update Student set st_age+=1

select @@ROWCOUNT

select @@ROWCOUNT

select @@ERROR

select * from stu
go
select @@ERROR

select @@IDENTITY

------------------------------------
-- control of flow control

-- if
declare @x int 

update student 
set St_Age+=1

select @x=@@ROWCOUNT

if @x>0
  begin
  select'multi row affect'
  end
else
  begin
  select'no row'
  end

-- begin
-- end
-- if exists if not exists
select * from sys.columns

select * from sys.tables

if exists(select name from sys.tables)
  select'table is exist'
else
create table student(
    id int,
	name varchar(20)
	)

begin try
   delete from Department where dept_id=20
end try

begin catch
   select 'error'
   select Error_line(),ERROR_NUMBER(),ERROR_MESSAGE()
end catch
-- while 

-- case 
-- continue 
-- break
-- iif
-- waitfor


-----------
-- batch 
create table 
delete table

-- scribt 
create table 
go
delete table

-- transaction [set of queries ] ------> single unit of work
create table parent (pid int primary key)
create table child(cid int foreign key references parent(pid))

insert into parent values(1)
insert into parent values(2)
insert into parent values(3)
insert into parent values(4)

insert into child values(1)
insert into child values(5)
insert into child values(3)

select * from child

truncate table child

begin transaction
   insert into child values(1)
   insert into child values(2)
   insert into child values(3)
rollback

begin transaction
   insert into child values(1)
   insert into child values(5)
   insert into child values(3)
commit


begin try
   begin transaction
      insert into child values(1)
      insert into child values(5)
      insert into child values(3)
   commit
end try
begin catch
   rollback
end catch

--------------------------------
-- functions

select getdate()

select isnull(st_fname,'') from student

select upper(st_fname),lower(st_fname) from student

select len(st_fname) from student

select max(st_fname) from student

select top(1) st_fname 
from student 
order by len(St_Fname) desc

select power(salary,2) from Instructor

---------------------------------------------------------

-- create my own function 

-- windowing
-- lead lag first_value last_value






