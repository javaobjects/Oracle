--------------------第四章 单行函数-----------------

--注意：本章需要关注每个函数的参数及返回值

-------------------字符函数------------------
--大小写转换函数
--全部字符转换为大写(upper)
--利用伪表dual可以对一些不存在与任何表中的数据进行操作
select upper('hehe') from dual;

--全部字符转换为小写(lower)
select lower('HEHE') from dual;
select lower(ename) from emp;

--将每个单词的首字母大写，其他转为小写（initcap）
select initcap('sQL cOUrse') from dual;
select initcap(ename) from emp;

--concat连接函数(等同于'||')
--查询出empno的员工名字为ename
select concat(concat(empno,'的员工名字为'),ename) from emp;

--substr(参数一，参数二，参数三)截取字符串 
--参数一表示截取哪一个字符串，参数二表示从哪一位开始截取，参数三表示截取多长（参数三可以不写，不写则默认截取到最后）
select substr('heheda',3) from dual;
select substr('heheda',3,2) from dual;
select substr(ename,1,1),ename from emp;  --截取emp表中每个员工的名字首字母

--length取长度
select length(ename),ename from emp;

--练习1.写一个查询,用首字母大写，其它字母小写显示雇员的 ename，显示名字的长度，
--并给每列一个适当的标签，条件是满足所有雇员名字的开始字母是J、A 或 M 的雇员，
--并对查询结果按雇员的ename升序排序。（提示：使用initcap、length、substr）
select initcap(ename) "名字" , length(ename) "名字长度" from emp 
where substr(ename,1,1) in('J','A','M')
order by ename asc;

--返回指定子字符串的位置 instr(参数一，参数二,参数三，参数四)  返回的是一个位置，它是一个数字
--参数一：主串   参数二：子串   参数三：表示从哪个位置开始找   参数四：子串第几次出现的位置
select instr('Adams aam','m',2,2) from dual;
select instr('Adams aam','m') from dual;   --4
select instr('Adams aam','m',5,1) from dual;  --9


--左填充函数lpad(参数一，参数二，参数三)
--参数一：待填充的字符串  参数二：被填充后字符串的长度  参数三：填充什么字符
--VIP0000000001
select concat('VIP',lpad('1',10,'0')) from dual;
select lpad(empno,10,'*') from emp;

--右填充函数rpad(参数一，参数二，参数三)
--参数一：待填充的字符串  参数二：被填充后字符串的长度  参数三：填充什么字符
select concat('VIP',rpad('1',10,'0')) from dual;

--去除首尾字符 trim(默认去除首尾空格)
select trim(' abc ') from dual;
--去除首尾指定字符'a'
select trim('a' from 'aabcc') from dual;
--仅去除首部的a
select trim(leading 'a' from 'aabaa') from dual;
--仅去除尾部的a
select trim(trailing 'a' from 'aabaa') from dual;

--替换字符串 replace(参数一，参数二，参数三)
--参数一：主串  参数二：即将被代替的串  参数三：代替参数二的串
select replace('abc','a','d') from dual;

--3.查询每个职工的编号,姓名，工资
--要求将查询到的数据按照一定的格式合并成一个字符串.
--前10位：编号,不足部分用*填充,左对齐
--中间10位：姓名，不足部分用*填充,左对齐
--后10位：工资，不足部分用*填充,右对齐

select rpad(empno,10,'*') from emp;
select rpad(ename,10,'*') from emp;
select lpad(sal,10,'*') from emp;

select concat(concat(rpad(empno,10,'*'),rpad(ename,10,'*')),lpad(sal,10,'*')) from emp;
select rpad(empno,10,'*') || rpad(ename,10,'*') || lpad(sal,10,'*') from emp;

-----------------------数值函数------------
--round(参数一，参数二)  参数一：即将被四舍五入的数据  参数二：四舍五入到小数点后几位,不带的话默认四舍五入到整数位
select round(123.456) from dual;
select round(123.456,2) from dual;   --123.46;

--trunc(参数一，参数二)  参数一：即将被截取的数据  参数二：截取到小数点后几位,不带的话默认截取到整数位
select trunc(123.456) from dual;    --123(截取到整数位)
select trunc(123.456,2) from dual;   --直接截取  得到123.45

--mod（m,n）取余 m%n
select mod(5,2) from dual;   --1


