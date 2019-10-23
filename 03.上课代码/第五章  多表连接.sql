---------------------------------------------------------
--
-- Oracle自有的写法  ： 等值连接、非等值连接、外部连接、内部连接
--
---------------------------------------------------------
------------------------
--笛卡尔积： 1.连接条件被忽略  2.连接条件失效
------------------------
1.查询员工编号，员工姓名，部门编号，部门名称
select * from emp,dept;   --56条数据  =  emp表14条数据  *  dept表4条数据

------------------------
--等值连接:N张表关联，至少有N-1个关联条件
------------------------
1.查询员工编号，员工姓名，部门编号，部门名称
select * from emp,dept where emp.deptno = dept.deptno; 
select emp.*,dept.* from emp,dept where emp.deptno = dept.deptno; 

select empno,ename,deptno,dname from emp,dept where emp.deptno = dept.deptno; --not ok 未明确定义的列
select empno,ename,emp.deptno,dname from emp,dept where emp.deptno = dept.deptno;--ok

--使用AND运算符增加其它查询条件 
1.现在只想查询工作地点在NEW YORK的员工编号，姓名，部门编号，工作地点
select empno,ename,emp.deptno,loc from emp,dept where emp.deptno = dept.deptno and loc = 'NEW YORK';--效率高
select empno,ename,emp.deptno,loc from emp,dept where loc = 'NEW YORK' and emp.deptno = dept.deptno;--效率低

--限制歧义列名
--select empno,ename,emp.deptno,dname from emp,dept where emp.deptno = dept.deptno;--效率低
--使用表名作为前缀
select emp.empno,emp.ename,emp.deptno,dept.dname from emp,dept where emp.deptno = dept.deptno;--效率高
--使用表别名作为前缀
select e.empno,e.ename,e.deptno,d.dname from emp e,dept d where e.deptno = d.deptno;

--多于两张表的连接:表结构参考课件
1.查询客户(customer)所有的订单(ord)与购买的产品(item)
select *
  from customer c, ord o, item i
 where c.custid = o.custid
   and o.ordid = i.ordid;
   
------------------------
--非等值连接:N张表关联，至少有N-1个关联条件
------------------------
1.查询每个员工的姓名，工资，工资等级
select e.ename,e.sal,s.grade from emp e,salgrade s where e.sal between s.losal and s.hisal;
select e.ename,e.sal,s.grade from emp e,salgrade s where e.sal>=s.losal and  e.sal<=s.hisal;

------------------------
--外部连接
------------------------
1.查询所有的员工信息，没有雇员工作的部门(40)也要显示出来
select * from emp e,dept d where e.deptno(+) = d.deptno; --emp表为从表（加空行）   dept为主表（所有数据均显示）

2.查询所有的员工信息，没有部门的员工(打杂的)也要显示出来
select * from emp e,dept d where e.deptno = d.deptno(+); --emp表为主表（所有数据均显示）   dept为从表（加空行）

------------------------
--内部连接（自身连接）
------------------------
1.查询每个员工的姓名和直接上级姓名？
select e.ename 员工姓名,m.ename 直接上级姓名 from emp e,emp m where e.mgr = m.empno;

--练习
1.查询所有工作在NEW YORK和CHICAGO的员工姓名，员工编号，以及他们的经理姓名，经理编号。
select e.empno 员工编号,
       e.ename 员工姓名,
       m.ename 经理姓名,
       m.empno 经理编号
  from emp e, dept d, emp m
 where e.deptno = d.deptno
   and e.mgr = m.empno
   and d.loc in ('CHICAGO', 'NEW YORK');

2.第上一题的基础上，添加没有经理的员工King，并按照员工编号排序。
select e.empno 员工编号,
       e.ename 员工姓名,
       m.ename 经理姓名,
       m.empno 经理编号
  from emp e, dept d, emp m
 where e.deptno = d.deptno
   and e.mgr = m.empno(+)
   and d.loc in ('CHICAGO', 'NEW YORK')
---------------------------------------------------------
--
-- SQL99标准的写法  ：
--
---------------------------------------------------------
--交叉连接cross join
select * from emp cross join dept;
select * from emp,dept;--笛卡尔积

--自然连接natural join
--            1.自行连接列名相同、类数据类型相同的列
--            2.默认将连接列显示在第一列，仅显示一次
--
--            缺点：连接列必须列名相同、且类型相同，否则不能自然连接,不能指定列名
select * from emp natural join dept;

--using子句
--     1.指定列名  
--     2.要求列类型一致
--     3.using子句中的用到的列不能使用表名和别名作为前缀
--     4.NATURAL JOIN子句和USING子句是相互排斥的，不能同时使用。
--
--     缺点：必须列名相同
select * from emp join dept using(deptno);

--on子句
1.查询员工的员工信息与部门信息                                             --两张表关联
select * from emp join dept on emp.deptno = dept.deptno;
select * from emp,dept where emp.deptno = dept.deptno;--同上

2.查询员工的员工信息emp与部门信息dept、以及经理信息emp、薪资等级信息salgrade--两张以上表关联
select *
  from emp e
  join dept d  on e.deptno = d.deptno
  join emp m on e.mgr = m.empno
  join salgrade s on e.sal between s.losal and s.hisal;
  

--左外连接left outer join
1.将没有部门的员工也显示出来
select * from emp left outer join dept on emp.deptno = dept.deptno;--emp主表   dept从表
select * from emp e,dept d where e.deptno = d.deptno(+);--emp主表   dept从表

--右外连接right outer join
1.将没有员工的部门也要显示出来
select * from emp right outer join dept on emp.deptno = dept.deptno;--emp从表   dept主表
select * from emp e,dept d where e.deptno(+) = d.deptno;--emp从表   dept主表

--全外连接full outer join
1.将没有部门的员工,以及没有员工的部门都显示出来
select * from emp full outer join dept on emp.deptno = dept.deptno;--emp主表   dept主表
--select * from emp e,dept d where e.deptno(+) = d.deptno(+);          -- not ok 


--练习
3.【多表连接】显示员工KING和FORD管理的员工姓名emp e及其经理姓名 emp m。
--① 显示员工KING和FORD管理的员工，及所管理员工的经理姓名
select e.ename 员工姓名, m.ename 经理姓名
  from emp e, emp m
 where e.mgr = m.empno
   and m.ename in ('KING', 'FORD');

--② 显示员工KING和FORD管理的员工，及KING和FORD的经理姓名
select e.ename 员工姓名, m.ename 员工的经理姓名, mm.ename 经理的经理的姓名
  from emp e, emp m, emp mm
 where e.mgr = m.empno
   and m.mgr = mm.empno(+)
   and m.ename in ('KING', 'FORD');
