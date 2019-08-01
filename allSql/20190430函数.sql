--单行函数
--字符函数
--lover 将字符全部转为小写
select ename,lower(ename) from emp;
select ename from emp where lower(ename) like '%s%';
--upper 将字符全部转为大写
select upper(ename) from emp;
select ename from emp where upper(ename) like '%s%';
--initcap--将字符首字母转为大写,其它字母变成小写
select initcap(ename) from emp;

select 'Sql course',initcap('sql sourse') from dual;--dual伪表
--concat 连接两个值 等同于 ||
select ename || '的工资是' || sal from emp;
select concat(concat(ename,'的工资是'),sal) from emp;
-- substr --截取字符串子串,默认下标1开始
select 'wuyuehong@qq.com',substr('wuyuehong@qq.com',3),
substr('wuyuehong@qq.com',10,3) from dual;
--length -- 取字符串长度
select ename,length(ename) from emp;
--1.写一个查询,用首字母大写，其它字母小写显示雇员的 ename，显
--示名字的长度，并给每列一个适当的标签，条件是满足所有雇员名字
--的开始字母是J、A 或 M 的雇员，并对查询结果按雇员的ename升序
--排序。

select initcap(ename) 首字母大写, length(ename) 名字长度
from emp
where initcap(ename) like 'J%' or initcap(ename) like 'A%' or initcap(ename) like 'M%'
order by ename;
--字符处理函数
-- instr 参数 一是目标字符串，参数二子串，参数三开始索引，参数四 第几次出现
select 'wuyuehong@qq.com',
instr('wuyuehong@qq.com','@',9),
instr('wuyuehong@qq.com','.',1,2) from dual;
--lpad--补充字符串(左）
--参数一 目标字符串，参数二 返回字符长度 参数三 填充字符串
select ename,lpad(ename,10,'aa'),length(ename) from emp;
--rpad--被充字符串（右）
select ename,rpad(ename,10,'aa'),rpad(ename,10,'aa'),length(ename) from emp;
--trim()--默认去字符串首尾空格 
--去掉指定字符串,默认去掉首尾指定子串
select '    sql sourse   ',trim('    sql sourse   ') from dual;
select 'hsql sourseh',trim('h' from 'hsql sourseh') from dual;
select 'hsql sourseh',trim(both 'h' from 'hsql sourseh') from dual;
select 'hsql sourseh',trim(leading 'h' from 'hsql sourseh') from dual;
select 'hsql sourseh',trim(trailing 'h' from 'hsql sourseh') from dual;
--replace 字符替换函数
--REPLACE(s1,s2,s3) 
--参数一 目标字符串 参数二目标字符子串 参数三替换字符串
select 'hsql sourseh',replace('hsql sourseh','hs','a') from dual;
select 'hsql sourseh',replace('hsql sourseh',' ','') from dual;
--1.查询员工姓名中中包含大写或小写字母A的员工姓名。

--2.查询部门编号为10或20，入职日期在81年5月1日之后，
--并且姓名中包含大写字母A的员工姓名，员工姓名长度（提示，要求使用INSTR函数，不能使用like进行判断)
select * from emp where 
deptno in(10,20) and instr(ename,'A') != 0;


select ename,length(ename) from emp 
where instr(ename,'A') > 0 and hiredate > '01-5月-81' and deptno in(10,20);


--3.查询每个职工的编号,姓名，工资
--要求将查询到的数据按照一定的格式合并成一个字符串.
--前10位：编号,不足部分用*填充,左对齐
--中间10位：姓名，不足部分用*填充,左对齐
--后10位：工资，不足部分用*填充,右对齐

------
--数值函数
--round 四舍五入 -- 参数一目标数值 参数  保留多少位
select 45.926,round(45.926)
,round(45.926,2),
round(45.926,0),
round(45.926,-1),
round(45.926,-2) from dual;
--trunc()截取-- 参数一目标数值 参数  保留多少位
select 45.926,trunc(45.926),
trunc(45.926,2),
trunc(45.926,0),
trunc(45.926,-1),
trunc(45.926,-2) from dual;
--mod 取余数 ，取模
select 12,mod(12,5) from dual;--2
--日期函数
--sysdate返回当前系统日期
select sysdate from dual;
--日期的运算
--加减 后面数值默认是天
select sysdate+2 from dual;
select sysdate-180 from dual;
--1.查询每个员工截止到现在一共入职多少天？
--2.当前日期为2015年，指定日期格式为DD-MON-RR,指定日期为01-1月-01，该日期实际所代表的日期为？

