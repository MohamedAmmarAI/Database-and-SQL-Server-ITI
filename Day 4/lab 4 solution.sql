
--1) Restore Company DB then 
--Try to create the following Queries: 

use Company_SD

-- 1. Display all the employees Data. 
select * from Employee

-- 2. Display the employee First name, last name, Salary and Department number. 
select fname,lname,salary,Dno
from Employee

-- 3. Display all the projects names, locations and the department which is responsible about it. 
select pname,plocation,Dnum
from Project

-- 4. If you know that the company policy is to pay an annual commission for each 
-- employee with specific percent equals 10% of his/her annual salary .Display each 
-- employee full name and his annual commission in an ANNUAL COMM column (alias). 
select fname +' '+ lname as "full name" , (salary*12*0.1) as "ANNUAL COMM"
from Employee

-- 5. Display the employees Id, name who earns more than 1000 LE monthly. 
select ssn,fname,Salary 
from Employee 
where salary>1000

-- 6. Display the employees Id, name who earns more than 10000 LE annually. 
select ssn,fname,(Salary*12) as annual_salary
from Employee 
where (salary*12)>10000

-- 7. Display the names and salaries of the female employees  
select fname,salary 
from Employee
where sex='f'

-- 8. Display each department id, name which managed by a manager with id equals 968574.
select Dnum,Dname
from Departments
where MGRSSN=968574

-- 9. Dispaly the ids, names and locations of  the pojects which controled with department 10.
select pnumber,pname,plocation 
from Project
where Dnum=10

-- 10. For each department, retrieve the department name and the maximum, minimum and average salary of its employees. 
select Dname,min(salary) as min_value,avg(salary) as average_value,max(salary) as max_value
from Departments d inner join Employee e
on d.Dnum=e.Dno
group by Dname

-- DML (Data Manipulating Language):

-- 1. Insert your personal data to the employee table as a new employee in department number 
-- 30, SSN = 102672, Superssn = 112233, salary=3000. 
insert into Employee
values('omar','ahmed',102672,'1/1/2000','alex','M',3000,112233,30)

-- 2. Insert another employee with personal data your friend as new employee in department 
-- number 30, SSN = 102660, but don’t enter any value for salary or manager number to him. 
insert into Employee(fname,lname,ssn,Bdate,address,sex,Dno)
values('zeyad','mostafa',102660,'2/2/2000','giza','M',30)

-- 3. Upgrade your salary by 20 % of its last value.
update Employee
set Salary*=1.20