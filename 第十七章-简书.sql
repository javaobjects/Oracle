--## ��ϰ1

--1. �Լ����Դ���һ���û�user1

create user user1 indentified by user1;

--2. ʹ�ù���Ա�˻�Ϊ�û�user1����create session��create table��Ȩ�ޡ�

grant create session to user1;

conn system/oracle;
grant create table to test;

--## �κ���ҵ
--1. �������û�neu
create user neu identified by neu;

--2. ���û�neu��Ȩ,ʹ���ܹ���¼�����ݿ⣬�ܹ���ѯscott�µ�emp�����޸�emp���sal,ename�����ֶ�
grant connect to neu;
grant update on scott.emp to neu;

select * from scott.emp;

--3. �����û�neu�ĵ�¼Ȩ��
revoke connect from neu;

--4. �����û�neu�����ж���Ȩ��
revoke update on scott.emp from neu;


--5. ������ɫrole_neu
create role role_neu;


--6. ����ɫrole_neu��Ȩ,ʹ���ܹ���¼�����ݿ�

--7. ����ɫrole_neu���û�neu

--8. ɾ����ɫrole_neu

--9. ɾ���û�neu

