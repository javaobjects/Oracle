----------------------第九章  相关子查询 -------------------------


--复习嵌套子查询
--思考如何查询比本部门平均薪水高的员工姓名，薪水。
select deptno,avg(sal) from emp group by deptno;

select * from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal > s.avgsal;


--相关子查询
--思考如何查询比本部门平均薪水高的员工姓名，薪水
select avg(sal) from emp where deptno = ?;
select * from emp e where sal > (select avg(sal) from emp where deptno = e.deptno);

--嵌套子查询跟相关子查询对比

--嵌套子查询可以单独运行
--相关子查询不能单独执行

--相关子查询需要父查询中的表往子查询传入数据之后，子查询才能运行


--1.查询比所在职位平均工资高的员工姓名，职位。
select * from emp e where sal > (select avg(sal) from emp where job = e.job);

--2.查询工资为其部门最低工资的员工编号，姓名，工资。
select * from emp e where sal = (select min(sal) from emp where deptno = e.deptno);

--查出指定部门的最低工资
select min(sal) from emp where deptno = ?

--查询所有部门名称和人数
select dname,(select count(*) from emp where deptno = d.deptno)
from dept d;

--查出指定部门的人数
select count(*) from emp where deptno = ?


--查询哪些员工是经理
select * from emp e where (select count(*) from emp where mgr = e.empno) > 0;


--1.查询所有雇员编号，名字和部门名字。
select empno,ename,(select dname from dept where deptno = e.deptno) "部门名字"
from emp e;

--(1)如果题目要求中需要用到子查询
--全部的需求都可以用嵌套子查询，但是不一定能用相关子查询，而有些情况下使用相关子查询可能会比较简单
--(2)判断能否使用相关子查询
--(3)先把题目的大体的结构写出来，需要子查询的部分后面再补充


--1.查询薪水多于他所在部门平均薪水的雇员名字，部门号。
select *  from emp e where sal > (select avg(sal) from emp where deptno = e.deptno);

--2.查询员工姓名和直接上级的名字。
select ename,(select ename from emp where empno = e.mgr) "上级姓名"
from emp e;

--3.查询每个部门工资最高的员工姓名，工资。
select ename,sal from emp e where sal = (select max(sal) from emp where deptno = e.deptno);


--4.查询每个部门工资前两名高的员工姓名，工资。
select ename,sal from emp e where (select count(*) from emp where deptno =  e.deptno and sal > e.sal) =1
                                  or  (select count(*) from emp where deptno =  e.deptno and sal > e.sal) = 0;
                                  
select deptno,ename,sal from emp e where (select count(*) from emp where deptno =  e.deptno and sal > e.sal)<=1;


--方法二
select * from emp x 
where sal in
(select sal from (select rownum,emp.* from emp order by sal desc) e where rownum<=2 and deptno=x.deptno); 



select * from emp;
select * from dept;
