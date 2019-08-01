-------------------第十一章  数据操作与事务控制----------------------

--DML数据操作语言

--插入行数据（insert into ...values）

--没有显式指定插入哪一个列，默认需要我们插入全部的列数据
insert into emp values(7777,'clearlove','player',8888,sysdate,1000,5000,20);

--插入日期类型数据
insert into emp values(7777,'clearlove','player',8888,to_date('2019/4/2','YYYY/MM/DD'),1000,5000,20);

--向表中插入指定列(没有指定的列，则默认为空值)
insert into emp(empno,ename) values(7777,'clearlove');

1.向部门表新增一个部门，部门编号为50，部门名称为HR，工作地点为SY。
2.向部门表新增一个部门，部门编号为60，部门名称为MARKET。
1.向员工表中新增一个员工，员工编号为8888，姓名为BOB，岗位为CLERK，经理为号7788，
   入职日期为1985-03-03，薪资3000，奖金和部门为空。
   
   
--插入多行数据
--关键在于values子句用了一个子查询来代替

--创建manager表(用于保存职位为manager的员工信息)
CREATE TABLE manager AS
SELECT * FROM emp WHERE 1=0;

--向manager表中插入职位为MANAGER的记录
insert into manager (select * from emp where job = 'MANAGER');
select * from manager;

--练习
--1.使用CREATE TABLE emp_back as SELECT * FROM EMP WHERE 1=0，创建emp_back表,拷贝下来即可。
CREATE TABLE emp_back as SELECT * FROM EMP WHERE 1=0;
select * from emp_back;

--2.把emp表中入职日期大于1982年1月1日之前的员工信息复制到emp_back表中。
insert into emp_back (select * from emp where hiredate > '01-1月-82');


--修改数据(update) 
--把员工编号为7782的部门编号修改为20
update emp
set deptno = 20
where empno = 7782;

--如果要修改所有记录，WHERE子句可以忽略
update emp
set sal = 10000;

--修改多列值
--把员工编号为7782的部门编号修改为20,并且工资设置为5000;
update emp
set deptno = 20,sal = 5000
where empno = 7782;

--修改时的完整性约束
--把员工编号为7782的部门编号修改为50
update emp
set deptno = 50
where empno = 7782;    --违反完整性约束


--相关update（在update中使用相关子查询）
--在emp表中增加一个列dname, 来存储部门名称
ALTER TABLE emp ADD(dname VARCHAR2(14));

--使用相关子查询更新dname列为正确的部门名称
update emp e
set dname = (select dname from dept where deptno = e.deptno);


--***先确定update哪一个表，再用where确定修改哪一行数据，再用set补充把相应的列修改为什么值****

--1.修改部门20的员工信息，把82年之后入职的员工入职日期向后调整10天
update emp
set hiredate = hiredate + 10
where deptno = 20 and hiredate > '01-1月-82';

--2.修改奖金为null的员工，奖金设置为0
update emp
set comm = 0
where comm is null;

--3.修改工作地点在NEW YORK或CHICAGO的员工工资，工资增加500
update emp
set sal = sal + 500
where deptno in (select deptno from dept where loc in('NEW YORK','CHICAGO'));

update emp e 
set sal=sal+490 
where (select loc from dept where deptno=e.deptno) in('NEW YOKE','CHICAGO');


--删除数据(delete)  删除指定行数据
--删除职位是CLERK的员工记录
delete from emp
where job = 'CLERK';

--删除整个表的全部数据(表还在，只是数据没了)
delete from emp;

--删除部门SALES的员工记录
delete from emp
where deptno = (select deptno from dept where dname = 'SALES');

--相关delete（在删除的时候使用相关子查询）
--删除曾经做过入职的员工记录
delete from emp e
where (select count(*) from emp_jobhistory where empno = e.empno) >0;

1.删除经理编号为7566的员工记录
2.删除工作在NEW YORK的员工记录
--3.删除工资大于所在部门平均工资的员工记录
delete from emp e
where sal > (select avg(sal) from emp where deptno = e.deptno);

commit;


--事务控制
--事务的组成（由一组DQL查询语句或者是一组DML数据操作语句带上一个TPL,DDL,DCL）

--设置保存点回滚到指定的位置
insert into emp(empno,ename) values(7778,'1');
insert into emp(empno,ename) values(7779,'1');
savepoint s1;
insert into emp(empno,ename) values(7780,'1');
insert into emp(empno,ename) values(7781,'1');
rollback to s1;


--行级锁
delete from emp where empno = 7839;

--表级锁(当别的用户对某个表的数据作操作的时候，该表的表结构不能被改变)


create table student (        --学生表
      xh char(4),--学号
      xm varchar2(10),--姓名
      sex char(4),--性别
      birthday date,--出生日期
      sal number(7,2), --奖学金
      studentcid number(2) --学生班级号
)

Create table class (   --班级表
			classid number(2), --班级编号
			cname varchar2(20),--班级名称
  			ccount  number(3) --班级人数
)

（1）添加三个班级信息为：1，JAVA1班，null
                         2，JAVA2班，null
                         3，JAVA3班，null
insert into class values(1,'JAVA1班',null);
insert into class values(2,'JAVA2班',null);
insert into class values(3,'JAVA3班',null);

（2）添加学生信息如下：‘A001’,‘张三’,‘男’,‘01-5月-05’,100,1


insert into student values('A001','张三','男','01-5月-05',100,1);

（3）添加学生信息如下：'A002','MIKE','男','1905-05-06',10
insert into student values('A002','mike','男',to_date('1905-05-06','yyyy/mm/dd'),100,1);


（4）插入部分学生信息： 'A003','JOHN','女’;
insert into student (xh,xm,sex) values('A003','JOHN','女');

（5）将A001学生性别修改为'女‘
update student 
set sex='女'
where xh='A001';

（6）将A001学生信息修改如下：性别为男，生日设置为1980-04-01
update student
set birthday='01-4月-80',sex='男'
where xh='A001';

（7）将生日为空的学生班级修改为Java3班
update student
set studentcid=3
where birthday is null;

（8）请使用一条SQL语句，使用子查询，更新班级表中每个班级的人数字段
update class c
set ccount = (select count(*) from student where studentcid = c.classid);


select * from student;
select * from  class




select * from emp;
select * from emp_jobhistory;
select * from emp; 
select * from dept;  
