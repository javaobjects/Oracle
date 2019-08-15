--## 练习1

--1. 自己尝试创建一个用户user1

create user user1 indentified by user1;

--2. 使用管理员账户为用户user1分配create session和create table的权限。

grant create session to user1;

conn system/oracle;
grant create table to test;

--## 课后作业
--1. 建立新用户neu
create user neu identified by neu;

--2. 给用户neu授权,使其能够登录到数据库，能够查询scott下的emp表，能修改emp表的sal,ename两个字段
grant connect to neu;
grant update on scott.emp to neu;

select * from scott.emp;

--3. 回收用户neu的登录权限
revoke connect from neu;

--4. 回收用户neu的所有对象权限
revoke update on scott.emp from neu;


--5. 建立角色role_neu
create role role_neu;


--6. 给角色role_neu授权,使其能够登录到数据库

--7. 赋角色role_neu给用户neu

--8. 删除角色role_neu

--9. 删除用户neu

