use Company_SD

select sum(salary) from Employee

select min(salary),max(salary) from Employee

select count(ssn) from employee

select count(Superssn) from employee

select AVG(salary) from Employee

select min(salary),Dno from Employee group by Dno

select count(ssn),address from Employee group by Address

select count(ssn),address from Employee
where Dno in (10,20) 
group by Address

select min(salary),Dno from Employee 
where address like '_a%'
group by Dno

select sum(salary),Dno from Employee
group by Dno
having sum(Salary)>=2000

select count(dno),address from Employee 
group by Address
having COUNT(Dno)>=5

select sum(salary),dno from Employee 
group by Dno
having COUNT(Dno)>5


