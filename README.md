
## 思考题

查询工资比Jones工资高的员工信息？

    select * from emp 
    where sal > (select sal from emp where ename in 'JONES');

![](18-Images/1.png) 
查询工资最低的员工姓名？

    select ename from emp
    where sal = (select min(sal) from emp);
![](18-Images/2.png) 

## 练习一
1. 查询入职日期最早的员工姓名，入职日期

```
select ename,hiredate

from emp 

where hiredate = (select min(hiredate) from emp);
```

![](18-Images/3.png) 

2. 查询工资比SMITH工资高并且工作地点在CHICAGO的员工姓名，工资，部门名称

```
select ename,sal,dept.dname

from emp join dept

on emp.deptno = dept.deptno

where sal > 

(select sal from emp where ename in 'SMITH') 

and dept.loc in 'CHICAGO';

```
![](18-Images/4.png)  

3. 查询入职日期比20部门入职日期最早的员工还要早的员工姓名，入职日期

```
一种解法：

select ename,hiredate

from emp

where hiredate < 

(select min(hiredate) from emp group by deptno having deptno in 20);


另一种解法：

select ename,hiredate

from emp

where hiredate < 

(select min(hiredate) from emp where deptno in 20);
```

![](18-Images/5.png)    

4. 查询部门人数大于所有部门平均人数的的部门编号，部门名称，部门人数
```

select dept.deptno,dept.dname,count(emp.deptno)

from emp join dept

on emp.deptno = dept.deptno

group by dept.deptno,dept.dname

having count(emp.deptno) > 

(select avg(count(deptno)) from emp group by deptno);
```

![](18-Images/6.png)  

## 练习二

1. 查询入职日期比10部门任意一个员工晚的员工姓名、入职日期，不包括10部门员工

```
select ename,hiredate

from emp

where hiredate > 

any (select hiredate from emp where deptno in 10) 

and deptno <> 10;
```


![](18-Images/7.png) 

2. 查询入职日期比10部门所有员工晚的员工姓名、入职日期，不包括10部门员工

```
select ename,hiredate

from emp

where hiredate > 

all (select hiredate from emp where deptno in 10)

and deptno <> 10;
```

![](18-Images/8.png) 

3. 查询职位和10部门任意一个员工职位相同的员工姓名，职位，不包括10部门员工

```
select ename,job

from emp

where job =

any (select job from emp where deptno in 10)

and deptno <> 10;
```

![](18-Images/9.png)  

## 练习三
1. 查询职位及经理和10部门任意一个员工职位及经理相同的员工姓名，职位，不包括10部门员工
```

select ename,job

from emp

where (job,mgr) in 

(select job,mgr from emp where deptno in 10)

and deptno not in 10;
```

![](18-Images/10.png)   

2. 查询职位及经理和10部门任意一个员工职位或经理相同的员工姓名，职位，不包括10部门员工

```
select ename,job

from emp

where job in 

(select job from emp where deptno in 10)

or mgr in

(select mgr from emp where deptno in 10)

and deptno not in 10;
```


![](18-Images/11.png)    

## 练习四

1. 查询比自己职位平均工资高的员工姓名、职位，部门名称，职位平均工资
```
此题我不熟练，建议重复练习

select ename,emp.job,dname,avgSal

from emp,

(select job,avg(sal) avgSal from emp group by job) tabjob,

dept

where emp.job = tabjob.job 

and emp.deptno = dept.deptno 

and avgSal < sal;
```
  
    
![](18-Images/12.png)      

2. 查询职位和经理同员工SCOTT或BLAKE完全相同的员工姓名、职位，不包括SCOOT和BLAKE本人。
```

select ename,job

from emp

where (job,mgr) in (select job,mgr from emp where ename in ('SCOTT','BLAKE'))

and ename not in ('SCOTT','BLAKE');
```

![](18-Images/13.png)   

3. 查询不是经理的员工姓名。

```
select ename 

from emp

where empno not in 

(select nvl(mgr,0) from emp);
```


![](18-Images/14.png)   

#### 此处要特别注意只要 (select mgr from emp) 语句返回只要有一条空则
#### 则会导致主查询没有记录返回。这是因为所有的条件和空值比较结果都是空值。因此无论
#### 什么时候只要空值有可能成为子查询结果集合中的一部分，就不能使用NOT IN 运算符
#### 切记！切记！！否则最终会害死自己和同事还有公司的！！！！！！


## 练习五
1. 查询入职日期最早的前5名员工姓名，入职日期。
```
select ename,hiredate 
from (select * from emp order by hiredate asc)
where rownum <= 5;
```

![](18-Images/15.png)   


2. 查询工作在CHICAGO并且入职日期最早的前2名员工姓名，入职日期。

```
select ename,hiredate

from (select ename,hiredate 

from emp,dept 

where emp.deptno = dept.deptno 

and loc in 'CHICAGO' 

order by hiredate asc)

where rownum <= 2;




第二种解法：

select emp.ename,emp.hiredate

from emp join dept

on emp.deptno = dept.deptno

where dept.loc in 'CHICAGO' and rownum <= 2

order by hiredate;
```

