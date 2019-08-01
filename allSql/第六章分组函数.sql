------第六章 分组函数
--5个分组函数
--min 求最小 值
--想求出emp表中最低工资

select min(sal) from emp;--800
--找出emp最早的入职日期
select min(hiredate) from emp;

--max 求一个最大值 
select max(sal) from emp;
select max(hiredate) from emp;

--max min 可以对日期类型 ，字符类型，数值类型的数据生效
--sum跟avg只能对数值类型做操作
--sum 求总和
--想求出emp表中的全部员工的总工资
select sum(sal) from emp;
select sum(hiredate) from emp;--error 只能接受数值的数据
--avg 求平均值
--求出emp表中全部员工的平均工资
select avg(sal) from emp;

--count 是返回结果集中全部指定数据的行数
--count 中的参数可以是*或者是列名或者是数字（只是一个点位的作用，跟*没有区别)
--count 后面带列表的时候，带空值的列将不会被统计
select count(*) from emp;
select count(1) from emp;
--想统计出emp表中有经理的人有多个
select count(mgr) from emp;

--在统计函数的参数中可以加上distinct先去重，再统计
--1.查询部门20的员工，每个月的工资总和及平均工资。
select sum(sal),avg(sal)
from emp
where deptno in 20;

--2.查询工作在CHICAGO的员工人数，最高工资及最低工资。
select count(*),
max(emp.sal),
min(emp.sal)
from emp,dept
where dept.loc in 'CHICAGO' and emp.deptno = dept.deptno;


--3.查询员工表中一共有几种岗位类型。
select count(distinct job) from emp;

--group by 子句给数据表分组
--如果有where子句 group by写到where子句后面
--侧皮肤一句话求出emp表中全部部门的最高工资
select deptno,max(sal)
from emp group by deptno;
--比较重要的概念
--统计列 在select子句中不包含分组函数的列
--统计列必须要写到group by 子句当中 
select deptno,ename,max(sal)
from emp group by deptno; --error 不是group by表达式

select deptno,ename,max(sal)
from emp group by deptno,ename;

--多列组合分组
--查询每个部门每个岗位的工资总和。
select deptno,job,sum(sal) 
from emp group by deptno,job;

--1.查询每个部门的部门编号，部门名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select dept.deptno,dept.dname,count(*),
max(emp.sal),min(emp.sal),sum(emp.sal),avg(emp.sal)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname;

--2.查询每个部门，每个岗位的部门编号，部门名称，岗位名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select dept.deptno,dept.dname,emp.job,count(*),
max(emp.sal),min(emp.sal),sum(emp.sal),avg(emp.sal)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname,emp.job;

--3.查询每个经理所管理的人数（有多少个人有上级经理），经理编号，经理姓名，要求包括没有经理的人员信息。
select count(*),m.empno,m.ename
from emp e,emp m 
where e.mgr = m.empno(+)
group by m.empno,m.ename;

--having 子句筛选分组后的数据
--having 子句搭配group by使用
--having子句限制的是带有分组函数的条件 where子句限制普通的限制条件 
--找出最高工资大于等3000的部门以及它的部门最高工资
select deptno,max(sal) from emp group by deptno having max(sal) > = 3000;
select deptno,max(sal) from emp where max(sal) > = 3000 group by deptno;---error where子句不允许使用分组函数
--1.查询部门人数大于2的部门编号，部门名称，部门人数。
select dept.deptno,dept.dname,count(dept.deptno)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname 
having count(dept.deptno) > 2;

--2.查询部门平均工资大于2000，且人数大于2的部门编号，
--部门名称，部门人数，部门平均工资，并按照部门人数升序排序。

select dept.deptno,dept.dname,count(dept.deptno),avg(emp.sal)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname
having avg(emp.sal) > 2000 and count(*) >2
order by count(dept.deptno) asc;
--分组函数的嵌套只能嵌套两层

--若有两层以上嵌套则报错----分组函数嵌套太深
--select from    where     group by    having     order by
--六个子句执行的顺序
--from where    group by     having    select    order by




select * from emp;
select * from dept;
