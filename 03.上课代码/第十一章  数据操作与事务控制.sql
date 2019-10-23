���ݲ�ѯ���� DQL(Data Query Language): select
���ݲ������� DML(Data Manipulation Language): insert   update   delete
���������� TPL(Transaction Process Language):commit  rollback

--------------------------------------------------------------------------------------------------
-- ��������(��������)
--              �﷨�� insert into ����(��1����2....) values(ֵ1��ֵ2....);  һ������һ��
--                     insert into ����(��1����2....) �Ӳ�ѯ;   һ������N��
--
--              1.�����б���ֵ�б�ĸ��������ͱ��뱣��һ��
--              2.�����б����ʡ�ԣ�Ĭ��ֵ�б�������и�ֵ
--              3.ֵ�б������ڡ��ַ�������ʹ��''������������
--------------------------------------------------------------------------------------------------
--�����ֵNULL   ������: �������б��к��Ը��С�
insert into dept(deptno,dname) values(50,'������');

--�����ֵNULL  ��ʾ��: ָ�� NULL�ؼ��ֻ���''
insert into dept(deptno,dname,loc) values(60,'����','�������125C');--ȫ����ֵ
insert into dept(deptno,dname,loc) values(70,'���Բ�',null);--loc����ֵ
insert into dept values(80,'ʵʩ��','');  --2.�����б����ʡ�ԣ�Ĭ��ֵ�б�������и�ֵ
insert into dept values(90,'��ά��');     --not OK û���㹻��ֵ

--��������ֵ  SYSDATE ������¼��ǰ���ں�ʱ��
insert into emp(empno,ename,hiredate) values(7777,'����',sysdate);

--��������ֵ   ����ʹ��RR���ڸ�ʽ��Ҳ����ʹ��to_date()����ת��YY���ڸ�ʽ
insert into emp(empno,ename,hiredate) values(8888,'���','2019-08-01');--�������ʽ�ַ�����ƥ��
insert into emp(empno,ename,hiredate) values(8888,'���','1-8��-19'); --RR���ڸ�ʽ
insert into emp(empno,ename,hiredate) values(8888,'���',to_date('2019-08-01','yyyy-mm-dd'));--YY���ڸ�ʽ

--���������ַ�
insert into dept(deptno,dname) values(50,'~!@#$%^*()-+');--ok
insert into dept(deptno,dname) values(50,'&');           --ok   
insert into dept(deptno,dname) values(50,'&����');-- not OK    &���ε��ַ���ʾһ���������ȴ��û��������ֵ

insert into dept(deptno,dname) values(50,'\&����');--not ok
insert into dept(deptno,dname) values(50,'&' || '����'); --ok
insert into dept(deptno,dname) values(50,chr(38) || '����'); --ok

--ascii() �鿴ָ���ַ���ascii����
select ascii('&') from dual; --38

--chr() �鿴ָ��ascii���������ַ�
select chr(38) from dual;

----------------------
--�����������������ݣ�
----------------------
1. ������10���е�Ա����Ϣ���ݵ�emp_dept10����
�ٸ��Ʊ�ṹ��������emp_dept10���ҽṹ��emp��һ��
create table emp_dept10 as select * from emp;           --1.����emp��ı�ṹ����������    
create table emp_dept10 as select * from emp where 1=0; --1.������emp��ı�ṹ

�� ʹ���Ӳ�ѯ�����������ݣ�������10��Ա�����ݱ��ݵ�emp_dept10����
insert into emp_dept10 select * from emp where deptno = 10;--2.��������������   
insert into emp_dept10(empno,ename,hiredate) select empno,ename,hiredate from emp where deptno = 10;--2.����ָ��������

--------------------------------------------------------------------------------------------------
-- �޸�����
--              �﷨�� update ���� set ����1=ֵ1[,����2=ֵ2.....]  [where ��������]
--------------------------------------------------------------------------------------------------
--ʹ�� WHERE �Ӿ�ָ��Ҫ�޸ĵļ�¼
1.��Ա�����Ϊ7782�Ĳ��ű���޸�Ϊ20
update emp set deptno = 20 where empno = 7782;

--���Ҫ�޸����м�¼��WHERE�Ӿ���Ժ���
2.������Ա���Ĳ��ű���޸�Ϊ20
update emp set deptno = 20;

--һ���޸Ķ���
3.�Ѳ��ű��Ϊ10��Ա�������ű�ŵ���Ϊ20����������100
update emp set deptno = 20,sal = sal+100 where deptno = 10;

--Ƕ���Ӳ�ѯ�޸�
4.�Ѳ��ű��Ϊ10��Ա�������ű�ŵ���Ϊ20��������ԭ�еĻ����ϣ����������˵�ƽ������
select avg(sal) from emp;--1.�����˵�ƽ������  2073.5
update emp set deptno=20,sal= sal+(select avg(sal) from emp) where deptno = 10;

--�޸ļ�¼ʱ��������Լ������
5.�Ѳ��ű��Ϊ10��Ա�������ű�ŵ���Ϊ55
update emp set deptno=55 where deptno =10;--not ok δ�ҵ�����ؼ���  emp.deptno ��������Դ�� dept.deptno,��ʱdept��û��55��ŵĲ��Ŵ���

--����Ӳ�ѯ�޸�
1.��emp������dname��
alter table emp add(dname varchar2(14));

