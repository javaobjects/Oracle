----------------第十三章  创建和维护表----------


--DDL 数据定义语言 create alter drop
--DDL 语句会自动提交事务
--我们可以对数据库的六个对象执行DDL语句


--创建表
--创表的时候 列与列之间用逗号隔开,最后一个列后面不需要带 逗号
--列名  列的数据类型 （列的长度） （默认值）

create table student(
    sno varchar2(50),
    sname varchar2(20),
    sex char(3) default '男'
);
insert into student(sno) values(7788);

--1.学校想做一个选课系统，其中涉及到课程表，学生表，请分别创建这两个表，自己思考表中应有的列及数据类型。
create table course(
   sno varchar2(20),
   cno number(5),
   cname varchar2(20),
   cgrade varchar2(5)
);

--通过子查询的语法 创建表
--通过as 子句来结合子查询创建表
create table manager
as select * from emp where where 1 = 0;

--1.通过子查询的方式创建一个表dept10,该表保存10号部门的员工数据。
create table dept10
as select * from emp where deptno = 10;

select * from dept10;

--修改表（修改表的结构-修改表中列的定义）

--增加列


--修改列

--删除列

--删除表 drop 不能回滚
drop table dept10;

--1.在员工表中添加一个性别列，列名为gender，类型为char(2)，默认值为“男”
--2.修改员工表中性别列的数据类型为char(4)
--3.修改员工表中性别列的默认值为“女”
--4.删除员工表中的性别列

--重命名表
rename dept10 to dept20;

--截断表(truncate)
--作用：截断表的数据
--截断后的数据不能恢复（自动提交事务），但是我们的DML操作中的delete语句是可以恢复数据的
truncate table dept20;

select * from deptno;





select * from user_tables;
select * from course;--课程 表
select * from sc;
select * from teacher;



select * from likaiqing;
select * from student;
