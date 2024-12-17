-- lab 3 part 1 solution
use Company_SD

-- 1. Insert your personal data to the employee table as a new employee in department 
-- number 30, SSN = 102672, Superssn = 112233.

     insert into employee(fname,lname,SSN,Bdate,Address,Sex,Salary,Superssn,Dno)
     values('omar','ahmed',102672,'1/1/2000','cairo','M',23000,112233,30)

-- 2.	Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660,
--      but don’t enter any value for salary or manager number to him.
     insert into Employee(fname,lname,SSN,Bdate,Address,Sex,Dno)
     values('zeyad','mostafa',102660,'2/2/2000','giza','M',30)

-- 3.	In the department table insert new department called "DEPT IT" , with id 100,
--      employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'

     insert into Departments(Dname,Dnum,MGRSSN,"MGRStart Date")
     values('DEPT IT',100,112233,'1-11-2006')

-- 4.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of
--      the new department (id = 100), and they give you(use your SSN from question1) her position (Dept. 20 manager) 
-- a.	First try to update her record in the department table
     update Departments set MGRSSN=968574 where Dnum=100

-- b.	Update your record to be department 20 manager.
     update Departments set MGRSSN=102672 where Dnum=20

-- c.	Update your friend data(entered in question2) to be in your teamwork (supervised by you)
     update Employee set Superssn=102672 where SSN=102660

-- 5.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data
--      from your database in case you know that you will be temporarily in his position.
--      Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or
--      works in any projects and handle these cases).
     update Employee set Superssn=102672 where Superssn=223344

	 update  Departments set MGRSSN=102672 where MGRSSN=223344

     delete from Dependent where ESSN=223344

	 delete from Works_for where ESSn=223344

	 delete from Employee where Fname='kamel' and lname='mohamed'

-- 6.	And your salary has been upgraded by 20 present of its last value.
     update Employee set Salary=Salary+(0.2*Salary) where SSN=102672

-- Try to create the following Queries:

-- 1.	Display all the employees Data.
     select * from Employee

-- 2.	Display the employee First name, last name, Salary and Department number.
     select fname,lname,salary,Dno from Employee

-- 3.	Display all the projects names, locations and the department which is responsible about it.
     select pname,plocation,dnum from Project

-- 4.	If you know that the company policy is to pay an annual commission for each employee with 
--      specific percent equals 10% of his/her annual salary .Display each employee full name and 
--      his annual commission in anccolumn (alias).
     select CONCAT(fname,' ',lname) as full_name,(Salary*0.10*12) as "annual commission" from Employee

-- 5.	Display the employees Id, name who earns more than 1000 LE monthly.
     select ssn,fname,Salary from Employee where Salary>1000
     
-- 6.	Display the employees Id, name who earns more than 10000 LE annually.
     select ssn,fname,(salary*12) as "ANNUAL SAL" from Employee where (Salary*12)>10000

-- 7.	Display the names and salaries of the female employees 
     select fname,salary,Sex from Employee where sex='f'

-- 8.	Display each department id, name which managed by a manager with id equals 968574.
     select dnum,dname from Departments where MGRSSN=968574

-- 9.	Dispaly the ids, names and locations of  the pojects which controled with department 10.
     select pnumber,pname,plocation from Project where Dnum=10


