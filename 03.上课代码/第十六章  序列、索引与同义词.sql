--------------------------------------------------------------
--����(index):�������������������������Ż���ѯЧ��
--
--    �Զ�������������primary key��unique Լ��ʱ��Ĭ�ϴ�������
--
--    �ֶ�������create index idx_tableName_columName on ����(����1[,����2...])
--------------------------------------------------------------
--rownum α��
--       ������ڵģ�ÿ��ѯһ�����ݣ���Զ��1��ʼ��ֻ��ʹ�� <���� <=�Ƚ�
select rownum,e.* from emp e;

--rowid α��
--      ��ʵ��������������У�Ψһ��ʶÿһ�����ݵ�ֵ
select rowid,e.* from emp e;

----------------------
--��������
----------------------
--��������
1.��emp���ename�ֶ��ϴ�������.
create index idx_emp_ename on emp(ename);

--�������������������
2.��emp���deptno��job������ϴ�������
create index idx_emp_deptno_job on emp(deptno,job);

--��������
1.������emp_bak����ṹͬemp��������emp�ı�ṹ��
create table emp_bak as select * from emp;

2.��emp_bak���в������������(��λ������)
insert into emp_bak select * from emp_bak;--3932160

3.��empno����ΪΨһ��ֵ
alter table emp_bak modify(empno number(7));--1.��empno�ĳ����޸�7

update emp_bak set empno = rownum;          --2.ʹ��rownum��empno�޸�ΪΨһֵ
update emp_bak set empno = seq_emp.nextval; --2.ʹ�������޸�ΪΨһֵ

4.��ѯempnoΪ3032160��Ա����Ϣ
select * from emp_bak where empno = 3032160;--������  0.20��

create index idx_emp_empno on emp_bak(empno);--��������

select * from emp_bak where empno = 3032160;--������  0.01��

----------������������������------------start
--1.������
select rowid,emp_bak.* from emp_bak where empno = 3032160;--0.2  �ɰͰ͵Ĳ�ѯ��6000����

--2.����������empno������һ��������Ϊ��ά�� 3032160 -> AAATBlAAEAAAOMfABa �������Ĺ�ϵ����Ҫ������
�� 3032160 -> AAATBlAAEAAAOMfABa 
select rowid from emp_bak where empno = 3032160;--AAATBlAAEAAAOMfABa
AAATBlAAEAAAKo7AAA	1
AAATBlAAEAAAKo7AAB	2
AAATBlAAEAAAKo7AAC	3
AAATBlAAEAAAKo7AAD	4
AAATBlAAEAAAKo7AAE	5
AAATBlAAEAAAKo7AAF	6
AAATBlAAEAAAKo7AAG	7
.....................
AAATBlAAEAAAOMfABa  3032160

��AAATBlAAEAAAOMfABa -> 3032160��Ӧ������
select rowid,emp_bak.* from emp_bak where rowid='AAATBlAAEAAAOMfABa';--0.01 ��ѯ��1��
----------������������������------------end

----------------------
--ɾ������
----------------------
drop index idx_emp_empno;

----------------------
--�����ֵ��
----------------------
select * from user_tables;--��ѯ��ǰ�û������еı��

select * from user_constraints;--�鿴��ǰ�û������е�Լ��
select * from user_cons_columns;--�鿴Լ������������Ϣ

select * from user_indexes;--��ѯ��ǰ�û������е�����
select * from user_ind_columns;--�鿴��������������Ϣ

--------------------------------------------------------------
--���У�sequence��������һ���Ĺ����Զ��������Զ����٣�ͨ��������������ֵ
--------------------------------------------------------------
--�򵥴���
create sequence seq_emp;

--���Ӵ���
create sequence SEQ_EMP
minvalue 1                             -- ��Сֵ  minvalue X | nominvalue
maxvalue 9999999999999999999999999999  --���ֵ  maxvalue X | nomaxvalue
start with 1                           --��ʼֵ
increment by 1                         --������ֵ
nocycle                                --Ĭ�ϲ�ѭ��  cycle | nocycle
cache 20;                              --Ĭ�ϻ���20  cache X | nocache

create sequence seq_dept
minvalue 10
maxvalue 90
start with 10
increment by 10
nocycle
nocache;

--��������
--   nextval : ��ȡ���е���һ��ֵ
--   currval ����ȡͬһ���Ự�У����еĵ�ǰ��ֵ����ȡֵ֮ǰ������ִ��nextvalȡ��һ��ֵ
select seq_emp.nextval from dual;
select seq_emp.currval from dual;

select seq_dept.nextval from dual;

--ʹ�����У���������ʱ���Զ���������ֵ
insert into emp(empno,ename,job) values(seq_emp.nextval,'�Ŵ���','��˿��ʿ');

--�޸����У�����start with��������Ծ������޸�
1.��seq_dept�����ֵ�޸�Ϊ200
alter sequence seq_dept
maxvalue 200;

--ɾ������
drop sequence seq_emp;

--------------------------------------------------------------
--ͬ��ʣ�synonym����������ȡ����
--------------------------------------------------------------
--˽��ͬ���
create synonym e for emp;
select * from scott.e;

--����ͬ���
create public synonym d for dept;
select * from d;

--ɾ��ͬ���
drop synonym e;
drop public synonym d;

--��ʾ��Ȩ�޲��㡱����Ҫsys����Ա��Ȩ
grant create synonym to scott;
grant create public synonym to scott;

grant drop synonym to scott;
grant drop public synonym to scott;







