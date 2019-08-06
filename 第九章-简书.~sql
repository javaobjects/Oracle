--例：思考如何查询比本部门平均薪水高的员工姓名，薪水。

--嵌套子查询的写法:

--我的理解写法：
--第一步：先查询员工姓名，薪水
select ename,sal from emp;
--第二步：--每个部门的平均薪水,将其作为一个表
select avg(sal) avgSal,deptno from emp group by deptno;
--第三步：在前两步基础之上解题
select ename,sal,emp.deptno from emp,
(select avg(sal) avgSal,deptno from emp group by deptno) tab_avgSal
where sal > avgSal and emp.deptno = tab_avgSal.deptno;
--标准答案写法 ：
select empno,ename,sal
from   emp e ,(select deptno,avg(sal) avgsal from emp group by deptno) d
where e.deptno =d.deptno
and e.sal >d.avgsal;

--相关子查询解题
select empno,ename,sal,deptno
from emp outer
where sal > (select avg(sal) from emp where deptno = outer.deptno);
--父查询中的行每被处理一次，子查询就执行一次

--## 练习1 

--如下练习，使用相关子查询完成

--1. 查询比所在职位平均工资高的员工姓名，职位。
select ename,job
from emp outer
where sal > (select avg(sal) from emp where job = outer.job);

--2. 查询工资为其部门最低工资的员工编号，姓名，工资。
select empno,ename,sal
from emp outer
where sal = (select min(sal) from emp where deptno = outer.deptno);

--## 练习2

--如下练习，用相关子查询完成

--1. 查询所有雇员编号，名字和部门名字。
select empno,ename,
(select dname from dept where emp.deptno = deptno) dname
from emp;

--2. 查询哪些员工是经理？
select * from emp e
where 0 < (select count(*) from emp 
           where mgr = e.empno);

--3. 查询哪些员工不是经理？
select * from emp e
where 0 = (select count(*) from emp 
           where mgr = e.empno);

--4. 查询每个部门工资最低的两个员工编号，姓名，工资。 
select empno,ename,sal,deptno
from emp outer
where 1 >= (select count(*)
                   from emp
                   where outer.sal > sal
                   and  deptno = outer.deptno);

--## 练习3

--如下练习，用exists或not exists完成

--1. 列出至少有一个雇员的所有部门名称。
select dname
from dept d
where exists (select '1'
                      from emp,dept
                      where emp.deptno = dept.deptno
                      and d.dname = dname);

--2. 列出一个雇员都没有的所有部门名称。
select dname
from dept d
where not exists (select '1'
                      from emp,dept
                      where emp.deptno = dept.deptno
                      and d.dname = dname);

--## 课后作业

--如下练习，使用相关子查询完成。

--1. 查询薪水多于他所在部门平均薪水的雇员名字，部门号。

select * from emp;
select * from dept;
--2. 查询员工姓名和直接上级的名字。

--3. 查询每个部门工资最高的员工姓名，工资。

--4. 查询每个部门工资前两名高的员工姓名，工资。
