----------------------------------------------------------
-- ���麯����min()  max()  avg()   sum()   count()
----------------------------------------------------------
--min()��Сֵ �� max()���ֵ    �����κ���������
1.��ѯ�������������ְ����
select min(hiredate),max(hiredate) from emp; --������������

2.��ѯ�������ߵ�н��
select min(sal),max(sal) from emp;--������ֵ����

3.��ѯ��С����������
select min(ename),max(ename) from emp;--�����ַ�����

--sum()��� �� avg()��ƽ��ֵ    ֻ��������ֵ����
1.��ѯְλ��SALES��ͷ������Ա��ƽ�����ʡ���͹��ʡ���߹��ʡ����ʺ͡�
select avg(sal),min(sal),max(sal),sum(sal) from emp where job like 'SALES%';

--count() ���ط���������������
1.��ѯ����30�ж��ٸ�Ա��
select count(*) from emp where deptno = 30;--6  Ч�ʵ�
select count(1) from emp where deptno = 30;--6  Ч�ʸ�
select count(empno) from emp where deptno = 30;--6
select count(deptno) from emp where deptno = 30;--6

--�������������ķǿ�(NULL)�е�������countĬ�ϻ��ų�nullֵ
2.����30�ж��ٸ�Ա����ȡ����
select count(comm) from emp where deptno = 30;--4

--DISTINCT�������ظ���¼����ʹ���麯�� 
3.��ѯ��Ա���Ĳ��������� 
select count(distinct deptno) from emp;

--����COUNT��*��֮�⣬�������з��麯������������еĿ�ֵ��Ȼ���ٽ��м���
1.��ѯ����Ա����ƽ������
select sum(comm),avg(comm) from emp;       --2200/4 = 550  Ĭ�Ϻ���nullֵ
select sum(comm),avg(nvl(comm,0)) from emp;--2200/14 =  157.142857142857

----------------------------------------------------------
-- group by �����Ӿ�
--       ע�⣺1.select�Ӿ��б��У�ֻ����ŷ��麯�����Լ�������group by�������
--             2.������group by�������һ��Ҫд��select�б���                 
----------------------------------------------------------
--�����з���
1.��ѯÿ�����ŵı�ţ�ƽ������
select deptno,avg(sal) from emp group by deptno;
select avg(sal) from emp group by deptno;
select empno,deptno,avg(sal) from emp group by deptno;--not ok empno����group by���ʽ

--�����з���
1.��ѯÿ������ÿ����λ�Ĺ����ܺ͡�
select deptno,job,sum(sal) from emp group by deptno,job;

--ʹ�÷��麯���ķǷ��Ĳ�ѯ
1.��ѯÿ�����ŵ�����
select deptno,count(ename) from emp;--not ok deptno���ǵ�����麯��
select deptno,count(ename) from emp group by deptno;--ok

--��ϰ
1.��ѯÿ�����ŵĲ��ű�ţ��������ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select e.deptno,
       d.dname,
       count(empno) ��������,
       max(sal) ��߹���,
       min(sal) ��͹���,
       sum(sal) �����ܺ�,
       avg(sal) ƽ������
  from emp e, dept d
 where e.deptno = d.deptno
 group by e.deptno,d.dname;

2.��ѯÿ�����ţ�ÿ����λ�Ĳ��ű�ţ��������ƣ���λ���ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select e.deptno,
       d.dname,
       e.job,
       count(empno) ��������,
       max(sal) ��߹���,
       min(sal) ��͹���,
       sum(sal) �����ܺ�,
       avg(sal) ƽ������
  from emp e, dept d
 where e.deptno = d.deptno
 group by e.deptno,d.dname,e.job;

3.��ѯÿ������������������������ţ�����������Ҫ�����û�о������Ա��Ϣ��
select e.mgr ������, m.ename ��������, count(e.empno) ��������
  from emp e, emp m
 where e.mgr = m.empno(+)
 group by e.mgr, m.ename;

----------------------------------------------------------
-- having�Ӿ� : �ų���      
----------------------------------------------------------
1.��ѯÿ��������߹��ʴ���2900�Ĳ��ű�ţ���߹���
select deptno,max(sal) from emp group by deptno having max(sal) > 2900;

--select����ִ�й���
select deptno, job, avg(sal)                    --5
  from emp                                      --1
 where job in ('SALESMAN', 'MANAGER', 'CLERK')  --2
 group by deptno, job                           --3
having avg(sal) > 1000                          --4
 order by 3 desc;                               --6

--------------------------------------------------------------
--�麯����Ƕ��:���麯���������Ƕ������   ���к�����������Ƕ��
 --------------------------------------------------------------
 1.��ѯ�������ŵ�ƽ������
 select deptno,count(1) from emp group by deptno;--�������ŵ�����
 select avg(count(1)) from emp group by deptno; --�������ŵ�ƽ������  3.5
 
 select max(avg(count(1))) from emp group by deptno;--not ok ���麯����Ƕ��̫��

--��ϰ
2.�����麯������ѯԱ����λ�в����ԡ�SA����ͷ����ƽ��������2500Ԫ���ϵĸ�λ��ƽ�����ʣ�����ƽ�����ʽ�������
select job, avg(sal)
  from emp
 where job not like 'SA%'
 group by job
having avg(sal) > 2500
 order by avg(sal) desc;

5.�����麯������ʾ�������;����������������������Ա������͹��ʣ�û�о����KINGҲҪ��ʾ����������͹���С��3000�ģ�����͹����ɸߵ�������
select e.mgr �������, m.ename ��������, min(e.sal) ������Ա������͹���
  from emp e, emp m
 where e.mgr = m.empno(+)
 group by e.mgr, m.ename
having min(e.sal) >= 3000
 order by min(e.sal) desc;

6.�����麯����дһ����ѯ����ʾÿ��������߹��ʺ���͹��ʵĲ�
select deptno,max(sal),min(sal),max(sal)-min(sal) from emp group by deptno;
