--第二章 编写简单的查询语句
--练习一
--1.使用两种方式查询所有员工(EMP)信息

    select * from emp;
    select empno,ename,job,mgr,hiredate,sal,comm,deptno from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-9ce7495255b33239.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.查询(EMP)员工编号、员工姓名、员工职位、员工月薪、工作部门编号。

    select empno,ename,job,sal,deptno from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-ad767f5ad75f8f4a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--练习二
--1.员工转正后，月薪上调20%，请查询出所有员工转正后的月薪。

select ename,sal,sal * 1.2 转正后月薪
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-beeabb35cc91a9a8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.员工试用期6个月，转正后月薪上调20%，
--请查询出所有员工工作第一年的年薪所得（不考虑奖金部分,年薪的试用期6个月的月薪+转正后6个月的月薪)

select ename,sal * 6 + sal * 1.2 * 6 as 第一年年薪
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-eac555b529513931.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--练习三
--1.员工试用期6个月，转正后月薪上调20%，
--请查询出所有员工工作第一年的所有收入（需考虑奖金部分)，
--要求显示列标题为员工姓名，工资收入，奖金收入，总收入。

select ename as 员工姓名,
sal * 6 + sal * 1.2 *6 as 工资收入,
nvl(comm,0) as 奖金收入,
sal * 6 + sal * 1.2 *6 + nvl(comm,0) as 总收入
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-9f9832557dca4ecb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--练习四
--1.员工试用期6个月，转正后月薪上调20%，
--请查询出所有员工工作第一年的所有收入（需考虑奖金部分)，要求显示格式为:XXX的第一年总收入为XXX。

select ename,ename || '的第一年总收入为' || (sal * 6 + sal * 1.2 * 6 + nvl(comm,0)) as 年薪
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-bf98ce4ddd98688a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.查询员工表中一共有哪几种岗位类型。

select distinct job from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-b20ed38d15bc26c2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--课后作业
--1.分别选择员工表、部门表、薪资等级表中的所有数据。

select * from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-f2a9b9a9aca2c284.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

select * from dept;
![](https://upload-images.jianshu.io/upload_images/5227364-dd1057592734ec37.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

select * from salgrade;
![](https://upload-images.jianshu.io/upload_images/5227364-5cc4f799923b653f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

select * from bonus;
![](https://upload-images.jianshu.io/upload_images/5227364-a9362c76a7e3bf7e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.分别查看员工表、部门表、薪资等级表的表结构。
--第三章
--练习一
--1.查询职位为SALESMAN的员工编号、职位、入职日期。

    select empno,job,hiredate from emp
    where job = 'SALESMAN';
![](https://upload-images.jianshu.io/upload_images/5227364-99cc1f36e3e07fb8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.查询1985年12月31日之前入职的员工姓名及入职日期。

    select ename,hiredate from emp
    where hiredate < '31-12月-85';
![](https://upload-images.jianshu.io/upload_images/5227364-18054adac50c503b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--3.查询部门编号不在10部门的员工姓名、部门编号。
select ename,deptno from emp
where deptno not in 10;
![](https://upload-images.jianshu.io/upload_images/5227364-57aacaa9c58373e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--练习二
--1.查询入职日期在82年至85年的员工姓名，入职日期。

    select ename,hiredate from emp
    where hiredate between '01-1月-82' and '31-12月-85';--注写01月会报错。。。
![](https://upload-images.jianshu.io/upload_images/5227364-448e1edb9d135f2a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.查询月薪在3000到5000的员工姓名，月薪。
select ename,sal from emp
where sal between 3000 and 5000;
![](https://upload-images.jianshu.io/upload_images/5227364-24cb153df9674fdb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--3.查询部门编号为10或者20的员工姓名，部门编号。
select ename,deptno
from emp
where deptno in(10,20);
![](https://upload-images.jianshu.io/upload_images/5227364-73fee56e271b5166.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--4.查询经理编号为7902, 7566, 7788的员工姓名，经理编号。

select ename,mgr
from emp
where mgr in(7902,7566,7788);
![](https://upload-images.jianshu.io/upload_images/5227364-673c1ca24354e6c9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--练习三
--1.查询员工姓名以W开头的员工姓名。

select ename 
from emp
where ename like 'W%';
![](https://upload-images.jianshu.io/upload_images/5227364-1cfce5d1c7161953.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.查询员工姓名倒数第2个字符为T的员工姓名。

select ename 
from emp
where ename like '%T_';
![](https://upload-images.jianshu.io/upload_images/5227364-7a293d50fcb796dd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.查询奖金为空的员工姓名，奖金。

select ename,comm
from emp
where comm is null;
![](https://upload-images.jianshu.io/upload_images/5227364-ea453936b108ba7f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--练习四
--1.查询工资超过2000并且职位是MANAGER,或者职位是SALESMAN的员工姓名、职位、工资
select ename,job,sal
from emp
where sal > 2000 and job = 'MANAGER' or job = 'SALESMAN';
![](https://upload-images.jianshu.io/upload_images/5227364-c265fe2b245184e9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--2.查询工资超过2000并且职位是 MANAGER或SALESMAN的员工姓名、职位、工资。
select ename,job,sal
from emp
where sal > 2000 and job in('MANAGER','SALESMAN');
![](https://upload-images.jianshu.io/upload_images/5227364-f6e490acfa66d6bd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.查询部门在10或者20，并且工资在3000到5000之间的员工姓名、部门、工资。

select ename,deptno,sal
from emp
where deptno in(10,20) and sal between 3000 and 5000;
![](https://upload-images.jianshu.io/upload_images/5227364-fafe9e5897013c64.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--4.查询入职日期在81年，并且职位不是SALES开头的员工姓名、入职日期、职位。

select ename,hiredate,job
from emp
where hiredate between '01-1月-81' and '31-12月-81' and job not like 'SALES%';
![](https://upload-images.jianshu.io/upload_images/5227364-f6d3198d2ab2a4cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--5.查询职位为SALESMAN或MANAGER，部门编号为10或者20，姓名包含A的员工姓名、职位、部门编号。

select ename,job,deptno
from emp
where job in('SALESMAN','MANAGER') and deptno in(10,20) and ename like '%A%';
![](https://upload-images.jianshu.io/upload_images/5227364-0baf5b7b6d9fe61c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--练习五
--1.查询部门在20或30的员工姓名，部门编号，并按照工资升序排序。
select ename,deptno,sal
from emp
where deptno in(20,30) order by sal asc;
![](https://upload-images.jianshu.io/upload_images/5227364-06de2d6ac93ff5a9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--2.查询工资在2000-3000之间，部门不在10号的员工姓名，部门编号，工资，并按照部门升序，工资降序排序。

select ename,deptno,sal
from emp
where sal between 2000 and 3000 and deptno not in 10 order by deptno asc,sal desc;
![](https://upload-images.jianshu.io/upload_images/5227364-005158ce69647f24.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--3.查询入职日期在82年至83年之间，职位以SALES或者MAN开头的员工姓名，入职日期，职位，并按照入职日期降序排序。

select ename,hiredate,job
from emp
where hiredate between '01-1月-82' and '31-12月-83' and (job like 'SALES%' or job like 'MAN%')
order by hiredate desc;
![](https://upload-images.jianshu.io/upload_images/5227364-0a47024600192e57.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--课后作业 
--1.查询入职时间在1982-7-9之后，并且不从事SALESMAN工作的员工姓名、入职时间、职位。
select ename,hiredate,job
from emp
where hiredate > '09-7月-82' and job not in 'SALESMAN';
![](https://upload-images.jianshu.io/upload_images/5227364-8c908c3767948708.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.查询员工姓名的第三个字母是a的员工姓名。
select ename
from emp
where ename like '__A%';
![](https://upload-images.jianshu.io/upload_images/5227364-81d9da2684cfb103.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.查询除了10、20号部门以外的员工姓名、部门编号。

select ename,deptno
from emp
where deptno not in(10,20);
![](https://upload-images.jianshu.io/upload_images/5227364-5009cae203be67d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--4.查询部门号为30号员工的信息，先按工资降序排序，再按姓名升序排序。 
select *
from emp
where deptno in 30
order by sal desc,
ename asc;
![](https://upload-images.jianshu.io/upload_images/5227364-fbeed7ed0801147c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--5.查询没有上级的员工(经理号为空)的员工姓名。

select ename
from emp
where mgr is null;
![](https://upload-images.jianshu.io/upload_images/5227364-edf41870f675c9be.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--6.查询工资大于等于4500并且部门为10或者20的员工的姓名\工资、部门编号。

select ename,sal,deptno
from emp
where sal >= 4500 and deptno in(10,20);
![](https://upload-images.jianshu.io/upload_images/5227364-65a6c5b3dc83aafe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

------ 单行函数
--练习1
--1.写一个查询,用首字母大写，其它字母小写显示雇员的 ename，
--显示名字的长度，并给每列一个适当的标签，条件是满足所有雇员名字的开始字母是J、A 或 M 的雇员，
--并对查询结果按雇员的ename升序排序。（提示：使用initcap[将单词首字母大写]、length、substr）

select initcap(ename) as 首字母大写,
length(ename) as 名字长度,
substr(ename,0,1),
substr(ename,1,1),
substr(ename,2,1) 
from emp 
where substr(ename,0,1) in('J','A','m')
order by ename asc;
![](https://upload-images.jianshu.io/upload_images/5227364-7e442a5d7b794ed3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--练习2
--1.查询员工姓名中中包含大写或小写字母A的员工姓名。

select ename,
instr(ename,'a'),
instr(ename,'A')
from emp
where instr(ename,'a') <> 0 or instr(ename,'A') <> 0;
![](https://upload-images.jianshu.io/upload_images/5227364-d4d65ea74586247a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--2.查询部门编号为10或20，入职日期在81年5月1日之后，
--并且姓名中包含大写字母A的员工姓名，员工姓名长度（提示，要求使用INSTR函数，不能使用like进行判断)

select ename,
length(ename),
hiredate,
deptno,
instr(ename,'A')
from emp
where deptno in(10,20) and
hiredate > '01-5月-81' and
instr(ename,'A') <> 0;
![](https://upload-images.jianshu.io/upload_images/5227364-2e22b29589c47e07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.查询每个职工的编号,姓名，工资
--要求将查询到的数据按照一定的格式合并成一个字符串.
--前10位：编号,不足部分用*填充,左对齐
--中间10位：姓名，不足部分用*填充,左对齐
--后10位：工资，不足部分用*填充,右对齐

select deptno,
ename,
sal,
lpad(deptno,10,'*'),
lpad(ename,10,'*'),
rpad(sal,10,'*')  
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-dc1877dd091490b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



--练习3
--1.写一个查询，分别计算100.456 四舍五入到小数点后第2位，第1位，整数位的值。
select round(100.456,2),
round(100.456,1),
round(100.456,0)
from dual;
![](https://upload-images.jianshu.io/upload_images/5227364-0cabb121c4bae720.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



--2.写一个查询，分别计算100.456 从小数点后第2位，第1位，整数位截断的值。
select trunc(100.456,2),
trunc(100.456,1),
trunc(100.456,0)
from dual;
![](https://upload-images.jianshu.io/upload_images/5227364-963a51be44d89c17.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--练习4
--1.查询每个员工截止到现在一共入职多少天？
select ename,trunc(sysdate - hiredate) as 到现在入职的天数 
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-a88569ce6da99300.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.当前日期为2015年，指定日期格式为DD-MON-RR,指定日期为01-1月-01，该日期实际所代表的日期为？



--3.当前日期为2015年，指定日期格式为DD-MON-RR,指定日期为01-1月-95，该日期实际所代表的日期为？
--4.当前日期为1998年，指定日期格式为DD-MON-RR,指定日期为01-1月-01，该日期实际所代表的日期为？
--5.当前日期为1998年，指定日期格式为DD-MON-RR,指定日期为01-1月-95，该日期实际所代表的日期为？
--6.当前日期为2015年，指定日期格式为DD-MON-YY,指定日期为01-1月-01，该日期实际所代表的日期为？
--7.当前日期为1998年，指定日期格式为DD-MON-YY,指定日期为01-1月-95，该日期实际所代表的日期为？

--练习5
--1.查询服务器当前时间
select * from user_tables;

select sysdate 
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-3314c097d872a304.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.查询部门10,20的员工截止到2000年1月1日，工作了多少个月，入职的月份。(提示：使用months_between,extract)

select hiredate,
trunc(months_between('01-1月-00',hiredate)) 工作月数,
extract(month from hiredate)
from emp
where deptno in(10,20);
![](https://upload-images.jianshu.io/upload_images/5227364-56f411f2be6cd167.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.如果员工试用期6个月，查询职位不是MANAGER的员工姓名，
--入职日期，转正日期，入职日期后的第一个星期一,入职当月的最后一天日期。
--（提示：使用add_months,next_day,last_day)

select hiredate as 入职日期,
add_months(hiredate,6) as 转正日期,
next_day(hiredate,'星期一') as 入职后的第一个星期一,
last_day(hiredate) as 入职当月的最后一天日期
from emp
where job not in 'MANAGER';
![](https://upload-images.jianshu.io/upload_images/5227364-f4a5ad5261c9f752.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



--练习6
--1.显示服务器系统当前时间，格式为2007-10-12 17:11:11(提示：使用to_char函数)

select sysdate,
to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') 
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-61ef77af8f1040e5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.显示ename、hiredate 和 雇员开始工作日是星期几，列标签DAY(提示：使用to_char函数)
select ename,hiredate,to_char(hiredate,'DAY') as DAY
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-7f13da7187c51017.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.查询员工姓名，工资，格式化的工资（￥999,999.99） (提示：使用to_char函数)

select ename,sal,to_char(sal,'$99,999')
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-7121ef1c67c7494a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--4.把字符串2015-3月-18 13:13:13 转换成日期格式，并计算和系统当前时间间隔多少天。 (提示：使用to_date函数)

select to_date('2015-3月-18 13:13:13','yyyy-mm"月"-dd hh24:mi:ss') as 日期,
trunc(sysdate-to_date('2015-3月-18 13:13:13','yyyy-mm"月"-dd hh24:mi:ss')) as 相差的天数
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-735cfabfb12553d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--课后作业
--1.计算2000年1月1日到现在有多少月，多少周（四舍五入）。

select round(months_between(sysdate,'01-1月-00')),
round(months_between(sysdate,'01-1月-00')*30/7)
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-5cf56dbdcfedca08.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.查询员工ENAME的第三个字母是A的员工的信息(使用2个函数)。

select ename,instr(ename,'A',3,1)
from emp
where instr(ename,'A',3,1) = 3;--从第三个位置开始第一次出现的位置
![](https://upload-images.jianshu.io/upload_images/5227364-57cf05cd81880442.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

select ename,substr(ename,3,1)
from emp
where substr(ename,3,1) in 'A';--从第三个位置开始截取一个字符串
![](https://upload-images.jianshu.io/upload_images/5227364-baa62e501610cf2a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.使用trim函数将字符串‘hello’、‘  Hello ’、‘bllb’、‘ hello    ’
--分别处理得到下列字符串ello、Hello、ll、hello。
select trim(leading 'h' from 'hello'),
trim(both ' ' from ' Hello '),
trim(both 'b' from 'bllb'),
trim(trailing ' ' from 'hello    ')
from dual;
![](https://upload-images.jianshu.io/upload_images/5227364-c8327f78452f230c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--4.将员工工资按如下格式显示：123,234.00 RMB 。
select sal,to_char(sal,'$99,999')
from emp;--这题我只能写成这样。。。若有人解出来。。请务必告知呀
![](https://upload-images.jianshu.io/upload_images/5227364-cd5e2aed44eaa5dd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--5.查询员工的姓名及其经理编号，要求对于没有经理的显示“No Manager”字符串。
select ename,mgr,nvl(to_char(mgr),'No Manager')
from emp; -- 据说 nvl()里两参数必须是同一类型。。否则。。错死你 ^o^
![](https://upload-images.jianshu.io/upload_images/5227364-58122c1d20d51a8f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--6.将员工的参加工作日期按如下格式显示：月份/年份。 
select hiredate,
extract(month from hiredate) || '/' || extract(year from hiredate) as "月份/年份"
from emp;

select hiredate,to_char(hiredate,'mm/yyyy') as "月份/年份"
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-492f68284a8b16bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--7.在员工表中查询出员工的工资，并计算应交税款：如果工资小于1000,税率为0，
--如果工资大于等于1000并小于2000，税率为10％，如果工资大于等于2000并小于3000，
--税率为15％，如果工资大于等于3000，税率为20％。
select ename,sal,
case
  when sal < 1000 then 0
    when sal >=1000 and sal < 2000 then (sal-1000)*0.1
      when sal >=2000 and sal <3000 then 1000 * 0.1 + (sal - 2000) * 0.15
        when sal > 3000 then 1000 * 0.1 + 1000 * 0.15 + (sal - 3000) * 0.2
          else 0
            end as 税款
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-11ff88c807d7af02.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--8.创建一个查询显示所有雇员的 ename和 sal。格式化sal为 15 个字符长度，用 $ 左填充，列标签 SALARY。

select ename,sal,lpad(sal,15,'$') as SALARY
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-ec00b23990449574.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


