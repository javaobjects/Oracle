-----------------------------------------------
-- 使用子查询
--    ①  子查询（内部查询）优先执行
--    ②  将步骤①中查询的结果交给父查询（外部查询）使用，用于确认或取消数据
--
--    单行子查询使用单行运算符：>  >=   =  <  <=  <>
--    多行子查询使用多行运算符：in  any  all
-----------------------------------------------
1.查询出比JONES雇员工资高的其他雇员
select sal from emp where ename = 'JONES';                                --1. jones的工资是多少？  2975.00
select * from emp where sal > (select sal from emp where ename = 'JONES');--2.查询出比JONES雇员工资高的其他雇员

-----------------------------------------------------------
--单行子查询:返回一行一列       使用单行运算符：>  >=   =  <  <=  <>
-----------------------------------------------------------
1.显示和雇员7369从事相同工作并且工资大于雇员7876的雇员的姓名和工作。
select job from emp where empno = 7369;                --1.雇员7369从事的工作是什么  CLERK
select sal from emp where empno = 7876;                --2.雇员7876的工资是多少 1100.00
select ename, job
  from emp
 where job = (select job from emp where empno = 7369)
   and sal > (select sal from emp where empno = 7876); --3.主查询
   
--子查询中使用组函数
1.查询工资最低的员工姓名，岗位及工资
select min(sal) from emp;                                --1. 查询最低工资是多少  800
select * from emp where sal = (select min(sal) from emp);--2. 主查询

--HAVING子句中使用子查询
1.查询部门最低工资比20部门最低工资高的部门编号及最低工资
select min(sal) from emp where deptno = 20;                           --1. 20部门最低工资  800
select deptno,min(sal) from emp group by deptno having min(sal) > 800;--2. 主查询
   
2.查询哪个部门的员工人数高于各部门平均人数。
select avg(count(empno)) from emp group by deptno;                         --1. 各部门平均人数   3.5
select deptno, count(empno)
  from emp
 group by deptno
having count(empno) > (select avg(count(empno)) from emp group by deptno); --2. 主查询
   
--练习
4.查询部门人数大于所有部门平均人数的的部门编号，部门名称，部门人数
select avg(count(empno)) from emp group by deptno;                         --1.所有部门平均人数  3.5

select e.deptno, d.dname, count(empno)
  from emp e, dept d
 where e.deptno = d.deptno
 group by e.deptno, d.dname
 having count(empno) > (select avg(count(empno)) from emp group by deptno); --2.主查询
   
-----------------------------------------------------------
--多行子查询:返回多行一列       使用多行运算符：in  any  all 
-----------------------------------------------------------
--in 
1.查询员工工资为各个部门最低工资的员工信息
select min(sal) from emp group by deptno;-- null 950  800 1300

select empno, ename
  from emp
 where sal = (select min(sal) from emp group by deptno);-- not ok 单行子查询返回多个结果
 
 select empno, ename,sal
  from emp
 where sal in (select min(sal) from emp group by deptno);--ok

2.查询是经理的员工姓名，工资
select distinct mgr from emp;                                   --1.查询哪些人是经理？  7839,7782,7698,7902,7788,7566
select * from emp where empno in(select distinct mgr from emp);-- 2.主查询

--ANY 与任意值匹配    <any    >any    =any（相当于in）
-- =any（相当于in）:与子查询的任意一个值相等
1.查询是经理的员工姓名，工资。
select distinct mgr from emp;                                   --1.查询哪些人是经理？  7839,7782,7698,7902,7788,7566
select * from emp where empno =any (select distinct mgr from emp);-- 2.主查询

-- >any :大于最小值
2.查询部门编号不为10，且工资比10部门【任意】一名员工工资【高】的员工编号，姓名，职位，工资。
select sal from emp where deptno = 10;                          --1.查询10部门所有员工的工资 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal >any (select sal from emp where deptno = 10) and deptno <> 10;-- 2.主查询

-- <any :小于最大值
3.查询部门编号不为10，且工资比10部门【任意】一名员工工资【低】的员工编号，姓名，职位，工资。
select sal from emp where deptno = 10;                         --1.查询10部门所有员工的工资 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal <any (select sal from emp where deptno = 10) and deptno <> 10;-- 2.主查询


--ALL 与所有值匹配    <all    >all    =all（无意义）
-- =all :等于所有值
1.【无意义】查询部门编号不为10，且工资与10部门【所有】员工工资【相等】的员工编号，姓名，职位，工资。
select sal from emp where deptno = 10;                          --1.查询10部门所有员工的工资 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal =all (select sal from emp where deptno = 10) and deptno <> 10;-- 2.主查询

