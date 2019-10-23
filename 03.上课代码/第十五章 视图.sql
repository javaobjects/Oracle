--------------------------------------------------------------
-- 创建视图（view） 
--      语法：create or replace view 视图名 as 子查询 [with check option] [with read only];
--
--      权限不足,sys/sys as sysdba管理员授权：
--                   grant create view to scott;
--------------------------------------------------------------
--简单创建：基于一张表,没有分组函数、分组语句等
1.创建一个视图v_emp10，通过该视图只能查看10号部门的员工编号，员工姓名，职位
create view v_emp10
as 
select empno,ename,job from emp where deptno = 10;--10号部门的员工编号，员工姓名，职位

--创建视图时，在子查询中使用列的别名
--     create or replace 修改视图:当视图不存在时create创建，当视图已存在时replace替换
create or replace view v_emp10
as 
select empno 员工编号,ename 员工姓名,job 职位 from emp where deptno = 10;--10号部门的员工编号，员工姓名，职位

--复杂创建：基于多张表、分组函数、分组语句等
2.创建一个视图，通过该视图可以查看每个部门的名称，最低工资，最高工资，平均工资
create or replace view v_dept_avgsal(部门名称,最低工资,最高工资,平均工资)
as
select d.dname,min(sal),max(sal),avg(sal) from dept d,emp e where d.deptno = e.deptno group by d.dname;--查看每个部门的名称，最低工资，最高工资，平均工资

--------------------------------------------------------------
-- 修改视图： create or replace
--------------------------------------------------------------

--------------------------------------------------------------
--视图上执行DML操作的规则
--    基于简单视图的DML修改数据时，只能影响视图可见数据
--------------------------------------------------------------
--基于简单视图的DML（可以）
create or replace view v_emp10
as 
select * from emp where deptno = 10;

①基于视图v_emp10,将部门10的员工7839的薪资修改为10000
update v_emp10 set sal = 10000 where empno = 7839; --ok  影响行数1，因为7839为视图可见数据

②基于视图v_emp10,将员工编号为6666的职位修改为"老板的爸爸"
update v_emp10 set job = '老板的爸爸' where empno = 6666;--ok 影响行数为0，因为6666为视图不可见数据

③基于视图v_emp10,新增一行数据
insert into v_emp10(empno,ename,job,deptno) values(7777,'视图数据','测试',10);--ok,影响行数1

--基于复杂视图的DML（不可以）
create or replace view v_dept_avgsal(部门名称,最低工资,最高工资,平均工资)
as
select d.dname,min(sal),max(sal),avg(sal) from dept d,emp e where d.deptno = e.deptno group by d.dname;--查看每个部门的名称，最低工资，最高工资，平均工资

①基于视图v_dept_avgsal，将部门名称为'RESEARCH'的部门的最低工资调整为5000
update v_dept_avgsal set 最低工资 = 5000 where 部门名称 = 'RESEARCH';-- not ok 次数据操作操纵非法

--with check option
--     使用with check option修饰的视图，对数据进行DML操作时，必须遵守where子句的限制条件，不允许修改
create or replace view v_emp10
as 
select * from emp where deptno = 10
with check option;
--测试
update v_emp10 set sal = 10000 where empno = 7839; --ok
update v_emp10 set deptno = 20 where empno = 7839; --not ok 视图with check option where子句违规

--with read only
create or replace view v_emp10
as 
select * from emp where deptno = 10
with read only;
--测试
update v_emp10 set sal = 10000 where empno = 7839;--not ok 无法对只读视图进行DML操作

--------------------------------------------------------------
-- 使用视图查询数据
--------------------------------------------------------------
select * from v_emp10;
select * from v_dept_avgsal;

--------------------------------------------------------------
-- 删除视图
--------------------------------------------------------------
drop view v_emp10;

--------------------------------------------------------------
-- 数据字典
--------------------------------------------------------------
select * from user_tables;--查询当前用户下所有的表格

select * from user_constraints;--查看当前用户下所有的约束
select * from user_cons_columns;--查看约束关联的列信息

select * from user_indexes;--查询当前用户下所有的索引
select * from user_ind_columns;--查看索引关联的列信息

select * from user_views;--查看当前用户下所有的视图
select * from user_updatable_columns;--查看视图或表关联的列是否允许DML操作

select * from user_objects;--查看当前用户下所有的对象






