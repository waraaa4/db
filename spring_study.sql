use spring_study;
select user();

drop table trainee;
create table trainee(
	t_number bigint auto_increment,
    t_name varchar(20),
    t_age int,
    t_phone varchar(20),
    t_gender varchar(10),
    t_birth date,
    t_address varchar(50),
    constraint primary key(t_number)
);

select * from trainee;

-- 두번째 훈련생에 대한 정보만 조회할 때 쿼리는?
select * from trainee where t_number=2;

-- 훈련생 삭제할때 쿼리는?
delete from trainee where t_number=?;

-- 훈련생 전화번호 집주소 수정
update trainee set t_phone='010-1111-2222', t_address='제주도' where t_number=1;


drop table member_table;
create table member_table(
	m_number bigint auto_increment,
    m_id varchar(20),
    m_password varchar(20),
    m_name varchar(20),
    m_email varchar(20),
    m_phone varchar(20),
    constraint primary key(m_number)
);

select * from member_table;

-- 아이디 비번 비교
select * from member_table where m_id="" and m_password="";

drop table board_table;
create table board_table(
	b_number bigint auto_increment,
    b_writer varchar(20),
    b_password varchar(20),
    b_title varchar(20),
    b_contentsl varchar(20),
    b_date datetime,
    constraint primary key(b_number)
);
select * from board_table;

