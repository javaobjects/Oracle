select * from emp,salgrade 
where emp.sal between losal and hisal;

select e.ename,m.ename from emp e,emp m where e.mgr = m.empno;


------------sql 99 标准的连接 语法------------------
--连接的语句写在from子句当中
--交叉连接 cross join
select * from 
emp cross join dept;

--自然连接 natural join 
--自动的找到两个表中同名跟同数据类型的列 自动实现连接 （自动的）
--自动将连接的列放到第一列 
--自动按照第一列升序排序
select * from emp
natural join dept;
--using 子句 （相当于一个手动版本的自动连接 ）
--语法 ： a 表 join b表 using(列）
select * from emp join dept using(deptno);

--on子句(比较常用，因为它的连接语法跟oracle语法比较相似)
--语法： a表 join b表 on(连接条件) join c表 on(连接 条件)
--如果 有三个或以上的表连接的话，需要重复书写 join子句跟on子句
select * from emp join dept on(emp.deptno = dept.deptno);

select * from emp join dept on(emp.deptno = dept.deptno) 
join salgrade s on(emp.sal between s.losal and s.hisal);

-- 外连接
--左外连接
--语法 ： a表 left outer join b表 on (连接条件)
--主表是左边的表，主表的数据一定要显示
--查询所有雇员姓名，部门编号，部门名称 ，包括没有员工的部门也要显示 出来
--连接 的列排到 第一位，并且 按照升序排序
select * from
dept d left outer join emp e on (d.deptno = e.deptno);

--右外连接 
--语法： a表 right outer join b 表 on（连接 条件)
-- 主表是右边的表，主表的数据 一定要显示 
--查询所有雇员姓名，部门编号，部门名称 ，包括没有员工的部门也要显示 出来
select * from 
emp e right outer join dept d on(d.deptno = e.deptno);
--全外连接 
--连接 的表的数据 都 要显示 
--语法 ：a 表 full outer join dept  d on(d.deptno = e.deptno);

--使用SQL-99写法，完成如下练习
--1.创建一个员工表和部门表的交叉连接。

select * from emp 
cross join dept;

--2.使用自然连接，显示入职日期在80年5月1日之后的员工姓名，部门名称，入职日期 natural join
select emp.ename,dept.dname,emp.hiredate
from emp
natural join dept where hiredate > '01-5月-80';

--3.使用USING子句，显示工作在CHICAGO的员工姓名，部门名称，工作地点 JOIN dept d USING (deptno) 
select emp.ename,dept.dname,dept.loc
from emp join dept using(deptno)
where dept.loc in 'CHICAGO';

--4.使用ON子句，显示工作在CHICAGO的员工姓名，部门名称，工作地点，薪资等级
select emp.ename,dept.dname,dept.loc,salgrade.grade
from emp
join dept
on(emp.deptno = dept.deptno)
join salgrade
on(emp.sal between salgrade.losal and salgrade.hisal)
where dept.loc = 'CHICAGO';

--5.使用左连接，查询每个员工的姓名，经理姓名，没有经理的King也要显示出来。left outer join
select e.ename as 员工名字,
m.ename as 经理名字 
from emp e
left outer join emp m
on (e.mgr = m.empno);

--6.使用右连接，查询每个员工的姓名，经理姓名，没有经理的King也要显示出来。 RIGHT  OUTER JOIN

select e.ename,
m.ename
from emp m
right outer join emp e
on (e.mgr = m.empno);



select * from emp;
select * from dept;
select * from salgrade;


