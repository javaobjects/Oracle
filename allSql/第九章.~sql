-------------第 九章 相关子查询--------------

--复习嵌套子查询
--思考如何查询比本部门平均薪水高的员工姓名，薪水
select deptno,avg(sal) 
from emp
group by deptno;

select ename,sal from 
emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s
where e.deptno = s.deptno and sal > avgsal;

--相关子查询
--通过相关子查询也可以解决上述问题
--全部有关于查询的题目都可以用嵌套子查询来做
--有部分题目可以使用相关子查询来做
--有时候用相关子查询会比较简便

--嵌套 可以单独执行
--相关子查询 不能单独执行，它必须借助父查询的表中的某些数据
--父查询中行每被处理一次 子查询就执行一次



--思考如何查询比本部门平均薪水高的员工姓名，薪水

select avg(sal) from emp where deptno = ?;

select * from
emp e
where sal > (select avg(sal) from emp where deptno = e.deptno);

--1.查询比所在职位平均工资高的员工姓名，职位。
select ename,job
from emp e
where sal > (select avg(sal) from emp where job = e.job);


--2.查询工资为其部门最低工资的员工编号，姓名，工资。
select empno,ename,sal
from emp e
where sal = (select min(sal) from emp where deptno = e.deptno);

--查询所有部门名称和人数
select dname,(select count(*) from emp where deptno = d.deptno) as 部门人数
from dept d;

--查出哪些员工是经理
select *
from emp e
where (select count(*) from emp  where mgr = e.empno) > 0;




CREATE TABLE emp_jobhistory(
    id NUMBER,--流水号
    empno NUMBER,--员工编号
    job VARCHAR2(9),--岗位
    begindate DATE,--开始日期
    sal Number(7,2)--在该岗位时工资
)

INSERT INTO emp_jobhistory VALUES(1,7839,'TRAINEE','17-11月-81',500);
INSERT INTO emp_jobhistory VALUES(2,7839,'SALESMAN','17-2月-82',1800);
INSERT INTO emp_jobhistory VALUES(3,7839,'CLERK','17-2月-83',2000);
INSERT INTO emp_jobhistory VALUES(4,7839,'SALESMAN','17-2月-85',1800);
INSERT INTO emp_jobhistory VALUES(5,7839, 'MANAGER','17-2月-87',3000);

--查询至少调过2次岗位的员工编号，姓名，岗位
select * from emp e where (select count(*) from emp_jobhistory where empno = e.empno) >= 2;

--1.查询所有雇员编号，名字和部门名字。
select emp.empno,emp.ename,dept.dname
from emp join dept
on emp.deptno = dept.deptno;

select empno,ename,(select dname from dept where deptno = e.deptno)
from emp e;



--2.查询哪些员工是经理？
select ename 
from emp
where empno in (select mgr from emp);

select *
from emp e
where (select count(*) from emp  where mgr = e.empno) > 0;
--3.查询哪些员工不是经理？
select ename 
from emp
where mgr not in (select empno from emp);

select *
from emp e
where (select count(*) from emp  where mgr = e.empno) = 0;

select * from emp;
--4.查询每个部门工资最低的两个员工编号，姓名，工资。 

-- 先把每个部门的工资查出
--再进行比对

--遍历 emp 表中的每一行数据，查看该员工的部门中，如果有一个员工的工资比他低，现在他倒数第二低
--如果该部门中没有员工的工资比他低那他则是工资最低的。。

select empno,ename,sal from 
emp e where (select count(*) from emp where deptno = e.deptno and sal < e.sal ) = 0
or (select count(*) from emp where deptno = e.deptno and sal < e.sal ) = 1

select empno,ename,sal from 
emp e where (select count(*) from emp where deptno = e.deptno and sal < e.sal ) <= 1;

select empno,ename,sal from 
emp e where (select count(*) from emp where deptno = e.deptno and sal < e.sal ) in (0,1);




select sal 
from emp e,(select sal,deptno from emp where e.deptno = deptno order by sal desc);--自己写的。。没写出来。。。。


select * from emp_jobhistory;--历史员工岗位记录表

--exists操作符
--select 1 只是一个占位符 只要exists紧跟着的子查询中的结果集中有值,
--那么当前遍历到的那行数据就会满足条件
--查询哪些人是经理
select * 
from emp e
where exists(select 1 from emp where mgr = e.empno);

--如下练习，用exists或not exists完成
--1.列出至少有一个雇员的所有部门名称。

select * from emp;
select * from dept;

select dname,deptno 
from dept d
where exists(select 1 from 
(select emp.deptno,count(*) from emp join dept on emp.deptno = dept.deptno group by emp.deptno)
where deptno = d.deptno)

select dname,deptno
from dept d
where exists(select count(*) from emp where emp.deptno = d.deptno);

select dname,deptno
from dept d
where exists(select 1 from emp where emp.deptno = d.deptno );



--2.列出一个雇员都没有的所有部门名称。

select dname,deptno 
from dept d
where not exists(select 1 from 
(select emp.deptno,count(*) from emp join dept on emp.deptno = dept.deptno group by emp.deptno)
where deptno = d.deptno)



select * from emp;


