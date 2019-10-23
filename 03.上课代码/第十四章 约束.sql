-------------------------------------------------------
-- not null(非空约束):不能为null 或者 ''
--
--     1.约束的列值不能为null
--     2.只能定义列级别的约束
--     3.可以不用指定约束名称
-------------------------------------------------------
1.创建表emp_bak,指定ename不能为null
--不指定约束名称
create table emp_bak(
       empno number(4),
       ename varchar2(10) not null,--列级别约束
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
);
--测试
insert into emp_bak(empno,ename) values(1111,'删的快');--ok
insert into emp_bak(empno,ename) values(2222,'');  --not ok 无法将null值插入"scott.emp_bak.ename"
insert into emp_bak(empno,ename) values(2222,null);--not ok 无法将null值插入"scott.emp_bak.ename"

-------------------------------------------------------
-- unique(唯一约束、唯一键):
--
--     1.约束的列值必须唯一，但是可以为null
--     2.既能定义列级别约束（单列unique约束），也可以定义表级别的约束（多列组合unique约束）
--     3.建议指定约束名称
--     4.创建唯一约束时，默认给所有约束的列添加索引index,用于优化查询效率，例如：select * from emp_bak where empno=?
--     5.一个表可以同时定义多个unique唯一约束
--     6.可以给一列或多列定义unique唯一约束
--------------------------------------------------------
1.创建表emp_bak,指定empno必须唯一、同时ename必须唯一
--不指定约束名称
create table emp_bak(
       empno number(4) unique,   --列级别约束 ,系统命名SYS_C0011805
       ename varchar2(10) unique,--列级别约束,系统命名SYS_C0011806
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
);
--测试
insert into emp_bak(empno,ename) values(1111,'删的快');--ok
insert into emp_bak(empno,ename) values(1111,'删的快2');--not ok 违反唯一约束条件scott.SYS_C0011805
insert into emp_bak(empno,ename) values(null,'删的快2');--ok

--指定约束名称
create table emp_bak(
       empno number(4) constraint emp_empno_unique unique,   --列级别约束 ,自定义命名emp_empno_unique
       ename varchar2(10) constraint emp_ename_unique unique,--列级别约束,自定义命名emp_ename_unique
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
       
       --表级别约束
       --,constraint emp_empno_unique unique(empno),
       --constraint emp_ename_unique unique(ename)
);
--测试
insert into emp_bak(empno,ename) values(1111,'张三');--ok
insert into emp_bak(empno,ename) values(1111,'李四');--not ok 违反唯一约束条件scott.emp_empno_unique

--同时给多列定义组合唯一约束
1.创建表emp_bak,指定empno、ename组合唯一
create table emp_bak(
       empno number(4),  
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --组合约束，只能定义表级别约束
       constraint emp_empno_ename_unique unique(empno,ename)
);
--测试
insert into emp_bak(empno,ename) values(1111,'张三');--ok
insert into emp_bak(empno,ename) values(1111,'李四');--ok
insert into emp_bak(empno,ename) values(2222,'李四');--ok
insert into emp_bak(empno,ename) values(2222,'李四');--not ok 违反唯一约束条件scott.emp_empno_ename_unique
-------------------------------------------------------
-- primary key(主键约束):相当于unique + not null
--
--     1.约束的列值必须唯一，且不可以为null
--     2.既能定义列级别约束（单列PK约束），也可以定义表级别的约束（多列组合PK约束）
--     3.建议指定约束名称
--     4.创建唯一约束时，默认给所有约束的列添加索引index,用于优化查询效率，例如：select * from emp_bak where empno=?
--     5.一个表只能有一个primary key主键约束
--     6.可以给一列或多列定义primary key主键约束
--------------------------------------------------------
1.创建表emp_bak,指定empno为主键
--指定约束名称
create table emp_bak(
       empno number(4) ,--constraint emp_empno_pk primary key,   --列级别约束 ,自定义命名emp_empno_pk
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --定义表级别约束
       constraint emp_empno_pk primary key(empno)
);
--测试
insert into emp_bak(empno,ename) values(1111,'张三');--ok
insert into emp_bak(empno,ename) values(1111,'李四');--not ok 违反唯一约束条件scott.emp_empno_pk
insert into emp_bak(empno,ename) values(null,'李四');--not ok  无法将null值插入"scott.emp_bak.empno"

