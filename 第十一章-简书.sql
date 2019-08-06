--## 练习1

--1. 向部门表新增一个部门，部门编号为50，部门名称为HR，工作地点为SY。
insert into dept(deptno,dname,loc)
       values(50,'HR','SY');

--2. 向部门表新增一个部门，部门编号为60，部门名称为MARKET。
insert into dept(deptno,dname)
       values(60,'MARKET');

--## 练习2

--1. 向员工表中新增一个员工，员工编号为8888，姓名为BOB，岗位为CLERK，经理为号7788，
--入职日期为1985-03-03，薪资3000，奖金和部门为空。
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
            values(8888,'BOB','CLERK',7788
            ,to_date('1985-03-03','yyyy/mm/dd'),3000,null,null);

--## 练习3

--1. 使用CREATE TABLE emp_back as  SELECT * FROM EMP WHERE 1=0，创建emp_back表,拷贝下来即可。
create table emp_back
as select * from emp where 1 = 0;

--2. 把emp表中入职日期大于1982年1月1日之前的员工信息复制到emp_back表中。
insert into emp_back
            select * 
            from emp
            where hiredate > '01-1月-82';

--## 练习4

--1. 修改部门20的员工信息，把82年之后入职的员工入职日期向后调整10天
select * from emp_back;

update emp_back
set hiredate = hiredate + 10
where deptno in 20
and hiredate > '01-1月-82';

select * from emp_back;

select * from emp;
select * from dept;
--2. 修改奖金为null的员工，奖金设置为0

--3. 修改工作地点在NEW YORK或CHICAGO的员工工资，工资增加500

--## 练习5

--1. 重复做一下刚才的案例。

--## 练习6

--1. 删除经理编号为7566的员工记录

--2. 删除工作在NEW YORK的员工记录

--3. 删除工资大于所在部门平均工资的员工记录

--## 练习7

--分析如下语句序列，哪些语句会结束事务？

--    INSERT…

--    UPDATE..

--    INSERT

--    ROLLBACK;

--    DELETE..

--    DELETE..

--    SELECT..

--    COMMIT..

--    INSERT..

--    INSERT..

--    DELETE..

--    GRANT..

--    INSERT..

--    SELECT;


--## 练习8

--1. test表为空表，分析如下语句操作后，最后test表的状态。

--    INSERT INTO test(id,name) values(1, 'a')；
--    INSERT INTO test(id,name) values(2, 'b')；
--    SAVEPOINT s1;
--    INSERT INTO test(id,name) values(3, 'c')；
--    INSERT INTO test(id,name) values(4, 'd')；
--    DELETE FROM test WHERE id in (1,3);
--    ROLLBACK TO s1;
--    DELETE FROM test WHERE id in (2,4);
--    COMMIT;
--    ROLLBACK;
--## 练习9

--分析如下两个会话，执行完每一步时的数据库状态。

--    会话A

--    1.UPDATE EMP SET sal = sal+500 WHERE deptno= 10;



--    3.SELECT sal FROM EMP WHERE deptno = 10;



--    6.COMMIT:

--    8.SELECT sal FROM EMP WHERE deptno = 10;



--    会话B


--    2.SELECT sal FROM EMP WHERE deptno = 10;



--    4.UPDATE EMP SET sal = sal+500 WHERE deptno = 20;

--    5.UPDATE EMP SET sal = sal+1000 WHERE deptno = 10;

--    7.COMMIT;

--## 课后作业


--1.使用如下语句，创建学生表student和班级表class


--    create table student (        --学生表
--                xh char(4),--学号
--                xm varchar2(10),--姓名
--                sex char(2),--性别
--                birthday date,--出生日期
--                sal number(7,2), --奖学金
--                studentcid number(2) --学生班级号
--    )
--    Create table class (   --班级表
--                classid number(2), --班级编号
--                cname varchar2(20),--班级名称
--                ccount  number(3) --班级人数
--    )

--2. 基于上述学生表和班级表，完成如下问题

--（1）添加三个班级信息为：1，JAVA1班，null
--                         2，JAVA2班，null
--                         3，JAVA3班，null

--（2）添加学生信息如下：‘A001’,‘张三’,‘男’,‘01-5月-05’,100,1

--（3）添加学生信息如下：'A002','MIKE','男','1905-05-06',10

--（4）插入部分学生信息： 'A003','JOHN','女’

--（5）将A001学生性别修改为'女‘

--（6）将A001学生信息修改如下：性别为男，生日设置为1980-04-01

--（7）将生日为空的学生班级修改为Java3班

--（8）请使用一条SQL语句，使用子查询，更新班级表中每个班级的人数字段

--3.使用如下语句，建立以下表

--    CREATE TABLE copy_emp   (
--    empno number(4),
--    ename varchar2(20),
--    hiredate date default sysdate ,
--    deptno number(2),
--    sal number(8,2))

--4. 在第三题表的基础上，完成下列问题

--(1)在表copy_emp中插入数据，要求sal字段插入空值，部门号50，参加工作时间为2000年1月1日，其他字段随意

--(2)在表copy_emp中插入数据，要求把emp表中部门号为10号部门的员工信息插入

--(3)修改copy_emp表中数据，要求10号部门所有员工涨20%的工资

--(4)修改copy_emp表中sal为空的记录，工资修改为平均工资

--(5)把工资为平均工资的员工，工资修改为空

--(6)另外打开窗口2查看以上修改

--(7)执行commit，窗口2中再次查看以上信息

--(8)删除工资为空的员工信息

--(9)执行rollback
