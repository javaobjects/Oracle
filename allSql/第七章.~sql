----第七章 子查询 
--嵌套子查询(全部的子查询 都可以单独执行)
--单行子查询（子查询中只返回一行数据 ）
--查询工资比Jones工资高的员工信息？
select * 
from emp
where sal> (select sal from emp where ename ='JONES');
--查询工资最低的员工姓名？
select min(sal) from emp;
select ename from emp where sal = (select min(sal) from emp);

--查询部门最低工资比20部门最低工资高的部门编号及最低工资
select deptno,min(sal) from emp group by deptno 
having min(sal) > (select min(sal) from emp where deptno = 20);

--查询哪个部门的员工人数高于各个部门平均人数。
select deptno,count(*) from emp group by deptno having count(*) > 
(select avg(count(*)) from emp group by deptno);

--1.查询入职日期最早的员工姓名，入职日期
select ename,hiredate
from emp
where hiredate = (select min(hiredate) from emp);

--2.查询工资比SMITH工资高并且工作地点在CHICAGO的员工姓名，工资，部门名称 
--JOIN dept d USING
select emp.ename,emp.sal,dept.deptno
from emp,dept
where sal > (select sal from emp where ename = 'SMITH')
 and dept.loc = 'CHICAGO' and emp.deptno = dept.deptno;

select emp.ename,emp.sal,dept.deptno
from emp join dept
on(emp.deptno = dept.deptno)
where sal > (select sal from emp where ename = 'SMITH')
 and dept.loc = 'CHICAGO';
--3.查询入职日期比20部门入职日期最早的员工还要早的员工姓名，入职日期
select ename,hiredate
from emp
where hiredate < (select min(hiredate) from emp where deptno in 20);

--4.查询部门人数大于所有部门平均人数的的部门编号，部门名称，部门人数
 
select dept.deptno,dept.dname,count(*)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname 
having count(*) > (select avg(count(*)) from emp group by deptno);

select dept.deptno,dept.dname,count(*)
from emp join dept
on(emp.deptno = dept.deptno)
group by dept.deptno,dept.dname 
having count(*) > (select avg(count(*)) from emp group by deptno);

--多行子查询（子查询 返回多行数据）
--多行子查询的运算符 ： in any all 
--查询是经理的员工姓名跟工资

--in 运算符
select ename,sal from emp 
where empno in (select distinct mgr from emp);

-- any 
--   > any (大于集合中任意一个值即大于集合中的最小值)

--查询部门编号不为10，且工资比10部门任意一名员工工资高的员工编号，姓名，职位，工资。
select empno,ename,job,sal from emp
where sal > any (select sal from emp where deptno in 10) and deptno <> 10;


-- < any （小于一个值 即小于集合中的最大值 ）
--查询部门编号不为10，且工资比10部门任意一名员工工资低的员工编号，姓名，职位，工资。

select empno,ename,job,sal from emp
where sal < any (select sal from emp where deptno in 10) and deptno <> 10;
-- =any 相当于in运算符

--all 运行符
-- <all （小于集合中全部值即小于集合中的最小值）
--查询部门编号不为10，且工资比10部门所有员工工资低的员工编号，姓名，职位，工资。
select empno,ename,job,sal from emp
where sal < all (select sal from emp where deptno in 10) and deptno <> 10;

-- > all (大于集合中全部值 即大于集合中的最大值 )
--查询部门编号不为10，且工资比10部门任意一名员工工资高的员工编号，姓名，职位，工资。

select empno,ename,job,sal from emp
where sal > all (select sal from emp where deptno in 10) and deptno <> 10;

-- =all 等于集合中全部值 
--1.查询入职日期比10部门任意一个员工晚的员工姓名、入职日期，不包括10部门员工
select ename,hiredate
from emp
where hiredate > any(select hiredate from emp where deptno in 10) and deptno not in 10;

--2.查询入职日期比10部门所有员工晚的员工姓名、入职日期，不包括10部门员工

select ename,hiredate
from emp
where hiredate > all(select hiredate from emp where deptno in 10) and deptno not in 10;


--3.查询职位和10部门任意一个员工职位相同的员工姓名，职位，不包括10部门员工

select ename,job
from emp
where job = any(select job from emp where deptno in 10) and deptno not in 10;

select ename,job
from emp
where job in(select job from emp where deptno in 10) and deptno not in 10;

