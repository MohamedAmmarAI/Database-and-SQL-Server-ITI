
use iti
select top(3) * from Student

select top(3) St_Fname from Student

select top(3) * from student 
where St_Address='alex'

select top(3) salary from Instructor

select max(salary) from Instructor

select top(2) salary from Instructor
order by Salary desc

select top(7) with ties * from student 
order by st_age

select NEWID()

select *,NEWID()
from student 

select * from Student 
order by NEWID()

select st_fname + ' '+ st_lname as full_name 
from Student
order by full_name

select st_fname + ' '+ st_lname as full_name 
from Student
where full_name='ahmed ali'

-- execution order
-- from
-- join 
-- on
-- where 
-- group
-- having
-- select
-- order by 
-- top

select * 
from(
     select st_fname+ ' '+ st_lname as full_name from Student
	 ) as new_table
where full_name='ahmed ali'

-- DB objects [table view function sp rule ]
-- [server name].[ DB name].[schema name].[object name]

select * 
from [DESKTOP-5R03G04].iti.dbo.student

select * from Company_SD.dbo.Project

select dname from Company_SD.dbo.Departments
union all 
select dept_name from department


-- DDL
select * into table2
from Student


select *,ROW_NUMBER() over(order by st_age desc) as RN 
from Student

select *,DENSE_RANK() over(order by st_age desc) as DR 
from Student

select * from 
           (select *,ROW_NUMBER() over(order by st_age desc) as RN 
            from Student) as new_table
where RN=1


select * from 
           (select *,DENSE_RANK() over(order by st_age desc) as DR
            from Student) as new_table
where DR=1



select * from 
           (select *,ROW_NUMBER() over(partition by dept_id order by st_age desc) as RN 
            from Student) as new_table
where RN=1



select * from 
           (select *,DENSE_RANK() over(partition by dept_id order by st_age desc) as RN 
            from Student) as new_table
where RN=1


select * from 
           (select *,NTILE(4) over(order by st_age desc) as G
            from Student) as new_table
where G=1


-----------------------------------------Data types
---------------------------numeric dt
---------------------------decimal dt
---------------------------char dt
---------------------------var char dt
--------------------------binary dt
--------------------------datetime dt

select ins_name ,salary, case
                         when salary>=3000 then 'high'
				         when salary<3000 then 'low'
				         else 'no data'
				         end as new_salary
from Instructor

update Instructor
      set salary=
	  case
	  when salary>=3000 then salary*1.10
	  else salary*1.20
	  end 

select ins_name,iif(salary>=3000,'high','low')
from Instructor

----------------------------------------------

