--从顶向下查询
1.查询KING管理的所有的下级员工信息
select * from emp start with ename = 'KING' connect by prior 父列 = 子列;--empno父列   mgr子列
select * from emp start with ename = 'KING' connect by prior empno = mgr;
select * from emp start with ename = 'KING' connect by mgr = prior empno;--同上

--从下向上查询
1.查询SMITH的所有的上级员工信息
select * from emp start with ename = 'SMITH' connect by prior 子列 = 父列;--empno父列   mgr 列  
select * from emp start with ename = 'SMITH' connect by prior mgr = empno;
select * from emp start with ename = 'SMITH' connect by empno = prior mgr;--同上

--使用level伪列
select level,emp.* from emp start with ename = 'KING' connect by prior empno = mgr;
select level,emp.* from emp start with ename = 'SMITH' connect by prior mgr = empno;

--使用level，以及lpad生成树状报告
select level,ename,lpad(ename,length(ename) + level*8,'-') from emp start with empno = 7839 connect by prior empno = mgr;

--排除某几行数据:使用where添加限制条件
1.查询7839管理的所有的下级员工信息，但是不包括SCOTT的信息
select level, ename, lpad(ename, length(ename) + level * 8, '-')
  from emp
  where ename <> 'SCOTT'
 start with empno = 7839
connect by prior empno = mgr;

--排除一个分支:使用connect by添加限制条件
1.查询7839管理的所有的下级员工信息，但是不包括BLAKE以及BLAKE所有下属的信息
select level, ename, lpad(ename, length(ename) + level * 8, '-')
  from emp
 start with empno = 7839
connect by prior empno = mgr and ename <> 'BLAKE';