-- >all :大于最大值
2.查询部门编号不为10，且工资比10部门【所有】员工工资【高】的员工编号，姓名，职位，工资。
select sal from emp where deptno = 10;                          --1.查询10部门所有员工的工资 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal >all (select sal from emp where deptno = 10) and deptno <> 10;-- 2.主查询

-- <all :小于最小值
3.查询部门编号不为10，且工资比10部门【所有】员工工资【低】的员工编号，姓名，职位，工资。
select sal from emp where deptno = 10;                         --1.查询10部门所有员工的工资 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal <all (select sal from emp where deptno = 10) and deptno <> 10;-- 2.主查询


-----------------------------------------------------------
--多列子查询:返回多行多列       通常用多行运算符：in
-----------------------------------------------------------
--成对比较
1.查询出和1981年入职的【任意】一个员工的【部门和职位完全相同】员工姓名、部门、职位、入职日期,不包括1981年入职员工
select * from emp where hiredate between '1-1月-81' and '31-12月-81';  --1.1981年入职的员工的部门和职位
select * from emp where substr(hiredate,-2) = '81';                    --1.1981年入职的员工的部门和职位
select * from emp where to_char(hiredate,'yyyy') = '1981';             --1.1981年入职的员工的部门和职位
select * from emp where extract(year from hiredate) = '1981';          --1.1981年入职的员工的部门和职位

select distinct deptno,job from emp where extract(year from hiredate) = '1981';          --1.1981年入职的员工的部门和职位

select *
  from emp
 where (deptno, job) = any (select distinct deptno,job from emp where extract(year from hiredate) = '1981')
   and extract(year from hiredate) <> '1981'; --2.主查询

--不成对比较
1.查询出和1981年入职的【任意】一个员工的【部门或职位相同】员工姓名、部门、职位、入职日期,不包括1981年入职员工。
select distinct deptno from emp where extract(year from hiredate) = '1981';          --1.1981年入职的员工的部门
select distinct job from emp where extract(year from hiredate) = '1981';             --2.1981年入职的员工的职位

select *
  from emp
 where (deptno in (select distinct deptno from emp where extract(year from hiredate) = '1981')
    or job in (select distinct job from emp where extract(year from hiredate) = '1981'))
   and extract(year from hiredate) <> '1981';

--子查询中的null值
1.查询是经理的员工姓名，工资
select distinct mgr from emp;                                   --1.查询哪些人是经理？  null,7839,7782,7698,7902,7788,7566
select * from emp where empno in(select distinct mgr from emp); -- 2.主查询

2.查询不是经理的员工姓名
select distinct mgr from emp where mgr is not null;             --1.查询哪些人是经理？  7839,7782,7698,7902,7788,7566
select * from emp where empno not in(select distinct mgr from emp where mgr is not null);--2.主查询

--在from子句中使用子查询
1.查询比自己部门平均工资高的员工姓名，工资，部门编号，部门平均工资
select deptno,avg(sal) from emp group by deptno;--1.部门平均工资
select e.ename,e.sal,e.deptno,s.avgsal from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s where e.deptno = s.deptno and e.sal > s.avgsal;

--练习
1.查询比自己职位平均工资高的员工姓名、职位，部门名称，职位平均工资
select job,avg(sal) avgsal from emp group by job;--1.职位平均工资

select e.ename,e.job,d.dname,s.avgsal
  from emp e, dept d, (select job, avg(sal) avgsal from emp group by job) s
 where e.deptno = d.deptno
   and e.job = s.job
   and e.sal > s.avgsal;
   
--rownum:伪列,永远从1开始
--     注意： rownum只能执行<、<=运算，不能执行>、>=或一个区间运算Between..And等

--TOP-N查询
1.查询工资最高的三个员工的信息
select rownum,e1.* from (select emp.* from emp where sal is not null order by sal desc) e1 where rownum <= 3;

2.查询工资最低的三个员工的信息
select rownum,e1.* from (select emp.* from emp where sal is not null order by sal) e1 where rownum <= 3;


--数据库分页
假设每页显示5条
1  1-5
2  6-10
3  11-15
4  16-20

开始下标：每页显示条数 * 当前页码-(每页显示条数-1)= 每页显示条数*当前页码-每页显示条数+1=(当前页码-1)*每页显示条数 + 1
结束下标：每页显示条数 * 当前页码

