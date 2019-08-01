----------------------------------第十六章   序列、索引--------------------------------

--序列(可以利用序列来对主键的值按照一定规则作一个自动生成)

--创建序列
create sequence se_test1
increment by 1
start with 1
maxvalue 1000000
minvalue 1
cache 20;

--CURRVAL在被引用之前，必须先使用NEXTVAL来产生一个序列值
select se_test.nextval from dual;
select se_test.currval from dual;

insert into cla(cno) values(se_test.nextval);
select * from cla;

--1.创建一个序列，该序列起始值从1开始，无最大值，增量是1，不循环。
create sequence se_test
start with 1
increment by 1
nocycle;

--2.查询序列的当前值及下一个值
select se_test.currval from dual;
select se_test.nextval from dual;


--3.使用第1题所建的序列，向部门表中插入两条记录，部门编号使用序列值，部门名称分别为：Education、Market，城市分别为：DALLAS、WASHTON
insert into dept values(se_test.nextval,'Education','DALLAS');
insert into dept values(se_test.nextval,'Market','WASHTON');


--索引
--测试索引的功效
create table emp_back as select * from emp;
insert into emp_back select * from emp_back;
update emp_back set empno = se_test.nextval;

select * from emp_back where empno = 250000;   --0.1秒 没有索引的时候根据该列查询的时间

--给emp_back表中empno添加索引
create index ind1 on emp_back(empno);
select * from emp_back where empno = 250000;   --0.05秒 有索引的时候根据该列查询的时间



select * from emp_back;
select * from dept;
