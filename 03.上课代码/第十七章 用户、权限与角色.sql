----------------------------------------------
-- 用户
----------------------------------------------
1.【管理员】创建用户
create user user1 identified by 123456;

2.【管理员】授权用户：访问数据库的权限create session
grant create session to user1;

3.【user1】创建表tab_test
create table tab_test(
       tid number(4)
);

4.【管理员】授权用户：创建表的权限create table
grant create table to user1;

5.【管理员】授权表空间：
alter user user1 quota 10M on users;

6.修改密码 ① 用户已登录，修改密码  ② 用户忘记密码，管理重置
alter user user1 identified by 123;

7.用户状态：正常（未锁定）、锁定、密码过期
alter user user1 account lock;--管理员锁定（the account is locked）
alter user user1 account unlock;--管理员解锁
alter user user1 password expire;--管理员设置密码过期

8.【管理员】删除用户:处于连接状态的用户不能被删除
drop user user1 cascade;

----------------------------------------------
-- 权限： 系统权限 与 对象权限
--
--     系统权限：A->B->C, 当A回收B的权限时，【不会级联】回收C的权限
--     对象权限：A->B->C, 当A回收B的权限时，【会级联】  回收C的权限
----------------------------------------------
create user user2 identified by 123456;
create user user3 identified by 123456;

--系统权限
1.授系统权限给用户   grant...to    --with admin option 允许user2继续将该权限授权给其他用户，比如User3  管理员 -> user2 -> user3
grant create session to user2 with admin option;--管理员授权给user2
grant create session to user3;                  --user2授权给user3

2.从用户撤回系统权限 revoke...from --  A->B->C, 当A回收B的权限时，不会级联回收C的权限
revoke create session from user2;
revoke create session from user3;

--对象权限
1.授对象权限给用户 grant...on...to --with grant option 允许user2继续将该权限授权给其他用户，比如User3  scott -> user2 -> user3
grant select on emp to user2 with grant option;   --scott授权给user2
grant select on scott.emp to user3;               --user2授权给user3   单个授权

grant update,insert,delete on scott.emp to user2; --scott授权给user2  批量授权

grant all privileges on scott.emp to user2;       --scott授权给user2  全量授权

grant update(job,deptno) on scott.emp to user2;    --scott授权给user2  仅限制修改job与deptno列

2.从用户撤回对象权限  revoke...on...from --  A->B->C, 当A回收B的权限时，会级联回收C的权限
revoke select on scott.emp from user2;

----------------------------------------------
-- 角色：权限的集合
----------------------------------------------
1.【管理员】创建角色
create role stuRole;

2.【管理员】给角色授权
grant create session,create table,create view to stuRole;

3.【管理员】创建用户
create user user4 identified by 123456;
create user user5 identified by 123456;

4.【管理员】给用户授予角色
grant stuRole to user4;
grant stuRole to user5;

5.【user4】查看权限
select * from session_privs;

6.【管理员】回收角色的权限
revoke create session from stuRole;

7.【管理员】回收用户的角色
revoke stuRole from user4;

8.【管理员】删除角色
drop role stuRole;

----------------------------------------------
-- 预定义角色：DBA、Connect、Resource
----------------------------------------------
create user user6 identified by 123456;
grant connect,resource to user6;

select * from dba_sys_privs where grantee = 'DBA';--管理员权限
select * from dba_sys_privs where grantee = 'CONNECT';--管理员权限  CREATE SESSION
select * from dba_sys_privs where grantee = 'RESOURCE';--管理员权限

----------------------------------------------
-- public
----------------------------------------------
grant create session to public;--将登陆权限授权给所有人
