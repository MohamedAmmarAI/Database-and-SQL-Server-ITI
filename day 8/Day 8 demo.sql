 
 ------------------------------------------- indexes ------------------------------
 use ITI

 select * from Student where St_Age=18

 create nonclustered index myindex
 on student(st_fname)

 create nonclustered index myindex2 
 on student(st_lname)

 -- pk      -- constraint  ---> clustered index

 -- unique  -- constraint --> non cluster index

 ---------------------------------------------------------------

 -- physical tables

 create table exam (
                 eid int,
				 edate date,
				 numoq int
 )

 select * from exam

 drop table exam

 --Local table   --session based tables

 Create table #exam
(
eid int,
edate date,
numofQ int
)

insert into #exam values(1 , '12-2-2020' , 3)
select * from #exam 

--global table   --shared tables


--global table   --shared tables
Create table ##exam
(
eid int,
edate date,
numofQ int
)

insert into ##exam values(234, '12-2-2020' , 567)
select * from ##exam 



------------------------------Views------------------------------------

/** Views **/
/*
IS A Saved select statment we can't write insert update delete in it .

Views Properties : 
�	No DML Queries inside view body 
�	Standered View may be Considered as Virtual table 
�	Has No Parms 

--Why and when we use it?
�	Simplify construction of complex queries
�	Specify user view
�	Limit access to data [grant revoke]
�	Hide names of database objects [table name and columns]
*/								


/** Creating Views **/

create view vstuds
as 
   select * from Student

---Selecting data from View 

select * from vstuds


---Alias name for view column 
--Create view that contain cairo strudent informatio
create view vcairo
as
   select st_id,st_fname,st_address 
   from student
   where st_address='cairo'

alter view vcairo(sid,sname,sadd)
as
   select st_id,st_fname,st_address 
   from student
   where st_address='cairo'

select * from vcairo

select sname from vcairo

--Create view that containt alex strudent informatio
create view valex
as 
   select st_id,st_fname,st_address
   from student
   where St_Address='alex'

select * from valex

sp_helptext valex

--Create view for cairo and alex students--
--View inside view 

create view Vall
as
select * from vcairo
union all
select * from valex
-----------------------------------

select * from Vall

Create view Vjoin(sid,sname,did,dname)
with encryption
as
select st_id,st_fname,d.dept_id,dept_name
from student S inner join department d
	on d.dept_id=s.dept_id


select * from vjoin

select sname,dname from vjoin

select sname,dname from vjoin

-- view for sname,dname,grade
create view vgrades
as
select sname,dname,grade
from vjoin v inner join Stud_Course sc
	on v.sid=sc.St_Id

select * from vgrades

sp_helptext 'vgrades'

----------------------For view security------------------------------
create view vgrades
with encryption
as
select sname,dname,grade
from vjoin v inner join Stud_Course sc
	on v.sid=sc.St_Id

----------------------------------- View+DML -------------------------------------
-----View DML in One table
	
---------------------------1- Insert in one table--------------------------------- 
--1- Rest column in table that we toke view from should have one of the flowing
--(Defualt value , identity , allow null , derived)

insert into vcairo
values(234,'ali','cairo')

-------------------With Check options-------------------------
insert into vcairo
values(325,'ali','alex')

alter view Vcairo(sid,sname,sadd)
as
	Select st_id,st_fname,st_address
	from Student
	where st_address='cairo'
with check option

insert into vcairo
values(329,'ali','alex')

select * from vcairo

--------------------------------------Update-----------------------------

update Vcairo
set sname='nour' where sid=29

--------------------------------------Delete -----------------------------

delete from vcairo
where sname='nour'

-------------------DML with view that came from Multi tables-----------------------

alter view Vjoin(sid,sname,did,dname)
with encryption
as
select st_id,st_fname,d.dept_id,dept_name
from student S inner join department d
	on d.dept_id=s.dept_id

--Delete XXXXXXXXXXXXXXXX

select * from Vjoin

--insert   update avilable with conditions
-----------1-insert and update must affect in one table 

insert into vjoin
values(21,'nada',700,'Cloud')

--insert in table 
insert into vjoin(sid,sname)
values(21,'nada')

insert into vjoin(did,dname)
values(700,'Cloud')

update vjoin 
set sname ='Doaa'
where sid=5

--indexed view --Continued--
--When we use it When you use the same complex query on many tables, multiple times.
--When new system need to read old table data, but doesn't watch to change their
--perceived schema.
create view vdata
with schemabinding
as
	select ins_name,salary
	from dbo.Instructor   --We have to write Schema name 
	where dept_id=10 

--Fist one will be altered
alter table instructor alter column ins_degree varchar(50)

--But this one will not altered because it's found in view 
--and view take phicycal copy from table 
alter table instructor alter column ins_name varchar(100)

