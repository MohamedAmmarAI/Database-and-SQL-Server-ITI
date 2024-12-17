use Company_SD
-- cross join
select fname,Dname from employee,Departments

select fname,dname 
from employee cross join Departments

-- inner join
select fname,dname 
from employee inner join Departments
on employee.Dno=Departments.Dnum

select fname,dname 
from employee as e,Departments as d
where e.Dno=D.Dnum

-- outer join
select fname,dname 
from employee as e left outer join Departments as d
on e.Dno=d.Dnum

select fname,dname
from employee as e right outer join Departments as d
on e.Dno=d.Dnum

select fname,dname
from employee as e full outer join Departments as d
on e.Dno=d.Dnum

--self join
select x.fname as emp_name,y.fname as supper_name
from employee x,employee y
where x.Superssn=y.SSN

select x.fname as emp_name,y.*
from employee x,employee y
where x.Superssn=y.SSN

-- multi join
select fname,pname,hours
from employee as e,project as p, Works_for as w
where e.SSN=W.ESSn and W.Pno=p.Pnumber

select fname,pname,hours,Dname
from employee as e inner join Works_for as w 
on e.SSN=W.ESSn
inner join project as p
on W.Pno=p.Pnumber
inner join Departments as d
on d.Dnum=e.Dno

-- DML 
 -- join update
 select * from Employee

 update Employee
  set salary+=1000
select Salary
from Employee E , Departments D
where E.Dno=D.Dnum and Dname='DP2'

select fname from Employee

select fname from employee
where fname is not null

select isnull(fname,'')
from Employee

select isnull(fname,'has no name')
from Employee

select ISNULL(fname,lname) as new_name
from Employee

select coalesce(fname,lname,address,'no data')
from Employee

select fname,salary from Employee

select fname+'  '+convert(varchar(10),salary) from Employee

select 'first name is   '+fname+'  and salary is  '+convert(varchar(10),salary) from Employee

select 'first name is   '+isnull(fname,Lname)+'  and salary is  '+convert(varchar(10),salary) from Employee

select isnull(Fname,Lname) +' '+ convert(varchar(10),isnull(salary,''))
from Employee

select concat(fname,'    ',salary) from Employee -- concat convert all inside () to string and replacement all null with space

select * from employee 
where Fname='ahmed'

select * from employee
where fname like 'ahmed'

-- _ one char
-- % zero or more char

select * from employee
where fname like 'a%'

select * from employee
where fname like '%a'


select * from employee
where fname like '%a%'

select ssn , salary from Employee
order by ssn,Salary desc

