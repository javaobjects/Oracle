----------------------------------------------
-- �û�
----------------------------------------------
1.������Ա�������û�
create user user1 identified by 123456;

2.������Ա����Ȩ�û����������ݿ��Ȩ��create session
grant create session to user1;

3.��user1��������tab_test
create table tab_test(
       tid number(4)
);

4.������Ա����Ȩ�û����������Ȩ��create table
grant create table to user1;

5.������Ա����Ȩ��ռ䣺
alter user user1 quota 10M on users;

6.�޸����� �� �û��ѵ�¼���޸�����  �� �û��������룬��������
alter user user1 identified by 123;

7.�û�״̬��������δ���������������������
alter user user1 account lock;--����Ա������the account is locked��
alter user user1 account unlock;--����Ա����
alter user user1 password expire;--����Ա�����������

8.������Ա��ɾ���û�:��������״̬���û����ܱ�ɾ��
drop user user1 cascade;

----------------------------------------------
-- Ȩ�ޣ� ϵͳȨ�� �� ����Ȩ��
--
--     ϵͳȨ�ޣ�A->B->C, ��A����B��Ȩ��ʱ�������ἶ��������C��Ȩ��
--     ����Ȩ�ޣ�A->B->C, ��A����B��Ȩ��ʱ�����ἶ����  ����C��Ȩ��
----------------------------------------------
create user user2 identified by 123456;
create user user3 identified by 123456;

--ϵͳȨ��
1.��ϵͳȨ�޸��û�   grant...to    --with admin option ����user2��������Ȩ����Ȩ�������û�������User3  ����Ա -> user2 -> user3
grant create session to user2 with admin option;--����Ա��Ȩ��user2
grant create session to user3;                  --user2��Ȩ��user3

2.���û�����ϵͳȨ�� revoke...from --  A->B->C, ��A����B��Ȩ��ʱ�����ἶ������C��Ȩ��
revoke create session from user2;
revoke create session from user3;

--����Ȩ��
1.�ڶ���Ȩ�޸��û� grant...on...to --with grant option ����user2��������Ȩ����Ȩ�������û�������User3  scott -> user2 -> user3
grant select on emp to user2 with grant option;   --scott��Ȩ��user2
grant select on scott.emp to user3;               --user2��Ȩ��user3   ������Ȩ

grant update,insert,delete on scott.emp to user2; --scott��Ȩ��user2  ������Ȩ

grant all privileges on scott.emp to user2;       --scott��Ȩ��user2  ȫ����Ȩ

grant update(job,deptno) on scott.emp to user2;    --scott��Ȩ��user2  �������޸�job��deptno��

2.���û����ض���Ȩ��  revoke...on...from --  A->B->C, ��A����B��Ȩ��ʱ���ἶ������C��Ȩ��
revoke select on scott.emp from user2;

----------------------------------------------
-- ��ɫ��Ȩ�޵ļ���
----------------------------------------------
1.������Ա��������ɫ
create role stuRole;

2.������Ա������ɫ��Ȩ
grant create session,create table,create view to stuRole;

3.������Ա�������û�
create user user4 identified by 123456;
create user user5 identified by 123456;

4.������Ա�����û������ɫ
grant stuRole to user4;
grant stuRole to user5;

5.��user4���鿴Ȩ��
select * from session_privs;

6.������Ա�����ս�ɫ��Ȩ��
revoke create session from stuRole;

7.������Ա�������û��Ľ�ɫ
revoke stuRole from user4;

8.������Ա��ɾ����ɫ
drop role stuRole;

----------------------------------------------
-- Ԥ�����ɫ��DBA��Connect��Resource
----------------------------------------------
create user user6 identified by 123456;
grant connect,resource to user6;

select * from dba_sys_privs where grantee = 'DBA';--����ԱȨ��
select * from dba_sys_privs where grantee = 'CONNECT';--����ԱȨ��  CREATE SESSION
select * from dba_sys_privs where grantee = 'RESOURCE';--����ԱȨ��

----------------------------------------------
-- public
----------------------------------------------
grant create session to public;--����½Ȩ����Ȩ��������
