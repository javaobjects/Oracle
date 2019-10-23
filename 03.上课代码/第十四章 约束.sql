-------------------------------------------------------
-- not null(�ǿ�Լ��):����Ϊnull ���� ''
--
--     1.Լ������ֵ����Ϊnull
--     2.ֻ�ܶ����м����Լ��
--     3.���Բ���ָ��Լ������
-------------------------------------------------------
1.������emp_bak,ָ��ename����Ϊnull
--��ָ��Լ������
create table emp_bak(
       empno number(4),
       ename varchar2(10) not null,--�м���Լ��
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
);
--����
insert into emp_bak(empno,ename) values(1111,'ɾ�Ŀ�');--ok
insert into emp_bak(empno,ename) values(2222,'');  --not ok �޷���nullֵ����"scott.emp_bak.ename"
insert into emp_bak(empno,ename) values(2222,null);--not ok �޷���nullֵ����"scott.emp_bak.ename"

-------------------------------------------------------
-- unique(ΨһԼ����Ψһ��):
--
--     1.Լ������ֵ����Ψһ�����ǿ���Ϊnull
--     2.���ܶ����м���Լ��������uniqueԼ������Ҳ���Զ�������Լ�����������uniqueԼ����
--     3.����ָ��Լ������
--     4.����ΨһԼ��ʱ��Ĭ�ϸ�����Լ�������������index,�����Ż���ѯЧ�ʣ����磺select * from emp_bak where empno=?
--     5.һ�������ͬʱ������uniqueΨһԼ��
--     6.���Ը�һ�л���ж���uniqueΨһԼ��
--------------------------------------------------------
1.������emp_bak,ָ��empno����Ψһ��ͬʱename����Ψһ
--��ָ��Լ������
create table emp_bak(
       empno number(4) unique,   --�м���Լ�� ,ϵͳ����SYS_C0011805
       ename varchar2(10) unique,--�м���Լ��,ϵͳ����SYS_C0011806
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
);
--����
insert into emp_bak(empno,ename) values(1111,'ɾ�Ŀ�');--ok
insert into emp_bak(empno,ename) values(1111,'ɾ�Ŀ�2');--not ok Υ��ΨһԼ������scott.SYS_C0011805
insert into emp_bak(empno,ename) values(null,'ɾ�Ŀ�2');--ok

--ָ��Լ������
create table emp_bak(
       empno number(4) constraint emp_empno_unique unique,   --�м���Լ�� ,�Զ�������emp_empno_unique
       ename varchar2(10) constraint emp_ename_unique unique,--�м���Լ��,�Զ�������emp_ename_unique
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
       
       --����Լ��
       --,constraint emp_empno_unique unique(empno),
       --constraint emp_ename_unique unique(ename)
);
--����
insert into emp_bak(empno,ename) values(1111,'����');--ok
insert into emp_bak(empno,ename) values(1111,'����');--not ok Υ��ΨһԼ������scott.emp_empno_unique

--ͬʱ�����ж������ΨһԼ��
1.������emp_bak,ָ��empno��ename���Ψһ
create table emp_bak(
       empno number(4),  
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --���Լ����ֻ�ܶ������Լ��
       constraint emp_empno_ename_unique unique(empno,ename)
);
--����
insert into emp_bak(empno,ename) values(1111,'����');--ok
insert into emp_bak(empno,ename) values(1111,'����');--ok
insert into emp_bak(empno,ename) values(2222,'����');--ok
insert into emp_bak(empno,ename) values(2222,'����');--not ok Υ��ΨһԼ������scott.emp_empno_ename_unique
-------------------------------------------------------
-- primary key(����Լ��):�൱��unique + not null
--
--     1.Լ������ֵ����Ψһ���Ҳ�����Ϊnull
--     2.���ܶ����м���Լ��������PKԼ������Ҳ���Զ�������Լ�����������PKԼ����
--     3.����ָ��Լ������
--     4.����ΨһԼ��ʱ��Ĭ�ϸ�����Լ�������������index,�����Ż���ѯЧ�ʣ����磺select * from emp_bak where empno=?
--     5.һ����ֻ����һ��primary key����Լ��
--     6.���Ը�һ�л���ж���primary key����Լ��
--------------------------------------------------------
1.������emp_bak,ָ��empnoΪ����
--ָ��Լ������
create table emp_bak(
       empno number(4) ,--constraint emp_empno_pk primary key,   --�м���Լ�� ,�Զ�������emp_empno_pk
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --�������Լ��
       constraint emp_empno_pk primary key(empno)
);
--����
insert into emp_bak(empno,ename) values(1111,'����');--ok
insert into emp_bak(empno,ename) values(1111,'����');--not ok Υ��ΨһԼ������scott.emp_empno_pk
insert into emp_bak(empno,ename) values(null,'����');--not ok  �޷���nullֵ����"scott.emp_bak.empno"

