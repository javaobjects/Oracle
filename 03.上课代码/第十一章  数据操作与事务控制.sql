数据查询语言 DQL(Data Query Language): select
数据操作语言 DML(Data Manipulation Language): insert   update   delete
事务处理语言 TPL(Transaction Process Language):commit  rollback

--------------------------------------------------------------------------------------------------
-- 新增数据(插入数据)
--              语法： insert into 表名(列1，列2....) values(值1，值2....);  一次新增一行
--                     insert into 表名(列1，列2....) 子查询;   一次新增N行
--
--              1.列名列表与值列表的个数、类型必须保持一致
--              2.列名列表可以省略，默认值列表给所有列赋值
--              3.值列表中日期、字符串必须使用''单引号括起来
--------------------------------------------------------------------------------------------------
--插入空值NULL   隐含法: 在列名列表中忽略该列。
insert into dept(deptno,dname) values(50,'开发部');

--插入空值NULL  显示法: 指定 NULL关键字或者''
insert into dept(deptno,dname,loc) values(60,'需求部','东软大厦125C');--全部给值
insert into dept(deptno,dname,loc) values(70,'测试部',null);--loc给空值
insert into dept values(80,'实施部','');  --2.列名列表可以省略，默认值列表给所有列赋值
insert into dept values(90,'运维部');     --not OK 没有足够的值

--插入日期值  SYSDATE 函数记录当前日期和时间
insert into emp(empno,ename,hiredate) values(7777,'李四',sysdate);

--插入日期值   可以使用RR日期格式，也可以使用to_date()函数转换YY日期格式
insert into emp(empno,ename,hiredate) values(8888,'李二','2019-08-01');--文字与格式字符串不匹配
insert into emp(empno,ename,hiredate) values(8888,'李二','1-8月-19'); --RR日期格式
insert into emp(empno,ename,hiredate) values(8888,'李二',to_date('2019-08-01','yyyy-mm-dd'));--YY日期格式

--插入特殊字符
insert into dept(deptno,dname) values(50,'~!@#$%^*()-+');--ok
insert into dept(deptno,dname) values(50,'&');           --ok   
insert into dept(deptno,dname) values(50,'&需求部');-- not OK    &修饰的字符表示一个变量，等待用户输入变量值

insert into dept(deptno,dname) values(50,'\&需求部');--not ok
insert into dept(deptno,dname) values(50,'&' || '需求部'); --ok
insert into dept(deptno,dname) values(50,chr(38) || '需求部'); --ok

--ascii() 查看指定字符的ascii编码
select ascii('&') from dual; --38

--chr() 查看指定ascii编码代表的字符
select chr(38) from dual;

----------------------
--批量新增（备份数据）
----------------------
1. 将部门10所有的员工信息备份到emp_dept10表中
①复制表结构：创建表emp_dept10，且结构与emp表一致
create table emp_dept10 as select * from emp;           --1.复制emp表的表结构与所有数据    
create table emp_dept10 as select * from emp where 1=0; --1.仅复制emp表的表结构

② 使用子查询批量新增数据：将部门10的员工数据备份到emp_dept10表中
insert into emp_dept10 select * from emp where deptno = 10;--2.复制所有列数据   
insert into emp_dept10(empno,ename,hiredate) select empno,ename,hiredate from emp where deptno = 10;--2.复制指定列数据

--------------------------------------------------------------------------------------------------
-- 修改数据
--              语法： update 表名 set 列名1=值1[,列名2=值2.....]  [where 限制条件]
--------------------------------------------------------------------------------------------------
--使用 WHERE 子句指定要修改的记录
1.把员工编号为7782的部门编号修改为20
update emp set deptno = 20 where empno = 7782;

--如果要修改所有记录，WHERE子句可以忽略
2.把所有员工的部门编号修改为20
update emp set deptno = 20;

--一次修改多列
3.把部门编号为10的员工，部门编号调整为20，工资增加100
update emp set deptno = 20,sal = sal+100 where deptno = 10;

--嵌入子查询修改
4.把部门编号为10的员工，部门编号调整为20，工资在原有的基础上，增加所有人的平均工资
select avg(sal) from emp;--1.所有人的平均工资  2073.5
update emp set deptno=20,sal= sal+(select avg(sal) from emp) where deptno = 10;

--修改记录时的完整性约束错误
5.把部门编号为10的员工，部门编号调整为55
update emp set deptno=55 where deptno =10;--not ok 未找到父项关键字  emp.deptno 的数据来源于 dept.deptno,此时dept中没有55编号的部门存在

--相关子查询修改
1.在emp中新增dname列
alter table emp add(dname varchar2(14));

