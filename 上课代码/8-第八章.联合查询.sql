----------------------�ڰ���   ���ϲ�ѯ----------------------

--�������������������������

--���ϲ�ѯ
--union
--Ĭ��ȥ���ظ���
--���ݵ�һ���Զ�����������
--��ѯ���Ϊ7839��Ա����ǰ���ʡ���λ����ʷ���ʡ���λ
select sal,job from emp where empno = 7839   
union
select sal,job from emp_jobhistory  where empno = 7839;

--union all��ȫ���ϲ�ѯ
--��ȥ���ظ���
--�����Զ�����
--��ѯ���Ϊ7839��Ա����ǰ���ʡ���λ����ʷ���ʡ���λ,�ظ��м�¼��Ҫ��ȥ��
select sal,job from emp where empno = 7839   
union all
select sal,job from emp_jobhistory  where empno = 7839;

--ʹ���������㣬��ѯ10�Ų��ż�20�Ų��ŵ�Ա�����������ű�š�
select ename,deptno from emp where deptno = 10
union
select ename,deptno from emp where deptno = 20;


select * from emp;
select * from emp_jobhistory;
