----------------------------第六章  分组函数-------------------

--五个分组函数

--min求最小值(可以作用于不同的数据类型)
--求出emp表中的最低工资 
select min(sal) from emp;   --可以对数字类型作操作
select min(hiredate) from emp;  --可以对日期类型作操作
select min(ename) from emp;  --可以对字符类型的数据做操作

----max求最大值(可以作用于不同的数据类型)
select max(sal) from emp;   --可以对数字类型作操作
select max(hiredate) from emp;  --可以对日期类型作操作
select max(ename) from emp;  --可以对字符类型的数据做操作

--avg求平均值(只能作用于数值类型上)
select avg(sal) from emp;
select avg(ename) from emp;   --error 无效数字(avg函数只能识别数字类型的数据)

--sum求总和(只能作用于数值类型上)
select sum(sal) from emp;   
select sum(ename) from emp;  --error 无效数字(sum函数只能识别数字类型的数据)

--count统计(返回一个数字)
select count(*) from emp;
--想统计出emp表中有经理的员工有多少个
select count(mgr) from emp;

--分组函数中可以先使用DISTINCT先消除掉重复行，再统计
--找出有员工的部门有多少个
select count(distinct deptno) from emp;

--分组函数中的空值处理(统计函数不统计空值)
--想查出员工表的平均奖金
select avg(comm) from emp;   --550
select avg(nvl(comm,0)) from emp;    --157.142857142857


--1.查询部门20的员工，每个月的工资总和及平均工资。
select sum(sal),avg(sal) from emp where deptno = 20;

--2.查询工作在CHICAGO的员工人数，最高工资及最低工资。
select count(*),max(sal),min(sal) from emp e,dept d where e.deptno = d.deptno and loc = 'CHICAGO';

--3.查询员工表中一共有几种岗位类型。
select count(distinct job) "岗位类型数量" from emp;


---------------------------以上全是统计整个表时的情况---------------------------------

--我们可以使用group by子句进行数据的分组
--统计出每个部门的平均工资
select deptno,avg(sal) from emp group by deptno;

--*********************统计列************************
--统计列：在select语句中不带分组函数的列，而统计列必须写到group by分组语句中
--但是在group by中的列不一定要出现在select语句中

--统计出每个部门的最低工资
select deptno,min(sal) from emp group by deptno;

--多列组合分组
--查询每个部门每个岗位的工资总和
select sum(sal) from emp     group by deptno,job;

--where子句先写，group by子句后写


--1.查询每个部门的部门编号，部门名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select e.deptno,d.dname,count(*),max(sal),min(sal),sum(sal),avg(sal) 
from emp e,dept d
where e.deptno = d.deptno 
group by e.deptno,d.dname;


--2.查询每个部门，每个岗位的部门编号，部门名称，岗位名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select e.deptno,dname,job,count(*),max(sal),min(sal),sum(sal),avg(sal)
from emp e,dept d
where e.deptno = d.deptno
group by e.deptno,job,dname


--3.查询每个经理所管理的人数（有多少个人有上级经理），经理编号，经理姓名，要求包括没有经理的员工信息。
select count(*),m.empno,m.ename 
from emp e,emp m
where e.mgr = m.empno(+)
group by e.mgr,m.empno,m.ename


--排除组结果
--统计出每个部门的最低工资,要让部门最低工资大于1000的才输出
--where子句当中不能出现分组函数
select deptno,min(sal)  from emp where min(sal)>1000  group by deptno;

--在同一个句子当中列别名不能被where子句识别
select deptno,min(sal) "minsal" from emp where minsal > 1000  group by deptno;

--使用having来限制带分组函数的条件
--普通的不带分组函数的限制条件仍然要写到where当中
select deptno,min(sal)  from emp  group by deptno having min(sal)>1000;

--已经学过的子句
select
from
where
group by
having
order by

--执行顺序
from    where   group by   having    select   order by

--组函数的嵌套
--查出每个部门的最大工资值里的最小值
--组函数只能嵌套两层
select avg(min(max(sal))) from emp group by deptno;   --error   分组函数嵌套太深


--1.查询部门平均工资在2500元以上的部门名称及平均工资。
select dname,avg(sal) from emp e,dept d where e.deptno = d.deptno group by dname  having avg(sal) > 2500;

--2.查询员工岗位中不是以“SA”开头并且平均工资在2500元以上的岗位及平均工资，并按平均工资降序排序。
select job,avg(sal) avgsal from emp where job not like 'SA%' group by job having avg(sal) > 2500  order by avgsal desc; 

--3.查询部门人数在2人以上的部门名称、最低工资、最高工资,并对求得的工资进行四舍五入到整数位。
select dname,count(*),round(min(sal)),round(max(sal)) from emp e,dept d 
where e.deptno = d.deptno group by dname having count(*) > 2;

--4.查询岗位不为SALESMAN，工资和大于等于2500的岗位及每种岗位的工资和。 
select job,sum(sal) from emp where job <> 'SALESMAN' group by job having sum(sal) >= 2500;


--5.显示经理号码和经理姓名，这个经理所管理员工的最低工资，没有经理的KING也要显示，不包括最低工资小于3000的，按最低工资由高到低排序。
select m.empno,m.ename,min(e.sal) minsal from emp e,emp m 
where e.mgr = m.empno(+) 
group by e.mgr,m.empno,m.ename 
having min(e.sal) >= 3000 
order by minsal desc;


--6.写一个查询，显示每个部门最高工资和最低工资的差额
select deptno,(max(sal) - min(sal)) "差额"  from emp group by deptno;
















select * from emp;
select * from dept;
