

--дһ����ѯ��䣬��ѯԱ���������������ơ������ص㣿
select ename,dept.dname,dept.loc from emp,dept where emp.deptno(+) = dept.deptno;


--��ϰһ
--1.дһ����ѯ����ʾ����Ա�����������ű�ţ��������ơ�

select ename,dept.deptno,dept.dname
from emp,dept
where emp.deptno(+) = dept.deptno;

--2.дһ����ѯ����ʾ���й�����CHICAGO���ҽ���Ϊ�յ�Ա�������������ص㣬����

select ename,dept.loc,comm
from emp,dept
where emp.deptno = dept.deptno and loc in 'CHICAGO' and comm is not null;
--3.дһ����ѯ����ʾ���������к���A�ַ���Ա�������������ص㡣

select ename,dept.loc
from emp,dept
where emp.deptno = dept.deptno and ename like '%A%';

select ename,dept.loc
from emp,dept
where emp.deptno = dept.deptno and instr(ename,'A') <> 0;

select ename,dept.loc
from emp,dept
where emp.deptno = dept.deptno and instr(ename,'A') != 0;

select ename,dept.loc
from emp,dept
where emp.deptno = dept.deptno and instr(ename,'A') > 0;
--��ϰ��
--1.��ѯÿ��Ա���ı�ţ����������ʣ����ʵȼ������ڹ������У����չ��ʵȼ�������������

select empno,ename,sal,grade,loc
from emp,dept,salgrade
where emp.deptno = dept.deptno and sal between losal and hisal
order by sal asc;




select * from user_tables;
select * from SALGRADE;
--˼������ѯÿ��Ա����������ֱ���ϼ�������
select worker.ename,manager.ename
from emp worker,emp manager
where worker.mgr = manager.empno(+);




--��ϰ��

--1.��ѯ���й�����NEW YORK��CHICAGO��Ա��������Ա����ţ��Լ����ǵľ��������������š�

select worker.ename,worker.empno,manager.ename,worker.mgr
from emp worker,emp manager,dept
where worker.mgr = manager.empno(+)
and worker.deptno = dept.deptno 
and loc in ('NEW YORK','CHICAGO');


--2.����һ��Ļ����ϣ����û�о����Ա��King��������Ա���������

select worker.ename,worker.empno,manager.ename,worker.mgr
from emp worker,emp manager,dept
where worker.mgr = manager.empno(+)
and worker.deptno = dept.deptno 
and loc in ('NEW YORK','CHICAGO')
order by worker.empno asc;

--3.��ѯ����Ա����ţ��������������ƣ�����û�в��ŵ�Ա��ҲҪ��ʾ������

select empno,ename,dept.dname
from emp,dept
where emp.deptno(+) = dept.deptno;


select * from emp;
select * from dept;
--��ϰ��
--ʹ��SQL-99д�������������ϰ
--1.����һ��Ա����Ͳ��ű�Ľ������ӡ�
select * from emp cross join dept;

--�������ӻ����������Ľ���˻�����������֮��ĵѿ�������һ���ģ�

--2.ʹ����Ȼ���ӣ���ʾ��ְ������80��5��1��֮���Ա���������������ƣ���ְ����
select ename,dname,hiredate
from emp
natural join dept
where hiredate > '01-5��-80';



--3.ʹ��USING�Ӿ䣬��ʾ������CHICAGO��Ա���������������ƣ������ص�
select ename,dname,loc
from emp 
join dept using(deptno)
where loc in 'CHICAGO';


--4.ʹ��ON�Ӿ䣬��ʾ������CHICAGO��Ա���������������ƣ������ص㣬н�ʵȼ�

select ename,dname,loc,grade
from emp join dept
on emp.deptno = dept.deptno
join salgrade
on sal between losal and hisal
where loc in 'CHICAGO';

--5.ʹ�������ӣ���ѯÿ��Ա��������������������û�о����KingҲҪ��ʾ������

select worker.ename,manager.ename
from emp worker
left outer join emp manager
on worker.mgr = manager.empno;


--6.ʹ�������ӣ���ѯÿ��Ա��������������������û�о����KingҲҪ��ʾ������
select worker.ename,manager.ename
from emp manager
right outer join emp worker
on worker.mgr = manager.empno;

--�κ���ҵ
--1.��ʾԱ��SMITH���������������ƣ�ֱ���ϼ�����

select worker.ename,dname,manager.ename
from emp worker,emp manager,dept
where worker.mgr = manager.empno
and worker.deptno = dept.deptno 
and worker.ename in 'SMITH'; --ͨ��д��

select worker.ename,dname,manager.ename
from emp worker join emp manager
on worker.mgr = manager.empno
join dept
on worker.deptno = dept.deptno 
where worker.ename in 'SMITH';--join on

select worker.ename,dname,manager.ename
from emp worker left outer join emp manager
on worker.mgr = manager.empno
left outer join dept
on worker.deptno = dept.deptno 
where worker.ename in 'SMITH';--�������� left outer join

select worker.ename,dname,manager.ename
from emp worker right outer join emp manager
on worker.mgr = manager.empno
right outer join dept
on worker.deptno = dept.deptno 
where worker.ename in 'SMITH';--�������� right outer join 

--2.��ʾԱ���������������ƣ����ʣ����ʼ���Ҫ���ʼ������4����

select ename,dname,sal,grade
from emp,dept,salgrade
where emp.deptno = dept.deptno 
and sal between losal 
and hisal and grade > 4;--ͨ��д��

select ename,dname,sal,grade
from emp join dept
on emp.deptno = dept.deptno
join salgrade
on sal between losal and hisal
where grade > 4;--join on

select ename,dname,sal,grade
from emp left outer join dept
on emp.deptno = dept.deptno
left outer join salgrade
on sal between losal and hisal
where grade > 4;--�������� left outer join

select ename,dname,sal,grade
from emp right outer join dept
on emp.deptno = dept.deptno
right outer join salgrade
on sal between losal and hisal
where grade > 4;--�������� right outer join 

--3.��ʾԱ��KING��FORD�����Ա���������侭��������




--4.��ʾԱ���������μӹ���ʱ�䣬���������μӹ���ʱ�䣬Ҫ��μ�ʱ��Ⱦ����硣
select worker.ename as Ա������,worker.hiredate as Ա����ְ����,
manager.ename as ��������,manager.hiredate as ������ְ����
from emp worker,emp manager 
where worker.mgr = manager.empno and worker.hiredate < manager.hiredate;
