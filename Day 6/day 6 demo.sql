--what is Schema 
--it is Logical grouping for tables and data base objects
--Why we need Schema ?
--1-we can't make more than one object in Data base(table , view ,...) 
--with same name 
--2-Too Much Permission if we deal with each table indevidually
--3- We could give permision in schema 

------------------------Create Schema --------------------------


use ITI
create schema HR

-- select *
-- from serverName.DatabaseName.SchemaName.TableName

select * from [DESKTOP-5R03G04].iti.dbo.student

create schema sales

--to move an existing table to my new schema
alter schema HR transfer dbo.student 
alter schema HR transfer dbo.instructor
alter schema Sales transfer dbo.department

select * from [DESKTOP-5R03G04].iti.HR.student

select * from [DESKTOP-5R03G04].iti.HR.Instructor

select * from [DESKTOP-5R03G04].iti.sales.department

create table HR.stud(
                    id int,
					name varchar(20)
					)

--Create table inside specific schema
create table sales.student(
                           id int,
						   name varchar(20)
						   )
select * from HR.stud
select * from HR.student
select * from HR.instructor
select * from sales.student

-----------------Don't forget to change schema using wizerd---------------
use ITI

alter schema dbo transfer HR.student 
alter schema dbo transfer HR.instructor
alter schema dbo transfer sales.department

------------------------synonym-----------------------------------------
--what is synonym ? Saved alias name 

create synonym s1
for HR.student

select * from s1

select s.St_Id
from HR.Student s

use AdventureWorks2012

create synonym HE
for HumanResources.EmployeeDepartmentHistory

select * from HE

---------------------------------Data base intergrity---------------------------


---------------------------------------Conistraint-------------------------------------
--Set of conditions we apply it in columns 
--Constraint applied to new and old data so if old data dosen't match 
--Conistraint it won't Created 

create table Dept(
                 dept_id int primary key,
				 name varchar(20)
				 )

create table emp(
eid int identity(1,1),
ename varchar(20),
e_add varchar(20) default 'alex',
hiredate date default getdate(),
sal int,
overtime int,
net_salary as(isnull(sal,0)+isnull(overtime,0)),
BD date,
age as(year(getdate())-year(BD)),
gender varchar(1),
hour_rate int not null,
did int,
constraint c11 primary key(eid,ename),
constraint c12 unique(sal),
constraint c13 unique(overtime),
constraint c14 check(sal>1000),
constraint c15 check( e_add in ('cairo','mansoura','alex')),
constraint c16 check(gender='f' or gender='m'),
constraint c17 check(overtime between 100 and 500),
constraint c18 foreign key(did) references Dept(dept_id)

)

--Note Constraint on old and new data 

alter table emp add constraint c100 check(hour_rate>100)


--Drop Constraint 
alter table emp drop constraint c13

-------------------------------------Rules----------------------------------------------
--what if we want to apply Constraint in new data only
--what if we want to write Constraint once and make it shaired on more than one column
--what if we want to Datatype and apply constraint and Rules on it 
--As Resualt for all of that their is a Rules that solve ali this problems
--XXXXX       Constraint   ---> New Data
--XXXXX       Constraint   --->shared 
--XXXXX       Datatype        Constraint    Default

select * from dbo.emp