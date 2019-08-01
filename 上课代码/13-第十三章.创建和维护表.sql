-----------------------------第十三章   创建和维护表-------------------------

--DQL（date query language） 数据查询语言  select
--DML（date manipulation language） 数据操作语言  insert update delete
--DDL（date Definition language） 数据定义语言：对数据库对象作操作  create alter drop truncate (自动提交事务)




--创建表 
--表名  列名  数据类型，数据长度  默认值（可选）
--创建一个学生表
create table student(
       name varchar2(10),
       sex char(4) default '男',
       school varchar2(20),
       sno number(10)
);

--当插入表数据时没有插入有定义默认值的列的时候，它会自动添加上默认值
insert into student(name,school,sno) values('xiaoming','xuexiao',7777);

--学校想做一个选课系统，其中涉及到课程表，学生表，请分别创建这两个表，自己思考表中应有的列及数据类型
create table cls(
      cno   number(5),
      cname varchar2(10),
      cday  date
);


create table std(
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       sno  number(5),
       cno  number(5)
);


--用子查询语法创建表
--1.通过子查询的方式创建一个表dept10,该表保存10号部门的员工数据
create table dept10 as (select * from emp where deptno = 10);
select * from dept10;

--修改表--修改表结构--修改表里面列的定义
--新增列
--修改列
--删除列

--删除表drop
drop table dept10;

--重命名表 rename 旧名字  to 新名字
rename std to sstd;

--截断表truncate(删除自动提交事务)
truncate table emp_back;

select * from class;




select * from emp;
select * from dept;