2.��emp���е�dname����Ϊʵ�ʲ��ŵ�����
update emp set dname = (select dname from dept where deptno = emp.deptno);

--��ϰ
2.�޸Ľ���Ϊnull��Ա������������Ϊ0
update emp set comm = 0 where comm is null;

select * from emp where comm = null;--null������ֵ�����Ϊnull
select * from emp where comm in(null);--null������ֵ�����Ϊnull

--------------------------------------------------------------------------------------------------
-- ɾ������
--              �﷨�� delete [from] ����  [where ��������]
--------------------------------------------------------------------------------------------------
--ɾ��ѡ�м�¼
1.ɾ��ְλ��CLERK��Ա����¼
delete from emp where job = 'CLERK';

--ɾ��ȫ����¼
2.ɾ������Ա����¼
delete from emp;
delete emp;

--������һ����ɾ�������¼
3.ɾ������SALES��Ա��
select deptno from dept where dname = 'SALES';--1.SALES�Ĳ��ű��Ϊ���٣�  30
delete from emp where deptno = (select deptno from dept where dname = 'SALES');

--ɾ����¼ʱ��������Լ������
4.ɾ�����ű��Ϊ10�Ĳ��ż�¼
delete from dept where deptno = 10; --not ok ���ҵ��Ӽ�¼  ��Ϊemp.deptno����dept.deptno,��dept.deptnoΪ10�Ĳ����Ѿ�����3��Ա��

--���DELETE
5.ɾ������������ְ��Ա����¼
delete from emp where ����������ְ;
delete from emp where exists (select * from emp_jobhistory where empno = emp.empno);

6.ɾ��û��Ա���Ĳ��ż�¼
delete from dept where û��Ա���Ĳ���;
delete from dept where not exists (select * from emp where deptno = dept.deptno);

--------------------------------------------------------------------------------------------------
-- �������: ��һ��SQL�����ɵĹ���Ԫ,Ҫôȫ��ִ�гɹ���Ҫôȫ��ִ��ʧ��
--              
--       �����Ĵ����ԣ�
--             1. ԭ���ԣ�һ�����������е�SQL��䣬ִ��ʱ��Ҫôȫ��ִ�гɹ���Ҫôȫ��ִ��ʧ��
--             2. һ���ԣ�����SQL���ִ�гɹ�������ʧ�ܣ��������ݴ���ƽ��״̬��
--             3. �����ԣ�����������֮���໥���룬����Ӱ��
--             4. �־��ԣ�һ�����ݱ��ύ�������Ա����浽���ݿ��У������ٳ���
--
--       ����������һ����������Ժ�ִ����һ��DML(����ɾ����)��伴��ʼ�µ�����
--
--       ���������
--                1.��ʾ����
--                       commit:��ʾ�ύ
--                       rollback:��ʾ�ع����������еĲ�����
--
--                2.��ʽ����
--                      ��ʽ�ύ������������һ���������ʱ���ᷢ����ʽ�ύ
--                              1.ִ��һ��DDL(CREATE��ALTER��DROP��TRUNCATE��RENAME����䣻
--                              2.ִ��һ��DCL(GRANT��REVOKE)��䣻
--                              3.��SQL*Plus�����˳�����ʹ��EXIT��QUIT�����˳�����
--
--                      ��ʽ�ع�������������һ���������ʱ���ᷢ����ʽ�ع�
--                              1. ��SQL*Plus��ǿ���˳�
--                              2. �ͻ������ӵ����������쳣�ж�
--                              3. ϵͳ����

--------------------------------------------------------------------------------------------------
--��������
insert into dept(deptno,dname) values(50,'����');
insert into dept(deptno,dname) values(60,'������Դ��');
rollback;--��ʾ�ع�,�������

insert into dept(deptno,dname) values(70,'���ڲ�');
commit;--��ʾ�ύ���������

------------------------------------------------------
--���ñ����
insert into dept(deptno,dname) values(81,'����');
savepoint poin1;--���ñ����1
insert into dept(deptno,dname) values(82,'UI��');
insert into dept(deptno,dname) values(83,'ǰ�˲�');
savepoint poin2;--���ñ����2
insert into dept(deptno,dname) values(84,'������');
insert into dept(deptno,dname) values(85,'���Բ�');
savepoint poin3;--���ñ����3
insert into dept(deptno,dname) values(86,'ʵʩ��');

rollback to poin2;--�ع������2��λ��
commit; --�ύ��������SQL���

rollback;--�����Ѿ����ύ���������ٱ��ع�
------------------------------------------------------

------------------------------------------------------
-- ����
--      
--      �м���  ��  ����             �������� ��  �ֹ�����
--
--      �м���: ORACLEĬ�ϵĻ�������DML����Ӱ����м�¼���Զ�����
--              ���Ự1���޸�ָ�������ݣ���û��commit�ύ�������rollback�ع�����֮ǰ,
--              �������б������������Ự2�������޸ĸ����ݡ�
--              ����Ự1�����������ͷţ������Ự2���Լ�������������
--
--      ���������Ự1�ڲ���ָ������ʱ�����������������Ự������Ա�ṹ�����޸ģ������С��޸��С�ɾ���У�
------------------------------------------------------
--�Ự1 ��ִ��һ������
update dept set loc='125C����' where deptno = 83;
select * from dept;

--�Ự2��ִ��һ������
delete from dept where deptno = 50;
select * from dept;











