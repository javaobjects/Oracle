--## 练习1

--1. 学校有一个选课系统，其中包括如下关系模式：

--系(系编号： 主键，
--   系名称:  唯一键，
--   系主任： 非空约束，
--   系所在校区：取值范围只能在南湖校区和浑南校区)

create table tabCollege(
       cgNo number(4) constraint tabCollege_cgNo_pk primary key,--  系编号： 主键，
       cgName varchar2(20) constraint tabCollege_cgName_unique unique,--   系名称:  唯一键，
       cgDirector varchar2(20) constraint tabCollege_cgDirector_noNull not null,--   系主任： 非空约束，
       cgCampus varchar2(40) constraint tabCollege_cgCampus_ck check(cgCampus in ('南湖校区','浑南校区'))
       --   系所在校区：取值范围只能在南湖校区和浑南校区)
);
-- 班级(班级编号： 主键，
--     班级名称： 唯一键，
--     所属系：  外键)
create table tabClass(
       caNo number(4) constraint tabClass_caNo_pk primary key,-- 班级编号： 主键，
       caName varchar2(40) constraint tabClass_caName_unique unique,--     班级名称： 唯一键，
       cgName varchar2(40) constraint tabClass_cgName_fk references tabCollege(cgName) --     所属系：  外键
);

-- 2. 创建学生表，包含如下属性:

-- 学号 定长字符型 10位 主键

-- 姓名 变长字符型 20位 非空

-- 性别 定长字符型 2位 取值范围只能为男或女

-- 出生日期 日期型 

-- 所在班级 

-- ## 课后作业

-- 1. 简述5种约束的含义。

-- 2. 创建学生关系sc，包括属性名：

-- 选课流水号 数值型 主键；

-- 学生编号 非空 外键

-- 课程编号 非空 外键；

-- 成绩     0-100之间；

-- 3. 创建copy_emp，要求格式同emp表完全一样，不包含数据。

-- 4. 创建copy_dept，要求格式同dept表完全一样，不包含数据。

-- 5. 设置copy_emp 表中外键deptno，参照copy_dept中deptno,语句能否成功,为什么？

-- 6. 追加copy_dept表中主键deptno