--3.当前日期为2015年，指定日期格式为DD-MON-RR,指定日期为01-1月-95，该日期实际所代表的日期为？

--4.当前日期为1998年，指定日期格式为DD-MON-RR,指定日期为01-1月-01，该日期实际所代表的日期为？

--5.当前日期为1998年，指定日期格式为DD-MON-RR,指定日期为01-1月-95，该日期实际所代表的日期为？

--6.当前日期为2015年，指定日期格式为DD-MON-YY,指定日期为01-1月-01，该日期实际所代表的日期为？

--7.当前日期为1998年，指定日期格式为DD-MON-YY,指定日期为01-1月-95，该日期实际所代表的日期为？
--months_between 返回两个日期类型数据之间间隔的自然月数
select months_between(hiredate,sysdate),
months_between(sysdate,hiredate) from emp;
--add_months 添加月数
select hiredate,add_months(hiredate,6) as 转正日期 from emp;
--next_day
select next_day(sysdate,'星期二') from emp;
--last_day 返回指定日期当月最后一天的日期
select last_day('01-2月-81') from dual;
--round(date,fmt) 按照指 定格式四舍五入获得日期
select hiredate,round(hiredate,'MM') from emp;--按月份四舍五入 找天 大于15月份加1
select hiredate,round(hiredate,'YY') from emp;--按照年四舍五入 找月 大于6年加1
select hiredate,round(hiredate,'DD') from emp;--按照日四舍五入
--trunc(data,fmt)截取日期 按照指定格式 截取获得日期
select hiredate,trunc(hiredate,'MM') from emp;
select hiredate,trunc(hiredate,'YY') from emp;
select hiredate,trunc(hiredate,'DD') from emp;

--extract 抽取指定格式日期year month
select sysdate,extract(month from sysdate) from emp;

--1.查询服务器当前时间
select sysdate from dual;
--2.查询部门10,20的员工截止到2000年1月1日，工作了多少个月，
--入职的月份。(提示：使用months_between,extract)
select hiredate as 入职日期,
extract(month from hiredate) as 入职月份,
months_between('01-1月-00',hiredate) as 工作月份
 from emp where deptno in(10,20);

--3.如果员工试用期6个月，查询职位不是MANAGER的员工姓名，
--入职日期，转正日期，入职日期后的第一个星期一,入职当月的最后一天日期。
--（提示：使用add_months,next_day,last_day)

select ename as 员工姓名,
hiredate as 入职日期,
add_months(hiredate,6) 转正日期,
next_day(hiredate,'星期一') as 入职日期后的第一个星期一,
last_day(hiredate)as 入职当月的最后一天日期
from emp where job not in('MANAGER');

select ename 员工姓名, hiredate 入职日期, add_months(hiredate,6) 转正日期, 
       next_day(hiredate,'星期一') 第一个星期一, last_day(hiredate) 
from emp where job <> 'MANAGER';--kaiqingli

--转化函数
--隐式转换
select sal,sal+12.0 from emp;
select sal,sal+'10' from emp;
--显示转换
--to_char 日期转为字符类型
select hiredate,to_char(hiredate,'yy-mm-dd') from emp;
select hiredate,to_char(hiredate,'yyyy-mm-dd') from emp;
select hiredate,to_char(hiredate,'yyyy/mm/dd') from emp;
select hiredate,to_char(hiredate,'yyyy"年"mm"月"dd"日"') from emp;
select hiredate,to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from emp;
select hiredate,to_char(sysdate,'yyyy-mm-dd hh12:mi:ss') from emp;
--to_char 用于数值型 
select 12343434.789 from dual;
select to_char('$12343434.789') from dual;
--to_number 字符内型转换为数值类型
select saL,sal+'10' from emp;--隐式转换
select to_number('123.4')+3 from dual;--显示转换
--to_date 字符类型转为日期类型
select to_date('2018-03-01','YY/MM/DD') from dual;
--1.显示服务器系统当前时间，格式为2007-10-12 17:11:11(提示：使用to_char函数)
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from emp;
--2.显示ename、hiredate 和 雇员开始工作日是星期几，列标签DAY(提示：使用to_char函数)
select ename as 员工姓名,
hiredate as 入职日期,
to_char(hiredate,'day') as day
from emp;
--3.查询员工姓名，工资，格式化的工资（￥999,999.99） (提示：使用to_char函数)
select ename,sal,
to_char(sal,'')
from emp;
--4.把字符串2015-3月-18 13:13:13 转换成日期格式，并计算和系统当前时间间隔多少天。 (提示：使用to_date函数)
select to_date('2015-3月-18 13:13:13','YY-MM"月"-DD hh24:mi:ss'),
trunc(sysdate - to_date('2015-3月-18 13:13:13','YY-MM"月"-DD hh24:mi:ss'))
 from dual;