--多列子查询
--成对比较
--查询出和1981年入职的任意一个员工的部门和
--职位完全相同员工姓名、部门、职位、入职日期,不包括1981年入职员工
select ename,deptno,job,hiredate 
from emp
where (deptno,job) in (select deptno,job from emp where to_char(hiredate,'YYYY') = '1981')
and to_char(hiredate,'YYYY') <> '1981';

--非成对比较

--查询出和1981年入职的任意一个员工的
--部门或职位相同员工姓名、部门、职位、入职日期,不包括1981年入职员工。
select ename,deptno,job,hiredate 
from emp
where deptno in (select deptno from emp where to_char(hiredate,'YYYY') = '1981') or 
     job in (select job from emp where to_char(hiredate,'YYYY') = '1981')
     and to_char(hiredate,'YYYY') <> '1981';
-- 在 from 子句中使用子查询 
--查询比自己部门平均工资高的员工 姓名，工资，部门编号，部门平均工资
select deptno,avg(sal) from emp 
group by deptno;

select ename,sal,e.deptno,avgsal from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s
where e.deptno = s.deptno and e.sal > s.avgsal;

--1.查询比自己职位平均工资高的员工姓名、职位，部门名称，职位平均工资

select emp.ename,emp.job,dept.dname,avgsal 
from emp join (select job,avg(emp.sal) avgsal from emp group by emp.job) jobavgsal
on(emp.job = jobavgsal.job)
join dept
on(emp.deptno = dept.deptno)
where sal > jobavgsal.avgsal;


select emp.ename,emp.job,dept.dname,avgsal 
from emp join (select job,avg(emp.sal) avgsal from emp group by emp.job) jobavgsal
on emp.job = jobavgsal.job
join dept
on emp.deptno = dept.deptno
where sal > jobavgsal.avgsal;

--2.查询职位和经理同员工SCOTT或BLAKE完全相同的员工姓名、职位，不包括SCOOT和BLAKE本人。
select ename,job
from emp 
where (job,mgr) in (select job, mgr from emp where ename in('SCOTT','BLAKE'))
and ename not in('SCOTT','BLAKE');


select ename, job from emp 
where (job, mgr) in (
      select job, mgr from emp where ename in('SCOTT', 'BLAKE'))
      and ename not in('SCOTT', 'BLAKE');--李凯晴
--3.查询不是经理的员工姓名。


--带not in 的限制条件的子查询的空值需要做处理
select ename
from emp
where empno not in(select distinct mgr from emp  where mgr is not null);


--1.查询部门平均工资在2500元以上的部门名称及平均工资。
select dept.dname,avg(sal)
from emp join dept
on(emp.deptno = dept.deptno)
group by emp.deptno ,dept.dname
having avg(sal) > 2500

--2.查询员工岗位中不是以“SA”开头并且平均工资在2500元以上的岗位及平均工资，并按平均工资降序排序。
select emp.job,avg(emp.sal)
from emp join dept
on emp.deptno = dept.deptno
where instr(emp.job,'SA',1,1) = 0
group by emp.job
having avg(emp.sal) > 2500
order by avg(emp.sal) desc;


--3.查询部门人数在2人以上的部门名称、最低工资、最高工资,并对求得的工资进行四舍五入到整数位。
select dept.dname,round(min(emp.sal),0),round(max(emp.sal),0)
from emp join dept
on emp.deptno = dept.deptno
group by dept.dname
having count(*) > 2;

--4.查询岗位不为SALESMAN，工资 和 大于等于2500的 岗位及每种岗位的工资和。 
select sal,job,sum(sal)
from emp
group by sal,job
having sal > 2500 and job not in('SALESMAN')

--5.显示经理号码和经理姓名，这个经理所管理员工的最低工资，
--没有经理的KING也要显示，不包括最低工资小于3000的，按最低工资由高到低排序。
select m.empno,m.ename,min(m.sal)
from emp e,emp m
where e.mgr = m.empno(+)
group by m.empno,m.ename
having min(e.sal) >= 3000
order by min(e.sal) desc;--这题没解对

--6.写一个查询，显示每个部门最高工资和最低工资的差额。
select max(sal)-min(sal)
from emp
group by deptno

--1.查询工资高于编号为7782的员工工资，并且和7369号员工从事相同工作的员工的编号、姓名及工资。
select empno,ename,sal,job
from emp
where sal > (select sal from emp where empno in 7782) 
and job = (select job from emp where empno in 7369)

