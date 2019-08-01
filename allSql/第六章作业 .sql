

--请思考如下问题？
--查询所有员工的每个月工资总和，平均工资？
select sum(sal) as 月工资总和,avg(sal) as 平均工资
from emp;

--查询工资最高和最低的工资是多少？

select max(sal),min(sal) from emp;
--查询公司的总人数？

select count(*) from emp;
--查询有奖金的总人数？

select count(*) from emp where comm is not null;

select count(*) from emp where nvl(comm,0) > 0;

--练习一
--1.查询部门20的员工，每个月的工资总和及平均工资。
select sum(sal),avg(sal) from emp where deptno in 20;



--2.查询工作在CHICAGO的员工人数，最高工资及最低工资。刘

select count(*),max(sal),min(sal)
from emp join dept
on emp.deptno = dept.deptno
where loc in 'CHICAGO'; 


--3.查询员工表中一共有几种岗位类型。

select count(distinct deptno) from emp; 

--思考
--查询每个部门的平均工资？
select avg(sal),deptno from emp group by deptno;

--练习二
--1.查询每个部门的部门编号，部门名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select emp.deptno,dept.dname,count(*),max(sal),min(sal),sum(sal),avg(sal)
from emp join dept
on emp.deptno = dept.deptno
group by emp.deptno,dept.dname;

--2.查询每个部门，每个岗位的部门编号，部门名称，岗位名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select emp.deptno,dname,job,count(*),max(sal),min(sal),sum(sal),avg(sal)
from emp join dept 
on emp.deptno = dept.deptno
group by emp.deptno,dname,job;

--3.查询每个经理所管理的人数（有多少个人有上级经理），经理编号，经理姓名，要求包括没有经理的人员信息。
select count(*),manager.empno,manager.ename 
from emp worker,emp manager
where worker.mgr = manager.empno(+)
group by manager.empno,manager.ename;

--练习三
--1.查询部门人数大于2的部门编号，部门名称，部门人数。
select dept.deptno,dept.dname,count(dept.deptno)
from emp join dept
on emp.deptno = dept.deptno
group by dept.deptno,dept.dname
having count(dept.deptno) > 2;


--2.查询部门平均工资大于2000，且人数大于2的部门编号，部门名称，部门人数，部门平均工资，并按照部门人数升序排序。
select dept.deptno,dname,count(dept.deptno),avg(sal)
from emp join dept
on emp.deptno = dept.deptno
group by dept.deptno,dname
having avg(sal) > 2000 and count(dept.deptno) > 2
order by count(*) asc;

--课后作业 
--1.查询部门平均工资在2500元以上的部门名称及平均工资。
select dname,avg(sal)
from emp join dept
on emp.deptno = dept.deptno
group by dname
having avg(sal) > 2500;



--2.查询员工岗位中不是以“SA”开头并且平均工资在2500元以上的岗位及平均工资，并按平均工资降序排序。
select job,avg(sal)
from emp
group by job
having avg(sal) > 2500 and job not like 'SA%';

--3.查询部门人数在2人以上的部门名称、最低工资、最高工资,并对求得的工资进行四舍五入到整数位。

select dname,round(min(sal)),round(max(sal))
from emp join dept
on emp.deptno = dept.deptno
group by dname
having count(dname) > 2;


--4.查询岗位不为SALESMAN，工资和大于等于2500的岗位及每种岗位的工资和。 
select job,sum(sal)
from emp join dept
on emp.deptno = dept.deptno
group by job
having job not in 'SALESMAN' and sum(sal) >=  2500;

--5.显示经理号码和经理姓名，这个经理所管理员工的最低工资，
--没有经理的KING也要显示，不包括最低工资小于3000的，按最低工资由高到低排序。

select s.mgr,s.ename,minsal
from emp e,(select e.mgr,m.ename,min(e.sal) minsal from emp e,
emp m where e.mgr=m.empno(+) group by e.mgr,m.ename) s
where e.mgr=s.mgr and minsal>=3000
order by e.sal desc;



--先查询经理所管理的员工的最低工资  

select worker.mgr,manager.ename,min(worker.sal) minsal from 
emp worker,emp manager 
where worker.mgr = manager.empno(+) 
group by worker.mgr,manager.ename
having min(worker.sal) > = 3000
order by minsal desc;----这才是正确解法





--先查询经理所管理的员工有哪些
select manager.ename managerName,manager.empno managerEmpno,worker.ename,worker.sal  from
emp worker,emp manager
where worker.mgr = manager.empno(+);
--再查询 经理所管理的员工的最低工资 
select managerEmpno,managerName,min(sal) minSal
from (select manager.ename managerName,manager.empno managerEmpno,worker.ename,worker.sal  from
emp worker,emp manager
where worker.mgr = manager.empno(+))
group by managerName,managerEmpno;

select e.mgr,m.ename,min(e.sal) from emp e,emp m where e.mgr=m.empno(+) group by e.mgr,m.ename;
--所以最终解法为
select  manager.empno,manager.ename,tabminsal.minSal
from emp worker, emp manager,(select managerEmpno,managerName,min(sal) minSal
from (select manager.ename managerName,manager.empno managerEmpno,worker.ename,worker.sal  from
emp worker,emp manager
where worker.mgr = manager.empno(+))
group by managerName,managerEmpno) tabminsal
where worker.mgr = manager.empno(+) 
and manager.ename = tabminsal.managerName 
and tabminsal.minSal >= 3000
order by tabminsal.minSal desc;
--6.写一个查询，显示每个部门最高工资和最低工资的差额。
select (max(sal)-min(sal))
from emp
group by deptno;

--索引简称_表名_  索引命名
--seq_表名_字段名 序列命名
