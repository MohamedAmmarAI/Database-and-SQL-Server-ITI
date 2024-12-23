------------------------- Day 4 ----------------

use Company_SD

create table EMP(
                Eid int ,
				Ename varchar(20),
				salary int,
				address varchar(20),
				did int
				 ) 

INSERT INTO EMP (Eid, Ename, Salary, Address, did) VALUES
(1, 'ahmed', 3000, 'cairo', 10),
(2, 'ali', 5000, 'cairo', 10),
(3, 'eman', 2000, 'cairo', 10),
(4, 'khalid', 1000, 'alex', 10),
(5, 'yousef', 4000, 'alex', 10),
(6, 'sameh', 5000, 'alex', 10),
(7, 'mohamed', 6000, 'alex', 20),
(8, 'alaa', 7000, 'alex', 20),
(9, 'ola', 4000, 'cairo', 20),
(10, 'reem', 2000, 'cairo', 20),
(11, 'nada', 9000, 'cairo', 20),
(12, 'sayed', 8000, 'mansoura', 30),
(13, 'reham', 1500, 'mansoura', 30),
(14, 'sally', 2000, 'mansoura', 30),
(15, 'omar', 3000, 'mansoura', 30);

select * from EMP

--------------- Aggregate function -------------------------
-- count max min avg sum

select sum(salary) from EMP

select MIN(salary),MAX(salary) from EMP

select count(Eid) from EMP

select avg(salary) from EMP

select min(salary),did from EMP
group by did

select COUNT(Eid),address 
from EMP
group by address


select COUNT(Eid),address 
from EMP
where did in (10,30)
group by address

select min(salary),did
from EMP
where address like '_a%'
group by did

select sum(salary),did 
from EMP
group by did
having sum(salary)>=22000

select count(Eid),address 
from EMP
group by address
having count(Eid)>=5

select sum(salary), did
from EMP
group by did
having count(Eid)>5

select sum(salary),did
from EMP
where address like '_a%'
group by did
having sum(salary)>12000


select max(salary),address
from EMP
where did in(10,30)
group by address
having count(Eid)>3

use ITI

select salary from Instructor

select sum(salary) from Instructor

select min(salary) as min_value,max(salary) as max_value
from Instructor

select count(*),count(st_fname),count(st_id),count(st_age)
from Student

select avg(st_age) from Student

select avg(isnull(st_age,0)) from Student

select sum(st_age)/COUNT(*)
from Student

select sum(salary),DEPT_id
from Instructor
group by Dept_Id

select sum(salary),d.dept_id,dept_name
from instructor i inner join Department d
on i.Dept_Id=d.Dept_Id
group by d.Dept_Id,Dept_Name

select avg(st_age),st_address,dept_id
from Student
group by St_Address,Dept_Id

--------------------------------------
--------------------- subqueries-----------------------------------


select * from Student
where st_age<23

select * from Student
where st_age<(select avg(St_Age) from Student)

select * , (select count(st_id) from Student)
from Student

select dept_name from Department
where Dept_Id in (select distinct(Dept_Id)
                  from Student
				  where Dept_Id is not null)

-- subquery + DML

delete from Stud_Course
where St_Id=1

delete from Stud_Course 
where St_Id in (select St_Id from Student where St_Address='cairo')


--------------------------------------------
-- union all union intersect except 

select st_fname from Student
union all
select ins_name from Instructor

select st_fname from Student
union 
select ins_name from Instructor

select st_fname from Student
intersect
select ins_name from Instructor

select st_fname from Student
except
select ins_name from Instructor

-------------------------------------

select year(getdate())

select month(getdate())

select day(getdate())

select SUBSTRING(st_fname,1,3) from Student

select db_name()

select SUSER_NAME()