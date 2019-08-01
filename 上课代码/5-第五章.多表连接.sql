---------------------------------多表连接--------------------------

--------------------------Oracle独有的连接语法--------------------------
--注意事项
--N个表相连时，至少需要N－1个连接条件
--如果在多个表中出现相同的列名，则需要使用表名作为来自该表的列名的前缀

--笛卡尔积(得到n*m的结果集)
select * from emp,dept;

--等值连接(在笛卡尔积得到的表中选择出相应的行)
select * from emp,dept where emp.deptno = dept.deptno;

--写一条查询语句，查询员工姓名、部门名称、工作地点
select ename,dname,loc from emp,dept where emp.deptno = dept.deptno;

--写一条查询语句，查询员工姓名、部门名称、工作地点 并且工资大于2000的员工
--如果要加其他限制条件的时候，用and来连接
select ename,dname,loc,sal from emp,dept where emp.deptno = dept.deptno and sal > 2000;

--可以用表别名来作列的前缀
select ename,dname,loc,sal from emp e,dept d where e.deptno = d.deptno and sal > 2000;

--1.写一个查询，显示所有员工姓名，部门编号，部门名称。
select ename,e.deptno,dname from emp e,dept d where e.deptno = d.deptno

--2.写一个查询，显示所有工作在CHICAGO并且奖金不为空的员工姓名，工作地点，奖金
select ename,loc,comm from emp e,dept d where  e.deptno = d.deptno and loc = 'CHICAGO' and comm is not null;


--3.写一个查询，显示所有姓名中含有A字符的员工姓名，工作地点。
select ename,loc from emp e,dept d where e.deptno = d.deptno and ename like '%A%';


--非等值连接
--查询每个员工的姓名，工资，工资等级
select ename,sal,grade from emp e,salgrade g where e.sal between g.losal and g.hisal; 


--1.查询每个员工的编号，姓名，工资，工资等级，所在工作城市，按照工资等级进行升序排序。
select empno,ename,sal,grade,loc,grade from emp e,dept d,salgrade g 
where sal between losal and hisal and e.deptno = d.deptno 
order by g.grade;

--外部连接(+)
--(+)写在连接条件中
--(+)所在的一边为从表，从表的数据可以不显示，（+）的另一边为主表，主表的数据一定要显示
select * from emp e,dept d where e.deptno = d.deptno;

--查询所有雇员姓名，部门编号，部门名称，包括没有员工的部门也要显示出来
select * from emp e,dept d where e.deptno(+) = d.deptno;

--自身连接
--查询每个员工的姓名和直接上级姓名
select e.ename,m.ename from emp e,emp m where e.mgr = m.empno;

--1.查询所有工作在NEW YORK和CHICAGO的员工姓名，员工编号，以及他们的经理姓名，经理编号。
select e.ename,e.empno,m.ename,m.empno from emp e,emp m,dept d 
where e.mgr = m.empno and e.deptno = d.deptno and loc in('NEW YORK','CHICAGO');

--2.第上一题的基础上，添加没有经理的员工King，并按照员工编号排序。(员工表是主表)
select e.ename,e.empno,m.ename,m.empno from emp e,emp m,dept d 
where e.mgr = m.empno(+) and e.deptno = d.deptno and loc in('NEW YORK','CHICAGO')
order by e.empno;

--3.查询所有员工编号，姓名，部门名称，包括没有部门的员工也要显示出来。(员工是主表)
select empno,ename,dname from emp e,dept d where e.deptno = d.deptno(+);


--------------------------SQL99标准的连接语法--------------------------
--使用与所有数据库

--交叉连接(笛卡尔积)  cross join
select * from emp cross join dept;

--自然连接  natural join
--自然连接是对两个表之间相同名字和数据类型的列自动进行的等值连接
--将连接的那个列排到第一列,第一列按照升序排序
select * from emp natural join dept;

--using子句作等值连接
--手动版的natural join
select * from emp join dept using(deptno);

--on子句
--可读性较高，推荐使用(如果连接的表多余两个，则需要重复再书写一遍join 跟 on)
select * from emp e join dept d on(e.deptno = d.deptno) join salgrade s on(e.sal between s.losal and s.hisal);

--左外连接 left outer join（左边为主表）
--输出全部员工信息，包括没有员工的部门也要输出
select * from dept d left outer join emp e on(e.deptno = d.deptno);

--左外连接 right outer join（右边为主表）
--输出全部员工信息，包括没有员工的部门也要输出
select * from emp e right outer join dept d on(e.deptno = d.deptno);

--全外连接 full outer join
--没有员工的部门或者是没有部门的员工都会被输出
select * from emp e full outer join dept d on(e.deptno = d.deptno);


--1.创建一个员工表和部门表的交叉连接。
select * from emp cross join dept;

--2.使用自然连接，显示入职日期在80年5月1日之后的员工姓名，部门名称，入职日期
select ename,dname,hiredate from emp natural join dept where hiredate > '01-5月-80';

--3.使用USING子句，显示工作在CHICAGO的员工姓名，部门名称，工作地点
select ename,dname,loc from emp join dept using(deptno) where loc = 'CHICAGO';

--4.使用ON子句，显示工作在CHICAGO的员工姓名，部门名称，工作地点，薪资等级
select ename,dname,loc,grade
from emp e join dept d on(e.deptno = d.deptno) join salgrade s on(e.sal between s.losal and s.hisal)    
where loc = 'CHICAGO';


--5.使用左连接，查询每个员工的姓名，经理姓名，没有经理的King也要显示出来。
select e.ename,m.ename from emp e left outer join emp m on(e.mgr = m.empno);


--6.使用右连接，查询每个员工的姓名，经理姓名，没有经理的King也要显示出来。
select e.ename,m.ename from emp m right outer join emp e on(e.mgr = m.empno);


--1.显示员工SMITH的姓名，部门名称，直接上级名称
select e.ename,dname,m.ename from emp e,emp m,dept d
where e.mgr = m.empno and e.deptno = d.deptno and e.ename = 'SMITH';

--2.显示员工姓名，部门名称，工资，工资级别，要求工资级别大于4级。
select e.ename,d.dname,e.sal,s.grade from emp e,dept d,salgrade s 
where e.deptno = d.deptno and e.sal between s.losal and s.hisal and grade > 4;

--3.显示员工KING和FORD管理的员工姓名及其经理姓名。
select e.ename,m.ename from emp e,emp m where e.mgr = m.empno and m.ename in('KING','FORD');

--4.显示员工姓名，参加工作时间，经理名，参加工作时间，要求参加时间比经理早。
select e.ename,e.hiredate,m.ename,m.hiredate from emp e,emp m where e.mgr = m.empno and e.hiredate < m.hiredate;






select * from emp;
select * from dept;
select * from salgrade;
