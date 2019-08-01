--多表链接查询 嵌套子查询 相关子查询 （约束 事务）
------------
--多表链接 查询
------------
--笛卡尔积 14*4
select emp.empno,
emp.ename,emp.job,emp.mgr,
emp.hiredate,emp.sal,
emp.deptno,dept.deptno,
dept.dname
from emp,dept;

select emp.empno,
emp.ename,emp.job,emp.mgr,
emp.hiredate,emp.sal,
emp.deptno,dept.deptno,
dept.dname
from emp,dept
where emp.deptno = dept.deptno;

select emp.*,dept.* from emp,dept where emp.deptno = dept.deptno;
--查询所有员工编号、姓名，部门编号，工作地点
select empno,ename,dept.deptno,loc
from emp,dept
where dept.deptno = emp.deptno;
--现在只想查询工作地点在NEW YORK的员工编号，姓名，部门编号，工作地点
select empno,ename,dept.deptno,loc
from emp,dept
where dept.deptno = emp.deptno and loc = 'NEW YORK';
--给定表别名
select e.empno,e.ename,d.deptno,d.loc
from emp e,dept d
where d.deptno = e.deptno and d.loc = 'NEW YORK';
--1.写一个查询，显示所有员工姓名，部门编号，部门名称。
select emp.ename,emp.deptno,dept.dname
from emp,dept;
--2.写一个查询，显示所有工作在CHICAGO并且奖金不为空的员工姓名，工作地点，奖金
select emp.ename,dept.loc,emp.comm
from emp,dept where dept.loc = 'CHICAGO' and emp.comm is not null;
--3.写一个查询，显示所有姓名中含有A字符的员工姓名，工作地点。
select emp.ename,dept.loc 
from emp,dept
where emp.ename like '%A%';
--假设有第三个表（部门类型-deptno,dtype)
--查询所有员工编号 ，姓名 ，部门编号，工作地点 ，部门类型名称
select e.empno,e.ename,d.deptno,d.loc
from emp e,dept d,dep de
where d.deptno = e.deptno and d.deptno = de.deptno
----------------
--非等值 链接 
--------------
--查询工资等级 在员工姓 名部门名称 
select s.grade,e.ename,d.dname,e.sal
from dept d,emp e,salgrade s
where e.sal between s.losal and s.hisal and e.deptno = d.deptno
order by e.sal;
--到目前为止sql语句 的执行顺序
--1 from
--2 where
--3 select
--4 order by 
--1.查询每个员工的编号，姓名，工资，工资等级，所在工作城市，按照工资等级进行升序排序。

-----------
--外部链接 
----------
--查询没有雇员工作的部门
--查询所有雇员姓名，部门编号，部门名称，包括没有员工的部门也要显示出来
select ename,dept.deptno,dept.dname
from emp,dept
where dept.deptno = emp.deptno(+);
--查询每个员工的姓名和直接上级姓名？--e 员工表  w 经理表
select e.ename,w.ename
from emp e,emp w
where e.mgr = w.empno;






select * from salgrade;
select * from dept;
select * from emp;
