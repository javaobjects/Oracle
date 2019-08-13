--## ��ϰ1

--1. ѧУ��һ��ѡ��ϵͳ�����а������¹�ϵģʽ��

--ϵ(ϵ��ţ� ������
--   ϵ����:  Ψһ����
--   ϵ���Σ� �ǿ�Լ����
--   ϵ����У����ȡֵ��Χֻ�����Ϻ�У���ͻ���У��)

create table tabCollege(
       cgNo number(4) 
       constraint tabCollege_cgNo_pk primary key,
       --  ϵ��ţ� ������
       cgName varchar2(20) 
       constraint tabCollege_cgName_unique unique,
       --   ϵ����:  Ψһ����
       cgDirector varchar2(20) 
       constraint tabCollege_cgDirector_noNull not null,
       --   ϵ���Σ� �ǿ�Լ����
       cgCampus varchar2(40) 
       constraint tabCollege_cgCampus_ck check(cgCampus in ('�Ϻ�У��','����У��'))
       --   ϵ����У����ȡֵ��Χֻ�����Ϻ�У���ͻ���У��)
);
-- �༶(�༶��ţ� ������
--     �༶���ƣ� Ψһ����
--     ����ϵ��  ���)
create table tabClass(
       caNo number(4) 
       constraint tabClass_caNo_pk primary key,
       -- �༶��ţ� ������
       caName varchar2(40) 
       constraint tabClass_caName_unique unique,
       --     �༶���ƣ� Ψһ����
       cgName varchar2(40) 
       constraint tabClass_cgName_fk references tabCollege(cgName)
        --     ����ϵ��  ���
);

-- 2. ����ѧ����������������:

-- ѧ�� �����ַ��� 10λ ����

-- ���� �䳤�ַ��� 20λ �ǿ�

-- �Ա� �����ַ��� 2λ ȡֵ��Χֻ��Ϊ�л�Ů

-- �������� ������ 

-- ���ڰ༶ 

create table tabStudent14(
       stNo char(10) 
       constraint tabStudent14_stNo_pk primary key,
       -- ѧ�� �����ַ��� 10λ ����
       stName varchar2(20) 
       constraint tabStudent14_stName_notNull not null,
       -- ���� �䳤�ַ��� 20λ �ǿ�
       stSex char(2) 
       constraint tabStudent14_stSex_ck check(stSex in ('��','Ů')),
       -- �Ա� �����ַ��� 2λ ȡֵ��Χֻ��Ϊ�л�Ů
       stBirthday date,-- �������� ������ 
       caNo number(4) 
       constraint tabStudent14_caNo_fk reference tabClass(caNo)
       -- ���ڰ༶ û��Ҫ��˵������������Լ���˼·��֮�����Ӧ��Ϊ���
);



-- ## �κ���ҵ

-- 1. ����5��Լ���ĺ��塣

-- not null	�ǿ�Լ����ָ��ĳ�е����������ݲ��ܰ�����ֵ
-- unique	Ψһ��Լ����ָ���л����е���ϵ����������ݱ���Ψһ
-- primary key	����Լ�������ÿ�е�Ψһ�Ա�ʶ��ָ���л����е���ϵ����������ݱ���Ψһ
-- foreign key	���Լ�������м��������Ͻ�����һ��ǿ��������ϵ
-- check	�����Լ����������ָ��һ���������������

-- 2. ����ѧ����ϵsc��������������

-- ѡ����ˮ�� ��ֵ�� ������

-- ѧ����� �ǿ� ���

-- �γ̱�� �ǿ� �����

-- �ɼ�     0-100֮�䣻

-- 3. ����copy_emp��Ҫ���ʽͬemp����ȫһ�������������ݡ�

-- 4. ����copy_dept��Ҫ���ʽͬdept����ȫһ�������������ݡ�

-- 5. ����copy_emp �������deptno������copy_dept��deptno,����ܷ�ɹ�,Ϊʲô��

-- 6. ׷��copy_dept��������deptno