1.查询第一页数据
select rownum,e.* from emp e where rownum <= 5;

2.查询第二页数据
select e1.* from (select rownum rn,e.* from emp e where rownum <= 10) e1 where e1.rn >= 6; --效率高，仅查询10条
select e1.* from (select rownum rn,e.* from emp e) e1 where e1.rn <= 10 and e1.rn >= 6;    --效率低，永远查询所有数据

3.查询第三页数据
select e1.* from (select rownum rn,e.* from emp e where rownum <= 15) e1 where e1.rn >= 11;
select e1.* from (select rownum rn,e.* from emp e) e1 where e1.rn <= 15 and e1.rn >= 11;

--公用的SQL分页查询语句
select e1.* from (select rownum rn,e.* from emp e where rownum <= &end) e1 where e1.rn >= &begin;

select e1.* from (select rownum rn,e.* from emp e where rownum <= (每页显示条数 * 当前页码)) e1 where e1.rn >= (当前页码-1)*每页显示条数 + 1);
select e1.* from (select rownum rn,e.* from emp e) e1 where e1.rn <=(每页显示条数 * 当前页码) and e1.rn >= (当前页码-1)*每页显示条数 + 1);

--数据分页前，先排序
1.根据入职日期降序排序后，再分页
select *
  from (select rownum rn, e1.*
          from (select emp.* from emp order by hiredate desc) e1
         where rownum <= 10) e2
 where e2.rn >= 6;
 
--练习
1.按照每页显示5条记录，分别查询工资最高的第1页，第2页，第3页信息，要求显示员工姓名、入职日期、部门名称、工资。
select *
  from (select rownum rn, e2.*
          from (select * from emp order by sal desc) e2,dept d
         where e2.deptno = d.deptno and rownum <= 10) e3
 where rn >= 6;


select *
  from (select rownum rn, e2.*
          from (select * from emp order by sal desc) e2
         where rownum <= 10) e3,
       dept d
 where e3.deptno = d.deptno
   and rn >= 6;

select *
  from (select rownum rn, e2.*
          from (select e.*, d.dname,d.loc
                  from emp e, dept d
                 where e.deptno = d.deptno
                 order by sal desc) e2
         where rownum <= 10) e3
 where rn >= 6;


--练习
14. 列出至少有一个雇员的所有部门
--分组语句
select deptno,count(empno) from emp group by deptno having count(empno) >= 1;--分组语句

--嵌套子查询
select deptno,count(empno) from emp group by deptno;--1.查询部门人数
select * from (select deptno,count(empno) ecount from emp group by deptno) d where d.ecount >= 1;--2.主查询

select deptno,count(empno) from emp group by deptno;--1.查询部门人数
select * from dept d,(select deptno,count(empno) ecount from emp group by deptno) c where d.deptno = c.deptno(+) and c.ecount >=1;--2.主查询

--相关子查询
select * from dept where exists (select * from emp where deptno= dept.deptno);--1.相关子查询

24. 显示每位经理管理员工的最低工资，及最低工资者的姓名
select mgr,min(sal) from emp group by mgr;--1.每位经理管理员工的最低工资
select * from emp e,(select mgr,min(sal) minsal from emp group by mgr) s where e.mgr = s.mgr and e.sal = s.minsal;--2.主查询

25. 显示比工资最高的员工参加工作时间晚的员工姓名，参加工作时间
select max(sal) from emp;                                       --1.最高的工资   5000
select hiredate from emp where sal = (select max(sal) from emp);--2.查工资最高的员工的参加工作的时间  1981/11/17
select * from emp where hiredate > (select hiredate from emp where sal = (select max(sal) from emp));--3.主查询

26. 显示出平均工资最高的的部门平均工资及部门名称
select deptno,avg(sal) from emp group by deptno; --1.部门平均工资
select max(avg(sal)) from emp group by deptno; --1.部门的最高平均工资---补充  2916.66666666667

select e.deptno, d.dname, avg(e.sal) avgsal
  from emp e, dept d
 where e.deptno = d.deptno
 group by e.deptno, d.dname
having avg(e.sal) = (select max(avg(sal)) from emp group by deptno); --2.主查询

--借助rownum实现
select *
  from (select e.deptno, d.dname, avg(e.sal) avgsal
          from emp e, dept d
         where e.deptno = d.deptno
         group by e.deptno, d.dname
         order by avgsal desc) e
 where rownum = 1;


