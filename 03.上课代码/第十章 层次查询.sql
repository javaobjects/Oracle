--�Ӷ����²�ѯ
1.��ѯKING��������е��¼�Ա����Ϣ
select * from emp start with ename = 'KING' connect by prior ���� = ����;--empno����   mgr����
select * from emp start with ename = 'KING' connect by prior empno = mgr;
select * from emp start with ename = 'KING' connect by mgr = prior empno;--ͬ��

--�������ϲ�ѯ
1.��ѯSMITH�����е��ϼ�Ա����Ϣ
select * from emp start with ename = 'SMITH' connect by prior ���� = ����;--empno����   mgr ��  
select * from emp start with ename = 'SMITH' connect by prior mgr = empno;
select * from emp start with ename = 'SMITH' connect by empno = prior mgr;--ͬ��

--ʹ��levelα��
select level,emp.* from emp start with ename = 'KING' connect by prior empno = mgr;
select level,emp.* from emp start with ename = 'SMITH' connect by prior mgr = empno;

--ʹ��level���Լ�lpad������״����
select level,ename,lpad(ename,length(ename) + level*8,'-') from emp start with empno = 7839 connect by prior empno = mgr;

--�ų�ĳ��������:ʹ��where�����������
1.��ѯ7839��������е��¼�Ա����Ϣ�����ǲ�����SCOTT����Ϣ
select level, ename, lpad(ename, length(ename) + level * 8, '-')
  from emp
  where ename <> 'SCOTT'
 start with empno = 7839
connect by prior empno = mgr;

--�ų�һ����֧:ʹ��connect by�����������
1.��ѯ7839��������е��¼�Ա����Ϣ�����ǲ�����BLAKE�Լ�BLAKE������������Ϣ
select level, ename, lpad(ename, length(ename) + level * 8, '-')
  from emp
 start with empno = 7839
connect by prior empno = mgr and ename <> 'BLAKE';

