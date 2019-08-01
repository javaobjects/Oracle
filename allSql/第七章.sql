----������ �Ӳ�ѯ 
--Ƕ���Ӳ�ѯ(ȫ�����Ӳ�ѯ �����Ե���ִ��)
--�����Ӳ�ѯ���Ӳ�ѯ��ֻ����һ������ ��
--��ѯ���ʱ�Jones���ʸߵ�Ա����Ϣ��
select * 
from emp
where sal> (select sal from emp where ename ='JONES');
--��ѯ������͵�Ա��������
select min(sal) from emp;
select ename from emp where sal = (select min(sal) from emp);

--��ѯ������͹��ʱ�20������͹��ʸߵĲ��ű�ż���͹���
select deptno,min(sal) from emp group by deptno 
having min(sal) > (select min(sal) from emp where deptno = 20);

--��ѯ�ĸ����ŵ�Ա���������ڸ�������ƽ��������
select deptno,count(*) from emp group by deptno having count(*) > 
(select avg(count(*)) from emp group by deptno);

--1.��ѯ��ְ���������Ա����������ְ����
select ename,hiredate
from emp
where hiredate = (select min(hiredate) from emp);

--2.��ѯ���ʱ�SMITH���ʸ߲��ҹ����ص���CHICAGO��Ա�����������ʣ��������� 
--JOIN dept d USING
select emp.ename,emp.sal,dept.deptno
from emp,dept
where sal > (select sal from emp where ename = 'SMITH')
 and dept.loc = 'CHICAGO' and emp.deptno = dept.deptno;

select emp.ename,emp.sal,dept.deptno
from emp join dept
on(emp.deptno = dept.deptno)
where sal > (select sal from emp where ename = 'SMITH')
 and dept.loc = 'CHICAGO';
--3.��ѯ��ְ���ڱ�20������ְ���������Ա����Ҫ���Ա����������ְ����
select ename,hiredate
from emp
where hiredate < (select min(hiredate) from emp where deptno in 20);

--4.��ѯ���������������в���ƽ�������ĵĲ��ű�ţ��������ƣ���������
 
select dept.deptno,dept.dname,count(*)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname 
having count(*) > (select avg(count(*)) from emp group by deptno);

select dept.deptno,dept.dname,count(*)
from emp join dept
on(emp.deptno = dept.deptno)
group by dept.deptno,dept.dname 
having count(*) > (select avg(count(*)) from emp group by deptno);

--�����Ӳ�ѯ���Ӳ�ѯ ���ض������ݣ�
--�����Ӳ�ѯ������� �� in any all 
--��ѯ�Ǿ����Ա������������

--in �����
select ename,sal from emp 
where empno in (select distinct mgr from emp);

-- any 
--   > any (���ڼ���������һ��ֵ�����ڼ����е���Сֵ)

--��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10��������һ��Ա�����ʸߵ�Ա����ţ�������ְλ�����ʡ�
select empno,ename,job,sal from emp
where sal > any (select sal from emp where deptno in 10) and deptno <> 10;


-- < any ��С��һ��ֵ ��С�ڼ����е����ֵ ��
--��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10��������һ��Ա�����ʵ͵�Ա����ţ�������ְλ�����ʡ�

select empno,ename,job,sal from emp
where sal < any (select sal from emp where deptno in 10) and deptno <> 10;
-- =any �൱��in�����

--all ���з�
-- <all ��С�ڼ�����ȫ��ֵ��С�ڼ����е���Сֵ��
--��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10��������Ա�����ʵ͵�Ա����ţ�������ְλ�����ʡ�
select empno,ename,job,sal from emp
where sal < all (select sal from emp where deptno in 10) and deptno <> 10;

-- > all (���ڼ�����ȫ��ֵ �����ڼ����е����ֵ )
--��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10��������һ��Ա�����ʸߵ�Ա����ţ�������ְλ�����ʡ�

select empno,ename,job,sal from emp
where sal > all (select sal from emp where deptno in 10) and deptno <> 10;

-- =all ���ڼ�����ȫ��ֵ 
--1.��ѯ��ְ���ڱ�10��������һ��Ա�����Ա����������ְ���ڣ�������10����Ա��
select ename,hiredate
from emp
where hiredate > any(select hiredate from emp where deptno in 10) and deptno not in 10;

--2.��ѯ��ְ���ڱ�10��������Ա�����Ա����������ְ���ڣ�������10����Ա��

select ename,hiredate
from emp
where hiredate > all(select hiredate from emp where deptno in 10) and deptno not in 10;


--3.��ѯְλ��10��������һ��Ա��ְλ��ͬ��Ա��������ְλ��������10����Ա��

select ename,job
from emp
where job = any(select job from emp where deptno in 10) and deptno not in 10;

select ename,job
from emp
where job in(select job from emp where deptno in 10) and deptno not in 10;

--�����Ӳ�ѯ
--�ɶԱȽ�
--��ѯ����1981����ְ������һ��Ա���Ĳ��ź�
--ְλ��ȫ��ͬԱ�����������š�ְλ����ְ����,������1981����ְԱ��
select ename,deptno,job,hiredate 
from emp
where (deptno,job) in (select deptno,job from emp where to_char(hiredate,'YYYY') = '1981')
and to_char(hiredate,'YYYY') <> '1981';

