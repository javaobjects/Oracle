-------------------第十六章  序列跟索引------------------

--序列
--序列是一个自定义的自动增加/减少的数字序列
--通常应用于自动生成主键


--创建序列
--定义序列时多个规则不用加其它符号
--创建序列test_seq，起始值为10，每次增长2，最大值100，最小值9，循环序列，每次缓存10 
create sequence test_seq 
start with 10 --序列的初始值
increment by 2 --增量
maxvalue 100   --最大值
minvalue 9     --最小值
cycle          --表示序列循环（默认不循环)
cache 10;       --表示10个序列值将会缓存到内存中（默认缓存20个值）   

--查看序列的值  利用两个伪列（nextval 序列的下一个值,currval(序列的当前值) ）

--语法  序列名字.伪列名字

--使用currval 之前 ，必须先通过nextval得到序列的下一个值，否则currval无法值行

select test_seq.currval from dual;--error currval未在当前会话中定义

select test_seq.nextval from dual;--得到序列的下一个值

select test_seq.currval from dual;--得到序列的当前值

--1.创建一个序列，该序列起始值从1开始，无最大值，增量是1，不循环。
create sequence se 
start with 1
increment 1;


create sequence se_dept;

--2.查询序列的当前值及下一个值
select se.currval from dual;
select se.nextval from dual;

--3.使用第1题所建的序列，向部门表中插入两条记录，
--部门编号使用序列值，部门名称分别为：Education、Market，城市分别为：DALLAS、WASHTON
insert into dept
values(se.nextval,'Education','DALLAS');

insert into dept
values(se.nextval,'Market','WASHTON');

select * from dept;


--删除序列

drop sequence test_seql;

--索引 index
--通过索引可以快速定位到指定的行数据中
--给列添加索引可以加快对该列的筛选速度


create index text_index
on student(sno); --给指定列手动添加索引

--从表中的列定义主键或者 是唯一 列的时候将会地该列自动添加索引

--通过 一个例子查看序列的作用
--创建 一个新的表
create table emp_back as select * from emp;
--给emp的备份表插入大量数据
insert into emp_back
select * from emp_back;
--设置备份表中的员工编号为一个唯一值
update emp_back
set empno = test_seq1.nextval;

select * from emp_back 
where empno = 159988;--0.07s  --没有添加索个时的时间
--给备份发表中的empno添加索引

create index suoyin
on emp_back(empno);

--重复尝试查询操作
select * from emp_back 
where empno = 159988;--0.04s ---添加了索引后的查询时间

select * from emp_back;






--1.使用子查询的方式，创建test表。
create table emp_test as
select * from emp;

--2.快速复制test表中的数据，复制到100w条左右
insert into emp_test
select * from emp_test;
--3.更新test表中的empno字段为rownum
update emp_test
set empno = rownum;
--4.查询test中empno为800000的记录值，记录查询执行时间。
select * from emp_test where empno = 800;--0.012s
--5.在test表的empno字段上创建索引
create index suoyin
on emp_test(empno);
--6.重新执行第4题，对比查询时间

select * from emp_test where empno = 800;--0.009s

select * from emp_test;

--删除索引
drop index text_index;

--1.创建序列，起始位1，自增为1，最小值为1，最大值为9999
create sequence se_index
start with 1
increment 1
minvalue 1
max value 9999;

create sequence se_index
max value 9999;
--2.创建序列，起始值为50，每次增加5；
create sequence se_increment5
start with 50
increment by 5;
--3.在表copy_dept中插入记录，其中部门号码采用上一步中创建的序列生成；

insert into copy_dept(deptno) values(se_increment5.nextval)
select * from copy_dept;

--4.请为工资创建索引，比较<10000,>1000,与round（sal）>10000,哪个索引有效，哪个索引无效；
create index index1
on emp(sal);


select * from emp where sal < 10000;
select * from emp where round(sal) > 10000;--无效


--5.创建表，采用“create table copy_emp_index as select * from emp”，生成500万条数据，把其中的“员工号”字段修改为唯一；
--6.查询表copy_emp_index表中员工号为200001的员工姓名，工资，记录执行时间；
--7.在copy_emp_index表的empno字段上创建索引，再次执行第6题语句，记录执行时间并做对比；
