--通用函数
--nvl 参数一目标对象 参数二替代值
select comm,nvl(comm,0) from emp;
-- nvl2 参数一目标对象 参数二 参数三代替值 
select comm,nvl2(comm,'有奖金',0) from emp;
select comm,nvl2(comm,'有奖金','无') from emp;
--nullif 参数一与参数二进行比较如果相等返回空，否则返回参数一
--参数一与参数二类型必须一致
select nullif(1,'1') from dual;--数值类型不一致
select nullif(1,1) from dual;--null
select nullif(1,2) from dual;--1
--coalesce函数
select coalesce(123) from dual;--函数没有足够的参数
select coalesce(null,null,3,4,2) from dual;
select coalesce(null,null,comm,4,2) from emp;
------
--case --decode用来进行条件判断输出映射结果
------
select * from emp;
select * from dept;
select ename,hiredate,deptno,
       case deptno
         when 10 then '研发部'
         when 20 then '生产部'  
         when 30 then '财务部'
           else '无'
             end as 部门
       from emp;      
--decode
select ename,hiredate,deptno,
       decode(deptno,10,'研发部',20,'生产部',30,'财务部','无') as 部门
       from emp;     
-----------------
--函数嵌套
--注意：函数的嵌套最里的那一层先执行
----------------
select ename,nvl(to_char(mgr),'无经理') from emp;
--1.计算2000年1月1日到现在有多少月，多少周（四舍五入）。
select months_between(sysdate,'01-1月-00') as 月,
round(months_between(sysdate,'01-1月-00')*30/7) as 周
from dual;

--2.查询员工ENAME的第三个字母是A的员工的信息(使用2个函数)。
select * from emp where ename like '__A%';



--3.使用trim函数将字符串‘hello’、‘  Hello ’、‘bllb’、‘ hello  
--  ’分别处理得到下列字符串ello、Hello、ll、hello。
select trim('h' from 'hello'),
       trim(' ' from ' Hello '),
       trim('b' from 'bllb'),
       trim(' ' from ' hello ')
 from dual;

--4.将员工工资按如下格式显示：123,234.00 RMB 。
select ename,sal,to_char(sal,'$99,99.99') from emp;
--5.查询员工的姓名及其经理编号，要求对于没有经理的显示“No Manager”字符串。
select ename,mgr,nvl(to_char(mgr),'NO Manager') from emp;

--6.将员工的参加工作日期按如下格式显示：月份/年份。 

--7.在员工表中查询出员工的工资，并计算应交税款：
--如果工资小于1000,税率为0，如果工资大于等于1000并小于2000，
--税率为10％，如果工资大于等于2000并小于3000，税率为15％，如果工资大于等于3000，税率为20％。
select sal,ename,
       case 
         when sal<1000 then 0
           when sal >= 1000 and sal < 2000 then (sal-1000)*0.1
             when sal >= 2000 and sal < 3000 then 1000*0.1 + (sal - 2000) * 0.15
               when sal >= 3000 then 1000*0.1 + 1000*0.15+(sal-3000)*0.2
                 end as 税收
                 from emp;

--8.创建一个查询显示所有雇员的 ename和 sal。格式化sal为 15 个字符长度，用 $ 左填充，列标签 SALARY。






select * from emp;
