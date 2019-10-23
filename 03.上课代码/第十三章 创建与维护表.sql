数据查询语言 DQL(Data Query Language): select
数据操作语言 DML(Data Manipulation Language): insert   update   delete---针对table表格中的数据增加、修改、删除
事务处理语言 TPL(Transaction Process Language):commit  rollback
事务定义语言 DDL(Data Definition Language):   create   alter    drop-----针对对象的创建、修改、删除
-------------------------------------------------------
--创建表
--     create table 表名(列名  列类型[长度] [default 默认值][,........]);
--
--     子查询创建表：
--            create table 表名[列名1,列名2....] as 子查询;
-------------------------------------------------------
1.创建表person,并指定以下列的信息：
列名   列数据类型  长度  精度  默认值
id       number      4
cname    varchar2    20
birthday date
height   number      3
weight   number      5   2
country_code char    2          '01'   --一个中文占2个字节   英文与数字分别占1个字节

--创建表
create table person(
       id number(4),
       cname varchar2(20),
       birthday date,
       height number(3),
       weight number(5,2),
       country_code char(2) default '01'
);
--默认值使用
--插入默认值
insert into person(id,cname,birthday,height,weight) values(1000,'宝宝',sysdate,52,7);

--使用默认值修改
insert into person(id,cname,birthday,height,weight,country_code) values(2000,'宝宝',sysdate,52,7,'10');
update person set country_code = default where id = 2000;


--用子查询语法创建表
1.创建表dept_10,用于保存部门10的员工的所有信息,表结构与emp表一致
create table dept_10 as select * from emp where deptno = 10;                               --复制所有列

2.创建表dept_20,用于保存部门20的员工的雇员编号、雇员姓名、经理,表结构信息参照emp表
create table dept_20(empno,ename,mgr) as select empno,ename,mgr from emp where deptno = 20;--复制指定列

--引用另一个用户的表
select * from scott.emp;


-------------------------------------------------------
--修改表（添加列、修改列、删除列）
--
--     添加列：alter table 表名 add (列名 列类型[长度] [default 默认值]);
--     修改列：alter table 表名 modify (列名 列类型[长度] [default 默认值]);
--
--     删除列(删除单列)：alter table 表名 drop column 列名; 
--     删除列(删除多列)：alter table 表名 drop (列名1,列名2.....); 
--
--
--     修改列注意：
--            1. 修改数据类型：已有的行数据必须为空。
--            2. 修改长度原则：
--                     数值型修改长度：当长度向小改时，已有行的数该列必须为空；
--                                     当长度向大改时，可以随意修改。
--                     字符型修改长度：当长度向小改时，只要修改后的值能容纳下当前已有数据的最大值即可，
--                                     当长度向大改时，可以随意修改。
--            3. 修改列的默认值：
--                     默认值的修改不会影响已经存在的行，只影响新增加的行
--
--            4. 修改列名：
--                     alter table 表名  rename column 原列名  to 新列名;
--  
--     删除列注意：
--            1.列可以有也可以没有数据。  
--            2.表中至少保留一列。 
--            3.列被删除后，不能再恢复。 
--            4.被外键引用的列，不能被删除。

-------------------------------------------------------
--添加列
1.给person表添加性别列:sex char(2)
alter table person add sex char(2);
insert into person(id,cname,birthday,height,weight,sex) values(3000,'宝宝3号',sysdate,52,7,'男');

--修改列
1.将person表的sex列的数据类型修改为number(2);
alter table person modify sex number(2);              --not ok 1. 修改数据类型：已有的行数据必须为空。

2.将person表的sex的长度修改为char(1)
alter table person modify sex char(1);                --not ok 2.当长度向小改时，已有行的数该列必须为空

3.将person表的country_code的默认值修改为'88'
alter table person modify country_code default '88';  --3. 默认值的修改不会影响已经存在的行，只影响新增加的行
insert into person(id,cname,birthday,height,weight,sex) values(4000,'宝宝4号',sysdate,52,7,'男');

4.将person表的sex的列名修改为sexName
alter table person rename column sex to sexName;

--删除列
1.将person表的sexName列删除
alter table person drop column sexName;--删除单列  1.列可以有也可以没有数据。  

2.将person表的height、weight列删除
alter table person drop (height,weight);--删除多列

alter table person drop (id,cname,birthday,country_code);--not ok 无法删除表的全部列   2.表中至少保留一列。

3.将dept表的deptno列删除
alter table dept drop (deptno);--not ok  无法删除父项关键字列     4.被外键引用的列，不能被删除。

-------------------------------------------------------
--删除表
--      语法： drop table 表名;
-------------------------------------------------------
1.删除表person
drop table person

-------------------------------------------------------
--重命名表
--      语法： rename 旧表名 to 新表名;
-------------------------------------------------------
1.将person表表名修改为dossier
rename person to dossier;

-------------------------------------------------------
--截断表
--      语法： truncate table 表名；
--
--      截断表truncate与删除表数据delete的区别：
--          truncate属于DDL语言，删除表中所有的数据，释放存储空间，不可以撤回数据
--          delete属于DML语言，可以删除指定的数据,不释放存储空间，可以通过rollback回滚数据
-------------------------------------------------------
truncate table person;
delete from person;

-------------------------------------------------------
--数据字典
-------------------------------------------------------
select * from user_tables;--查询当前用户下所有的表格

--练习
1.请分析按照以下要求都需要建立什么类型的字段?
(1)最大2000个字节定长字符串
char

(2)如果输入‘张三’ 后添空格6个
char(10)

(3)性别输入'男'或'女’
char(2)

(4)最大4000个字节变长字符串
varchar2

(5)如果在数据库中输入'张三'则显示数据'张三’
varchar2(10)

(6)表示数字范围为-10的125次方到10的126次方, 可以表示小数 也可以表示整数
number

(7)最大表示4位整数  -9999 到 9999
number(4)

(8)表示5位有效数字 2位小数的 一个小数  -999.99 到 999.99
number(5,2)

(9)包含年月日和时分秒
date

(10)包含年月日和时分秒毫秒
timestamp

(11)二进制大对象图像/声音
blob