--2.查询工资最高的员工姓名和工资。 
select ename,sal
from emp
where sal = (select max(sal) from emp);

--3.查询部门最低工资高于10号部门最低工资的部门的编号、名称及部门最低工资。
--4.查询员工工资为其部门最低工资的员工的编号和姓名及工资。
--5.显示经理是KING的员工姓名，工资。
--6.显示比员工SMITH参加工作时间晚的员工姓名，工资，参加工作时间。

-- rownum为例
-- rownum 存在于所有的表中（可以存在于所有的普通表或者是子查询的结果集中）
select rownum,e.* 
from emp e;

--通过rownum 找出emp表中的前5条数据
select rownum,emp.* 
from emp
where rownum <= 5;

select emp.* 
from emp
where rownum <= 5;

--通过rownum找出emp个客户的6-10条数据
-- rownum伪列 不能使用 > 、>=、between...and 运算符做判断
-- rownum在where筛选数据的时候会动态发生变化
select emp.* 
from emp
where rownum >= 6;

--top-n查询
--找出数据表中的最前面的n条数据
--找出emp表中工资前5的员工
select * 
from emp
order by sal desc;

select rownum,emp.*
from emp
where row <=5
order by sal desc;--不能得到正确结果 ，where 先于order by执行

select s.* from 
(select * from emp order by sal desc) s
where rownum <= 5;
--找出emp表中工资后5的员工
select s.* from 
(select * from emp order by sal asc) s
where rownum <= 5;

--1.查询入职日期最早的前5名员工姓名，入职日期。
select hdate.ename,hdate.hiredate
from (select * from emp order by hiredate asc) hdate
where rownum <= 5;

--2.查询工作在CHICAGO并且入职日期最早的前2名员工姓名，入职日期。
select emp.ename,emp.hiredate,dept.loc
from emp join dept
on emp.deptno = dept.deptno
where dept.loc in 'CHICAGO' and rownum <= 2
order by hiredate;

--分布查询（序）
--通过rownum找出emp个客户的6-10条数据
--先通过rownum找出emp表中的前10条数据
select emp.* from emp where rownum <= 10;
-- 再从中找出6-10条
select * from (select rownum rn, emp.* from emp where rownum <= 10) where rn >= 6;
-- 再从中找出11-15条

select * from (select rownum rn, emp.* from emp where rownum <= 15) where rn >= 11;

--通过rownum 找出 数据表中的第n页的数据
select * from (select rownum rn, emp.* from emp where rownum <= endIndex) where rn >= starIndex;
--对排序后的结果集的分页
--找出emp表中的第一页的数据，要求数据是按照员工表的工资升序排序
select * from emp
order by sal asc;

select * from (select * from emp order by sal asc) s where rownum <= 5;
-- 找出第二页的数据
select * from (select * from emp order by sal asc) s where rownum <= 10;

select * from (select rownum rn,s.* from (select * from emp order by sal asc) s where rownum <= 10) m
where rn >= 6;
-- 找出第三页的数据

select * from (select rownum rn,s.* from (select * from emp order by sal asc) s where rownum <= 15) m
where rn >= 15;

--1.按照每页显示5条记录，分别查询第1页，第2页，第3页信息，要求显示员工姓名、入职日期、部门名称。
select emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno
where rownum <= 15

--第一页
select rownum rn,emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno
where rownum <= 5;

select * from (select rownum rn,emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno)
where rn <= 5; 

--第二页

select * from (select rownum rn,emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno
where rownum <= 10)
where rn > 5; 

--第三页
select * from (select rownum rn,emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno
where rownum <= 15)
where rn > 10; 

--1.按照每页显示5条记录，分别查询工资最高的第1页，第2页，第3页信息，要求显示员工姓名、入职日期、部门名称、工资。

select rownum,alldata.* from (select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata
where rownum <= 15;

--第一页 
select rownum,alldata.* from (select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata
where rownum <= 5;


select * from (select rownum rn,alldata.* from (select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata)
where rn <= 5;
--第二页
select * from (select rownum rn,alldata.* from 
(select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata
where rownum <= 10)
where rn >5;

--第三页
select * from (select rownum rn,alldata.* from (select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata
where rownum <= 15)
where rn >10;


select emp.ename,emp.hiredate,dept.loc
from emp,dept
where dept.loc in 'CHICAGO' and rownum <= 2 and emp.deptno = dept.deptno;


select * from emp;
select * from dept;
