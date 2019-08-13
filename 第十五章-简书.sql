-- ## 练习1
-- 1. 创建一个视图，通过该视图可以查询到工资在2000-5000内并且姓名中包含有A的员工编号，姓名，工资。
create or replace view viewSal2k_5k
       as select empno,ename,sal from emp
       where sal between 2000 and 5000
       and ename like '%A%';

-- 2. 通过上述创建的视图查询数据

select * from viewSal2k_5k;

-- ## 练习2

-- 1. 创建一个视图，通过该视图可以查询到工作在NEW YORK和CHICAGO的员工编号，姓名，部门编号，入职日期。
create or replace view viewLoc_NY_CA
as select empno,ename,dept.deptno,hiredate
          from emp,dept
          where emp.deptno = dept.deptno
          and loc in ('NEW YORK','CHICAGO');

select * from viewLoc_NY_CA;


-- 2. 创建一个视图，通过该视图可以查询到每个部门的部门名称及最低工资。

create or replace view viewMinSalbydname
as select dname,min(sal) minSalbydname
   from emp,dept
   where emp.deptno(+) = dept.deptno
   group by dept.dname;
select * from viewMinSalbydname;

-- 3. 通过如上视图，查询每个部门工资最低的员工姓名及部门名称

select ename,viewMinSalbydname.dname
from emp,dept,viewMinSalbydname
where emp.deptno = dept.deptno
and dept.dname = viewMinSalbydname.dname
and emp.sal = viewMinSalbydname.minSalbydname;


-- ## 课后作业

-- 1. 创建视图v_emp_20，包含20号部门的员工编号，姓名，年薪列(年薪=12*(工资+奖金）；
create or replace view v_emp_20
as select empno,ename,12 * (nvl(sal,0) + nvl(comm,0)) 年薪
from emp where deptno in 20;

select * from v_emp_20;

-- 2. 从视图v_emp_20中查询年薪大于1万元员工的信息；

select * from v_emp_20
where 年薪 > 10000;

-- 3. 请为工资大于2000的员工创建视图，要求显示员工的部门信息，职位信息，工作地点；

create or replace view v_sal2000M
as select dname,job,loc
   from emp,dept
   where emp.deptno = dept.deptno
   and sal > 2000;
select * from v_sal2000M;
-- 4. 针对以上视图执行insert,update,delete,语句能否成功，为什么？

insert into v_sal2000M values('aaa','bbb','ccc'); -- error 无法修改与非键值保存表对应的列




