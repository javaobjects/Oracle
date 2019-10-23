--------------------------------------------------------------------------
-- 字符函数 
--------------------------------------------------------------------------
----------------
--大小写转换函数  lower   upper   initcap  
----------------
--lower() 转小写
select empno,ename,job from emp where ename like 'a%' or ename like 'A%';
select empno,ename,job,lower(ename),lower(job) from emp where lower(ename) like 'a%';--根据列名转换

select 'SQL Course',lower('SQL Course') from dual;--根据变量或表达式转换  dual伪表 一行N列   sql course

--upper() 转大写
select 'SQL Course',upper('SQL Course') from dual;--SQL COURSE

--initCap() 首字母大写
select 'sql course',Initcap('sql course') from dual;--Sql Course

----------------
--字符处理函数  concat   substr  length   instr   lpad  rpad  trim  replace
----------------
--concat(参数一，参数二) 拼接字符串
select ename || ' 的职位是 ' || job from emp;  --SMITH 的职位是 CLERK

select concat(ename,' 的职位是 ',job) from emp;--not ok 参数个数无效
select concat(concat(ename,' 的职位是 '),job) from emp;--ok

--substr(参数一，参数二[,参数三]) 截取字符串,下标从1开始
--   参数一：待截取的目标字符串
--   参数二：开始位置
--   参数三：截取长度，可省略，默认长度到最后
select substr('zr@neusoft.com',3) from dual;  --@neusoft.com
select substr('zr@neusoft.com',1,2) from dual;--zr

select substr('zr@neusoft.com',-4) from dual; --.com
select substr('zr@neusoft.com',-3) from dual; --com

--length() 获取字符串的长度
select empno,ename,length(ename) from emp;

select length('12ab中文') from dual;  --6

1.写一个查询,用首字母大写，其它字母小写显示雇员的 ename，
显示名字的长度，并给每列一个适当的标签(别名)，
条件是满足所有雇员名字的开始字母是J、A 或 M 的雇员，并对查询结果按雇员的ename升序排序。
（提示：使用initcap、length、substr）
select initCap(ename) 员工姓名,length(ename) 姓名长度 from emp where substr(ename,1,1) in('J','A','M');
select initCap(ename) 员工姓名,length(ename) 姓名长度 from emp where ename like 'A%' or ename like 'J%' or ename like  'M%';

--instr(参数一，参数二[,参数三][,参数四]) 查找指定字符的下标,如果字符不存在，返回0
--     参数一：待查找的目标字符串
--     参数二：查找的字符是谁
--     参数三：开始位置,默认从1开始
--     参数四：第N次出现的位置
select instr('zr@neusoft.com','@') from dual; --3
select instr('zhaorong@neusoft.com','@') "@符号的下标",
       substr('zhaorong@neusoft.com',1,instr('zhaorong@neusoft.com','@')-1) 邮箱前缀 from dual; --3,zhaorong
       
select instr('sql course','s') from dual; --1
select instr('sql course','s',3) from dual; --9
select instr('sql courses','s',3,2) from dual; --11

--lpad 左补全   V0000007369
select empno,'V' || lpad(empno,10,'0') from emp;     --V0000007369  假定长度为10，不足补0
select empno,concat('V',lpad(empno,10,'0')) from emp;--V0000007369

--rpad 右补全
select ename,rpad(ename,10,'*') from emp;--SMITH*****

--trim() 去首尾字符，默认去首尾空格
select ' SQL Course ',trim(' SQL Course ') from dual;--默认去首尾空格
select 'ISQL CourseI',trim(leading 'I' from 'ISQL CourseI') from dual;--SQL CourseI 去首部字符
select 'ISQL CourseI',trim(trailing 'I' from 'ISQL CourseI') from dual;--ISQL Course 去尾部字符
select 'ISQL CourseI',trim(both 'I' from 'ISQL CourseI') from dual;--SQL Course   去首尾字符

--replace(参数一，参数二，参数三) 替换字符串
--     使用参数三替换参数二的值                
select ' SQL Course ',replace(' SQL Course ',' ','') from dual;
select replace('发表一个评论，中间带了敏感字符，谈到了党与习大大','习大大','***') from dual;

--练习
1.查询员工姓名中包含大写或小写字母A的员工姓名。
select empno,ename from emp where ename like '%a%' or ename like '%A%';
select empno,ename from emp where lower(ename) like '%a%';
select empno,ename,lower(ename) from emp where instr(lower(ename),'a') > 0;

2.查询部门编号为10或20，入职日期在81年5月1日之后，并且姓名中包含大写字母A的员工姓名，员工姓名长度（提示，要求使用INSTR函数，不能使用like进行判断)
select ename,length(ename) from emp where deptno in(10,20) and hiredate > '1-5月-81' and instr(ename,'A') >0 ;