--同时给多列定义组合主键约束
1.创建表emp_bak,指定empno、ename组合为主键
create table emp_bak(
       empno number(4),  
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --组合约束，只能定义表级别约束
       constraint emp_empno_ename_pk primary key(empno,ename)
);
-------------------------------------------------------
-- foreign key(外键约束):
--
--     1.外键列的值必须在引用列值的范围内，或者为null
--     2.外键参照的是列必须是主键或者唯一键
--     3.主键表主键值被外键表参照时，主键表记录不允许被删除

--     4.建议指定约束名称
--     5.既能定义列级别约束，也可以定义表级别的约束
--     6.一个表可以有多个外键约束
--
--     级联删除 on delete cascade
--     级联清空 on delete set null
--------------------------------------------------------
1.创建表emp_bak,指定deptno为外键，参考dept表的deptno主键列
--指定约束名称
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),-- constraint emp_deptno_fk references dept(deptno)   --列级别约束 ,自定义命名emp_deptno_fk
       
       --定义表级别约束
       constraint emp_deptno_fk foreign key(deptno) references dept(deptno)
);
--测试
insert into emp_bak(empno,ename) values(1111,'张三');--ok 外键值可以为null
insert into emp_bak(empno,ename,deptno) values(1111,'张三',10);--ok 参考dept.deptno的值
insert into emp_bak(empno,ename,deptno) values(2222,'李四',88);-- not ok 违反完整性约束条件scott.emp_deptno_fk-未找到父项关键字

-- 3.主键表主键值被外键表参照时，主键表记录不允许被删除
delete from dept where deptno = 10; -- not ok 违反完整性约束条件scott.fk_deptno-已找到子记录

--级联删除 on delete cascade
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --定义表级别约束
       constraint emp_deptno_fk foreign key(deptno) references dept(deptno) on delete cascade --on delete cascade
);
--测试
insert into emp_bak(empno,ename,deptno) values(1111,'张是哪',10);
insert into emp_bak(empno,ename,deptno) values(2222,'李四',88);

delete from dept where deptno = 88;--级联删除：①将部门88的员工全部删除  ② 将部门88删除


--级联清空 on delete set null
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --定义表级别约束
       constraint emp_deptno_fk foreign key(deptno) references dept(deptno) on delete set null --on delete set null
);
--测试
insert into emp_bak(empno,ename,deptno) values(1111,'张是哪',10);
insert into emp_bak(empno,ename,deptno) values(2222,'李四',88);

delete from dept where deptno = 88;--级联清空：①将部门88的员工的部门编号deptno清空  ② 将部门88删除
-------------------------------------------------------
-- check(检查性约束):
--
--     1.约束的列取值范围,但是可以为null
--     2.建议指定约束名称
--     3.既能定义列级别约束，也可以定义表级别的约束
--     4.一个表可以有多个check键约束
--------------------------------------------------------
1.创建表emp_bak,约束sal必须大于等于3000
--比较运算符  >   >=  =  <   <=  <>
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2) constraint emp_sal_check check(sal >= 3000),   --列级别约束 ,自定义命名emp_sal_check
       comm number(7,2),
       deptno number(2)
       
       --定义表级别约束
       --constraint emp_sal_check check(sal >= 3000)
);
--测试
insert into emp_bak(empno,ename,sal) values(1111,'张三',null);--ok 可以为null
insert into emp_bak(empno,ename,sal) values(1111,'张三',2900);--not ok 违反检查约束条件scott.emp_sal_check
insert into emp_bak(empno,ename,sal) values(1111,'张三',3000);

--特殊比较运算符  in
1.创建表emp_bak,约束job取值必须为开发师、测试师、前端师
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9) constraint emp_job_check check(job in('开发师','测试师','前端师')),   --列级别约束 ,自定义命名emp_sal_check
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
       
       --定义表级别约束
       -- constraint emp_job_check check(job in('开发师','测试师','前端师'))
);
--测试
insert into emp_bak(empno,ename,job) values(1111,'张三',null);--ok 可以为null
insert into emp_bak(empno,ename,job) values(1111,'张三','程序猿');--not ok 违反检查约束条件scott.emp_job_check
insert into emp_bak(empno,ename,job) values(1111,'张三','开发师');

