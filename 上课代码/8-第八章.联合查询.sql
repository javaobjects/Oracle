----------------------第八章   联合查询----------------------

--把两个结果集的数据联合起来

--联合查询
--union
--默认去除重复行
--根据第一列自动按升序排序
--查询编号为7839的员工当前工资、岗位及历史工资、岗位
select sal,job from emp where empno = 7839   
union
select sal,job from emp_jobhistory  where empno = 7839;

--union all完全联合查询
--不去除重复行
--不会自动排序
--查询编号为7839的员工当前工资、岗位及历史工资、岗位,重复行记录不要求被去掉
select sal,job from emp where empno = 7839   
union all
select sal,job from emp_jobhistory  where empno = 7839;

--使用联合运算，查询10号部门及20号部门的员工姓名，部门编号。
select ename,deptno from emp where deptno = 10
union
select ename,deptno from emp where deptno = 20;


select * from emp;
select * from emp_jobhistory;