3.查询每个职工的编号,姓名，工资
要求将查询到的数据按照一定的格式合并成一个字符串.
前10位：编号,不足部分用*填充,左对齐
中间10位：姓名，不足部分用*填充,左对齐
后10位：工资，不足部分用*填充,右对齐
select rpad(empno,10,'*') || rpad(ename,10,'*') || lpad(sal,10,'*') from emp;

--------------------------------------------------------------------------
-- 数值函数 
--------------------------------------------------------------------------
--round() 四舍五入
select round(45.926),round(45.926,2) from dual;      --46   45.93
select round(455.926,-1),round(455.926,-2) from dual;--460	500
select round(445.926,-1),round(445.926,-2) from dual;--450  400

--trunc() 截断数字
select trunc(45.926),trunc(45.926,2) from dual;      --45   45.92
select trunc(455.926,-1),trunc(455.926,-2) from dual;--450	400
select trunc(445.926,-1),trunc(445.926,-2) from dual;--440  400

--mod() 取余，求模
select mod(10,3) from dual;--1

--------------------------------------------------------------------------
-- 日期函数 
--     日期加减运算时，单位以"天"来计算
--------------------------------------------------------------------------
--sysdate 返回系统当前日期
select sysdate from dual; --2019/8/20 14:48:53

1.查询员工的入职日期，转正日期(6个月试用期)，入职天数，入职星期数等
select empno,
       ename,
       hiredate 入职日期,
       hiredate + (6 * 30) 转正日期,
       (sysdate - hiredate) 入职天数,
       (sysdate - hiredate)/7 入职星期数
  from emp;

--months_between：返回两个日期类型数据之间间隔的自然月数
1.查询员工的入职日期，入职月数
select empno,ename,hiredate 入职日期,months_between(sysdate,hiredate) 入职月数 from emp
select months_between('1-12月-81','15-8月-81') from dual; --3.54838709677419
 
--add_months：返回指定日期加上相应的月数后的日期
1.查询员工的入职日期，转正日期(6个月试用期)
select empno,ename,hiredate 入职日期,add_months(hiredate,6) 转正日期  from emp;

--next_day：返回某一日期的下一个指定日期 
select next_day(sysdate,'星期二') from dual;--2019/8/27 15:10:30

--last_day：返回指定日期当月最后一天的日期
select last_day(sysdate) from dual;--2019/8/31 15:11:10

--round：四舍五入日期
select sysdate,         --2019/8/20 15:12:23
       round(sysdate),   --2019/8/21  根据1-12 与13-24小时制判断
       round(sysdate,'year'),  --2020/1/1  根据1-6 与 7-12月份判断
       round(sysdate,'month'), --2019/9/1   根据1-15 与 16-30天数判断
       round(sysdate,'day')    --2019/8/18  根据1-3 与 4-7 星期判断
from dual;


--trunc：截断日期
select sysdate,         --2019/8/20 15:12:23
       trunc(sysdate),   --2019/8/20
       trunc(sysdate,'year'),  --2019/1/1
       trunc(sysdate,'month'), --2019/8/1
       trunc(sysdate,'day')    --2019/8/18
from dual;

--extract 抽取年、月、日
select sysdate,
       extract(year from sysdate) 年份, --2019
       extract(month from sysdate) 月份,--8
       extract(day from sysdate) 日     --20
  from dual;

--------------------------------------------------------------------------
-- 转换函数   to_char()  to_date()  to_number()
--------------------------------------------------------------------------
--to_char() 用于日期型  日期 -> 字符
select sysdate from dual;          --2019/8/20 15:51:12
select to_char(sysdate) from dual; --20-8月 -19

select to_char(sysdate,'yyyy/mm/dd hh12:mi:ss') from dual; --2019/08/20 03:53:10    hh12十二小时制
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') from dual; --2019/08/20 15:53:33    hh24二十四小时制

select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual; --2019-08-20 15:54:11

select to_char(sysdate,'yyyy年mm月dd日 hh24:mi:ss') from dual; --not ok 日期格式无法识别 ,汉字需要使用"" 双引号括起来 
select to_char(sysdate,'yyyy"年"mm"月"dd"日" hh24:mi:ss') from dual; --ok 2019年08月20日 15:56:09

select 
       to_char(sysdate,'year'), --twenty nineteen
       to_char(sysdate,'month'),--8月
       to_char(sysdate,'day'),  --星期二
       to_char(sysdate,'dy'),   --星期二
       to_char(sysdate,'am'),    --下午
       to_char(sysdate,'yyyy-mm-dd hh24:mi:ss day am')--2019-08-20 15:59:08 星期二 下午
from dual;

