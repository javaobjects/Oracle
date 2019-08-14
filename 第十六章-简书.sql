--## 练习1
--1. 创建一个序列，该序列起始值从1开始，无最大值，增量是1，不循环。
create sequence test_seq1
       start with 1 -- 始值从1开始 可省略
       nomaxvalue -- 无最大值 
       increment by 1 -- 增量是1 可省略
       nocycle; -- 不循环
drop sequence test_seq1;       
--2. 查询序列的当前值及下一个值

select test_seq1.nextval from dual;-- 查询序列的下一个值
select test_seq1.currval from dual; -- 查询序列的当前值

--3. 使用第1题所建的序列，向部门表中插入两条记录，
--部门编号使用序列值，部门名称分别为：Education、Market，
--城市分别为：DALLAS、WASHTON


create table copy_dept
as select * from dept;

select * from copy_dept;

insert into copy_dept
values(test_seq1.nextval,'Education','DALLAS');

insert into copy_dept
values(test_seq1.nextval,'Market','WASHTON');

select * from copy_dept;

--## 练习2

--1. 使用子查询的方式，创建test表。
create table test
as select * from emp;

select * from test;


--2. 快速复制test表中的数据，复制到100w条左右

insert into test select * from test;
-- 执行咯 13将 147456条数据 大概要执行16次左右

select * from test;

--3. 更新test表中的empno字段为rownum
alter table test modify empno number(10);
--先要修改精度，否则报错 值大于为此列指定的允许精度
update test set empno = rownum;

select * from test;

--4. 查询test中empno为800000的记录值，记录查询执行时间。

select * from test where empno in 800000;-- 0.128s

--5. 在test表的empno字段上创建索引

--6. 重新执行第4题，对比查询时间

--## 练习3

--1. 有如下关系模式，

--student(sno,sname,gender,birthday,email);--学生

--course(cno,cname,type,credit);--课程

--sc（sno,cno,grade);--选课

--试分析哪些列上适合创建索引？


--## 课后作业
--1. 创建序列，起始位1，自增为1，最小值为1，最大值为9999

--2. 创建序列，起始值为50，每次增加5；

--3. 在表copy_dept中插入记录，其中部门号码采用上一步中创建的序列生成；

--4. 请为工资创建索引，比较<10000,>1000,与round（sal）>10000,哪个索引有效，哪个索引无效；

--5. 创建表，采用“create table copy_emp_index as select * from emp”，生成500万条数据，把其中的“员工号”字段修改为唯一；

--6. 查询表copy_emp_index表中员工号为200001的员工姓名，工资，记录执行时间；

--7. 在copy_emp_index表的empno字段上创建索引，再次执行第6题语句，记录执行时间并做对比；