--�ǳɶԱȽ�

--��ѯ����1981����ְ������һ��Ա����
--���Ż�ְλ��ͬԱ�����������š�ְλ����ְ����,������1981����ְԱ����
select ename,deptno,job,hiredate 
from emp
where deptno in (select deptno from emp where to_char(hiredate,'YYYY') = '1981') or 
     job in (select job from emp where to_char(hiredate,'YYYY') = '1981')
     and to_char(hiredate,'YYYY') <> '1981';
-- �� from �Ӿ���ʹ���Ӳ�ѯ 
--��ѯ���Լ�����ƽ�����ʸߵ�Ա�� ���������ʣ����ű�ţ�����ƽ������
select deptno,avg(sal) from emp 
group by deptno;

select ename,sal,e.deptno,avgsal from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s
where e.deptno = s.deptno and e.sal > s.avgsal;

--1.��ѯ���Լ�ְλƽ�����ʸߵ�Ա��������ְλ���������ƣ�ְλƽ������

select emp.ename,emp.job,dept.dname,avgsal 
from emp join (select job,avg(emp.sal) avgsal from emp group by emp.job) jobavgsal
on(emp.job = jobavgsal.job)
join dept
on(emp.deptno = dept.deptno)
where sal > jobavgsal.avgsal;


select emp.ename,emp.job,dept.dname,avgsal 
from emp join (select job,avg(emp.sal) avgsal from emp group by emp.job) jobavgsal
on emp.job = jobavgsal.job
join dept
on emp.deptno = dept.deptno
where sal > jobavgsal.avgsal;

--2.��ѯְλ�;���ͬԱ��SCOTT��BLAKE��ȫ��ͬ��Ա��������ְλ��������SCOOT��BLAKE���ˡ�
select ename,job
from emp 
where (job,mgr) in (select job, mgr from emp where ename in('SCOTT','BLAKE'))
and ename not in('SCOTT','BLAKE');


select ename, job from emp 
where (job, mgr) in (
      select job, mgr from emp where ename in('SCOTT', 'BLAKE'))
      and ename not in('SCOTT', 'BLAKE');--���
--3.��ѯ���Ǿ����Ա��������


--��not in �������������Ӳ�ѯ�Ŀ�ֵ��Ҫ������
select ename
from emp
where empno not in(select distinct mgr from emp  where mgr is not null);


--1.��ѯ����ƽ��������2500Ԫ���ϵĲ������Ƽ�ƽ�����ʡ�
select dept.dname,avg(sal)
from emp join dept
on(emp.deptno = dept.deptno)
group by emp.deptno ,dept.dname
having avg(sal) > 2500

--2.��ѯԱ����λ�в����ԡ�SA����ͷ����ƽ��������2500Ԫ���ϵĸ�λ��ƽ�����ʣ�����ƽ�����ʽ�������
select emp.job,avg(emp.sal)
from emp join dept
on emp.deptno = dept.deptno
where instr(emp.job,'SA',1,1) = 0
group by emp.job
having avg(emp.sal) > 2500
order by avg(emp.sal) desc;


--3.��ѯ����������2�����ϵĲ������ơ���͹��ʡ���߹���,������õĹ��ʽ����������뵽����λ��
select dept.dname,round(min(emp.sal),0),round(max(emp.sal),0)
from emp join dept
on emp.deptno = dept.deptno
group by dept.dname
having count(*) > 2;

--4.��ѯ��λ��ΪSALESMAN������ �� ���ڵ���2500�� ��λ��ÿ�ָ�λ�Ĺ��ʺ͡� 
select sal,job,sum(sal)
from emp
group by sal,job
having sal > 2500 and job not in('SALESMAN')

--5.��ʾ�������;����������������������Ա������͹��ʣ�
--û�о����KINGҲҪ��ʾ����������͹���С��3000�ģ�����͹����ɸߵ�������
select m.empno,m.ename,min(m.sal)
from emp e,emp m
where e.mgr = m.empno(+)
group by m.empno,m.ename
having min(e.sal) >= 3000
order by min(e.sal) desc;--����û���

--6.дһ����ѯ����ʾÿ��������߹��ʺ���͹��ʵĲ�
select max(sal)-min(sal)
from emp
group by deptno

--1.��ѯ���ʸ��ڱ��Ϊ7782��Ա�����ʣ����Һ�7369��Ա��������ͬ������Ա���ı�š����������ʡ�
select empno,ename,sal,job
from emp
where sal > (select sal from emp where empno in 7782) 
and job = (select job from emp where empno in 7369)

--2.��ѯ������ߵ�Ա�������͹��ʡ� 
select ename,sal
from emp
where sal = (select max(sal) from emp);

--3.��ѯ������͹��ʸ���10�Ų�����͹��ʵĲ��ŵı�š����Ƽ�������͹��ʡ�
--4.��ѯԱ������Ϊ�䲿����͹��ʵ�Ա���ı�ź����������ʡ�
--5.��ʾ������KING��Ա�����������ʡ�
--6.��ʾ��Ա��SMITH�μӹ���ʱ�����Ա�����������ʣ��μӹ���ʱ�䡣

-- rownumΪ��
-- rownum ���������еı��У����Դ��������е���ͨ��������Ӳ�ѯ�Ľ�����У�
select rownum,e.* 
from emp e;

--ͨ��rownum �ҳ�emp���е�ǰ5������
select rownum,emp.* 
from emp
where rownum <= 5;

select emp.* 
from emp
where rownum <= 5;

--ͨ��rownum�ҳ�emp���ͻ���6-10������
-- rownumα�� ����ʹ�� > ��>=��between...and ��������ж�
-- rownum��whereɸѡ���ݵ�ʱ��ᶯ̬�����仯
select emp.* 
from emp
where rownum >= 6;

--top-n��ѯ
--�ҳ����ݱ��е���ǰ���n������
--�ҳ�emp���й���ǰ5��Ա��
select * 
from emp
order by sal desc;

select rownum,emp.*
from emp
where row <=5
order by sal desc;--���ܵõ���ȷ��� ��where ����order byִ��

select s.* from 
(select * from emp order by sal desc) s
where rownum <= 5;
--�ҳ�emp���й��ʺ�5��Ա��
select s.* from 
(select * from emp order by sal asc) s
where rownum <= 5;

--1.��ѯ��ְ���������ǰ5��Ա����������ְ���ڡ�
select hdate.ename,hdate.hiredate
from (select * from emp order by hiredate asc) hdate
where rownum <= 5;

--2.��ѯ������CHICAGO������ְ���������ǰ2��Ա����������ְ���ڡ�
select emp.ename,emp.hiredate,dept.loc
from emp join dept
on emp.deptno = dept.deptno
where dept.loc in 'CHICAGO' and rownum <= 2
order by hiredate;

--�ֲ���ѯ����
--ͨ��rownum�ҳ�emp���ͻ���6-10������
--��ͨ��rownum�ҳ�emp���е�ǰ10������
select emp.* from emp where rownum <= 10;
-- �ٴ����ҳ�6-10��
select * from (select rownum rn, emp.* from emp where rownum <= 10) where rn >= 6;
-- �ٴ����ҳ�11-15��

select * from (select rownum rn, emp.* from emp where rownum <= 15) where rn >= 11;

--ͨ��rownum �ҳ� ���ݱ��еĵ�nҳ������
select * from (select rownum rn, emp.* from emp where rownum <= endIndex) where rn >= starIndex;
--�������Ľ�����ķ�ҳ
--�ҳ�emp���еĵ�һҳ�����ݣ�Ҫ�������ǰ���Ա����Ĺ�����������
select * from emp
order by sal asc;

select * from (select * from emp order by sal asc) s where rownum <= 5;
-- �ҳ��ڶ�ҳ������
select * from (select * from emp order by sal asc) s where rownum <= 10;

select * from (select rownum rn,s.* from (select * from emp order by sal asc) s where rownum <= 10) m
where rn >= 6;
-- �ҳ�����ҳ������

select * from (select rownum rn,s.* from (select * from emp order by sal asc) s where rownum <= 15) m
where rn >= 15;

--1.����ÿҳ��ʾ5����¼���ֱ��ѯ��1ҳ����2ҳ����3ҳ��Ϣ��Ҫ����ʾԱ����������ְ���ڡ��������ơ�
select emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno
where rownum <= 15

--��һҳ
select rownum rn,emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno
where rownum <= 5;

select * from (select rownum rn,emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno)
where rn <= 5; 

--�ڶ�ҳ

select * from (select rownum rn,emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno
where rownum <= 10)
where rn > 5; 

--����ҳ
select * from (select rownum rn,emp.ename,emp.hiredate,dept.dname
from emp join dept
on emp.deptno = dept.deptno
where rownum <= 15)
where rn > 10; 

--1.����ÿҳ��ʾ5����¼���ֱ��ѯ������ߵĵ�1ҳ����2ҳ����3ҳ��Ϣ��Ҫ����ʾԱ����������ְ���ڡ��������ơ����ʡ�

select rownum,alldata.* from (select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata
where rownum <= 15;

--��һҳ 
select rownum,alldata.* from (select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata
where rownum <= 5;


select * from (select rownum rn,alldata.* from (select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata)
where rn <= 5;
--�ڶ�ҳ
select * from (select rownum rn,alldata.* from 
(select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata
where rownum <= 10)
where rn >5;

--����ҳ
select * from (select rownum rn,alldata.* from (select emp.ename,emp.hiredate,dept.dname,emp.sal
from emp join dept
on emp.deptno = dept.deptno
order by sal desc) alldata
where rownum <= 15)
where rn >10;


select emp.ename,emp.hiredate,dept.loc
from emp,dept
where dept.loc in 'CHICAGO' and rownum <= 2 and emp.deptno = dept.deptno;


select * from emp;
select * from dept;
