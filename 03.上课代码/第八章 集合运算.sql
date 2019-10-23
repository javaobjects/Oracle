-------------------------------------------------
--联合运算（union）
--    1.去重复
--    2.默认第一列升序排序
--    3.所有SQL语句的列数一致、类型一致、列名可以不一致，默认使用第一个SQL语句作为列名
--    4.每个SQL语句不能有自己的order by语句
-------------------------------------------------
1.查询编号为7839的员工当前工资、岗位及历史工资、岗位？
select * from emp where empno = 7839;           --7839的员工当前工资、岗位
select * from emp_jobhistory where empno = 7839;--7839的员工历史工资、岗位

--多表连接（不适用）
select * from emp e,emp_jobhistory h where e.empno = h.empno;

--联合运算
select empno 雇员编号,sal 工资,job 岗位 from emp where empno = 7839       --7839的员工当前工资、岗位   1条数据
union
select empno,sal,job from emp_jobhistory where empno = 7839 order by 岗位;--7839的员工历史工资、岗位   5条数据

-------------------------------------------------
--完全联合运算（union all）
--    1.不去重复
--    2.不排序
--    3.所有SQL语句的列数一致、类型一致、列名可以不一致，默认使用第一个SQL语句作为列名
--    4.每个SQL语句不能有自己的order by语句
--    5.完全联合运算（union all） >  联合运算（union）,因为union all不需要去重，也不需要排序
-------------------------------------------------
1.查询编号为7839的员工当前工资、岗位及历史工资、岗位,要求不要去除重复数据
--完全联合运算
select empno 雇员编号,sal 工资,job 岗位 from emp where empno = 7839       --7839的员工当前工资、岗位   1条数据
union all
select empno,sal,job from emp_jobhistory where empno = 7839 order by 岗位;--7839的员工历史工资、岗位   5条数据


--练习
2.使用多表连接，查询每个部门的部门编号，部门人数，没有人数的部门显示0。
select d.deptno,count(e.empno) from emp e,dept d where e.deptno(+) = d.deptno group by d.deptno;

3.使用联合运算，查询每个部门的部门编号，部门人数，没有人数的部门显示0。
select deptno,count(empno) from emp group by deptno                                       --有人数的部门  emp
union
select deptno,0 from dept where not exists (select * from emp where deptno = dept.deptno);--没有人数的部门  dept

5. 使用集合运算，输出如下效果？
select deptno 部门,loc 工作地点, to_char(null) 员工姓名,to_date(null) 入职日期 from dept--查询部门信息
union
select deptno 部门,to_char(null) 工作地点,ename 员工姓名,hiredate 入职日期 from emp;--查询员工信息

-------------------------------------------------
--相交运算（intersect） ： 取多个SQL语句之间的共有数据
-------------------------------------------------
1.查询哪些员工做过岗位调动？
select empno from emp--所有的员工
intersect
select empno from emp_jobhistory;--调用过的员工编号


-------------------------------------------------
--相减运算（minus） ： 取A-B的数据，即第一个SQL有，第二个SQL没有的数据
-------------------------------------------------
1.查询哪些员工没有做过岗位调动？
select empno from emp--所有的员工
minus
select empno from emp_jobhistory;--调用过的员工编号

