--------------------------------------------------------------
--索引(index):单列索引、复合索引，用于优化查询效率
--
--    自动创建：当创建primary key或unique 约束时，默认创建索引
--
--    手动创建：create index idx_tableName_columName on 表名(列名1[,列名2...])
--------------------------------------------------------------
--rownum 伪列
--       虚拟存在的，每查询一次数据，永远从1开始，只能使用 <或者 <=比较
select rownum,e.* from emp e;

--rowid 伪列
--      真实存在在物理磁盘中，唯一标识每一行数据的值
select rowid,e.* from emp e;

----------------------
--创建索引
----------------------
--单列索引
1.在emp表的ename字段上创建索引.
create index idx_emp_ename on emp(ename);

--复合索引（组合索引）
2.在emp表的deptno和job的组合上创建索引
create index idx_emp_deptno_job on emp(deptno,job);

--测试索引
1.创建表emp_bak，表结构同emp（即复制emp的表结构）
create table emp_bak as select * from emp;

2.往emp_bak表中插入大批量数据(单位：百万)
insert into emp_bak select * from emp_bak;--3932160

3.将empno设置为唯一的值
alter table emp_bak modify(empno number(7));--1.将empno的长度修改7

update emp_bak set empno = rownum;          --2.使用rownum将empno修改为唯一值
update emp_bak set empno = seq_emp.nextval; --2.使用序列修改为唯一值

4.查询empno为3032160的员工信息
select * from emp_bak where empno = 3032160;--无索引  0.20秒

create index idx_emp_empno on emp_bak(empno);--创建索引

select * from emp_bak where empno = 3032160;--有索引  0.01秒

----------分析有无索引的区别------------start
--1.无索引
select rowid,emp_bak.* from emp_bak where empno = 3032160;--0.2  干巴巴的查询了6000多行

--2.有索引：给empno创建了一个索引，为了维护 3032160 -> AAATBlAAEAAAOMfABa 这段奇妙的关系，需要花代价
① 3032160 -> AAATBlAAEAAAOMfABa 
select rowid from emp_bak where empno = 3032160;--AAATBlAAEAAAOMfABa
AAATBlAAEAAAKo7AAA	1
AAATBlAAEAAAKo7AAB	2
AAATBlAAEAAAKo7AAC	3
AAATBlAAEAAAKo7AAD	4
AAATBlAAEAAAKo7AAE	5
AAATBlAAEAAAKo7AAF	6
AAATBlAAEAAAKo7AAG	7
.....................
AAATBlAAEAAAOMfABa  3032160

②AAATBlAAEAAAOMfABa -> 3032160对应的数据
select rowid,emp_bak.* from emp_bak where rowid='AAATBlAAEAAAOMfABa';--0.01 查询了1行
----------分析有无索引的区别------------end

----------------------
--删除索引
----------------------
drop index idx_emp_empno;

----------------------
--数据字典表
----------------------
select * from user_tables;--查询当前用户下所有的表格

select * from user_constraints;--查看当前用户下所有的约束
select * from user_cons_columns;--查看约束关联的列信息

select * from user_indexes;--查询当前用户下所有的索引
select * from user_ind_columns;--查看索引关联的列信息

--------------------------------------------------------------
--序列（sequence）：按照一定的规则自动增长或自动减少，通常用于生成主键值
--------------------------------------------------------------
--简单创建
create sequence seq_emp;

--复杂创建
create sequence SEQ_EMP
minvalue 1                             -- 最小值  minvalue X | nominvalue
maxvalue 9999999999999999999999999999  --最大值  maxvalue X | nomaxvalue
start with 1                           --开始值
increment by 1                         --累增的值
nocycle                                --默认不循环  cycle | nocycle
cache 20;                              --默认缓存20  cache X | nocache

create sequence seq_dept
minvalue 10
maxvalue 90
start with 10
increment by 10
nocycle
nocache;

--两个属性
--   nextval : 获取序列的下一个值
--   currval ：获取同一个会话中，序列的当前的值，且取值之前必须先执行nextval取下一个值
select seq_emp.nextval from dual;
select seq_emp.currval from dual;

select seq_dept.nextval from dual;

--使用序列：新增数据时，自动生成主键值
insert into emp(empno,ename,job) values(seq_emp.nextval,'张大鹏','屌丝男士');

--修改序列：除了start with以外的属性均可以修改
1.将seq_dept的最大值修改为200
alter sequence seq_dept
maxvalue 200;

--删除序列
drop sequence seq_emp;

--------------------------------------------------------------
--同义词（synonym）：给对象取别名
--------------------------------------------------------------
--私有同义词
create synonym e for emp;
select * from scott.e;

--共有同义词
create public synonym d for dept;
select * from d;

--删除同义词
drop synonym e;
drop public synonym d;

--提示“权限不足”，需要sys管理员授权
grant create synonym to scott;
grant create public synonym to scott;

grant drop synonym to scott;
grant drop public synonym to scott;







