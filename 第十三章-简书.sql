--1. 学校想做一个选课系统，其中涉及到课程表，学生表，请分别创建这两个表，自己思考表中应有的列及数据类型。

--课程表：
create table tab_course_13(
       cid number(4),--课程编号
       cname varchar(50),--课程名称
       ctypeId number(4),--课程类型
       score number(1),--学分
       chour number(2) --课时
);
--学生表
create table tab_student_13(
       sid char(10),--学生编号2019003004
       sname varchar2(20),--学生姓名
       sex char(4) default '男',--性别
       telephone varchar2(15),--电话号码
       collegeId number(4),--学院
       majorId number(4),--专业
       classId number(4),--班级
       inDate date --入学日期
);

--## 练习2

--1. 通过子查询的方式创建一个表dept10,该表保存10号部门的员工数据。
create table tab_dept10
as select * from emp
where deptno in 10;

select * from tab_dept10;

--## 练习3

--1. 在员工表中添加一个性别列，列名为gender，类型为char(2)，默认值为“男”
select * from copy_emp;

alter table copy_emp add (gender char(2));
alter table copy_emp modify(gender default '男');

select * from copy_emp;

--2. 修改员工表中性别列的数据类型为char(4)

alter table copy_emp modify (gender char(4));

--3. 修改员工表中性别列的默认值为“女”
alter table copy_emp modify (gender default '女');

--4. 删除员工表中的性别列

select * from copy_emp;

alter table copy_emp drop column gender;

select * from copy_emp;

--## 课后作业

--1. 请分析按照以下要求都需要建立什么类型的字段?

--(1)最大2000个字节定长字符串 char(2000)

--(2)如果输入‘张三’ 后添空格6个 char(10)

--(3)性别输入'男'或'女’ char(2)

--(4)最大4000个字节变长字符串 varchar2(4000)

--(5)如果在数据库中输入'张三'则显示数据'张三’ nvarchar2(2)

--(6)表示数字范围为- 10的125次方到10的126次方, 可以表示小数 也可以表示整数 number

--(7)最大表示4位整数  -9999 到 9999 number(4)

--(8)表示5位有效数字 2位小数的 一个小数  -999.99 到 999.99 number(5,2)

--(9)包含年月日和时分秒 date

--(10)包含年月日和时分秒毫秒 timestamp

--(11)二进制大对象图像/声音 blob

--2. 创建表date_test,包含列d，类型为date型。
--试向date_test表中插入两条记录，
--一条当前系统日期记录，一条记录为“1998-08-18”。

create table tab_date_test(
       d date
);

select * from tab_date_test;

insert into tab_date_test
values(sysdate);
insert into tab_date_test
values(to_date('1998-08-18','yyyy/mm/dd'));

select * from tab_date_test;

--3. 创建与dept表相同表结构的表dtest，将dept表中部门编号在40之前的信息插入该表。
create table tab_dtest
as select * from dept
where deptno < 40;

select * from tab_dtest;
--4. 创建与emp表结构相同的表empl，并将其部门编号为前30号的员工信息复制到empl表。
create table tab_empl
as select * from emp
where deptno <= 30;

select * from tab_empl;
--5. 试为学生表student增加一列学生性别gender 默认值 “女”。

--6. 试修改学生姓名列数据类型为定长字符型10位。
