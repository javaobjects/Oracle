

--写一条查询语句，查询员工姓名、部门名称、工作地点？
select ename,dept.dname,dept.loc from emp,dept where emp.deptno(+) = dept.deptno;


--练习一
--1.写一个查询，显示所有员工姓名，部门编号，部门名称。

select ename,dept.deptno,dept.dname
from emp,dept
where emp.deptno(+) = dept.deptno;

--2.写一个查询，显示所有工作在CHICAGO并且奖金不为空的员工姓名，工作地点，奖金

select ename,dept.loc,comm
from emp,dept
where emp.deptno = dept.deptno and loc in 'CHICAGO' and comm is not null;
--3.写一个查询，显示所有姓名中含有A字符的员工姓名，工作地点。

select ename,dept.loc
from emp,dept
where emp.deptno = dept.deptno and ename like '%A%';

select ename,dept.loc
from emp,dept
where emp.deptno = dept.deptno and instr(ename,'A') <> 0;

select ename,dept.loc
from emp,dept
where emp.deptno = dept.deptno and instr(ename,'A') != 0;

select ename,dept.loc
from emp,dept
where emp.deptno = dept.deptno and instr(ename,'A') > 0;
--练习二
--1.查询每个员工的编号，姓名，工资，工资等级，所在工作城市，按照工资等级进行升序排序。

select empno,ename,sal,grade,loc
from emp,dept,salgrade
where emp.deptno = dept.deptno and sal between losal and hisal
order by sal asc;




select * from user_tables;
select * from SALGRADE;
--思考：查询每个员工的姓名和直接上级姓名？
select worker.ename,manager.ename
from emp worker,emp manager
where worker.mgr = manager.empno(+);




--练习三

--1.查询所有工作在NEW YORK和CHICAGO的员工姓名，员工编号，以及他们的经理姓名，经理编号。

select worker.ename,worker.empno,manager.ename,worker.mgr
from emp worker,emp manager,dept
where worker.mgr = manager.empno(+)
and worker.deptno = dept.deptno 
and loc in ('NEW YORK','CHICAGO');


--2.第上一题的基础上，添加没有经理的员工King，并按照员工编号排序。

select worker.ename,worker.empno,manager.ename,worker.mgr
from emp worker,emp manager,dept
where worker.mgr = manager.empno(+)
and worker.deptno = dept.deptno 
and loc in ('NEW YORK','CHICAGO')
order by worker.empno asc;

--3.查询所有员工编号，姓名，部门名称，包括没有部门的员工也要显示出来。

select empno,ename,dept.dname
from emp,dept
where emp.deptno(+) = dept.deptno;


select * from emp;
select * from dept;
--练习四
--使用SQL-99写法，完成如下练习
--1.创建一个员工表和部门表的交叉连接。
select * from emp cross join dept;

--交叉连接会产生两个表的交叉乘积，和两个表之间的笛卡尔积是一样的；

--2.使用自然连接，显示入职日期在80年5月1日之后的员工姓名，部门名称，入职日期
select ename,dname,hiredate
from emp
natural join dept
where hiredate > '01-5月-80';



--3.使用USING子句，显示工作在CHICAGO的员工姓名，部门名称，工作地点
select ename,dname,loc
from emp 
join dept using(deptno)
where loc in 'CHICAGO';


--4.使用ON子句，显示工作在CHICAGO的员工姓名，部门名称，工作地点，薪资等级

select ename,dname,loc,grade
from emp join dept
on emp.deptno = dept.deptno
join salgrade
on sal between losal and hisal
where loc in 'CHICAGO';

--5.使用左连接，查询每个员工的姓名，经理姓名，没有经理的King也要显示出来。

select worker.ename,manager.ename
from emp worker
left outer join emp manager
on worker.mgr = manager.empno;


--6.使用右连接，查询每个员工的姓名，经理姓名，没有经理的King也要显示出来。
select worker.ename,manager.ename
from emp manager
right outer join emp worker
on worker.mgr = manager.empno;

--课后作业
--1.显示员工SMITH的姓名，部门名称，直接上级名称

select worker.ename,dname,manager.ename
from emp worker,emp manager,dept
where worker.mgr = manager.empno
and worker.deptno = dept.deptno 
and worker.ename in 'SMITH'; --通常写法

select worker.ename,dname,manager.ename
from emp worker join emp manager
on worker.mgr = manager.empno
join dept
on worker.deptno = dept.deptno 
where worker.ename in 'SMITH';--join on

select worker.ename,dname,manager.ename
from emp worker left outer join emp manager
on worker.mgr = manager.empno
left outer join dept
on worker.deptno = dept.deptno 
where worker.ename in 'SMITH';--左外连接 left outer join

select worker.ename,dname,manager.ename
from emp worker right outer join emp manager
on worker.mgr = manager.empno
right outer join dept
on worker.deptno = dept.deptno 
where worker.ename in 'SMITH';--右外连接 right outer join 

--2.显示员工姓名，部门名称，工资，工资级别，要求工资级别大于4级。

select ename,dname,sal,grade
from emp,dept,salgrade
where emp.deptno = dept.deptno 
and sal between losal 
and hisal and grade > 4;--通常写法

select ename,dname,sal,grade
from emp join dept
on emp.deptno = dept.deptno
join salgrade
on sal between losal and hisal
where grade > 4;--join on

select ename,dname,sal,grade
from emp left outer join dept
on emp.deptno = dept.deptno
left outer join salgrade
on sal between losal and hisal
where grade > 4;--左外连接 left outer join

select ename,dname,sal,grade
from emp right outer join dept
on emp.deptno = dept.deptno
right outer join salgrade
on sal between losal and hisal
where grade > 4;--右外连接 right outer join 

--3.显示员工KING和FORD管理的员工姓名及其经理姓名。




--4.显示员工姓名，参加工作时间，经理名，参加工作时间，要求参加时间比经理早。
select worker.ename as 员工姓名,worker.hiredate as 员工入职日期,
manager.ename as 经理姓名,manager.hiredate as 经理入职日期
from emp worker,emp manager 
where worker.mgr = manager.empno and worker.hiredate < manager.hiredate;