--特殊比较运算符  between...and....
1.创建表emp_bak,约束sal取值范围为3000-99999之间
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2) constraint emp_job_check check(sal between 3000 and 99999),   --列级别约束 ,自定义命名emp_sal_check,
       comm number(7,2),
       deptno number(2)
       
       --定义表级别约束
       -- constraint emp_job_check check(sal between 3000 and 99999)
);
--测试
insert into emp_bak(empno,ename,sal) values(1111,'张三',null);--ok 可以为null
insert into emp_bak(empno,ename,sal) values(1111,'张三',2900);--not ok 违反检查约束条件scott.emp_sal_check
insert into emp_bak(empno,ename,sal) values(1111,'张三',99999);--ok

-------------------------------------------------------
-- 综合定义五类约束
--------------------------------------------------------
--列级别约束
create table emp_bak(
       empno number(4) constraint emp_empno_pk primary key,--主键约束
       ename varchar2(10) constraint emp_ename_unique unique,--唯一约束
       job varchar2(9) constraint emp_job_nn not null,--非空约束
       mgr number(4),
       hiredate date,
       sal number(7,2) constraint emp_sal_check check(sal >= 3000),--检查性约束
       comm number(7,2),
       deptno number(2) constraint emp_deptno_fk references dept(deptno) -- 外键约束
);
--表级别约束
create table emp_bak(
       empno number(4),
       ename varchar2(10),
       job varchar2(9) constraint emp_job_nn not null,--非空约束
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       constraint emp_empno_pk primary key(empno),--主键约束
       constraint emp_ename_unique unique(ename),--唯一约束
       constraint emp_sal_check check(sal >= 3000),--检查性约束
       constraint emp_deptno_fk foreign key(deptno) references dept(deptno) -- 外键约束
);
-------------------------------------------------------
--追加约束
-------------------------------------------------------
create table emp_bak(
       empno number(4),
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
);
--追加约束
alter table emp_bak add constraint emp_empno_pk primary key(empno);--主键约束
alter table emp_bak add constraint emp_ename_unique unique(ename);--唯一约束
alter table emp_bak add constraint emp_sal_check check(sal>=3000);--检查性约束
alter table emp_bak add constraint emp_deptno_fk foreign key(deptno) references dept(deptno);--外键约束

alter table emp_bak modify (job constraint emp_job_nn not null);--非空约束

-------------------------------------------------------
--删除约束
-------------------------------------------------------
alter table emp_bak drop constraint emp_empno_pk;--主键约束
alter table emp_bak drop primary key;            --主键约束

alter table emp_bak drop constraint emp_ename_unique;--唯一约束
alter table emp_bak drop unique(ename);              --唯一约束

alter table emp_bak drop constraint emp_sal_check;--检查性约束

alter table emp_bak drop constraint emp_deptno_fk;--外键约束

alter table emp_bak drop constraint emp_job_nn;--非空约束
alter table emp_bak modify (job null);         --非空约束

-------------------------------------------------------
--禁用约束
-------------------------------------------------------
alter table emp_bak disable constraint emp_empno_pk;--禁用主键
alter table emp_bak disable constraint emp_ename_unique;--禁用唯一约束
alter table emp_bak disable constraint emp_sal_check;--禁用检查性约束
alter table emp_bak disable constraint emp_deptno_fk;--禁用外键约束
alter table emp_bak disable constraint emp_job_nn;--禁用非空约束

-------------------------------------------------------
--启用约束
-------------------------------------------------------
alter table emp_bak enable constraint emp_empno_pk;--启用主键
alter table emp_bak enable constraint emp_ename_unique;--启用唯一约束
alter table emp_bak enable constraint emp_sal_check;--启用检查性约束
alter table emp_bak enable constraint emp_deptno_fk;--启用外键约束
alter table emp_bak enable constraint emp_job_nn;--启用非空约束

-------------------------------------------------------
--数据字典  P(primary key) R(foreign key) C(check,not null属于C) U(unique)
-------------------------------------------------------
select * from user_constraints;--查看当前用户下所有的约束
select * from user_cons_columns;--查看约束关联的列信息

