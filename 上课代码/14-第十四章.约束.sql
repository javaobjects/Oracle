--------------------------第十四章  约束-----------------------------------

--not null非空约束
create table std(
       sno  number(5) not null,
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5)
);


insert into std(sno,sname) values(7777,'clearlove');
insert into std(sname) values('clearlove');   --无法插入空值

--unique唯一性约束
--自动创建索引（加快对该列的搜索速度）
--定义单列唯一
create table std(
       sno  number(5) unique,
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5)
);

insert into std(sno,sname) values(7777,'clearlove');   
insert into std(sno,sname) values(7777,'xiaoming');   --违反唯一性约束

--定义多列组合唯一
create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5),
       constraint yueshu1 unique(sno,sname)
);

insert into std(sno,sname) values(7777,'clearlove');
insert into std(sno,sname) values(7777,'xiaoming'); 
insert into std(sno,sname) values(7777,'xiaoming');    --违反唯一约束条件

--primary key主键约束(not null + unique)
--自动创建索引（加快对该列的搜索速度）
--每个表只能创建一个主键约束

--对单列作主键约束
create table std(
       sno  number(5) primary key,
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5)
);

insert into std(sname) values(7777); --not null
insert into std(sno,sname) values(7777,'clearlove');
insert into std(sno,sname) values(7777,'xiaoming'); --违反唯一性约束

--对多列作一个组合主键约束
create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5),
       constraint yueshu2 primary key(sno,sname)
);


--foreign key外键约束
--外键参照的是列必须是主键或者唯一键
--外键列的值必须在引用列值的范围内，或者为空
--主键表主键值被外键表参照时，主键表记录不允许被删除
--on delete cascade 级联删除(参照主键列中的某个值的行会会连带删除)
--on delete set null(参照主键列中的某个值变为空值)
delete from dept where deptno = 10;  --违反了完整性约束 -- 已找到子记录

create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5) constraint yueshu3 references cls(cno)
);

create table cls(
      cno   number(5) primary key,
      cname varchar2(10),
      cday  date
);


--check约束(check里面带的是完整的表达式)
create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3) check(sage <= 120 and sage >= 0),
       sgrade number(4,1)
);

insert into std(sno,sage) values(7777,20);
insert into std(sno,sage) values(7777,121);  -- 违反检查性约束



--追加约束:创建完表后想追加新的约束（工具完成）

create table cls(
      cno   number(5) primary key,
      cname varchar2(10),
      cday  date
);

create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5)
);

--删除约束（工具完成）

--1.学校有一个选课系统，其中包括如下关系模式：
--系(系编号： 主键，
--   系名称:  唯一键，
--  系主任： 非空约束，
--  系所在校去：取值范围只能在南湖校区和浑南校区)
create table department(
       dno number(10) primary key,
       dname varchar2(50) unique,
       dheader varchar(50) not null,
       darea varchar2(50) check(darea in ('南湖校区','浑南校区'))
);


   
--班级(班级编号： 主键，
--     班级名称： 唯一键，
--     所属系：  外键)
create table cla(
     cno number(10) primary key,
     cname varchar2(50) unique,
     dno number(10) constraint yueshu1 references department(dno)
);


--2.创建学生表，包含如下属性:
--学号 定长字符型 10位 主键
--姓名 变长字符型 20位 非空
--性别 定长字符型 2位 取值范围只能为男或女
--出生日期 日期型 
--所在班级 
create table student(
       sno char(10) primary key,
       sname varchar2(20) not null,
       ssex char(3) check(ssex in ('男','女')),
       sbirthday date,
       cno number(10)
);



















select * from std;

select * from emp;
select * from dept;
