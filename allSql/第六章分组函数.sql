------������ ���麯��
--5�����麯��
--min ����С ֵ
--�����emp������͹���

select min(sal) from emp;--800
--�ҳ�emp�������ְ����
select min(hiredate) from emp;

--max ��һ�����ֵ 
select max(sal) from emp;
select max(hiredate) from emp;

--max min ���Զ��������� ���ַ����ͣ���ֵ���͵�������Ч
--sum��avgֻ�ܶ���ֵ����������
--sum ���ܺ�
--�����emp���е�ȫ��Ա�����ܹ���
select sum(sal) from emp;
select sum(hiredate) from emp;--error ֻ�ܽ�����ֵ������
--avg ��ƽ��ֵ
--���emp����ȫ��Ա����ƽ������
select avg(sal) from emp;

--count �Ƿ��ؽ������ȫ��ָ�����ݵ�����
--count �еĲ���������*�������������������֣�ֻ��һ����λ�����ã���*û������)
--count ������б��ʱ�򣬴���ֵ���н����ᱻͳ��
select count(*) from emp;
select count(1) from emp;
--��ͳ�Ƴ�emp�����о�������ж��
select count(mgr) from emp;

--��ͳ�ƺ����Ĳ����п��Լ���distinct��ȥ�أ���ͳ��
--1.��ѯ����20��Ա����ÿ���µĹ����ܺͼ�ƽ�����ʡ�
select sum(sal),avg(sal)
from emp
where deptno in 20;

--2.��ѯ������CHICAGO��Ա����������߹��ʼ���͹��ʡ�
select count(*),
max(emp.sal),
min(emp.sal)
from emp,dept
where dept.loc in 'CHICAGO' and emp.deptno = dept.deptno;


--3.��ѯԱ������һ���м��ָ�λ���͡�
select count(distinct job) from emp;

--group by �Ӿ�����ݱ����
--�����where�Ӿ� group byд��where�Ӿ����
--��Ƥ��һ�仰���emp����ȫ�����ŵ���߹���
select deptno,max(sal)
from emp group by deptno;
--�Ƚ���Ҫ�ĸ���
--ͳ���� ��select�Ӿ��в��������麯������
--ͳ���б���Ҫд��group by �Ӿ䵱�� 
select deptno,ename,max(sal)
from emp group by deptno; --error ����group by���ʽ

select deptno,ename,max(sal)
from emp group by deptno,ename;

--������Ϸ���
--��ѯÿ������ÿ����λ�Ĺ����ܺ͡�
select deptno,job,sum(sal) 
from emp group by deptno,job;

--1.��ѯÿ�����ŵĲ��ű�ţ��������ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select dept.deptno,dept.dname,count(*),
max(emp.sal),min(emp.sal),sum(emp.sal),avg(emp.sal)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname;

--2.��ѯÿ�����ţ�ÿ����λ�Ĳ��ű�ţ��������ƣ���λ���ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select dept.deptno,dept.dname,emp.job,count(*),
max(emp.sal),min(emp.sal),sum(emp.sal),avg(emp.sal)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname,emp.job;

--3.��ѯÿ��������������������ж��ٸ������ϼ������������ţ�����������Ҫ�����û�о������Ա��Ϣ��
select count(*),m.empno,m.ename
from emp e,emp m 
where e.mgr = m.empno(+)
group by m.empno,m.ename;

--having �Ӿ�ɸѡ����������
--having �Ӿ����group byʹ��
--having�Ӿ����Ƶ��Ǵ��з��麯�������� where�Ӿ�������ͨ���������� 
--�ҳ���߹��ʴ��ڵ�3000�Ĳ����Լ����Ĳ�����߹���
select deptno,max(sal) from emp group by deptno having max(sal) > = 3000;
select deptno,max(sal) from emp where max(sal) > = 3000 group by deptno;---error where�Ӿ䲻����ʹ�÷��麯��
--1.��ѯ������������2�Ĳ��ű�ţ��������ƣ�����������
select dept.deptno,dept.dname,count(dept.deptno)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname 
having count(dept.deptno) > 2;

--2.��ѯ����ƽ�����ʴ���2000������������2�Ĳ��ű�ţ�
--�������ƣ���������������ƽ�����ʣ������ղ���������������

select dept.deptno,dept.dname,count(dept.deptno),avg(emp.sal)
from emp,dept
where emp.deptno = dept.deptno
group by dept.deptno,dept.dname
having avg(emp.sal) > 2000 and count(*) >2
order by count(dept.deptno) asc;
--���麯����Ƕ��ֻ��Ƕ������

--������������Ƕ���򱨴�----���麯��Ƕ��̫��
--select from    where     group by    having     order by
--�����Ӿ�ִ�е�˳��
--from where    group by     having    select    order by




select * from emp;
select * from dept;