------------------------日期函数(简单介绍)----------------------
--如果要做日期类型的运算，只能对两个Date类型的数据作运算
--sysdate 系统日期

--利用sysdate输出当前的系统时间
select sysdate from dual;

--利用hiredate跟sysdate做运算
--想查出emp表中每个员工到现在工作了多久
select empno,sysdate - hiredate from emp;

--MONTHS_BETWEEN：返回两个日期类型数据之间间隔的自然月数(左边的日期减去右边的日期)
--想要查出emp表中每个员工到现在工作了多少个月
select months_between(sysdate,hiredate) from emp;
select months_between(hiredate,sysdate) from emp;  --得到的是一个负数

--ADD_MONTHS：返回指定日期加上相应的月数后的日期
select add_months(hiredate,2) from emp;




-----------------------------转换函数----------------------------
--隐式转换
insert into emp(empno) values('7777');
select '123.456' + 10 from dual;

--显式转换
--to_char用于日期型(实现自定义日期格式的输出)
--to_char(参数一，参数二)  参数一：日期格式的数据   参数二：自定义的日期格式
select hiredate from emp;
--XXXX-X月-X天  小时：分钟：秒数   星期天   
select to_char(hiredate,'yyyy-mm-dd HH24:MI:SS day') from emp;
select to_char(sysdate,'YYYY"年"') from dual;

--to_char用于数值类型(可以实现数值类型数据的格式定义,然后变成字符串展示)
--把123456789转为￥123,456,789.5(给的格式位数必须要大于等于实际数字的位数，否则将无法识别)
select to_char(123456789.5,'L999,999,999.99') from dual;  --￥123,456,789.50
select to_char(123456789.5,'L99,999,999.999') from dual;   --格式位数少于实际位数，无法识别

--to_number（把字符串转为自定义格式的数字）
--to_number(参数一，参数二)  参数一：将要转换为数字的字符串   参数二：你希望的数字的格式
--123.456
select to_number('123.456','999.999')+10 from dual;

--to_date(把字符串转为自定义格式的日期)
--to_date(参数一，参数二)  参数一：将要转换为日期类型的字符串   参数二：你希望的日期的格式
--'2019-3-29'
select to_date('2019-3-29','YYYY-MM-DD') from dual;
insert into emp(empno,hiredate) values(7778,'2019-3-29');  --报错(需要先转换成日期类型的数据才能进行插入操作)

--1.显示服务器系统当前时间，格式为2007-10-12 17:11:11(提示：使用to_char函数)
select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') from dual;

--2.显示ename、hiredate 和 雇员开始工作日是星期几，列标签DAY(提示：使用to_char函数)
select ename,hiredate,to_char(hiredate,'DAY') from emp;

--4.把字符串2015-3月-18 13:13:13 转换成日期格式，并计算和系统当前时间间隔多少天。 (提示：使用to_date函数)
select sysdate - to_date('2015-3月-18 13:13:13','YYYY-MONTH-DD HH24:MI:SS') "间隔时间" from dual;

------------------通用函数--------------------
--nvl（参数一，参数二）  返回值：如果参数一不为空，返回参数一，否则返回参数二
--计算出emp表中每个员工的年薪，假设一年有12个月(包括奖金)
select empno,sal*12+nvl(comm,0) "年薪" from emp;

--nvl2(参数一，参数二,参数三)  返回值：如果参数一不为空，返回参数二，否则返回参数三
select nvl2(null,'Y','N') from dual;    ---得到N

--nullif(参数一，参数二)  返回值:两个参数相等，则返回null，否则返回第一个表达式
select nullif('Y','N') from dual; --Y
select nullif('N','N') from dual; --null

--COALESCE(参数一，参数二....参数n)  返回参数列表中第一个不为空的参数
select coalesce(null,null,'Y') from dual;   --Y

--case语句(条件判断)
select empno,ename,deptno,(case deptno
                                  when 10 then '研发部'
                                  when 20 then '运维部'
                                  else  '打杂'  
                                  end) "部门名字"  
from emp;


--decode语句(条件判断) 
select empno,ename,deptno,decode(deptno,10,'研发部',20,'运维部','打杂') "部门名字"  from emp;                                 













select ename,nvl(to_char(mgr),'No Manager') mgrno from emp;








select * from emp;
 