--ͬʱ�����ж����������Լ��
1.������emp_bak,ָ��empno��ename���Ϊ����
create table emp_bak(
       empno number(4),  
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --���Լ����ֻ�ܶ������Լ��
       constraint emp_empno_ename_pk primary key(empno,ename)
);
-------------------------------------------------------
-- foreign key(���Լ��):
--
--     1.����е�ֵ������������ֵ�ķ�Χ�ڣ�����Ϊnull
--     2.������յ����б�������������Ψһ��
--     3.����������ֵ����������ʱ���������¼������ɾ��

--     4.����ָ��Լ������
--     5.���ܶ����м���Լ����Ҳ���Զ�������Լ��
--     6.һ��������ж�����Լ��
--
--     ����ɾ�� on delete cascade
--     ������� on delete set null
--------------------------------------------------------
1.������emp_bak,ָ��deptnoΪ������ο�dept���deptno������
--ָ��Լ������
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),-- constraint emp_deptno_fk references dept(deptno)   --�м���Լ�� ,�Զ�������emp_deptno_fk
       
       --�������Լ��
       constraint emp_deptno_fk foreign key(deptno) references dept(deptno)
);
--����
insert into emp_bak(empno,ename) values(1111,'����');--ok ���ֵ����Ϊnull
insert into emp_bak(empno,ename,deptno) values(1111,'����',10);--ok �ο�dept.deptno��ֵ
insert into emp_bak(empno,ename,deptno) values(2222,'����',88);-- not ok Υ��������Լ������scott.emp_deptno_fk-δ�ҵ�����ؼ���

-- 3.����������ֵ����������ʱ���������¼������ɾ��
delete from dept where deptno = 10; -- not ok Υ��������Լ������scott.fk_deptno-���ҵ��Ӽ�¼

--����ɾ�� on delete cascade
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --�������Լ��
       constraint emp_deptno_fk foreign key(deptno) references dept(deptno) on delete cascade --on delete cascade
);
--����
insert into emp_bak(empno,ename,deptno) values(1111,'������',10);
insert into emp_bak(empno,ename,deptno) values(2222,'����',88);

delete from dept where deptno = 88;--����ɾ�����ٽ�����88��Ա��ȫ��ɾ��  �� ������88ɾ��


--������� on delete set null
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       --�������Լ��
       constraint emp_deptno_fk foreign key(deptno) references dept(deptno) on delete set null --on delete set null
);
--����
insert into emp_bak(empno,ename,deptno) values(1111,'������',10);
insert into emp_bak(empno,ename,deptno) values(2222,'����',88);

delete from dept where deptno = 88;--������գ��ٽ�����88��Ա���Ĳ��ű��deptno���  �� ������88ɾ��
-------------------------------------------------------
-- check(�����Լ��):
--
--     1.Լ������ȡֵ��Χ,���ǿ���Ϊnull
--     2.����ָ��Լ������
--     3.���ܶ����м���Լ����Ҳ���Զ�������Լ��
--     4.һ��������ж��check��Լ��
--------------------------------------------------------
1.������emp_bak,Լ��sal������ڵ���3000
--�Ƚ������  >   >=  =  <   <=  <>
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2) constraint emp_sal_check check(sal >= 3000),   --�м���Լ�� ,�Զ�������emp_sal_check
       comm number(7,2),
       deptno number(2)
       
       --�������Լ��
       --constraint emp_sal_check check(sal >= 3000)
);
--����
insert into emp_bak(empno,ename,sal) values(1111,'����',null);--ok ����Ϊnull
insert into emp_bak(empno,ename,sal) values(1111,'����',2900);--not ok Υ�����Լ������scott.emp_sal_check
insert into emp_bak(empno,ename,sal) values(1111,'����',3000);

--����Ƚ������  in
1.������emp_bak,Լ��jobȡֵ����Ϊ����ʦ������ʦ��ǰ��ʦ
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9) constraint emp_job_check check(job in('����ʦ','����ʦ','ǰ��ʦ')),   --�м���Լ�� ,�Զ�������emp_sal_check
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
       
       --�������Լ��
       -- constraint emp_job_check check(job in('����ʦ','����ʦ','ǰ��ʦ'))
);
--����
insert into emp_bak(empno,ename,job) values(1111,'����',null);--ok ����Ϊnull
insert into emp_bak(empno,ename,job) values(1111,'����','����Գ');--not ok Υ�����Լ������scott.emp_job_check
insert into emp_bak(empno,ename,job) values(1111,'����','����ʦ');

--����Ƚ������  between...and....
1.������emp_bak,Լ��salȡֵ��ΧΪ3000-99999֮��
create table emp_bak(
       empno number(4) ,
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2) constraint emp_job_check check(sal between 3000 and 99999),   --�м���Լ�� ,�Զ�������emp_sal_check,
       comm number(7,2),
       deptno number(2)
       
       --�������Լ��
       -- constraint emp_job_check check(sal between 3000 and 99999)
);
--����
insert into emp_bak(empno,ename,sal) values(1111,'����',null);--ok ����Ϊnull
insert into emp_bak(empno,ename,sal) values(1111,'����',2900);--not ok Υ�����Լ������scott.emp_sal_check
insert into emp_bak(empno,ename,sal) values(1111,'����',99999);--ok

-------------------------------------------------------
-- �ۺ϶�������Լ��
--------------------------------------------------------
--�м���Լ��
create table emp_bak(
       empno number(4) constraint emp_empno_pk primary key,--����Լ��
       ename varchar2(10) constraint emp_ename_unique unique,--ΨһԼ��
       job varchar2(9) constraint emp_job_nn not null,--�ǿ�Լ��
       mgr number(4),
       hiredate date,
       sal number(7,2) constraint emp_sal_check check(sal >= 3000),--�����Լ��
       comm number(7,2),
       deptno number(2) constraint emp_deptno_fk references dept(deptno) -- ���Լ��
);
--����Լ��
create table emp_bak(
       empno number(4),
       ename varchar2(10),
       job varchar2(9) constraint emp_job_nn not null,--�ǿ�Լ��
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2),
       
       constraint emp_empno_pk primary key(empno),--����Լ��
       constraint emp_ename_unique unique(ename),--ΨһԼ��
       constraint emp_sal_check check(sal >= 3000),--�����Լ��
       constraint emp_deptno_fk foreign key(deptno) references dept(deptno) -- ���Լ��
);
-------------------------------------------------------
--׷��Լ��
-------------------------------------------------------
create table emp_bak(
       empno number(4),
       ename varchar2(10),
       job varchar2(9),
       mgr number(4),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(2)
);
--׷��Լ��
alter table emp_bak add constraint emp_empno_pk primary key(empno);--����Լ��
alter table emp_bak add constraint emp_ename_unique unique(ename);--ΨһԼ��
alter table emp_bak add constraint emp_sal_check check(sal>=3000);--�����Լ��
alter table emp_bak add constraint emp_deptno_fk foreign key(deptno) references dept(deptno);--���Լ��

alter table emp_bak modify (job constraint emp_job_nn not null);--�ǿ�Լ��

-------------------------------------------------------
--ɾ��Լ��
-------------------------------------------------------
alter table emp_bak drop constraint emp_empno_pk;--����Լ��
alter table emp_bak drop primary key;            --����Լ��

alter table emp_bak drop constraint emp_ename_unique;--ΨһԼ��
alter table emp_bak drop unique(ename);              --ΨһԼ��

alter table emp_bak drop constraint emp_sal_check;--�����Լ��

alter table emp_bak drop constraint emp_deptno_fk;--���Լ��

alter table emp_bak drop constraint emp_job_nn;--�ǿ�Լ��
alter table emp_bak modify (job null);         --�ǿ�Լ��

-------------------------------------------------------
--����Լ��
-------------------------------------------------------
alter table emp_bak disable constraint emp_empno_pk;--��������
alter table emp_bak disable constraint emp_ename_unique;--����ΨһԼ��
alter table emp_bak disable constraint emp_sal_check;--���ü����Լ��
alter table emp_bak disable constraint emp_deptno_fk;--�������Լ��
alter table emp_bak disable constraint emp_job_nn;--���÷ǿ�Լ��

-------------------------------------------------------
--����Լ��
-------------------------------------------------------
alter table emp_bak enable constraint emp_empno_pk;--��������
alter table emp_bak enable constraint emp_ename_unique;--����ΨһԼ��
alter table emp_bak enable constraint emp_sal_check;--���ü����Լ��
alter table emp_bak enable constraint emp_deptno_fk;--�������Լ��
alter table emp_bak enable constraint emp_job_nn;--���÷ǿ�Լ��

-------------------------------------------------------
--�����ֵ�  P(primary key) R(foreign key) C(check,not null����C) U(unique)
-------------------------------------------------------
select * from user_constraints;--�鿴��ǰ�û������е�Լ��
select * from user_cons_columns;--�鿴Լ������������Ϣ

