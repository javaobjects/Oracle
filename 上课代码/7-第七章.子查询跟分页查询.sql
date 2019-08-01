----------------------第七章  子查询-----------------------

--子查询可以单独执行

--单行子查询（子查询只返回一行数据）
--查询出比JONES的雇员工资高的其他雇员
select sal from emp where ename = 'JONES';
select * from emp where sal > (select sal from emp where ename = 'JONES');

--显示   和雇员7369从事相同工作  并且  工资大于雇员7876  的雇员的  姓名和工作。
select job from emp where empno = 7369;   --CLERK
select sal from emp where empno = 7876;   --1100

select * from emp 
where job = (select job from emp where empno = 7369) 
  and sal > (select sal from emp where empno = 7876);
  
--子查询中使用组函数
--查询工资最低的员工姓名，岗位及工资
select min(sal) from emp;
select ename,job,sal from emp where sal = (select min(sal) from emp);

--HAVING子句中使用子查询
--查询部门最低工资比  20部门最低工资高  的   部门编号及最低工资
select min(sal) from emp where deptno = 20;  --子查询  800
select deptno,min(sal) from emp 
group by deptno 
having min(sal) > (select min(sal) from emp where deptno = 20);

--查询哪个部门的员工人数 高于 各部门平均人数。
select avg(count(*)) from emp group by deptno;  --4.666667
select deptno,count(*) from emp 
group by deptno 
having count(*) > (select avg(count(*)) from emp group by deptno);


--1.查询入职日期最早的员工姓名，入职日期
select min(hiredate) from emp;   --1980/12/17
select ename,hiredate from emp where hiredate = (select min(hiredate) from emp);

--2.查询工资比SMITH工资高并且工作地点在CHICAGO的员工姓名，工资，部门名称
select sal from emp where ename = 'SMITH';
select * from emp e,dept d 
where e.deptno = d.deptno and sal > (select sal from emp where ename = 'SMITH') and loc = 'CHICAGO';

--3.查询入职日期比20部门入职日期最早的员工还要早的员工姓名，入职日期
select min(hiredate) from emp where deptno = 30;
select ename,hiredate from emp where hiredate < (select min(hiredate) from emp where deptno = 30);

--4.查询部门人数大于所有部门平均人数的的部门编号，部门名称，部门人数
select avg(count(*)) from emp group by deptno;
select e.deptno,dname,count(*) from emp e,dept d
where e.deptno = d.deptno 
group by e.deptno,dname having count(*) > (select avg(count(*)) from emp group by deptno);



--多行子查询(子查询返回多行数据)
--in运算符
--查询是经理的员工姓名，工资
select ename,sal from emp where empno in(select mgr from emp);

--any运算符
--查询部门编号不为10，且工资比10部门任意一名员工工资高的  员工编号，姓名，职位，工资
--方法一
select sal from emp where deptno = 10;
select * from emp where deptno <> 10 and sal >any (select sal from emp where deptno = 10);

--方法二
select min(sal) from emp where deptno = 10;
select * from emp where deptno <> 10 and sal > (select min(sal) from emp where deptno = 10);

--all运算符
--查询部门编号不为10，且工资比10部门所有员工工资低的员工编号，姓名，职位，工资
select sal from emp where deptno = 10;
select * from emp where deptno <> 10 and sal <all (select sal from emp where deptno = 10);



--1.查询入职日期比10部门任意一个员工晚的员工姓名、入职日期，不包括10部门员工
select hiredate from emp where deptno = 10;
select ename,hiredate from emp where hiredate >any (select hiredate from emp where deptno = 10) and deptno <> 10;

--2.查询入职日期比10部门所有员工晚的员工姓名、入职日期，不包括10部门员工
select ename,hiredate from emp where hiredate >all (select hiredate from emp where deptno = 10) and deptno <> 10;

--3.查询职位和10部门任意一个员工职位相同的员工姓名，职位，不包括10部门员工
select job from emp where deptno = 10;
select ename,job from emp where job in(select job from emp where deptno = 10) and deptno <> 10;


--多列子查询
--成对比较
--查询出和1981年入职的任意一个员工的部门和职位完全相同  员工姓名、部门、职位、入职日期,不包括1981年入职员工。
select deptno,job from emp where to_char(hiredate,'YYYY') = '1981';

