------------------------------------
-- 选择列
------------------------------------
--选择所有列
1.查询emp员工表的所有信息
select * from emp;-- * 表示所有列  
select empno,ename,job,mgr,hiredate,sal,comm,deptno from emp;--指定所有列的名称  效率高

--选择指定列
2.查询所有员工的员工编号、员工姓名、薪水
select empno,ename,sal from emp;

------------------------------------
-- 算数运算符
--    null : null值不与任意值计算，均返回null,不是0，不是''
--           nvl(comm,0):如果comm为null，默认为0，如果comm不为null，取自身的值
------------------------------------
1.查询员工的员工编号、员工姓名、入职日期，包括转正日期（假设试用期6个月）
select empno,ename,hiredate,(hiredate + 6*30) from emp;

2.查询员工的员工编号、员工姓名、入职日期，包括转正日期（假设试用期6个月）,年薪（试用期工资为转正工资的80%,加上奖金）
select empno,
       ename,
       hiredate,
       (hiredate + 6 * 30),
       sal,
       sal * 1.25,
       nvl(comm, 0),
       sal * 6 + sal * 1.25 * 6 + nvl(comm, 0) 
  from emp;
  
------------------------------------
-- 列别名
--
--  语法：
--         列名  别名
--         列名 as 别名
--
--  以下三种情况列别名两侧需要添加双引号
--         1.列别名中包含有空格
--         2.列别名中要求区分大小写
--         3.列别名中包含有特殊字符
------------------------------------
1.查询员工的员工编号、员工姓名、入职日期，包括转正日期（假设试用期6个月）,年薪（试用期工资为转正工资的80%,加上奖金）
select empno,
       ename,
       hiredate 试用日期,
       (hiredate + 6 * 30) 转正日期,
       sal 试用期工资,
       sal * 1.25 转正工资,
       nvl(comm, 0) 奖金,
       sal * 6 + sal * 1.25 * 6 + nvl(comm, 0) as 年薪
  from emp;
  
2.以下三种情况列别名两侧需要添加双引号
select empno,ename,sal,sal+500 "new salary" from emp;-- 1.列别名中包含有空格
select empno,ename,sal,sal+500 "NewSalary" from emp;--2.列别名中要求区分大小写
select empno,ename,sal,sal+500 "New@Salary" from emp;--3.列别名中包含有特殊字符

------------------------------------
--连接操作符  ||
--
--       原义字符串：使用单引号''括起来，在数据的每一行出现
------------------------------------
1.查询员工信息，并以以下格式显示"XXX的职位为XXXX"
select ename,job,ename || ' 的职位为 ' || job  from emp;

------------------------------------
--消除重复行 distinct
------------------------------------
1.查询有员工的部门有哪些？
select distinct deptno from emp; --单列去重

2.查询这家公司总共有多少个部门及岗位？
select distinct deptno,job from emp;--多列去重

------------------------------------
-- SQL 语句  &  SQL*PLUS命令
------------------------------------
1.在SQL window中只能执行sql语句
2.在command window 既能执行sql语句，也可以执行SQL*PLUS命令

例如：desc 表名



