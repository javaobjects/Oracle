----------------------------������  ���麯��-------------------

--������麯��

--min����Сֵ(���������ڲ�ͬ����������)
--���emp���е���͹��� 
select min(sal) from emp;   --���Զ���������������
select min(hiredate) from emp;  --���Զ���������������
select min(ename) from emp;  --���Զ��ַ����͵�����������

----max�����ֵ(���������ڲ�ͬ����������)
select max(sal) from emp;   --���Զ���������������
select max(hiredate) from emp;  --���Զ���������������
select max(ename) from emp;  --���Զ��ַ����͵�����������

--avg��ƽ��ֵ(ֻ����������ֵ������)
select avg(sal) from emp;
select avg(ename) from emp;   --error ��Ч����(avg����ֻ��ʶ���������͵�����)

--sum���ܺ�(ֻ����������ֵ������)
select sum(sal) from emp;   
select sum(ename) from emp;  --error ��Ч����(sum����ֻ��ʶ���������͵�����)

--countͳ��(����һ������)
select count(*) from emp;
--��ͳ�Ƴ�emp�����о����Ա���ж��ٸ�
select count(mgr) from emp;

--���麯���п�����ʹ��DISTINCT���������ظ��У���ͳ��
--�ҳ���Ա���Ĳ����ж��ٸ�
select count(distinct deptno) from emp;

--���麯���еĿ�ֵ����(ͳ�ƺ�����ͳ�ƿ�ֵ)
--����Ա�����ƽ������
select avg(comm) from emp;   --550
select avg(nvl(comm,0)) from emp;    --157.142857142857


--1.��ѯ����20��Ա����ÿ���µĹ����ܺͼ�ƽ�����ʡ�
select sum(sal),avg(sal) from emp where deptno = 20;

--2.��ѯ������CHICAGO��Ա����������߹��ʼ���͹��ʡ�
select count(*),max(sal),min(sal) from emp e,dept d where e.deptno = d.deptno and loc = 'CHICAGO';

--3.��ѯԱ������һ���м��ָ�λ���͡�
select count(distinct job) "��λ��������" from emp;


---------------------------����ȫ��ͳ��������ʱ�����---------------------------------

--���ǿ���ʹ��group by�Ӿ�������ݵķ���
--ͳ�Ƴ�ÿ�����ŵ�ƽ������
select deptno,avg(sal) from emp group by deptno;

--*********************ͳ����************************
--ͳ���У���select����в������麯�����У���ͳ���б���д��group by���������
--������group by�е��в�һ��Ҫ������select�����

--ͳ�Ƴ�ÿ�����ŵ���͹���
select deptno,min(sal) from emp group by deptno;

--������Ϸ���
--��ѯÿ������ÿ����λ�Ĺ����ܺ�
select sum(sal) from emp     group by deptno,job;

--where�Ӿ���д��group by�Ӿ��д


--1.��ѯÿ�����ŵĲ��ű�ţ��������ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select e.deptno,d.dname,count(*),max(sal),min(sal),sum(sal),avg(sal) 
from emp e,dept d
where e.deptno = d.deptno 
group by e.deptno,d.dname;


--2.��ѯÿ�����ţ�ÿ����λ�Ĳ��ű�ţ��������ƣ���λ���ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select e.deptno,dname,job,count(*),max(sal),min(sal),sum(sal),avg(sal)
from emp e,dept d
where e.deptno = d.deptno
group by e.deptno,job,dname


--3.��ѯÿ��������������������ж��ٸ������ϼ������������ţ�����������Ҫ�����û�о����Ա����Ϣ��
select count(*),m.empno,m.ename 
from emp e,emp m
where e.mgr = m.empno(+)
group by e.mgr,m.empno,m.ename


--�ų�����
--ͳ�Ƴ�ÿ�����ŵ���͹���,Ҫ�ò�����͹��ʴ���1000�Ĳ����
--where�Ӿ䵱�в��ܳ��ַ��麯��
select deptno,min(sal)  from emp where min(sal)>1000  group by deptno;

--��ͬһ�����ӵ����б������ܱ�where�Ӿ�ʶ��
select deptno,min(sal) "minsal" from emp where minsal > 1000  group by deptno;

--ʹ��having�����ƴ����麯��������
--��ͨ�Ĳ������麯��������������ȻҪд��where����
select deptno,min(sal)  from emp  group by deptno having min(sal)>1000;

--�Ѿ�ѧ�����Ӿ�
select
from
where
group by
having
order by

--ִ��˳��
from    where   group by   having    select   order by

--�麯����Ƕ��
--���ÿ�����ŵ������ֵ�����Сֵ
--�麯��ֻ��Ƕ������
select avg(min(max(sal))) from emp group by deptno;   --error   ���麯��Ƕ��̫��


--1.��ѯ����ƽ��������2500Ԫ���ϵĲ������Ƽ�ƽ�����ʡ�
select dname,avg(sal) from emp e,dept d where e.deptno = d.deptno group by dname  having avg(sal) > 2500;

--2.��ѯԱ����λ�в����ԡ�SA����ͷ����ƽ��������2500Ԫ���ϵĸ�λ��ƽ�����ʣ�����ƽ�����ʽ�������
select job,avg(sal) avgsal from emp where job not like 'SA%' group by job having avg(sal) > 2500  order by avgsal desc; 

--3.��ѯ����������2�����ϵĲ������ơ���͹��ʡ���߹���,������õĹ��ʽ����������뵽����λ��
select dname,count(*),round(min(sal)),round(max(sal)) from emp e,dept d 
where e.deptno = d.deptno group by dname having count(*) > 2;

--4.��ѯ��λ��ΪSALESMAN�����ʺʹ��ڵ���2500�ĸ�λ��ÿ�ָ�λ�Ĺ��ʺ͡� 
select job,sum(sal) from emp where job <> 'SALESMAN' group by job having sum(sal) >= 2500;


--5.��ʾ�������;����������������������Ա������͹��ʣ�û�о����KINGҲҪ��ʾ����������͹���С��3000�ģ�����͹����ɸߵ�������
select m.empno,m.ename,min(e.sal) minsal from emp e,emp m 
where e.mgr = m.empno(+) 
group by e.mgr,m.empno,m.ename 
having min(e.sal) >= 3000 
order by minsal desc;


--6.дһ����ѯ����ʾÿ��������߹��ʺ���͹��ʵĲ��
select deptno,(max(sal) - min(sal)) "���"  from emp group by deptno;
















select * from emp;
select * from dept;
