------------------������  �������������������--------------

------------------��ͨ�ıȽ������------------------

--��򵥵�������䣨where��
--���emp���в��ű��Ϊ10��Ա��
--ִ��˳��  ��from ��where �ٵ�select�����Ӷ�С��n+n��
select * from emp where  deptno = 10;

--�Ƚ��ַ�������
--�ҳ�emp����jobΪSALESMAN��Ա��
select * from emp where job = 'SALESMAN';
select * from emp where job = 'SALESman';  --�Ҳ�����Ӧ�����ݣ����������������ִ�Сд��

--�Ƚ�����������
--�ҳ���ְ���ڴ���1981��1��1�ŵ�Ա��
--RR���ڸ�ʽ OracleĬ�϶�������ڸ�ʽ  DD-MON-RR  DD�ǵڼ��� MON�Ǽ��£�����Ҫд��ȥ�� RR����ݵĺ���λ
select * from emp where hiredate > '01-1��-81';

--1.��ѯְλΪSALESMAN��  Ա����š�ְλ����ְ���ڡ�
select empno,job,hiredate from emp where job = 'SALESMAN';

--2.��ѯ1985��12��31��֮ǰ��ְ�� Ա����������ְ���ڡ�
select ename,hiredate from emp where hiredate < '31-12��-85';

--3.��ѯ���ű�Ų���10���ŵ� Ա�����������ű�š�
select ename,deptno from emp where deptno != 10;



------------------��������������------------------

--between...and...(�����߽�)
--�ҳ�emp���й���Ϊ1000��3000��Ա��
select * from emp where sal between 1000 and 3000;
--ʹ��and�����Ҳ���Դﵽͬ����Ч��
select * from emp where sal >= 1000 and sal <= 3000;


--in�����   �﷨in�����ϣ�   ���㼯���е�ĳһ����������оͻᱻѡ��,�����е�ֵ�ö��Ÿ���
--���ҳ�emp����jobΪ��SALESMAN�������ǡ�MANAGER����Ա��
select * from emp where job in('SALESMAN','MANAGER');
--or�����Ҳ���Դﵽ������Ч��
select * from emp where job = 'SALESMAN' or job = 'MANAGER';
select * from emp where job = 'SALESMAN' or 'MANAGER';   --error

--1.��ѯ��ְ������82����85���  Ա����������ְ���ڡ�
select ename,hiredate from emp where hiredate between '01-1��-82' and '31-12��-85';

--2.��ѯ��н��3000��5000�� Ա����������н��
select ename,sal from emp where sal between 3000 and 5000;

--3.��ѯ���ű��Ϊ10����20��Ա�����������ű�š�
select ename,deptno from emp where deptno in(10,20);

--4.��ѯ������Ϊ7902, 7566, 7788��Ա��������������
select ename,mgr from emp where mgr in(7902,7566,7788);


--like�����
--like�����õ��������������ַ���Ҳ�����ִ�Сд��
--�������ͨ���ʹ��   
       -- %  ��  ���������ַ�
       --  _  ��  ����һ���ַ�
--�ҳ�emp��������ΪS��ͷ��Ա��
select * from emp where ename like 'S%';

--�ҳ�emp�������ֵ����ڶ�λΪT��Ա��
select * from emp where ename like '%T_'; 

--�ҳ�jobΪ��MAN_����ͷ��Ա�� 
select * from emp where job like 'MAN@_%' escape '@';


--is null�����
--�ҳ�emp����û�н����Ա��
select * from emp where comm is null;
select * from emp where comm = null;   --�����д��,�Ҳ�����Ҫ������

--1.��ѯԱ��������W��ͷ��Ա��������
--2.��ѯԱ������������2���ַ�ΪT��Ա��������
--3.��ѯ����Ϊ�յ�Ա������������




------------------�߼������------------------
--and�����
--�ҳ�emp����jobΪ��MANAGER�����ҹ��ʴ���1500��Ա��
select * from emp where job = 'MANAGER' and sal >1500;

--or�����(��������һ���������������)
--�ҳ�emp����jobΪ'CLERK' ���� ������ 10���ŵ�Ա��
select * from emp where job = 'CLERK' or deptno = 10;

--not�����(�������ǰ�������Ƚ������ʹ��)
--not ���  between ... and ...
--���ҳ����ʲ���1000��3000�ڵ�Ա��
select * from emp where sal not between 1000 and 3000;

--not ���in�����
--���ҳ����Ų�Ϊ10������20��Ա��
select * from emp where deptno not in(10,20);

--not ���like�����
--���ҳ����ֲ�ΪS��ͷ��Ա��
select * from emp where ename not  like 'S%';