2.将emp表中的dname更新为实际部门的名称
update emp set dname = (select dname from dept where deptno = emp.deptno);

--练习
2.修改奖金为null的员工，奖金设置为0
update emp set comm = 0 where comm is null;

select * from emp where comm = null;--null与任意值计算均为null
select * from emp where comm in(null);--null与任意值计算均为null

--------------------------------------------------------------------------------------------------
-- 删除数据
--              语法： delete [from] 表名  [where 限制条件]
--------------------------------------------------------------------------------------------------
--删除选中记录
1.删除职位是CLERK的员工记录
delete from emp where job = 'CLERK';

--删除全部记录
2.删除所有员工记录
delete from emp;
delete emp;

--基于另一个表删除本表记录
3.删除部门SALES的员工
select deptno from dept where dname = 'SALES';--1.SALES的部门编号为多少？  30
delete from emp where deptno = (select deptno from dept where dname = 'SALES');

--删除记录时的完整性约束错误
4.删除部门编号为10的部门记录
delete from dept where deptno = 10; --not ok 已找到子记录  因为emp.deptno引用dept.deptno,而dept.deptno为10的部门已经存在3个员工

--相关DELETE
5.删除曾经做过入职的员工记录
delete from emp where 曾经做过入职;
delete from emp where exists (select * from emp_jobhistory where empno = emp.empno);

6.删除没有员工的部门记录
delete from dept where 没有员工的部门;
delete from dept where not exists (select * from emp where deptno = dept.deptno);

--------------------------------------------------------------------------------------------------
-- 事务管理: 由一组SQL语句组成的管理单元,要么全部执行成功，要么全部执行失败
--              
--       事务四大特性：
--             1. 原子性：一个事务中所有的SQL语句，执行时，要么全部执行成功，要么全部执行失败
--             2. 一致性：不论SQL语句执行成功，还是失败，整个数据处于平衡状态。
--             3. 隔离性：事务与事务之间相互隔离，互不影响
--             4. 持久性：一旦数据被提交，永久性被保存到数据库中，不能再撤回
--
--       事务开启：上一个事务结束以后，执行下一个DML(增、删、改)语句即开始新的事务
--
--       事务结束：
--                1.显示结束
--                       commit:显示提交
--                       rollback:显示回滚（撤销所有的操作）
--
--                2.隐式结束
--                      隐式提交：当下列任意一种情况发生时，会发生隐式提交
--                              1.执行一个DDL(CREATE、ALTER、DROP、TRUNCATE、RENAME）语句；
--                              2.执行一个DCL(GRANT、REVOKE)语句；
--                              3.从SQL*Plus正常退出（即使用EXIT或QUIT命令退出）；
--
--                      隐式回滚：当下列任意一种情况发生时，会发生隐式回滚
--                              1. 从SQL*Plus中强行退出
--                              2. 客户端连接到服务器端异常中断
--                              3. 系统崩溃

--------------------------------------------------------------------------------------------------
--开启事务
insert into dept(deptno,dname) values(50,'财务部');
insert into dept(deptno,dname) values(60,'人力资源部');
rollback;--显示回滚,事务结束

insert into dept(deptno,dname) values(70,'后勤部');
commit;--显示提交，事务结束

------------------------------------------------------
--设置保存点
insert into dept(deptno,dname) values(81,'需求部');
savepoint poin1;--设置保存点1
insert into dept(deptno,dname) values(82,'UI部');
insert into dept(deptno,dname) values(83,'前端部');
savepoint poin2;--设置保存点2
insert into dept(deptno,dname) values(84,'开发部');
insert into dept(deptno,dname) values(85,'测试部');
savepoint poin3;--设置保存点3
insert into dept(deptno,dname) values(86,'实施部');

rollback to poin2;--回滚保存点2的位置
commit; --提交部分事务SQL语句

rollback;--事务已经被提交，不可能再被回滚
------------------------------------------------------

------------------------------------------------------
-- 锁：
--      
--      行级锁  和  表级锁             （悲观锁 和  乐观锁）
--
--      行级锁: ORACLE默认的机制是在DML操作影响的行记录上自动加锁
--              当会话1在修改指定行数据，且没有commit提交事务或者rollback回滚事务之前,
--              该数据行被锁定，其他会话2不允许修改该数据。
--              如果会话1结束事务，锁释放，其他会话2可以继续操作该数据
--
--      表级锁：当会话1在操作指定数据时，表将被锁定，其他会话不允许对表结构进行修改（新增列、修改列、删除列）
------------------------------------------------------
--会话1 （执行一个事务）
update dept set loc='125C教室' where deptno = 83;
select * from dept;

--会话2（执行一个事务）
delete from dept where deptno = 50;
select * from dept;











