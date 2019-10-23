--------------------------------------------------------------
-- ������ͼ��view�� 
--      �﷨��create or replace view ��ͼ�� as �Ӳ�ѯ [with check option] [with read only];
--
--      Ȩ�޲���,sys/sys as sysdba����Ա��Ȩ��
--                   grant create view to scott;
--------------------------------------------------------------
--�򵥴���������һ�ű�,û�з��麯������������
1.����һ����ͼv_emp10��ͨ������ͼֻ�ܲ鿴10�Ų��ŵ�Ա����ţ�Ա��������ְλ
create view v_emp10
as 
select empno,ename,job from emp where deptno = 10;--10�Ų��ŵ�Ա����ţ�Ա��������ְλ

--������ͼʱ�����Ӳ�ѯ��ʹ���еı���
--     create or replace �޸���ͼ:����ͼ������ʱcreate����������ͼ�Ѵ���ʱreplace�滻
create or replace view v_emp10
as 
select empno Ա�����,ename Ա������,job ְλ from emp where deptno = 10;--10�Ų��ŵ�Ա����ţ�Ա��������ְλ

--���Ӵ��������ڶ��ű����麯������������
2.����һ����ͼ��ͨ������ͼ���Բ鿴ÿ�����ŵ����ƣ���͹��ʣ���߹��ʣ�ƽ������
create or replace view v_dept_avgsal(��������,��͹���,��߹���,ƽ������)
as
select d.dname,min(sal),max(sal),avg(sal) from dept d,emp e where d.deptno = e.deptno group by d.dname;--�鿴ÿ�����ŵ����ƣ���͹��ʣ���߹��ʣ�ƽ������

--------------------------------------------------------------
-- �޸���ͼ�� create or replace
--------------------------------------------------------------

--------------------------------------------------------------
--��ͼ��ִ��DML�����Ĺ���
--    ���ڼ���ͼ��DML�޸�����ʱ��ֻ��Ӱ����ͼ�ɼ�����
--------------------------------------------------------------
--���ڼ���ͼ��DML�����ԣ�
create or replace view v_emp10
as 
select * from emp where deptno = 10;

�ٻ�����ͼv_emp10,������10��Ա��7839��н���޸�Ϊ10000
update v_emp10 set sal = 10000 where empno = 7839; --ok  Ӱ������1����Ϊ7839Ϊ��ͼ�ɼ�����

�ڻ�����ͼv_emp10,��Ա�����Ϊ6666��ְλ�޸�Ϊ"�ϰ�İְ�"
update v_emp10 set job = '�ϰ�İְ�' where empno = 6666;--ok Ӱ������Ϊ0����Ϊ6666Ϊ��ͼ���ɼ�����

�ۻ�����ͼv_emp10,����һ������
insert into v_emp10(empno,ename,job,deptno) values(7777,'��ͼ����','����',10);--ok,Ӱ������1

--���ڸ�����ͼ��DML�������ԣ�
create or replace view v_dept_avgsal(��������,��͹���,��߹���,ƽ������)
as
select d.dname,min(sal),max(sal),avg(sal) from dept d,emp e where d.deptno = e.deptno group by d.dname;--�鿴ÿ�����ŵ����ƣ���͹��ʣ���߹��ʣ�ƽ������

�ٻ�����ͼv_dept_avgsal������������Ϊ'RESEARCH'�Ĳ��ŵ���͹��ʵ���Ϊ5000
update v_dept_avgsal set ��͹��� = 5000 where �������� = 'RESEARCH';-- not ok �����ݲ������ݷǷ�

--with check option
--     ʹ��with check option���ε���ͼ�������ݽ���DML����ʱ����������where�Ӿ�������������������޸�
create or replace view v_emp10
as 
select * from emp where deptno = 10
with check option;
--����
update v_emp10 set sal = 10000 where empno = 7839; --ok
update v_emp10 set deptno = 20 where empno = 7839; --not ok ��ͼwith check option where�Ӿ�Υ��

--with read only
create or replace view v_emp10
as 
select * from emp where deptno = 10
with read only;
--����
update v_emp10 set sal = 10000 where empno = 7839;--not ok �޷���ֻ����ͼ����DML����

--------------------------------------------------------------
-- ʹ����ͼ��ѯ����
--------------------------------------------------------------
select * from v_emp10;
select * from v_dept_avgsal;

--------------------------------------------------------------
-- ɾ����ͼ
--------------------------------------------------------------
drop view v_emp10;

--------------------------------------------------------------
-- �����ֵ�
--------------------------------------------------------------
select * from user_tables;--��ѯ��ǰ�û������еı��

select * from user_constraints;--�鿴��ǰ�û������е�Լ��
select * from user_cons_columns;--�鿴Լ������������Ϣ

select * from user_indexes;--��ѯ��ǰ�û������е�����
select * from user_ind_columns;--�鿴��������������Ϣ

select * from user_views;--�鿴��ǰ�û������е���ͼ
select * from user_updatable_columns;--�鿴��ͼ�����������Ƿ�����DML����

select * from user_objects;--�鿴��ǰ�û������еĶ���






