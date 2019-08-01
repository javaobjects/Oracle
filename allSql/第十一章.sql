-----------------第十一章
---DQL 数据查询语言 select
---DML 数据操作语言 insert delete update

--简单的插入语句
--插入表中的全部列
insert into dept
values(50,'DEVELOPMENT','DETROIT');
--插入表中的指定列
insert into dept(deptno,dname)
values(50,'DEVELOPMENT');
--1.向部门表新增一个部门，部门编号为50，部门名称为HR，工作地点为SY。
insert into dept
values(50,'HR','SY');

--2.向部门表新增一个部门，部门编号为60，部门名称为MARKET。

insert into dept(deptno,dname)
values(60,'MARKET');

--插入日期值
insert into emp(empno,ename,hiredate)
values(7777,'xiaoming','06-5月-2019');

insert into emp(empno,ename,hiredate)
values(7777,'xiaoming',to_date('2019-5-6','YYYY-MM-DD'));

--插入特殊字符&
--插入部门信息：编号为80，部门名称为&Test&，地点为null
--在oracle中，&接上一个字符串表示的是一个变量
insert into dept
values(80,'&Test&',null)--无法插入正确的部门的值

--通过字符串拼接可以解决上述问题
insert into dept
values(80,'&' || 'Test' || '&',null);
--1.向员工表中新增一个员工，员工编号为8888，姓名为BOB，岗位为CLERK，经理为号7788，
--入职日期为1985-03-03，薪资3000，奖金和部门为空。

insert into emp
values(8888,'BOB','CLERK',7788,'03-3月-85',300,null,null);

--插入多行数据
--用一个子查询得到的结果集代替values子句


--先创建一个manager表作为一个备份表
CREATE TABLE manager AS
SELECT * FROM emp WHERE 1=0;


--向manager 表中插入职位为manager的记录
insert into manager
select * from emp where job = 'MANAGER';

--1.查询薪水多于他所在部门平均薪水的雇员名字，部门号。
select ename,deptno,sal
from emp e
where sal > (select avg(sal) from emp where deptno = e.deptno);



select ename,deptno,sal from emp e
where sal >(select avg(sal) from emp where job = e.job);


--2.查询员工姓名和直接上级的名字。

select e.ename,m.ename
from emp e,emp m
where e.mgr = m.empno(+);


select ename,(select ename from emp where empno = e.mgr) as 经理的名字
from emp e;

--3.查询每个部门工资最高的员工姓名，工资。
select ename,sal
from emp e
where sal = (select max(sal) from emp where deptno = e.deptno);


select * from emp e where sal = (select max(sal) from emp where deptno = e.deptno);
--4.查询每个部门工资前两名高的员工姓名，工资。

select ename,sal,deptno
from emp e
where (select count(*) from emp where deptno = e.deptno and sal > e.sal) in (0,1)
order by deptno asc,sal desc;

select * from emp e where (select count(*) from emp where deptno = e.deptno and sal > e.sal) in (0,1);

--14. 列出至少有一个雇员的所有部门
select * from dept d where (select count(*) from emp where deptno = d.deptno) >= 1; 


select d.* from dept d,(select deptno,count(*) from emp group by deptno) s 
where d.deptno = s.deptno;

--25. 显示比工资最高的员工参加工作时间晚的员工姓名，参加工作时间
select hiredate from emp where sal = (select max(sal) from emp);

select ename,hiredate from emp where hiredate > (select hiredate from emp where sal = (select max(sal) from emp));
--24. 显示每位经理管理员工的最低工资，及最低工资者的姓名

select sal,ename from emp e where (sal,mgr) 
in (select min(sal),mgr from emp group by mgr having mgr is not null);--赵来荣

--21. 显示出和姓名中包含"W"的员工相同部门的员工姓名
select ename from emp where deptno in (select deptno from emp where ename like '%W%'); 


--修改数据
--修改某些行中的某些列
--最简单的修改数据的语句
--修改全部行中的某个列
update emp
set sal = 5000;

-- 想修改某些行中的某个列
--修改岗位为CLERK的员工工资，全部员工的工资加500
update emp       --1
set sal = sal + 500  --3
where job in 'CLERK'  --2

--修改某些行中的多个列
--set 语句中的修改句子用逗号隔开
update emp 
set sal = sal + 500,comm = nvl(comm,0) + 500
where job = 'CLERK';

--修改数据时的完整性约束
update emp
set deptno = 55
where deptno = 10;---error
--1.修改部门20的员工信息，把82年之后入职的员工入职日期向后调整10天
update emp
set hiredate = hiredate +10
where deptno = 20 and hiredate > '31-12月-82';--2条数据被修改


--2.修改奖金为null的员工，奖金设置为0

update emp
set comm = 0
where comm is null;--10条数据被修改



--3.修改工作地点在NEW YORK或CHICAGO的员工工资，工资增加500

update emp
set sal = sal + 500
where deptno in (select deptno from dept where loc in ('NEW YORK','CHICAGO'));--10条数据被修改

--相关updata
--在修改数据时使用相关子查询
--在emp表中增加一个列dname
ALTER TABLE emp
ADD(dname VARCHAR2(14));
--使用相关子查询更新dname列为正确的部门名称

update emp 
set dname = (select dname from dept where deptno = emp.deptno);

--删除语句 delete
--简单的删除语句
--删除员工表中岗位为clerk的员工 
--delete子句确定删除哪一个表 where子句确定删除哪些行
delete from emp
where job = 'CLERK';
--删除某个表的全部数据
delete emp;
delete from emp;

--删除数据时的完整性约束
delete emp
where deptno in 10;

delete dept
where deptno = 10;

--删除语句中使用相关子查询
--删除曾经做过入职的员工 记录
delete  emp
where empno in (select empno from emp_jobhistory);

--1.删除经理编号为7566的员工记录
delete emp
where mgr in 7566;

--2.删除工作在NEW YORK的员工记录
delete emp
where deptno in (select deptno from dept where loc in 'NEW YORK');

--3.删除工资大于所在部门平均工资的员工记录
delete emp e
where sal > (select avg(sal) from emp where deptno = e.deptno);----这题很重要。。。我特么没理解到。。。

delete emp 
where 
sal > (select avgSal from (select deptno,avg(sal) 
avgSal from emp group by deptno) where deptno = emp.detpno);--范玉伟 

--事务控制
--事务处理语言TPL commit rollback
--一组增删除查改语句加上一个非增删改查的语句就组成咯一个事务
--一个事务可以看作一个单元


--事务的结束
--显示结束
--显示提交或者回滚事务
--显式使用commit或者是rollback语句
rollback;

--隐式结束

--事务的开启
--标记：非增删查改语句后的第一条DML 语句

--设置保存点 savepoint
--作用：能够让我们的回滚操作回滚到保存点的位置


--锁
-- 行级锁
--当一个用户对某个表中某些行数据作操作的时候，其他用户不能对该行作操作
--当一边的事务结束的时候，行级锁就会被 释放


--表级锁
--当一个用户对某个表中的数据做操作的时候，该表的表结构不能被改变，直到事务结束才可以执行












select * from manager;
select * from emp;
select * from dept;