select ename,deptno,job,hiredate 
from emp 
where (deptno,job) in (select deptno,job from emp where to_char(hiredate,'YYYY') = '1981')
                          and to_char(hiredate,'YYYY') <> '1981';
                          
--非成对比较
--查询出和1981年入职的任意一个员工的部门或职位相同员工姓名、部门、职位、入职日期,不包括1981年入职员工
select deptno from emp where to_char(hiredate,'YYYY') = '1981';
select job from emp where to_char(hiredate,'YYYY') = '1981';

select ename,deptno,job,hiredate 
from emp where (job in(select job from emp where to_char(hiredate,'YYYY') = '1981')
                  or deptno in(select deptno from emp where to_char(hiredate,'YYYY') = '1981'))
                  and to_char(hiredate,'YYYY') <> '1981';
                  
                  
                  
--1.查询职位及经理和10部门任意一个员工职位及经理相同的员工姓名，职位，不包括10部门员工
select job,mgr from emp where deptno = 10;
select ename,job from emp where (job,mgr) in (select job,mgr from emp where deptno = 10) and deptno <> 10;


--2.查询职位及经理和10部门任意一个员工职位或经理相同的员工姓名，职位，不包括10部门员工
select job from emp where deptno = 10;
select mgr from emp where deptno = 10;
select ename,job from emp where (job in (select job from emp where deptno = 10) 
                                or mgr in(select mgr from emp where deptno = 10))
                                and deptno <> 10;

--子查询中的空值                                
--查询不是经理的员工姓名
--not in后面带的子查询有空值的时候需要进行相应的处理
select ename from emp where empno not in (select mgr from emp where mgr is not null);

--在 FROM 子句中使用子查询(把子查询中的结果集当成一个表)
--查询比自己部门平均工资高的员工姓名，工资，部门编号，部门平均工资
select deptno,avg(sal) from emp group by deptno;

select ename,sal,e.deptno,avgsal from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal > avgsal;

--1.查询比自己职位平均工资高的员工姓名、职位，部门名称，职位平均工资
select job,avg(sal) from emp group by job;

select ename,e.job,dname,avgsal from emp e,(select job,avg(sal) avgsal from emp group by job) s,dept d
where  e.job = s.job and e.deptno = d.deptno and e.sal > s.avgsal;


--2.查询职位和经理同员工SCOTT或BLAKE完全相同的员工姓名、职位，不包括SCOOT和BLAKE本人。
select job,mgr from emp where ename in('SCOTT','BLAKE');
select ename,job from emp where (job,mgr) in (select job,mgr from emp where ename in('SCOTT','BLAKE'))
                                  and ename not in('SCOTT','BLAKE');

--3.查询不是经理的员工姓名。
select ename from emp where empno not in (select mgr from emp where mgr is not null);


--分页查询
--rownum伪列（存在于任何一个表中，基础表或者是子查询的出来的表都会有一个默认的rownum伪列）
select rownum,emp.* from emp;

--找出emp表中前5行数据
select rownum,emp.* from emp where rownum <=5;

--找出6到10行数据(rownum在where去筛选数据的时候会动态变化，所以不能使用>,>=,between...and来判断rownum的条件)
select rownum,emp.* from emp where rownum >=6;    --error

--TOP-N查询
--找出emp表中工资前5高的员工
select rownum,emp.* from emp where rownum <=5  order by sal desc;   --error  它会先做rownum的筛选，然后再排序
select emp.* from emp order by sal desc;
select rownum,e.* from (select emp.* from emp order by sal desc) e where rownum <=5;


--简单的没排序分页查询
--查出emp表中第二页（6-10行）的数据
select rownum rn,emp.* from emp where rownum <=10;
select * from (select rownum rn,emp.* from emp where rownum <=10) where rn >= 6;

--查出emp表中第三页（11-15行）的数据
select rownum rn,emp.* from emp where rownum <=15;
select * from (select rownum rn,emp.* from emp where rownum <=15) where rn >= 11;

--排序后的数据的分页查询
--查询出工资最高的员工的第一页数据（一页有5行）
select * from emp order by sal desc;
select rownum,s.* from (select * from emp order by sal desc) s where rownum <=5;

