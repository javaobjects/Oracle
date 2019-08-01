-----------------------------------第二章  简单查询语句-----------------

--最简单的查询语句
select empno,ename from emp;

--选择所有列
select * from emp;

--选择所有列(多列之间用逗号隔开)（效率高）
select empno,ename,job,mgr,hiredate,sal,comm,deptno from emp;

--2.查询(EMP)员工编号、员工姓名、员工职位、员工月薪、工作部门编号。

--在select语句中做简单运算
--emp中全部员工薪水加500，展示出新的员工表信息
select empno,ename,sal+500 from emp;

--练习2.员工试用期6个月，转正后月薪上调20%，请查询出所有员工工作第一年的年薪所得（不考虑奖金部分,年薪的试用期6个月的月薪+转正后6个月的月薪)
select empno,ename,sal*6+(sal*1.2*6) from emp;

--列别名
select empno,ename,sal*6+(sal*1.2*6) "年薪" from emp;
select empno,ename,sal*6+(sal*1.2*6) as "年薪" from emp;

--空值null
--要查出全部员工的年薪（包含奖金）
--任何包含空值的算术表达式运算后的结果都为空值NULL
--nvl（参数一，参数二）  如果参数一不为空，则返回参数一，否则返回参数二
select empno,ename,sal*6+(sal*1.2*6)+nvl(comm,0) as "年薪" from emp;

--练习1.员工试用期6个月，转正后月薪上调20%，请查询出所有员工工作第一年的所有收入（需考虑奖金部分)，
--   要求显示列标题为员工姓名，工资收入，奖金收入，总收入。


--连接操作符（||）
--可以作列与列的连接，也可以作列与字符串的连接
--想输出empno的名字是ename
--除了列别名之外，其他用到引号的地方都用单引号
select empno || '的名字是' || ename "员工对应信息" from emp;



--消除重复行(distinct)
--找出有员工的部门是哪几个
select distinct deptno from emp;


--1.员工试用期6个月，转正后月薪上调20%，请查询出所有员工工作第一年的所有收入（需考虑奖金部分)，
--要求显示格式为:XXX的第一年总收入为XXX。
select empno || '的第一年总收入为' || (sal*6 + (sal*1.2*6) + nvl(comm,0)) "年薪的定义" from emp;


--2.查询员工表中一共有哪几种岗位类型。
select distinct job from emp;





select * from emp;    --检查数据用的语句
 






