![](18-Images/16.png)   
## 练习六
1. 按照每页显示5条记录，分别查询第1页，第2页，第3页信息，要求显示员工姓名、入职日期、部门名称。
```
第一页

select ename,hiredate,dname

from (select ename,hiredate,dname,rownum rn

from emp join dept 

on emp.deptno = dept.deptno where rownum < 6 )

where rn > 0;
```
![](18-Images/17.png)   

```
第二页

select ename,hiredate,dname

from (select ename,hiredate,dname,rownum rn 

from emp join dept 

on emp.deptno = dept.deptno where rownum < 11 )

where rn > 5;
```
![](18-Images/18.png)   

```
第三页

select ename,hiredate,dname

from (select ename,hiredate,dname,rownum rn

from emp join dept 

on emp.deptno = dept.deptno where rownum < 16 )

where rn > 10;
```

![](18-Images/19.png) 

## 练习七
1. 按照每页显示5条记录，分别查询工资最高的第1页，第2页，第3页信息，要求显示员工姓名、入职日期、部门名称、工资。

```
-- 第一步：将其所有的结果查出
select ename,hiredate,dname,sal
from emp,dept
where emp.deptno = dept.deptno
order by sal desc;
-- 第二步：将第一步的结果作为一个表再次进行查询,
--将将伪列重命名为一个列，此表可以作为制最大数值的表

select rownum rn tab_allDate.* from 
(select ename,hiredate,dname,sal
from emp,dept
where emp.deptno = dept.deptno
order by sal desc) tab_allDate;
-- 比如此处可以添一句where rownum <= maxNum 
-- 而若想分页则可以将以上的集合再判断 rn > minNum



-- 第三步：以上结果再次作业一个表进行分页

-- 第一页：0~5
select * from
(select rownum rn,tab_allDate.* from 
(select ename,hiredate,dname,sal
from emp,dept
where emp.deptno = dept.deptno
order by sal desc) tab_allDate
where rownum <= 5)
where rn > 0;

--第二页：5~10
select * from
(select rownum rn,tab_allDate.* from 
(select ename,hiredate,dname,sal
from emp,dept
where emp.deptno = dept.deptno
order by sal desc) tab_allDate
where rownum <= 10)
where rn > 5;
-- 第三页: 11~15
select * from
(select rownum rn,tab_allDate.* from 
(select ename,hiredate,dname,sal
from emp,dept
where emp.deptno = dept.deptno
order by sal desc) tab_allDate
where rownum <= 15)
where rn > 10;
```
![](18-Images/100.png)
![](18-Images/101.png)
![](18-Images/102.png)

## 课后作业
1. 查询工资高于编号为7782的员工工资，并且和7369号员工从事相同工作的员工的编号、姓名及工资。

```
select empno,ename,sal,job
from emp 
where sal > (select sal from emp where empno in 7782)
and job in (select job from emp where empno in 7369);
```
![](18-Images/103.png)
2. 查询工资最高的员工姓名和工资。 
```
select ename,sal
from emp
where sal in (select max(sal) from emp);
```
![](18-Images/104.png)
3. 查询部门最低工资高于10号部门最低工资的部门的编号、名称及部门最低工资。

4. 查询员工工资为其部门最低工资的员工的编号和姓名及工资。
5. 显示经理是KING的员工姓名，工资。
6. 显示比员工SMITH参加工作时间晚的员工姓名，工资，参加工作时间。
7. 使用子查询的方式查询哪些职员在NEW YORK工作。
8. 写一个查询显示和员工SMITH工作在同一个部门的员工姓名，雇用日期，查询结果中排除SMITH。
9. 写一个查询显示其工资比全体职员平均工资高的员工编号、姓名。
10. 写一个查询显示其上级领导是King的员工姓名、工资。
11. 显示所有工作在RESEARCH部门的员工姓名，职位。
12. 查询每个部门的部门编号、平均工资，要求部门的平均工资高于部门20的平均工资。
13. 查询大于自己部门平均工资的员工姓名，工资，所在部门平均工资，高于部门平均工资的额度。
14. 列出至少有一个雇员的所有部门
15. 列出薪金比"SMITH"多的所有雇员
16. 列出入职日期早于其直接上级的所有雇员
17. 找员工姓名和直接上级的名字
18. 显示部门名称和人数
19. 显示每个部门的最高工资的员工
20. 显示出和员工号7369部门相同的员工姓名，工资
21. 显示出和姓名中包含"W"的员工相同部门的员工姓名
22. 显示出工资大于平均工资的员工姓名，工资
23. 显示出工资大于本部门平均工资的员工姓名，工资
24. 显示每位经理管理员工的最低工资，及最低工资者的姓名
25. 显示比工资最高的员工参加工作时间晚的员工姓名，参加工作时间
26. 显示出平均工资最高的的部门平均工资及部门名称


==================================================================
#### 分割线
==================================================================
**博主为咯学编程：父母不同意学编程，现已断绝关系;恋人不同意学编程，现已分手;亲戚不同意学编程，现已断绝来往;老板不同意学编程,现已失业三十年。。。。。。如果此博文有帮到你欢迎打赏，金额不限。。。**

![](18-Images/pay.png)