---------------------------------------------
--使用WHERE子句   <   <=  =  >  >=  <>
---------------------------------------------
--比较数值型数据
1.查询部门编号为10的员工信息
select * from emp where deptno = 10;

--比较字符类型数据   注意：1.使用''单引号括起来  2.区分大小写
2.查询职位为SALESMAN的员工信息
select * from emp where job = 'SALESMAN';
select * from emp where job = 'salesman';

--比较日期类型数据  注意：1.使用''单引号括起来  2.默认日期格式为DD-MON-RR 日期-月份-RR格式的年份
3.查询入职日期为"1980/12/17"的员工信息
select * from emp where hiredate = '17-12月-80';

4.查询入职日期不为"1980/12/17"的员工信息
select * from emp where hiredate <> '17-12月-80';
---------------------------------------------
--特殊比较运算符   BETWEEN..AND..   IN   LIKE  IS NULL
---------------------------------------------
--BETWEEN..AND..   使用BETWEEN .. AND.. 运算符来判断要比较的值是否在某个范围内
1.查询薪资在800与1000之间的员工信息
select * from emp where sal between 800 and 1000;--包括区间值
select * from emp where sal>=800 and sal<=1000;--同上
--select * from emp where 800<=sal<=1000;-- not ok

2.查询82年入职的员工信息
select * from emp where hiredate between '1-1月-82' and '31-12月-82';
select * from emp where hiredate>='1-1月-82' and hiredate<='31-12月-82';

--IN运算符 使用IN运算符判断要比较的值是否和集合列表中的任何一个值相等
1.查询部门编号为10或者20的员工信息
select * from emp where deptno in(10,20);
select * from emp where deptno = 10 or deptno = 20;--同上

--LIKE运算符 模糊查询  
--         %  匹配零个或多个字符   _ 匹配一个任意的字符
select * from emp where ename like 'A%';--以A开头
select * from emp where ename like '%S';--以S结尾
select * from emp where ename like '%S%';--包含S
select * from emp where ename like '_M%';--第二个字母为M

select * from emp where job like 'SALES@_%' escape '@'; --查询以'SALES_'开头

--IS NULL 运算符  判断值为空的数据
1.查询没有奖金的员工信息
select * from emp where comm = null;  --not ok null值与任意值计算返回null
select * from emp where comm is null;--ok
---------------------------------------------
--逻辑运算符   and  or  not
---------------------------------------------
--逻辑与(AND)：  要求两个条件都为真,结果才为真
1.查找职位为CLERK，同时薪水大于1000的员工信息
select * from emp where job = 'CLERK' and sal > 1000;

--逻辑或(OR)：只需要两个条件中的一个为真,结果就返回真
1.查找职位为CLERK，或者薪水大于3000的员工信息
select * from emp where job = 'CLERK' or sal > 3000;

--逻辑非(NOT) NOT运算符还可以和IN 、BETWEEN…AND、LIKE、IS NULL一起使用
--not in
1.查询部门编号不是10或者20的员工信息
select * from emp where deptno not in(10,20);

--not between...and
1.查询薪资不在1000到3000范围以内的员工信息
select * from emp where sal not between 1000 and 3000;

--not like
1.查询职位不以SALES开头的员工信息
select * from emp where job not like 'SALES%';

--is not null
1.查询奖金不为空的员工信息
select * from emp where comm is not null;

--逻辑运算符优先级： not > and > or
1.查询职位为CLERK或者MANAGER，同时薪资大于2000的员工信息
select * from emp where job = 'CLERK' or job = 'MANAGER' and sal > 2000;--not ok
select * from emp where job = 'CLERK' or (job = 'MANAGER' and sal > 2000);--not ok 同上

select * from emp where (job = 'CLERK' or job = 'MANAGER') and sal > 2000;--ok

---------------------------------------------
--ORDER BY子句    升序排序(默认)  asc     降序排序  desc
---------------------------------------------
--按列名:升序排序
select * from emp order by sal;         --数值类型  默认升序排序
select * from emp order by sal asc;     --数值类型  默认升序排序

select * from emp order by hiredate asc;--日期类型   默认升序排序

select * from emp order by ename asc;   --字符类型   默认升序排序

--按列名:降序排序
select * from emp order by sal desc;    --数值类型  降序排序

--按列名：多列排序 
select * from emp order by deptno,sal;        --根据部门升序排序、再根据每个部门的薪资升序排序
select * from emp order by deptno asc,sal asc;--同上
select * from emp order by deptno asc,sal desc;--根据部门升序排序、再根据每个部门的薪资降序排序

--按列别名排序
select empno,ename,sal,(sal*12) yearSalary from emp order by yearSalary;

--按结果集列序号排序
select * from emp order by 2;--根据第二列排序
select * from emp order by 8;--根据第八列排序

select * from emp order by 9;--not ok 根据第九列排序---第九列不存在的，select列表中仅存在8列，取值1~8之间，9超出取值范围

select * from emp where deptno  = 10 order by 8,6;