--not ��� is null�����(is not null ����˳��Ҫ�ı�)
--�ҳ��н����Ա��
select * from emp where comm is not null;

--���ȼ�����(���ſ���ǿ�иı����ȼ�   and��ִ��  or��ִ��)
--�ҳ���λΪ��SALESMAN�� ���� ��ְ���ڴ���82��  ����  ���ű��Ϊ30��Ա��
select * from emp where job = 'SALESMAN' and hiredate > '01-1��-82' or deptno = 30;

--1.��ѯ���ʳ���2000����ְλ��MANAGER,����ְλ��SALESMAN�� Ա��������ְλ������
select ename,job,sal from emp where sal > 2000 and job = 'MANAGER' or job = 'SALESMAN';


--2.��ѯ���ʳ���2000����ְλ�� MANAGER��SALESMAN�� Ա��������ְλ�����ʡ�
select ename,job,sal from emp where sal >2000 and (job = 'MANAGER' or job = 'SALESMAN');
select ename,job,sal from emp where sal >2000 and job in('MANAGER','SALESMAN');


--3.��ѯ������10����20�����ҹ�����3000��5000֮���Ա�����������š����ʡ�
select ename,deptno,sal from emp where deptno in(10,20) and sal between 3000 and 5000;


--4.��ѯ��ְ������81�꣬����ְλ����SALES��ͷ��Ա����������ְ���ڡ�ְλ��
select ename,hiredate,job from emp where hiredate between '01-1��-81' and '31-12��-81' and job not like 'SALES%';

--5.��ѯְλΪSALESMAN��MANAGER�����ű��Ϊ10����20����������A��Ա��������ְλ�����ű�š�
select ename,job,deptno from emp where job in('SALESMAN','MANAGER') and deptno in(10,20) and ename like '%A%';


--����������order by��
--�����emp�����Ϣ�����ݹ��ʽ�������(asc����Ĭ�����򣩣�desc����)
--�����ʱ���ֵ�ŵ����ֵ������
select * from emp order by sal desc;

--���emp�����Ϣ�����ݹ�����������
--�����ʱ���ֵ�ŵ����ֵ������
select * from emp order by sal asc;
select * from emp order by sal;    --Ĭ����������

--��������
--�ȶԵ�һ�������򣬵ڶ����ڵ�һ�е��ظ����Ƕ����ֶ�����
--���emp����job��mgr�а�����������
--���ַ��������ǰ����ֵ������ŵ�
select * from emp order by job asc,mgr desc;

--����select�е�λ������д������
select empno,ename,job,mgr from emp order by 3 asc,4 desc;

--order by д�������
--1.��ѯ������20��30�� Ա�����������ű�ţ������չ�����������
select ename,deptno from emp where deptno in(20,30) order by sal asc;

--2.��ѯ������2000-3000֮�䣬���Ų���10�ŵ�Ա�����������ű�ţ����ʣ������ղ������򣬹��ʽ�������
select ename,deptno,sal from emp where sal between 2000 and 3000 and deptno <> 10 order by deptno asc,sal desc;

--3.��ѯ��ְ������82����83��֮�䣬ְλ��SALES����MAN��ͷ��Ա����������ְ���ڣ�ְλ����������ְ���ڽ�������
select ename,hiredate,job from emp 
where hiredate between '01-1��-81' and '31-12��-83' and (job like 'SALES%' or job like 'MAN%') 
order by hiredate desc;

--1.��ѯ��ְʱ����1982-7-9֮�󣬲��Ҳ�����SALESMAN������  Ա����������ְʱ�䡢ְλ��
select ename,hiredate,job from emp where hiredate > '09-7��-82' and job <> 'SALESMAN';

--2.��ѯԱ�������ĵ�������ĸ��a��Ա��������
select ename from emp where ename like '__A%';

--3.��ѯ����10��20�Ų��������Ա�����������ű�š�
select ename,deptno from emp where deptno not in(10,20);


--4.��ѯ���ź�Ϊ30��Ա������Ϣ���Ȱ����ʽ��������ٰ������������� 
select * from emp where deptno = 30 order by sal desc,ename;

--5.��ѯû���ϼ���Ա��(�����Ϊ��)��Ա��������
select ename from emp where mgr is null;


--6.��ѯ���ʴ��ڵ���4500���Ҳ���Ϊ10����20��Ա��������\���ʡ����ű�š�
select ename,sal,deptno from emp where sal >= 4500 and deptno in(10,20);

select ename,sal,deptno from emp where sal >= 4500 and (deptno = 10 or deptno = 20);


--�����õ����
select *  from emp;
