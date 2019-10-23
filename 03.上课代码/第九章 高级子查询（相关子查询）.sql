1.创建员工历史岗位表 emp_jobhistory：
CREATE TABLE emp_jobhistory(
    id NUMBER,--流水号
    empno NUMBER,--员工编号
    job VARCHAR2(9),--岗位
    begindate DATE,--开始日期
    sal Number(7,2)--在该岗位时工资
)

2.插入如下数据：
INSERT INTO emp_jobhistory VALUES(1,7839,'TRAINEE','17-11月-81',500);
INSERT INTO emp_jobhistory VALUES(2,7839,'SALESMAN','17-2月-82',1800);
INSERT INTO emp_jobhistory VALUES(3,7839,'CLERK','17-2月-83',2000);
INSERT INTO emp_jobhistory VALUES(4,7839,'SALESMAN','17-2月-85',1800);
INSERT INTO emp_jobhistory VALUES(5,7839, 'MANAGER','17-2月-87',3000);
commit;

---------------------------------------------
  嵌套子查询 与  相关子查询：
  
        ① 嵌套子查询：可以单独执行
           相关子查询：不可以单独执行，依赖于父查询
           
        ② 嵌套子查询：
                1) 先执行子查询
                2) 再使用步骤 1)中的数据,交给父查询使用，用于确认或取消数据
                
           相关子查询：
                1) 先执行父查询一次
                2) 将父查询得到的数据，交给子查询使用，用于确认或取消父查询数据
                3) 重复执行步骤1)、 2)，直到数据最后一行
---------------------------------------------
1.如何查询比本部门平均薪水高的员工姓名，薪水
--嵌套子查询
select deptno,avg(sal) from emp group by deptno;--1.部门的平均薪水
select * from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s where e.deptno = s.deptno and e.sal > s.avgsal;--2.嵌套子查询

--相关子查询
select * from emp where sal > 本部门平均薪水;
select * from emp o where o.sal > (select avg(i.sal) from emp i where i.deptno = o.deptno);

2.查询所有部门名称和人数
--嵌套子查询
select deptno,count(empno) from emp group by deptno;--1.查询每个部门的人数
select d.deptno,c.empCount from dept d,(select deptno,count(empno) empCount from emp group by deptno) c where d.deptno = c.deptno;--2.主查询

--相关子查询
select dname,人数 from dept;
select dname,(select count(empno) from emp where deptno = dept.deptno) from dept; 

3.查询哪些员工是经理?
--嵌套子查询
select distinct mgr from emp where mgr is not null;--1. 经理编号有哪些？ 
select * from emp where empno in(select distinct mgr from emp where mgr is not null);

--相关子查询
select * from emp where empno 是否为经理;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) > 0;

4.查询至少调过2次岗位的员工编号，姓名，岗位
--嵌套子查询
select empno,count(1) from emp_jobhistory group by empno;--1.查询每个员工的岗位调动次数
select * from emp e,(select empno,count(1) 调动次数 from emp_jobhistory group by empno) c where e.empno = c.empno and c.调动次数 > 2;

--相关子查询
select * from emp where 该员工调动次数 > 2;
select * from emp where (select count(1) from emp_jobhistory where empno = emp.empno) > 2;

--练习
如下练习，使用相关子查询完成
1.查询比所在职位平均工资高的员工姓名，职位。
select * from emp where sal > 本职位的平均工资;
select * from emp e1 where e1.sal > (select avg(e2.sal) from emp e2 where e2.job = e1.job);

2.查询工资为其部门最低工资的员工编号，姓名，工资。
select * from emp where sal = 本部门的最低工资;
select * from emp e1 where e1.sal = (select min(e2.sal) from emp e2 where e2.deptno = e1.deptno);

3.查询所有雇员编号，名字和部门名字。
select e.*,部门名字 from emp e;
select e.*,(select d.dname from dept d where d.deptno = e.deptno) from emp e;

4.查询哪些员工是经理？
select * from emp e where empno是经理;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) > 0;

5.查询哪些员工不是经理？
select * from emp e where empno不是经理;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) = 0;

6.查询每个部门工资最低的两个员工编号，姓名，工资。
select * from emp where 同部门且比我的工资小的人数 <= 1;
select * from emp e1 where (select count(1) from emp e2 where e2.deptno = e1.deptno and e2.sal < e1.sal ) <= 1

1	10	1300.00  比1300小的  0个
2	10	2450.00  比2450小的  1个
3	10	5000.00  比5000小的  2个

4	20	800.00   比800小的  0个
5	20	1100.00  比1100小的 1个
6	20	2975.00  比2975小的 2个
7	20	3000.00
8	20	3000.00

9	30	950.00     比950小的  0个
10	30	1251.00  比1251小的 1个
11	30	1251.00  比1251小的 1个
12	30	1501.00
13	30	1601.00
14	30	2850.00
	
------------------------------------------------------
--exists 与 not exists
------------------------------------------------------
4.查询哪些员工是经理？
select * from emp e where empno是经理;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) > 0; --效率低

select * from emp e1  where exists (select * from emp e2 where e2.mgr = e1.empno);    --效率高

5.查询哪些员工不是经理？
select * from emp e where empno不是经理;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) = 0;

select * from emp e1  where not exists (select * from emp e2 where e2.mgr = e1.empno);

--练习
2.查询员工姓名和直接上级的名字。
select empno,ename,mgr,直接上级的名字 from emp;
select e.empno,e.ename,e.mgr,(select m.ename from emp m where m.empno = e.mgr) from emp e;


4.查询每个部门工资前两名高的员工姓名，工资。
select ename,sal,deptno from emp where 同一部门且工资比我高的人 <= 1;
select e1.ename,e1.sal,e1.deptno from emp e1 where (select count(1) from emp e2 where e2.deptno = e1.deptno and e2.sal > e1.sal) <= 1;

15	MILLER	1300.00	10  比1300工资高的2人
9	CLARK	2450.00	10      比2450工资高的1人
10	KING	5000.00	10    比5000工资高的0人

12	ADAMS	1100.00	20
6	JONES	2975.00	20
3	SMITH	800.00	20
2	SCOTT	3000.00	20
14	FORD	3000.00	20

13	JAMES	950.00	30
11	TURNER	1501.00	30
5	WARD	1251.00	30
4	ALLEN	1601.00	30
8	BLAKE	2850.00	30
7	MARTIN	1251.00	30

