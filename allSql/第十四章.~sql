------------------第十四章

--not null约束
--定义了not null 约束的列不能插入空值

create table student(
    sno varchar2(50) not null,
    sname varchar2(20),
    sex char(3) default '男'
);
insert into student(sname) values('xiaoming');

--unique 唯一性约束
create table student(
    sno varchar2(50) unique,
    sname varchar2(20),
    sex char(3) default '男'
);
insert into student(sno) values('50');
insert into student(sno) values('50');--违反唯一性约束

--unique作组合的唯一性约束
--定义到到定义的最下面
create table student(
    sno varchar2(50),
    sname varchar2(20),
    sex char(3) default '男',
    constraint yueshu1 unique(sno,sname)
);

insert into student(sno,sname) values('50','xiaoming');
insert into student(sno,sname) values('50','xiaohong');
insert into student(sno,sname) values('50','xiaohong');--两列的值同时相同才算违反唯一性约束

--primary key 主键约束
--作用相当于not null + unique
--被主键约束修饰的列将会自动添加索引（对添加了索引的列作筛选，速度会比较快）
--每个表只能创建一个主键约束
--primary key可以修改一个多列组合的主键约束
create table student(
    sno varchar2(50) primary key,
    sname varchar2(20),
    sex char(3) default '男'
);

insert into student(sname) values('xiaoming');--体现咯not null作用
insert into student(sno) values('50');
insert into student(sno) values('50');--体现了unique约束的作用
--primary key可以修改一个多列组合的主键约束
create table student(
    sno varchar2(50),
    sname varchar2(20),
    sex char(3) default '男',
    constraint yueshu primary key(sno,sname)
);

--check检查性约束
--check后面跟着的是一个完整的表达式
create table student(
    sno varchar2(50),
    sname varchar2(20),
    sex char(3) default '男' check(sex = '男' or sex = '女')
);

insert into student(sno,sex) values('50','ss');
--foreign key 外键约束（可以表示表跟表之间列的依赖关系 )
--语法： constraint 约束名 references 被依赖的表名(被依赖的列)
--被外键约束依赖的列一定要是主键列或者是唯一列
create table student(
       sno varchar2(50) primary key,
       sname varchar2(20),
       sex char(3) default '男'
);
create table course(
       cno varchar2(50),
       cname varchar2(20)
);
create table xcourse(
       sno varchar2(50) constraint yueshu references student(sno),
       cno varchar2(50)
);

insert into xcourse values('33','22');--未找到父项关键字
insert into xcourse values('22','22')

delete from student
where sno = 22;-- 被参照的时候主键的值不能被删除

--如果想删除被依赖的一个主键的值时，可以在外键定义的时候定义cascade级联
--删除或者设置主键值为空值set null 
--定义咯cascade级联删除之后，如果删除被依赖的行，那么依赖它的行数据也会被删除
--定义咯set null设置为空值之后，如果删除被依赖的行，那么依赖它的行数据那个列被设置为空值



-- 1.学校有一个选课系统，其中包括如下关系模式：
-- 系(系编号： 主键，
--   系名称:  唯一键，
--   系主任： 非空约束，
--   系所在校去：取值范围只能在南湖校区和浑南校区)
-- 班级(班级编号： 主键，
--     班级名称： 唯一键，
--     所属系：  外键)
create table department(
  dno number(4) primary key,
  dname varchar2(50) unique,
  dhead varchar2(50) not null,
  darea varchar2(100) check(darea in ('南湖校区','浑南校区'))
);
create table cla(
  cno number(4) primary key,
  cname varchar2(50) unique,
  dno number(4) constraint yueshu references department(dno)
);



create table csc(
     cno number(30) primary key,
     cname varchar2(30) unique,
     chdepart varchar2(30) not null,
     cschool varchar2(30) check(cschool in ('南湖校区','浑南校区'))
);

create table cclass(
     ccno number(30) primary key,
     className varchar2(30) unique,
     cno number(30) constraint yueshu references csc(cno)
);
-- 2.创建学生表，包含如下属性:
-- 学号 定长字符型 10位 主键
-- 姓名 变长字符型 20位 非空
-- 性别 定长字符型 2位 取值范围只能为男或女
-- 出生日期 日期型 
-- 所在班级 
create table student(
     sno char(10) primary key,
     sname varchar2(20) not null,
     sex char(3) check(sex in ('男','女')),
     sbirth date,
     sclass varchar2(50)
);












select * from user_tables;























