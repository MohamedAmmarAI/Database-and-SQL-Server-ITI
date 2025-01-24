
--  1.	Write a query to rank the students according to their ages in each dept without gapping in ranking.use ITI

use ITI

select st_fname,
       st_lname,
	   st_address,
	   st_age,
	   dept_id,
	   DENSE_RANK() over(partition by dept_id order by st_age) as age_rank
from Student

-- 2.	Divide the products into 30 segments according to their weight to handle some operations in shipment use AdventureWorks

use AdventureWorks2012

select productid,
       name,
	   weight,
	   NTILE(30) over(order by weight) as weight_segment
from 
       production.product
where weight is not null


-- 3.  Write a query to select the all highest two salaries for instructors in
--     Each Department who have salaries. “using one of Ranking Functions”.use ITI

SELECT 
    ins_id, 
    ins_name, 
    dept_id, 
    salary
FROM (
    SELECT 
        ins_id, 
        ins_name, 
        dept_id, 
        salary,
        RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
    FROM 
        instructor
    WHERE 
        salary IS NOT NULL
    ) AS ranked_salaries
WHERE 
    salary_rank <= 2;

       
-- 4.	Write a query to select the third project that took long time (works_for table). use Company_SD
--     try to redo it use CTE

use Company_SD

SELECT pno, hours
FROM Works_for
ORDER BY hours DESC
OFFSET 2 ROWS FETCH NEXT 1 ROW ONLY;

-- use CTE

with cte_pro as(
               select pno,hours,
			      ROW_NUMBER() over(order by hours desc) as rak
			   from works_for
)
select pno,hours 
from cte_pro
where rak=3

-- 5.	Try to create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen?

use Company_SD

create clustered index Hiredate_index
on departments([MGRSTART DATE])
 
 --what happened
 -- Cannot create more than one clustered index on table 'departments'.
 -- Drop the existing clustered index 'PK_Departments' before creating another.



-- 6.	Try to create index that allow u to enter unique ages in student table.
-- What will happen?

use ITI
create unique index uni_index
on student(st_age)

--what happened
--The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object
--name 'dbo.Student' and the index name 'uni_index'. The duplicate key value is (<NULL>).



-- 7.	create a non-clustered index on column(Dept_Manager) that allows you to enter a unique instructor id in the table Department.

create nonclustered index IX_Dept_Manager2
on department(Dept_Manager)