--TO_CHAR 用于数值型  数值 -> 字符
--        注意：进行数字类型到字符型转换时，格式中的宽度一定要超过实际列宽度，否则会显示为###。 
select to_char(123.456) from dual;   --123.456
select to_char(123456789.125456,'$999,999,999.99') from dual;--$123,456,789.13
select to_char(123456789.125456,'L999,999,999.99') from dual;--￥123,456,789.13

select to_char(123456789.125456,'L0999,999,999,999.99') from dual;--￥0000,123,456,789.13

select to_char(123456789.125456,'L999,999.99') from dual;--#####################

--to_number 字符 -> 数值
select '123.456' + 100 from dual;  --223.456
select to_number('123.456') + 100 from dual;--223.456

select '123.456abc' + 100 from dual;  --not ok 无效数字
select to_number('123.456abc') + 100 from dual;--not ok 无效数字

--to_date 字符 -> 日期
select to_date('1-1月-81') from dual;--OK

select to_date('1995-10-19') from dual;--not ok 文字与格式字符串不匹配
select to_date('1995-10-19 12:24:48','yyyy-mm-dd hh24:mi:ss') from dual;  --1995/10/19 12:24:48

select to_date('1995/10/19 12:24:48','yyyy/mm/dd hh24:mi:ss') from dual;  --1995/10/19 12:24:48

select to_date('1995年10月19日 12:24:48','yyyy"年"mm"月"dd"日" hh24:mi:ss') from dual;  --1995/10/19 12:24:48

--------------------------------------------------------------------------
-- 通用函数
--------------------------------------------------------------------------
--nvl(参数一，参数二)  判断参数一是否为null,如果为null,取参数二的值，反之，取参数一本身的值
select ename,comm,nvl(comm,0) from emp;

--nvl2(参数一，参数二，参数三) 判断参数一是否为null，如果为null，取参数三的值，反之，取参数二的值
select ename,comm,nvl2(comm,'奖金不为空','奖金为空') from emp;

--nullif(参数一，参数二) 判断参数一==参数二，如果相等，返回null，如果不相等，返回参数一的值
select nullif(10,10) from dual; --null
select nullif(10,20) from dual; --10
select nullif(20,10) from dual; --20

--coalesce(参数一，参数二................参数N):判断参数一是否为null,如果为null,判断参数二的值，不为null，取其值，为null，继续判断参数三.........
select comm,coalesce(comm,0) from emp;
select comm,coalesce(comm,null,null,0,null,null) from emp;

--case....when....then...else....end ,类似于 if(){...}else if(){...}else{....}  条件判断函数
select empno,ename,deptno,
       (case deptno
           when 10 then '开发部'
           when 20 then '测试部'
           when 30 then '实施部'
           else '打杂部'
       end)
 from emp;
 
 select empno,ename,deptno,
       (case
           when deptno=10 then '开发部'
           when deptno=20 then '测试部'
           when deptno=30 then '实施部'
           else '打杂部'
       end)
 from emp;


--decode() 条件判断函数
select empno,ename,deptno,decode(deptno,10,'开发部',20,'测试部',30,'实施部','打杂部') from emp;


--------------------------------------------------------------------------
-- 函数嵌套：单行函数可以嵌套N层
--------------------------------------------------------------------------
1.查询员工信息，没有经理的人员显示"最大的BOSS"
select empno,ename,mgr,nvl(mgr,'最大的BOSS') from emp;--无效数字  nvl中仅允许存放同类型数据
select empno,ename,mgr,lower(nvl(to_char(mgr),'最大的BOSS')) from emp;

--练习
7.在员工表中查询出员工的工资，并计算应交税款：
如果工资小于1000,税率为0，
如果工资大于等于1000并小于2000，税率为10％，
如果工资大于等于2000并小于3000，税率为15％，
如果工资大于等于3000，税率为20％。
--方式一
select ename,sal,
       (case
           when sal < 1000 then 0
           when sal>=1000 and sal<2000 then sal*0.1
           when sal>=2000 and sal<3000 then sal*0.15
           else sal*0.2
       end) 应缴税款
 from emp;
 
--方式二
select ename,sal,
     (case trunc(sal/1000)
         when 0 then 0
         when 1 and sal<2000 then sal*0.1
         when 2 and sal<3000 then sal*0.15
         else sal*0.2
     end) 应缴税款
from emp;


--方式三
select ename,sal,trunc(sal/1000),decode(trunc(sal/1000),0,0,1,sal*0.1,2,sal*0.15,sal*0.2)应缴税款 from emp;


--抽取一个日期的年份
select hiredate,to_char(hiredate),substr(hiredate,-2) from emp;--80
select to_char(hiredate,'yyyy') from emp;   --1981
select extract(year from hiredate) from emp;--1981
