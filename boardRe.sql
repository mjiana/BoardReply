--���  �Խ������̺� ����(2021.05.26)
create table boardRe (
	idx int primary key,
	name varchar(20),
	email varchar(50),
	homepage varchar(50),
	title varchar(50),
	content varchar(2000),
	pwd varchar(10),
	wdate date,
	step int default null,
	ref int default null,
	depth int default null,
	hit int 
); 
-- sequence : �ڵ�������ȣ�� �����ϴ� ��ü
create sequence boardRe_idx_seq increment by 1 start with 1;

-- �����Ҷ� 
drop table boardRe;
drop sequence boardRe_idx_seq;

-- select
select * from boardRe;

update boardre set title='aaa', content='aaa' where idx=14; 

-----------------------------------------------------------
-- ���̺� ��� ����ϱ�
select * from tab;
-- ������ ��� ����ϱ�
select * from seq;
