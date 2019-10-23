-------------------------------------------------
--�������㣨union��
--    1.ȥ�ظ�
--    2.Ĭ�ϵ�һ����������
--    3.����SQL��������һ�¡�����һ�¡��������Բ�һ�£�Ĭ��ʹ�õ�һ��SQL�����Ϊ����
--    4.ÿ��SQL��䲻�����Լ���order by���
-------------------------------------------------
1.��ѯ���Ϊ7839��Ա����ǰ���ʡ���λ����ʷ���ʡ���λ��
select * from emp where empno = 7839;           --7839��Ա����ǰ���ʡ���λ
select * from emp_jobhistory where empno = 7839;--7839��Ա����ʷ���ʡ���λ

--������ӣ������ã�
select * from emp e,emp_jobhistory h where e.empno = h.empno;

--��������
select empno ��Ա���,sal ����,job ��λ from emp where empno = 7839       --7839��Ա����ǰ���ʡ���λ   1������
union
select empno,sal,job from emp_jobhistory where empno = 7839 order by ��λ;--7839��Ա����ʷ���ʡ���λ   5������

-------------------------------------------------
--��ȫ�������㣨union all��
--    1.��ȥ�ظ�
--    2.������
--    3.����SQL��������һ�¡�����һ�¡��������Բ�һ�£�Ĭ��ʹ�õ�һ��SQL�����Ϊ����
--    4.ÿ��SQL��䲻�����Լ���order by���
--    5.��ȫ�������㣨union all�� >  �������㣨union��,��Ϊunion all����Ҫȥ�أ�Ҳ����Ҫ����
-------------------------------------------------
1.��ѯ���Ϊ7839��Ա����ǰ���ʡ���λ����ʷ���ʡ���λ,Ҫ��Ҫȥ���ظ�����
--��ȫ��������
select empno ��Ա���,sal ����,job ��λ from emp where empno = 7839       --7839��Ա����ǰ���ʡ���λ   1������
union all
select empno,sal,job from emp_jobhistory where empno = 7839 order by ��λ;--7839��Ա����ʷ���ʡ���λ   5������


--��ϰ
2.ʹ�ö�����ӣ���ѯÿ�����ŵĲ��ű�ţ�����������û�������Ĳ�����ʾ0��
select d.deptno,count(e.empno) from emp e,dept d where e.deptno(+) = d.deptno group by d.deptno;

3.ʹ���������㣬��ѯÿ�����ŵĲ��ű�ţ�����������û�������Ĳ�����ʾ0��
select deptno,count(empno) from emp group by deptno                                       --�������Ĳ���  emp
union
select deptno,0 from dept where not exists (select * from emp where deptno = dept.deptno);--û�������Ĳ���  dept

5. ʹ�ü������㣬�������Ч����
select deptno ����,loc �����ص�, to_char(null) Ա������,to_date(null) ��ְ���� from dept--��ѯ������Ϣ
union
select deptno ����,to_char(null) �����ص�,ename Ա������,hiredate ��ְ���� from emp;--��ѯԱ����Ϣ

-------------------------------------------------
--�ཻ���㣨intersect�� �� ȡ���SQL���֮��Ĺ�������
-------------------------------------------------
1.��ѯ��ЩԱ��������λ������
select empno from emp--���е�Ա��
intersect
select empno from emp_jobhistory;--���ù���Ա�����


-------------------------------------------------
--������㣨minus�� �� ȡA-B�����ݣ�����һ��SQL�У��ڶ���SQLû�е�����
-------------------------------------------------
1.��ѯ��ЩԱ��û��������λ������
select empno from emp--���е�Ա��
minus
select empno from emp_jobhistory;--���ù���Ա�����

