

--��˼���������⣿
--��ѯ����Ա����ÿ���¹����ܺͣ�ƽ�����ʣ�
select sum(sal) as �¹����ܺ�,avg(sal) as ƽ������
from emp;

--��ѯ������ߺ���͵Ĺ����Ƕ��٣�

select max(sal),min(sal) from emp;
--��ѯ��˾����������

select count(*) from emp;
--��ѯ�н������������

select count(*) from emp where comm is not null;

select count(*) from emp where nvl(comm,0) > 0;

--��ϰһ
--1.��ѯ����20��Ա����ÿ���µĹ����ܺͼ�ƽ�����ʡ�
select sum(sal),avg(sal) from emp where deptno in 20;



--2.��ѯ������CHICAGO��Ա����������߹��ʼ���͹��ʡ���

select count(*),max(sal),min(sal)
from emp join dept
on emp.deptno = dept.deptno
where loc in 'CHICAGO'; 


--3.��ѯԱ������һ���м��ָ�λ���͡�

select count(distinct deptno) from emp; 

--˼��
--��ѯÿ�����ŵ�ƽ�����ʣ�
select avg(sal),deptno from emp group by deptno;

--��ϰ��
--1.��ѯÿ�����ŵĲ��ű�ţ��������ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select emp.deptno,dept.dname,count(*),max(sal),min(sal),sum(sal),avg(sal)
from emp join dept
on emp.deptno = dept.deptno
group by emp.deptno,dept.dname;

--2.��ѯÿ�����ţ�ÿ����λ�Ĳ��ű�ţ��������ƣ���λ���ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select emp.deptno,dname,job,count(*),max(sal),min(sal),sum(sal),avg(sal)
from emp join dept 
on emp.deptno = dept.deptno
group by emp.deptno,dname,job;

--3.��ѯÿ��������������������ж��ٸ������ϼ������������ţ�����������Ҫ�����û�о������Ա��Ϣ��
select count(*),manager.empno,manager.ename 
from emp worker,emp manager
where worker.mgr = manager.empno(+)
group by manager.empno,manager.ename;

--��ϰ��
--1.��ѯ������������2�Ĳ��ű�ţ��������ƣ�����������
select dept.deptno,dept.dname,count(dept.deptno)
from emp join dept
on emp.deptno = dept.deptno
group by dept.deptno,dept.dname
having count(dept.deptno) > 2;


--2.��ѯ����ƽ�����ʴ���2000������������2�Ĳ��ű�ţ��������ƣ���������������ƽ�����ʣ������ղ���������������
select dept.deptno,dname,count(dept.deptno),avg(sal)
from emp join dept
on emp.deptno = dept.deptno
group by dept.deptno,dname
having avg(sal) > 2000 and count(dept.deptno) > 2
order by count(*) asc;

--�κ���ҵ 
--1.��ѯ����ƽ��������2500Ԫ���ϵĲ������Ƽ�ƽ�����ʡ�
select dname,avg(sal)
from emp join dept
on emp.deptno = dept.deptno
group by dname
having avg(sal) > 2500;



--2.��ѯԱ����λ�в����ԡ�SA����ͷ����ƽ��������2500Ԫ���ϵĸ�λ��ƽ�����ʣ�����ƽ�����ʽ�������
select job,avg(sal)
from emp
group by job
having avg(sal) > 2500 and job not like 'SA%';

--3.��ѯ����������2�����ϵĲ������ơ���͹��ʡ���߹���,������õĹ��ʽ����������뵽����λ��

select dname,round(min(sal)),round(max(sal))
from emp join dept
on emp.deptno = dept.deptno
group by dname
having count(dname) > 2;


--4.��ѯ��λ��ΪSALESMAN�����ʺʹ��ڵ���2500�ĸ�λ��ÿ�ָ�λ�Ĺ��ʺ͡� 
select job,sum(sal)
from emp join dept
on emp.deptno = dept.deptno
group by job
having job not in 'SALESMAN' and sum(sal) >=  2500;

--5.��ʾ�������;����������������������Ա������͹��ʣ�
--û�о����KINGҲҪ��ʾ����������͹���С��3000�ģ�����͹����ɸߵ�������

select s.mgr,s.ename,minsal
from emp e,(select e.mgr,m.ename,min(e.sal) minsal from emp e,
emp m where e.mgr=m.empno(+) group by e.mgr,m.ename) s
where e.mgr=s.mgr and minsal>=3000
order by e.sal desc;



--�Ȳ�ѯ�����������Ա������͹���  

select worker.mgr,manager.ename,min(worker.sal) minsal from 
emp worker,emp manager 
where worker.mgr = manager.empno(+) 
group by worker.mgr,manager.ename
having min(worker.sal) > = 3000
order by minsal desc;----�������ȷ�ⷨ





--�Ȳ�ѯ�����������Ա������Щ
select manager.ename managerName,manager.empno managerEmpno,worker.ename,worker.sal  from
emp worker,emp manager
where worker.mgr = manager.empno(+);
--�ٲ�ѯ �����������Ա������͹��� 
select managerEmpno,managerName,min(sal) minSal
from (select manager.ename managerName,manager.empno managerEmpno,worker.ename,worker.sal  from
emp worker,emp manager
where worker.mgr = manager.empno(+))
group by managerName,managerEmpno;

select e.mgr,m.ename,min(e.sal) from emp e,emp m where e.mgr=m.empno(+) group by e.mgr,m.ename;
--�������սⷨΪ
select  manager.empno,manager.ename,tabminsal.minSal
from emp worker, emp manager,(select managerEmpno,managerName,min(sal) minSal
from (select manager.ename managerName,manager.empno managerEmpno,worker.ename,worker.sal  from
emp worker,emp manager
where worker.mgr = manager.empno(+))
group by managerName,managerEmpno) tabminsal
where worker.mgr = manager.empno(+) 
and manager.ename = tabminsal.managerName 
and tabminsal.minSal >= 3000
order by tabminsal.minSal desc;
--6.дһ����ѯ����ʾÿ��������߹��ʺ���͹��ʵĲ�
select (max(sal)-min(sal))
from emp
group by deptno;

--�������_����_  ��������
--seq_����_�ֶ��� ��������
