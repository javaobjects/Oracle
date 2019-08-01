----------------------------第十五章   视图 -----------------------------

--视图是逻辑上来自一个或多个表的数据集合

--创建视图
create view emp_back 
as (select empno,ename,hiredate from emp)


--创建视图时as的语句中带上列的别名
create view emp_back 
as (select empno "员工编号",ename "员工姓名",hiredate "入职日期" from emp)

--创建一个视图，通过该视图可以查询到工资在2000-5000内并且姓名中包含有A的员工编号，姓名，工资。
create view emp_back
as (select empno,ename,sal from emp where sal between 2000 and 5000 and ename like '%A%');

--直接在视图上做DML操作(连带删除原来的那个表)
delete from emp_back where empno = 7698;

--希望别人不能够直接通过视图来修改原来的表的数据
--with read only只读，直接锁定视图的数据，不能对视图里的数据作DML操作
create view emp_back
as (select empno,ename,sal from emp where sal between 2000 and 5000 and ename like '%A%')
with read only
;

--1.创建一个视图，通过该视图可以查询到工作在NEW YORK和CHICAGO的员工编号，姓名，部门编号，入职日期。
create view emp_test1 
as (select empno,ename,e.deptno,hiredate from emp e,dept d where e.deptno = d.deptno and loc in('NEW YORK','CHICAGO'));

select * from emp_test1;
select * from emp_test2;

--2.创建一个视图，通过该视图可以查询到每个部门的部门名称及最低工资。
create view emp_test2 
as ( select dname,(select min(sal) minsal from emp where deptno = d.deptno) "部门最低工资" from dept d)

select * from emp_test2;

--3.通过如上视图，查询每个部门工资最低的员工姓名及部门名称
select ename,e.dname from emp_test1 q,emp_test2 w,dept e 
where q.deptno = e.deptno and w.dname = e.dname;


select * from emp_back;
select * from emp;
select * from dept;
