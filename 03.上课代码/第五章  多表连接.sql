---------------------------------------------------------
--
-- Oracle���е�д��  �� ��ֵ���ӡ��ǵ�ֵ���ӡ��ⲿ���ӡ��ڲ�����
--
---------------------------------------------------------
------------------------
--�ѿ������� 1.��������������  2.��������ʧЧ
------------------------
1.��ѯԱ����ţ�Ա�����������ű�ţ���������
select * from emp,dept;   --56������  =  emp��14������  *  dept��4������

------------------------
--��ֵ����:N�ű������������N-1����������
------------------------
1.��ѯԱ����ţ�Ա�����������ű�ţ���������
select * from emp,dept where emp.deptno = dept.deptno; 
select emp.*,dept.* from emp,dept where emp.deptno = dept.deptno; 

select empno,ename,deptno,dname from emp,dept where emp.deptno = dept.deptno; --not ok δ��ȷ�������
select empno,ename,emp.deptno,dname from emp,dept where emp.deptno = dept.deptno;--ok

--ʹ��AND���������������ѯ���� 
1.����ֻ���ѯ�����ص���NEW YORK��Ա����ţ����������ű�ţ������ص�
select empno,ename,emp.deptno,loc from emp,dept where emp.deptno = dept.deptno and loc = 'NEW YORK';--Ч�ʸ�
select empno,ename,emp.deptno,loc from emp,dept where loc = 'NEW YORK' and emp.deptno = dept.deptno;--Ч�ʵ�

--������������
--select empno,ename,emp.deptno,dname from emp,dept where emp.deptno = dept.deptno;--Ч�ʵ�
--ʹ�ñ�����Ϊǰ׺
select emp.empno,emp.ename,emp.deptno,dept.dname from emp,dept where emp.deptno = dept.deptno;--Ч�ʸ�
--ʹ�ñ������Ϊǰ׺
select e.empno,e.ename,e.deptno,d.dname from emp e,dept d where e.deptno = d.deptno;

--�������ű������:��ṹ�ο��μ�
1.��ѯ�ͻ�(customer)���еĶ���(ord)�빺��Ĳ�Ʒ(item)
select *
  from customer c, ord o, item i
 where c.custid = o.custid
   and o.ordid = i.ordid;
   
------------------------
--�ǵ�ֵ����:N�ű������������N-1����������
------------------------
1.��ѯÿ��Ա�������������ʣ����ʵȼ�
select e.ename,e.sal,s.grade from emp e,salgrade s where e.sal between s.losal and s.hisal;
select e.ename,e.sal,s.grade from emp e,salgrade s where e.sal>=s.losal and  e.sal<=s.hisal;

------------------------
--�ⲿ����
------------------------
1.��ѯ���е�Ա����Ϣ��û�й�Ա�����Ĳ���(40)ҲҪ��ʾ����
select * from emp e,dept d where e.deptno(+) = d.deptno; --emp��Ϊ�ӱ��ӿ��У�   deptΪ�����������ݾ���ʾ��

2.��ѯ���е�Ա����Ϣ��û�в��ŵ�Ա��(���ӵ�)ҲҪ��ʾ����
select * from emp e,dept d where e.deptno = d.deptno(+); --emp��Ϊ�����������ݾ���ʾ��   deptΪ�ӱ��ӿ��У�

------------------------
--�ڲ����ӣ��������ӣ�
------------------------
1.��ѯÿ��Ա����������ֱ���ϼ�������
select e.ename Ա������,m.ename ֱ���ϼ����� from emp e,emp m where e.mgr = m.empno;

--��ϰ
1.��ѯ���й�����NEW YORK��CHICAGO��Ա��������Ա����ţ��Լ����ǵľ��������������š�
select e.empno Ա�����,
       e.ename Ա������,
       m.ename ��������,
       m.empno ������
  from emp e, dept d, emp m
 where e.deptno = d.deptno
   and e.mgr = m.empno
   and d.loc in ('CHICAGO', 'NEW YORK');

2.����һ��Ļ����ϣ����û�о����Ա��King��������Ա���������
select e.empno Ա�����,
       e.ename Ա������,
       m.ename ��������,
       m.empno ������
  from emp e, dept d, emp m
 where e.deptno = d.deptno
   and e.mgr = m.empno(+)
   and d.loc in ('CHICAGO', 'NEW YORK')
---------------------------------------------------------
--
-- SQL99��׼��д��  ��
--
---------------------------------------------------------
--��������cross join
select * from emp cross join dept;
select * from emp,dept;--�ѿ�����

--��Ȼ����natural join
--            1.��������������ͬ��������������ͬ����
--            2.Ĭ�Ͻ���������ʾ�ڵ�һ�У�����ʾһ��
--
--            ȱ�㣺�����б���������ͬ����������ͬ����������Ȼ����,����ָ������
select * from emp natural join dept;

--using�Ӿ�
--     1.ָ������  
--     2.Ҫ��������һ��
--     3.using�Ӿ��е��õ����в���ʹ�ñ����ͱ�����Ϊǰ׺
--     4.NATURAL JOIN�Ӿ��USING�Ӿ����໥�ų�ģ�����ͬʱʹ�á�
--
--     ȱ�㣺����������ͬ
select * from emp join dept using(deptno);

--on�Ӿ�
1.��ѯԱ����Ա����Ϣ�벿����Ϣ                                             --���ű����
select * from emp join dept on emp.deptno = dept.deptno;
select * from emp,dept where emp.deptno = dept.deptno;--ͬ��

2.��ѯԱ����Ա����Ϣemp�벿����Ϣdept���Լ�������Ϣemp��н�ʵȼ���Ϣsalgrade--�������ϱ����
select *
  from emp e
  join dept d  on e.deptno = d.deptno
  join emp m on e.mgr = m.empno
  join salgrade s on e.sal between s.losal and s.hisal;
  

--��������left outer join
1.��û�в��ŵ�Ա��Ҳ��ʾ����
select * from emp left outer join dept on emp.deptno = dept.deptno;--emp����   dept�ӱ�
select * from emp e,dept d where e.deptno = d.deptno(+);--emp����   dept�ӱ�

--��������right outer join
1.��û��Ա���Ĳ���ҲҪ��ʾ����
select * from emp right outer join dept on emp.deptno = dept.deptno;--emp�ӱ�   dept����
select * from emp e,dept d where e.deptno(+) = d.deptno;--emp�ӱ�   dept����

--ȫ������full outer join
1.��û�в��ŵ�Ա��,�Լ�û��Ա���Ĳ��Ŷ���ʾ����
select * from emp full outer join dept on emp.deptno = dept.deptno;--emp����   dept����
--select * from emp e,dept d where e.deptno(+) = d.deptno(+);          -- not ok 


--��ϰ
3.��������ӡ���ʾԱ��KING��FORD�����Ա������emp e���侭������ emp m��
--�� ��ʾԱ��KING��FORD�����Ա������������Ա���ľ�������
select e.ename Ա������, m.ename ��������
  from emp e, emp m
 where e.mgr = m.empno
   and m.ename in ('KING', 'FORD');

--�� ��ʾԱ��KING��FORD�����Ա������KING��FORD�ľ�������
select e.ename Ա������, m.ename Ա���ľ�������, mm.ename ����ľ��������
  from emp e, emp m, emp mm
 where e.mgr = m.empno
   and m.mgr = mm.empno(+)
   and m.ename in ('KING', 'FORD');
