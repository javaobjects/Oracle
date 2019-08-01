------------------第三章  限制数据与对数据排序--------------

------------------普通的比较运算符------------------

--最简单的限制语句（where）
--输出emp表中部门编号为10的员工
--执行顺序  先from 后where 再到select（复杂度小于n+n）
select * from emp where  deptno = 10;

--比较字符型数据
--找出emp表中job为SALESMAN的员工
select * from emp where job = 'SALESMAN';
select * from emp where job = 'SALESman';  --找不到相应的数据，引号中数据是区分大小写的

--比较日期型数据
--找出入职日期大于1981年1月1号的员工
--RR日期格式 Oracle默认定义的日期格式  DD-MON-RR  DD是第几天 MON是几月（月字要写进去） RR是年份的后两位
select * from emp where hiredate > '01-1月-81';

--1.查询职位为SALESMAN的  员工编号、职位、入职日期。
select empno,job,hiredate from emp where job = 'SALESMAN';

--2.查询1985年12月31日之前入职的 员工姓名及入职日期。
select ename,hiredate from emp where hiredate < '31-12月-85';

--3.查询部门编号不在10部门的 员工姓名、部门编号。
select ename,deptno from emp where deptno != 10;



------------------特殊的条件运算符------------------

--between...and...(包含边界)
--找出emp表中工资为1000到3000的员工
select * from emp where sal between 1000 and 3000;
--使用and运算符也可以达到同样的效果
select * from emp where sal >= 1000 and sal <= 3000;


--in运算符   语法in（集合）   满足集合中的某一个条件则改行就会被选中,集合中的值用逗号隔开
--想找出emp表中job为‘SALESMAN’或者是‘MANAGER’的员工
select * from emp where job in('SALESMAN','MANAGER');
--or运算符也可以达到这样的效果
select * from emp where job = 'SALESMAN' or job = 'MANAGER';
select * from emp where job = 'SALESMAN' or 'MANAGER';   --error

--1.查询入职日期在82年至85年的  员工姓名，入职日期。
select ename,hiredate from emp where hiredate between '01-1月-82' and '31-12月-85';

--2.查询月薪在3000到5000的 员工姓名，月薪。
select ename,sal from emp where sal between 3000 and 5000;

--3.查询部门编号为10或者20的员工姓名，部门编号。
select ename,deptno from emp where deptno in(10,20);

--4.查询经理编号为7902, 7566, 7788的员工姓名，经理编号
select ename,mgr from emp where mgr in(7902,7566,7788);


--like运算符
--like后面用单引号括起来的字符串也是区分大小写的
--配合两个通配符使用   
       -- %  ：  代表任意字符
       --  _  ：  代表一个字符
--找出emp表中名字为S开头的员工
select * from emp where ename like 'S%';

--找出emp表中名字倒数第二位为T的员工
select * from emp where ename like '%T_'; 

--找出job为‘MAN_’开头的员工 
select * from emp where job like 'MAN@_%' escape '@';


--is null运算符
--找出emp表中没有奖金的员工
select * from emp where comm is null;
select * from emp where comm = null;   --错误的写法,找不到想要的数据

--1.查询员工姓名以W开头的员工姓名。
--2.查询员工姓名倒数第2个字符为T的员工姓名。
--3.查询奖金为空的员工姓名，奖金。




------------------逻辑运算符------------------
--and运算符
--找出emp表中job为‘MANAGER’并且工资大于1500的员工
select * from emp where job = 'MANAGER' and sal >1500;

--or运算符(满足任意一个条件都可以输出)
--找出emp表中job为'CLERK' 或者 部门是 10部门的员工
select * from emp where job = 'CLERK' or deptno = 10;

--not运算符(可以配合前面的特殊比较运算符使用)
--not 配合  between ... and ...
--想找出工资不在1000到3000内的员工
select * from emp where sal not between 1000 and 3000;

--not 配合in运算符
--想找出部门不为10或者是20的员工
select * from emp where deptno not in(10,20);

--not 配合like运算符
--想找出名字不为S开头的员工
select * from emp where ename not  like 'S%';

