-- 1. Create a database named 'CompanyDB'.
create database CompanyDB;
use CompanyDB;

-- 2. Create a table named 'Employees' with columns: EmployeeID (Primary Key), Name, Age, Department, Salary, and HireDate.
create table Employees(
	employee_id int primary key,
    e_name varchar(50),
    e_age int not null,
    Department varchar(50),
    Salary varchar(50),
    HireDate datetime
);

alter table Employees modify Salary int;

-- 3. Insert at least five records into the 'Employees' table.
insert into Employees(employee_id,e_name,e_age,Department,Salary,HireDate) values
(1,'shashank','22','Devlopment',50000,'2024-02-20'),
(2,'kunjan','24','Devlopment',40000,'2024-06-10'),
(3,'chintan','23','Testing',30000,'2025-01-25'),
(4,'Ayush','22','Devlopment',40000,'2025-03-10'),
(5,'Dipesh','23','Testing',30000,'2025-03-10');

-- 4. Retrieve all data from the 'Employees' table.
select * from Employees;

-- 5. Retrieve employees who earn more than 50,000.
select * from employees where Salary >= 50000;

-- 6. Retrieve employees who were hired after January 1, 2022.
select * from employees where HireDate > '2022-01-01';

-- 7. Sort employees in ascending order based on their salaries.
select * from employees 
order by Salary asc;

-- 8. Update the salary of employees in the 'IT' department by increasing it by 10%.
update employees 
set Salary = Salary * 1.10
where Department = 'Testing';

-- 9. Delete employees who are older than 40 years.
delete from employees
where e_age > 23;

-- 10. Create a table named 'Departments' with columns: DeptID (Primary Key) and DeptName.
create table Departments(
	DeptId int primary key,
    DeptName varchar(50)
);

-- 11. Insert at least three departments into the 'Departments' table.
insert into Departments(DeptId,DeptName) values
(1,'Devlopment'),
(2,'Testing'),
(3,'Networking');

-- 12. Retrieve the total number of employees in each department.
select e.Department, COUNT(e.employee_id) AS TotalEmployees
FROM Employees e
GROUP BY e.Department;

-- 13. Find the average salary of employees in each department.
SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;

-- 14. Display the highest salary in each department.
select Department, max(salary) as maxSalary
from Employees
group by Department;

-- 15. Retrieve employees whose names start with the letter 'A'.
select * from Employees
where e_name like 'a%';

-- 16. Display employees who have 'Manager' in their job title (assuming there's a JobTitle column).

-- 17. Retrieve the employee with the second-highest salary
SELECT * FROM Employees  
ORDER BY Salary DESC  
LIMIT 1 OFFSET 2;

-- 18. Count the number of employees in the company.
select count(*) as Total_emp from Employees;

-- 19. Retrieve the department name along with the number of employees in each department using a JOIN.
select d.DeptName, count(e.employee_id) as TotalEmployees  
from Departments d  
left join Employees e on d.DeptName = e.Department  
group by d.DeptName;

-- 20. Retrieve all employees who do not belong to the 'HR' department.
select * from Employees  
where Department not in ('Devlopment') ;


