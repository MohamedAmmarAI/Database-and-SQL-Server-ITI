

---------------------------------------Part-1: Use ITI DB---------------------------------------------------

use ITI

-- 1.	Display instructor Name and Department Name 
select ins_name,Dept_name 
from Instructor i left join Department d
on i.Dept_Id=d.Dept_Id

-- 2.	Display student full name and the name of the course he is taking
--      For only courses which have a grade  
select st_fname+' '+st_lname as full_name ,crs_name
from Student s inner join Stud_Course sc
on s.St_Id=sc.St_Id
inner join Course c
on sc.Crs_Id=c.Crs_Id
where sc.Grade is not null

-- 3.	Display number of courses for each topic name
select T.top_name,count(crs_name) as number_of_courses
from Topic T left join  Course c
on c.Top_Id=T.Top_Id
group by Top_Name


-- 4.	Display max and min salary for instructors
select max(salary) as max_salary ,min(salary) as min_salary 
from Instructor

-- 5.	Display instructors who have salaries less than the average salary of all instructors.
select ins_name,salary
from Instructor
where Salary< (select avg(salary) from Instructor)


-- 6.	Display the Department name that contains the instructor who receives the minimum salary.
select Dept_name,ins_name 
from Department D inner join Instructor I
on D.Dept_Id=I.Dept_Id
where Salary=(select min(Salary) from Instructor)

------------------------------------Part-2: Use AdventureWorks DB----------------------------------------

-- 1.	Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema) to designate SalesOrders
--      that occurred within the period ‘7/28/2008’ and ‘7/29/2014’

use AdventureWorks2012

select salesorderID,shipdate from Sales.SalesOrderHeader
where ShipDate between '7/28/2008' and '7/29/2014'

-- 2.	Display only Products with a StandardCost below $110.00 (show ProductID, Name only)
select ProductID,name
from Production.Product
where StandardCost<110.00

-- 3.	Display ProductID, Name if its weight is unknown
select ProductID,name
from Production.Product
where Weight is null

-- Display all Products with a Silver, Black, or Red Color
select *
from Production.Product
where color in ('silver','Red','black')

-- 5.	 Display any Product with a Name starting with the letter B
select *
from Production.Product
where name like 'B%'

-- 6.	 Transfer the rowguid ,FirstName, SalesPerson from Customer table in a newly created table named [customer_Archive] updated
--       Note: Check your database to see the new table and how many rows in it?
--       Try the previous query but without transferring the data

select rowguid,firstname into customer_Archive
from Person.Person

select count(rowguid) from Person.Person

select count(rowguid) from customer_Archive


-------------------------------------------------------------Part-3:  Use Company_SD DB---------------------------------------------

use Company_SD

-- 1.	Display the Department id, name and SSN and the name of its manager.
select Dnum,Dname,SSN,fname
from Departments d inner join Employee e
on d.Dnum=e.Dno

-- 2.	Display the name of the departments and the name of the projects under its control.
SELECT 
    d.Dname AS DepartmentName,
    p.Pname AS ProjectName
FROM 
    Departments d
JOIN 
    Project p
ON 
    d.Dnum = p.Dnum;


-- 3.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly.
select * from Employee
where Dno=30 and salary between 1000 and 2000

-- 4.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
select e.fname,p.pname,w.Hours
from Employee e join Works_for w
on e.SSN=w.ESSn
join Project p
on p.Pnumber=w.Pno
where e.Dno=10  and w.Hours>=10 and p.Pname='AL Rabwah'


-- 5.	Find the names of the employees who directly supervised with Kamel Mohamed.

select fname+' '+lname as "Full Name" 
from Employee 
where Superssn=(
               select ssn from Employee 
			   where CONCAT(fname,' ',Lname) = 'Kamel Mohamed')

-- 6.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
select fname+' '+lname as "full name",pname 
from Employee e,Works_for w,Project p
where e.SSN=w.ESSn and w.Pno=p.Pnumber
order by p.Pname

-- 7.	For each project located in Cairo City , find the project number, the controlling department name ,
--      the department manager last name ,address and birthdate
select p.Pname as project_name, p.Pnumber as project_number,
		d.Dname as department_name, e.Lname as department_manager_lastname,
		e.Address as manager_address, e.Bdate as manager_birthdate
from Project p inner join Departments d
on p.Dnum = d.Dnum
inner join Employee e
on d.MGRSSN = e.SSN
where p.City = 'Cairo'

-- 8.	Display All Data of the mangers
select e.*
from employee e inner join Departments d
on e.SSN=d.MGRSSN

-- 9.	Display All Employees data and the data of their dependents even if they have no dependents
select e.*,d.* 
from Employee e left join Dependent d
on e.SSN=d.ESSN