--not 配合 is null运算符(is not null 单词顺序不要改变)
--找出有奖金的员工
select * from emp where comm is not null;

--优先级问题(括号可以强行改变优先级   and先执行  or后执行)
--找出岗位为‘SALESMAN’ 并且 入职日期大于82年  或者  部门编号为30的员工
select * from emp where job = 'SALESMAN' and hiredate > '01-1月-82' or deptno = 30;

--1.查询工资超过2000并且职位是MANAGER,或者职位是SALESMAN的 员工姓名、职位、工资
select ename,job,sal from emp where sal > 2000 and job = 'MANAGER' or job = 'SALESMAN';


--2.查询工资超过2000并且职位是 MANAGER或SALESMAN的 员工姓名、职位、工资。
select ename,job,sal from emp where sal >2000 and (job = 'MANAGER' or job = 'SALESMAN');
select ename,job,sal from emp where sal >2000 and job in('MANAGER','SALESMAN');


--3.查询部门在10或者20，并且工资在3000到5000之间的员工姓名、部门、工资。
select ename,deptno,sal from emp where deptno in(10,20) and sal between 3000 and 5000;


--4.查询入职日期在81年，并且职位不是SALES开头的员工姓名、入职日期、职位。
select ename,hiredate,job from emp where hiredate between '01-1月-81' and '31-12月-81' and job not like 'SALES%';

--5.查询职位为SALESMAN或MANAGER，部门编号为10或者20，姓名包含A的员工姓名、职位、部门编号。
select ename,job,deptno from emp where job in('SALESMAN','MANAGER') and deptno in(10,20) and ename like '%A%';


--对数据排序（order by）
--想输出emp表的信息，根据工资降序排序(asc升序（默认升序），desc降序)
--降序的时候空值排到最大值的上面
select * from emp order by sal desc;

--输出emp表的信息，根据工资升序排序
--升序的时候空值排到最大值的下面
select * from emp order by sal asc;
select * from emp order by sal;    --默认升序排序

--多列排序
--先对第一列做排序，第二列在第一列的重复的那段作分段排序
--想对emp表中job，mgr列按照升序排序
--对字符的排序是按照字典序来排的
select * from emp order by job asc,mgr desc;

--利用select列的位置作书写来排序
select empno,ename,job,mgr from emp order by 3 asc,4 desc;

--order by 写到最后面
--1.查询部门在20或30的 员工姓名，部门编号，并按照工资升序排序。
select ename,deptno from emp where deptno in(20,30) order by sal asc;

--2.查询工资在2000-3000之间，部门不在10号的员工姓名，部门编号，工资，并按照部门升序，工资降序排序。
select ename,deptno,sal from emp where sal between 2000 and 3000 and deptno <> 10 order by deptno asc,sal desc;

--3.查询入职日期在82年至83年之间，职位以SALES或者MAN开头的员工姓名，入职日期，职位，并按照入职日期降序排序。
select ename,hiredate,job from emp 
where hiredate between '01-1月-81' and '31-12月-83' and (job like 'SALES%' or job like 'MAN%') 
order by hiredate desc;

--1.查询入职时间在1982-7-9之后，并且不从事SALESMAN工作的  员工姓名、入职时间、职位。
select ename,hiredate,job from emp where hiredate > '09-7月-82' and job <> 'SALESMAN';

--2.查询员工姓名的第三个字母是a的员工姓名。
select ename from emp where ename like '__A%';

--3.查询除了10、20号部门以外的员工姓名、部门编号。
select ename,deptno from emp where deptno not in(10,20);


--4.查询部门号为30号员工的信息，先按工资降序排序，再按姓名升序排序。 
select * from emp where deptno = 30 order by sal desc,ename;

--5.查询没有上级的员工(经理号为空)的员工姓名。
select ename from emp where mgr is null;


--6.查询工资大于等于4500并且部门为10或者20的员工的姓名\工资、部门编号。
select ename,sal,deptno from emp where sal >= 4500 and deptno in(10,20);

select ename,sal,deptno from emp where sal >= 4500 and (deptno = 10 or deptno = 20);


--测试用的语句
select *  from emp;
