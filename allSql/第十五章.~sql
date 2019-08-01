-----------------第十五章 视图

--有选择性的显示 出数据库表的一部分
--一个数据表可以抽取n个视图

--创建视图 view
create view view1
as select empno,ename,job,mgr,hiredate from emp;

--查询视图
--跟查询表一样
select * from view1;

grant DBA to scott;--赋值创建视图的权限给scott用户


--1.创建一个视图，通过该视图可以查询到工资
--在2000-5000内并且姓名中包含有A的员工编号，姓名，工资。
create view btAsal
as select empno,ename,sal from emp
where sal between 2000 and 5000 and instr(ename,'A',1,1) <> 0;

--2.通过上述创建的视图查询数据
select * from btAsal;

--创建视图时，在子查询中使用列的别名

--1.创建一个视图，通过该视图可以查询到工作
--在NEW YORK和CHICAGO的员工编号，姓名，部门编号，入职日期。
create view part_emp
as select empno,ename,emp.deptno,hiredate
from emp,dept where emp.deptno = dept.deptno and loc in ('NEW YORK','CHICAGO');

select * from part_emp;

--2.创建一个视图，通过该视图可以查询到每个部门的部门名称及最低工资。
create view dname_Minsal
as select dept.dname,sal,ename
from emp,dept
where emp.deptno = dept.deptno and sal in (select min(sal) from emp group by deptno);--错误

create view dname_Minsal
as select dname,(select min(sal) from emp group by deptno) minsal
from dept;
select * from dname_Minsal;

--3.通过如上视图，查询每个部门工资最低的员工姓名及部门名称

select * from part_emp,dname_Minsal,dept,emp
where dept.deptno = part_emp.deptno and
 dept.dname = dname_Minsal.dname and emp.empno = part_emp.empno
 and emp.sal = dname_Minsal.minsal;

--修改视图
--create or replace view 视图名字
create or replace view dname_Minsal
as select dname,(select max(sal) from emp group by deptno) minsal
from dept;

--对视图做DML操作,被依赖的表的数据也会一起被删除
create view view6
as select * from emp;

delete from view6 
where empno = 7369;

--解决办法：可以在创建视图的时候写上一个width read only  --拒绝DML操作
create view view6
as select * from emp
width read only;

delete from view6 
where empno = 7369;--无法对只读视图进行DML操作

--1.创建视图v_emp_20，包含20号部门的员工编号，姓名，年薪列(年薪=12*(工资+奖金）；
create or replace view v_emp_20
as select empno,ename,12 * ( sal+ nvl(comm,0)) year_sal from emp where deptno in 20;

--2.从视图v_emp_20中查询年薪大于1万元员工的信息；
select * from v_emp_20 where year_sal > 10000;
--3.请为工资大于2000的员工创建视图，要求显示员工的部门信息，职位信息，工作地点；
create or replace view sal2000
as select dept.dname,job,dept.loc from emp,dept where emp.deptno = dept.deptno and sal > 2000;

--4.针对以上视图执行insert,update,delete,语句能否成功，为什么？
select * from v_emp_20;
select * from sal2000;



--虚拟列在修改的时候不能映射到原来的表中
inset into v_emp_20 values(7777,'230',12345);


---删除视图
drop view view6;




insert into v_emp_20(empno)
values(8888);

update v_emp_20
set year_sal = 9622
where year_sal = 9600;

