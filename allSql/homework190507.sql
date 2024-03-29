--1.请分析按照以下要求都需要建立什么类型的字段?
--(1)最大2000个字节定长字符串
char(2000)
--(2)如果输入‘张三’ 后添空格6个

--(3)性别输入'男'或'女’
--(4)最大4000个字节变长字符串
--(5)如果在数据库中输入'张三'则显示数据'张三’
--(6)表示数字范围为- 10的125次方到10的126次方, 可以表示小数 也可以表示整数
--(7)最大表示4位整数  -9999 到 9999
--(8)表示5位有效数字 2位小数的 一个小数  -999.99 到 999.99
--(9)包含年月日和时分秒
--(10)包含年月日和时分秒毫秒
--(11)二进制大对象图像/声音
--2.创建表date_test,包含列d，类型为date型。
--试向date_test表中插入两条记录，一条当前系统日期记录，一条记录为“1998-08-18”。
create table date_test(
      d date
);
insert into date_test values(sysdate);
insert into date_test values('18-8月-98');
select * from date_test;
--3.创建与dept表相同表结构的表dtest，将dept表中部门编号在40之前的信息插入该表。
create table dtest as select * from dept where 1 = 0;
insert into dtest select * from dept where deptno < 40;
select * from dtest;
--3.创建与emp表结构相同的表empl，并将其部门编号为前30号的员工信息复制到empl表。
create table emp1 as select * from emp where 1 = 0;
insert into emp1 select * from emp where deptno < 30;
select * from emp1;
--4.试为学生表student增加一列学生性别gender 默认值 “女”。
alter table student add(gender char(3) default '女');
--5.试修改学生姓名列数据类型为定长字符型10位。
alter table student modify (sname char(10)); 

--14章作业 
--1.简述5种约束的含义。
not null 非空约束，指定某列的所有行数据 不能包含空值
unique 唯一性约束，指定列或者列的组合所有数据必须唯一
primary key 主键约束 表的每一行的唯一性标识 指定列或者列的组合的所有行数据必须唯一
foreign key 外键约束 在列引用列上建立的一种强制依赖关系
check 检查性约束 在列上指定一个必须满足的条件

--2.创建学生关系sc，包括属性名：
--选课流水号 数值型 主键；
--学生编号 非空 外键
--课程编号 非空 外键；
--成绩     0-100之间；

create table sc(
  sxkno number(10) primary key,
  sno number(10) not null foreign key,
  skcno number(10) not null foreign key,
  sgrade number(10) check(sgrade >= 0 and sgrade <= 100 )
);

--3.创建copy_emp，要求格式同emp表完全一样，不包含数据。
create table copy_emp as select * from emp where 1 = 0;
--4.创建copy_dept，要求格式同dept表完全一样，不包含数据。
create table copy_dept as select * from dept where 1 = 0;
--用as创建表的时候不会把约束复制过去 只会复制表结构


--5.设置copy_emp 表中外键deptno，参照copy_dept中deptno,语句能否成功,为什么？
select * from copy_emp;

--用可视化工具中key操作 不能成功 因为外键约束只能依赖主键列或者唯一列


--6.追加copy_dept表中主键deptno
--可以 通过可视化工具完成



select * from emp;

insert into copy_emp
select empno,ename,hiredate,deptno,sal from emp where deptno = 10;

