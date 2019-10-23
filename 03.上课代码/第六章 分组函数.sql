----------------------------------------------------------
-- 分组函数：min()  max()  avg()   sum()   count()
----------------------------------------------------------
--min()最小值 与 max()最大值    用于任何数据类型
1.查询最早与最晚的入职日期
select min(hiredate),max(hiredate) from emp; --用于日期类型

2.查询最低与最高的薪资
select min(sal),max(sal) from emp;--用于数值类型

3.查询最小与最大的姓名
select min(ename),max(ename) from emp;--用于字符类型

--sum()求和 与 avg()求平均值    只能用于数值类型
1.查询职位以SALES开头的所有员工平均工资、最低工资、最高工资、工资和。
select avg(sal),min(sal),max(sal),sum(sal) from emp where job like 'SALES%';

--count() 返回符合条件的数据行
1.查询部门30有多少个员工
select count(*) from emp where deptno = 30;--6  效率低
select count(1) from emp where deptno = 30;--6  效率高
select count(empno) from emp where deptno = 30;--6
select count(deptno) from emp where deptno = 30;--6

--返回满足条件的非空(NULL)行的数量，count默认会排除null值
2.部门30有多少个员工领取奖金
select count(comm) from emp where deptno = 30;--4

--DISTINCT会消除重复记录后再使用组函数 
3.查询有员工的部门数量。 
select count(distinct deptno) from emp;

--除了COUNT（*）之外，其它所有分组函数都会忽略列中的空值，然后再进行计算
1.查询所有员工的平均奖金
select sum(comm),avg(comm) from emp;       --2200/4 = 550  默认忽略null值
select sum(comm),avg(nvl(comm,0)) from emp;--2200/14 =  157.142857142857

----------------------------------------------------------
-- group by 分组子句
--       注意：1.select子句列表中，只允许放分组函数，以及出现在group by后面的列
--             2.并不是group by后面的列一定要写在select列表中                 
----------------------------------------------------------
--按单列分组
1.查询每个部门的编号，平均工资
select deptno,avg(sal) from emp group by deptno;
select avg(sal) from emp group by deptno;
select empno,deptno,avg(sal) from emp group by deptno;--not ok empno不是group by表达式

--按多列分组
1.查询每个部门每个岗位的工资总和。
select deptno,job,sum(sal) from emp group by deptno,job;

--使用分组函数的非法的查询
1.查询每个部门的人数
select deptno,count(ename) from emp;--not ok deptno不是单组分组函数
select deptno,count(ename) from emp group by deptno;--ok

--练习
1.查询每个部门的部门编号，部门名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select e.deptno,
       d.dname,
       count(empno) 部门人数,
       max(sal) 最高工资,
       min(sal) 最低工资,
       sum(sal) 工资总和,
       avg(sal) 平均工资
  from emp e, dept d
 where e.deptno = d.deptno
 group by e.deptno,d.dname;

2.查询每个部门，每个岗位的部门编号，部门名称，岗位名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select e.deptno,
       d.dname,
       e.job,
       count(empno) 部门人数,
       max(sal) 最高工资,
       min(sal) 最低工资,
       sum(sal) 工资总和,
       avg(sal) 平均工资
  from emp e, dept d
 where e.deptno = d.deptno
 group by e.deptno,d.dname,e.job;

3.查询每个经理所管理的人数，经理编号，经理姓名，要求包括没有经理的人员信息。
select e.mgr 经理编号, m.ename 经理姓名, count(e.empno) 管理人数
  from emp e, emp m
 where e.mgr = m.empno(+)
 group by e.mgr, m.ename;

----------------------------------------------------------
-- having子句 : 排除组      
----------------------------------------------------------
1.查询每个部门最高工资大于2900的部门编号，最高工资
select deptno,max(sal) from emp group by deptno having max(sal) > 2900;

--select语句的执行过程
select deptno, job, avg(sal)                    --5
  from emp                                      --1
 where job in ('SALESMAN', 'MANAGER', 'CLERK')  --2
 group by deptno, job                           --3
having avg(sal) > 1000                          --4
 order by 3 desc;                               --6

--------------------------------------------------------------
--组函数的嵌套:分组函数最多允许嵌套两层   单行函数可以无限嵌套
 --------------------------------------------------------------
 1.查询各个部门的平均人数
 select deptno,count(1) from emp group by deptno;--各个部门的人数
 select avg(count(1)) from emp group by deptno; --各个部门的平均人数  3.5
 
 select max(avg(count(1))) from emp group by deptno;--not ok 分组函数的嵌套太深

--练习
2.【分组函数】查询员工岗位中不是以“SA”开头并且平均工资在2500元以上的岗位及平均工资，并按平均工资降序排序。
select job, avg(sal)
  from emp
 where job not like 'SA%'
 group by job
having avg(sal) > 2500
 order by avg(sal) desc;

5.【分组函数】显示经理号码和经理姓名，这个经理所管理员工的最低工资，没有经理的KING也要显示，不包括最低工资小于3000的，按最低工资由高到低排序。
select e.mgr 经理号码, m.ename 经理姓名, min(e.sal) 所管理员工的最低工资
  from emp e, emp m
 where e.mgr = m.empno(+)
 group by e.mgr, m.ename
having min(e.sal) >= 3000
 order by min(e.sal) desc;

6.【分组函数】写一个查询，显示每个部门最高工资和最低工资的差额。
select deptno,max(sal),min(sal),max(sal)-min(sal) from emp group by deptno;