--查询出工资最高的员工的第二页数据（一页有5行）
select rownum rn,s.* from (select * from emp order by sal desc) s where rownum <=10
select * from (select rownum rn,s.* from (select * from emp order by sal desc) s where rownum <=10) where rn >=6;


--1.按照每页显示5条记录，分别查询第1页，第2页，第3页信息，要求显示员工姓名、入职日期、部门名称。
--第一页
select rownum,ename,hiredate,dname from emp e,dept d where e.deptno = d.deptno and rownum <=5;

--第二页
select rownum rn,ename,hiredate,dname from emp e,dept d where e.deptno = d.deptno and rownum <= 10  --前十行数据
select * from (select rownum rn,ename,hiredate,dname from emp e,dept d where e.deptno = d.deptno and rownum <= 10)
where rn >= 6 ;

--第三页
select * from (select rownum rn,ename,hiredate,dname from emp e,dept d where e.deptno = d.deptno and rownum <= 15)
where rn >= 11 ;


--2.按照每页显示5条记录，分别查询工资最高的第1页，第2页，第3页信息，要求显示员工姓名、入职日期、部门名称、工资。
select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc ;  --将要分页的数据
select rownum,s.* 
from (select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc) s
where rownum <=5;   --第一页

--第二页
select rownum,s.* 
from (select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc) s
where rownum <=10;   --前十行数据

select * from (select rownum rn,s.* 
from (select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc) s
where rownum <=10) where rn >= 6;


--第三页
select * from (select rownum rn,s.* 
from (select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc) s
where rownum <=15) where rn >= 11;





--2.查询工资最高的员工姓名和工资。
select max(sal) from emp;
select ename,sal from emp where sal = (select max(sal) from emp);

--3. 查询部门最低工资高于10号部门最低工资的部门的编号、名称及部门最低工资。
select min(sal) from emp where deptno = 10;
select e.deptno,dname,min(sal) from emp e,dept d 
where e.deptno = d.deptno 
group by deptno 
having min(sal) > (select min(sal) from emp where deptno = 10);

--10.写一个查询显示其上级领导是KING的员工姓名、工资
select empno from emp m where ename = 'KING';
select ename,sal from emp where mgr = (select empno from emp m where ename = 'KING');

--13.查询大于自己部门平均工资的员工姓名，工资，所在部门平均工资，高于部门平均工资的额度
select deptno,avg(sal) from emp group by deptno;
select * from emp;
select ename,sal,avgsal,(sal - avgsal) "差额"
from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal > s.avgsal;

--19. 显示每个部门的最高工资的员工
select deptno,max(sal) from emp group by deptno;
select * from emp;
select * from emp e,(select deptno,max(sal) maxsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal = s.maxsal;


--23. 显示出工资大于本部门平均工资的员工姓名，工资
select deptno,avg(sal) from emp group by deptno;
select ename,sal from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal > s.avgsal;


--25. 显示比工资最高的员工参加工作时间晚的员工姓名，参加工作时间
select max(sal) from emp;
select hiredate from emp where sal = (select max(sal) from emp);
select ename,hiredate from emp where hiredate > (select hiredate from emp where sal = (select max(sal) from emp));


--26. 显示出平均工资最高的的部门平均工资及部门名称
select dname,avg(sal) from emp e,dept d where e.deptno = d.deptno group by dname;
select max(avg(sal)) from emp group by deptno;

--方法一
select * from (select dname,avg(sal) avgsal from emp e,dept d where e.deptno = d.deptno group by dname)
where avgsal = (select max(avg(sal)) from emp group by deptno);

--方法二
select dname,avg(sal)  from emp e,dept d 
where e.deptno = d.deptno 
group by dname 
having avg(sal) =(select max(avg(sal)) from emp group by deptno);

--方法三
select dname,avg(sal)  avgsal from emp e,dept d 
where e.deptno = d.deptno 
group by dname order by avgsal desc;

select rownum,s.* from (select dname,avg(sal)  avgsal from emp e,dept d 
where e.deptno = d.deptno 
group by dname order by avgsal desc) s where rownum <=1;
 



 

select * from emp;
select * from dept;
