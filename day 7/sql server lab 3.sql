----------------------------------- Note: Use ITI DB -------------------------

use ITI

-- 1.	 Create a scalar function that takes date and returns Month name of that date.

CREATE FUNCTION return_month(@date DATE)
RETURNS nvarchar(20)
AS
BEGIN
   -- Return the month directly using the MONTH function
   RETURN datename(month,@date);
END
go

-- Test the function
SELECT dbo.return_month('2023-01-02') AS MonthValue;

drop function if exists return_month


-- 2.	 Create a multi-statements table-valued function that takes 2 integers and returns the values between them.


CREATE FUNCTION get_values_between(@start INT, @end INT)
RETURNS @ValuesTable TABLE (Value INT)
AS
BEGIN
    -- Declare a variable to hold the current value
    DECLARE @current INT;

    -- Check if @start is less than @end
    IF @start < @end
    BEGIN
        SET @current = @start + 1; -- Start from the next value after @start
        WHILE @current < @end -- Stop before @end
        BEGIN
            INSERT INTO @ValuesTable (Value)
            VALUES (@current);
            SET @current = @current + 1;
        END;
    END
    -- Handle the case where @start > @end
    ELSE IF @start > @end
    BEGIN
        SET @current = @end + 1; -- Start from the next value after @end
        WHILE @current < @start -- Stop before @start
        BEGIN
            INSERT INTO @ValuesTable (Value)
            VALUES (@current);
            SET @current = @current + 1;
        END;
    END;

    RETURN;
END;
GO


-- Test case 1: Start is less than end
SELECT * FROM dbo.get_values_between(13, 20);

-- Test case 2: Start is greater than end
SELECT * FROM dbo.get_values_between(7, 3);

drop function if exists get_values_between


-- 3.	 Create a tabled valued function that takes Student No and returns Department Name with Student full name.

CREATE FUNCTION student_info(@id INT)
RETURNS @t TABLE (full_name VARCHAR(40), dept_name VARCHAR(20))
AS
BEGIN
    -- Insert the result directly into the table variable @t
    INSERT INTO @t (full_name, dept_name)
    SELECT 
        st_fname + ' ' + st_lname AS full_name,
        dept_name
    FROM Student s
    INNER JOIN Department d ON s.Dept_Id = d.Dept_Id
    WHERE s.St_Id = @id;

    -- Return the table variable
    RETURN;
END;
GO

select * from dbo.student_info(4)
	  


select * from Student
select * from Department
use ITI
-- 4.	Create a scalar function that takes Student ID and returns a message to user 
	--  If first name and Last name are null then display 'First name & last name are null'
	--  If First name is null then display 'first name is null'
	--  If Last name is null then display 'last name is null'
	--  Else display 'First name & last name are not null'

create function message_to_user(@id int)
returns varchar(100)
as
begin
  declare @first_name varchar(20),@last_name varchar(20),@message varchar(100)
  select @first_name=st_fname,@last_name=st_lname
  from student
  where St_Id=@id 
  if (@first_name is null and @last_name is null)
  begin 
     set @message='First name & last name are null'
  end
  else if (@first_name is null)
     begin
	   set @message='First name is null'
  end
  else if (@last_name is null)
     begin
	   set @message='last name is null'
  end
  else 
       set @message='First name & last name are not null'
  return @message
end
    
select dbo.message_to_user(2)
select dbo.message_to_user(1)
select dbo.message_to_user(13)
select dbo.message_to_user(14)

select * from Student

-- 5.	Create a function that takes integer which represents the format of the Manager hiring date
--      and displays department name, Manager Name and hiring date with this format.   

select * from Department


-- 6.	Create multi-statements table-valued function that takes a string
--      If string='first name' returns student first name
--      If string='last name' returns student last name 
--      If string='full name' returns Full Name from student table 
--      Note: Use “ISNULL” function

create function student_name(@str varchar(20))
returns @t table(first_name varchar(20),last_name varchar(20),full_name varchar(50))
as
begin
if @str='first_name'
begin
  insert into @t (first_name)
  select isnull(st_fname,'no name') from Student
end
else if @str='last_name'
begin
   insert into @t (last_name)
   select isnull(st_lname,'no name') from Student
end
else if @str='full_name'
begin
   insert into @t (full_name)
   select isnull(st_fname,'no name')+' '+isnull(st_lname,'no name') from Student
end
return
end

select * from student
select * from dbo.student_name('full_name')


-- 7.	Write a query that returns the Student No and Student first name without the last char

select st_id,left(st_fname,len(st_fname)-1) as name_without_last_char from student 



-- 8.  -- Write a query that takes the columns list and table name into variables
       -- and then return the result of this query “Use exec command”

-- Declare variables in the same batch
DECLARE @columns NVARCHAR(MAX);
DECLARE @table_name NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

-- Set the column list and table name
SET @columns = 'st_id, st_fname, st_lname, st_address, st_age, dept_id, st_super';
SET @table_name = 'student';

-- Construct the dynamic SQL query
SET @sql = 'SELECT ' + @columns + ' FROM ' + @table_name;

-- Execute the dynamic SQL
EXEC(@sql);



-- Part 2: Use Company DB
--      1.	Create function that takes project number and display all employees in this project

use Company_SD

create function employees_in_project(@id int)
returns @t table (employee_name varchar(50))
as 
begin

insert into @t (employee_name)
select e.fname
from employee e inner join works_for w
on e.ssn=w.Essn inner join project p
on w.pno=p.pnumber
where p.pnumber=@id

return
end

select * from dbo.employees_in_project(100)

