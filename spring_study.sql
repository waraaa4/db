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
    b_title varchar(50),
    b_contents varchar(1000),
    b_hits int default 0,
    b_date datetime,
    constraint primary key(b_number)
);
select * from board_table;

insert into board_table(b_writer,b_password,b_title,b_contents,b_date)
	values('작성자','123','제목','내용',now());
    
-- 1.최근글부터 보여야함.
select * from board_table order by b_number desc;    
-- 2.b_number 기준으로 내림차순 정렬한 상태에서 3개씩 글을 조회
-- limit a, b: a(순서, 가장첫번째가 0), b(한번에 조회할 갯수)
-- 현재 게시판 테이블에서 3개씩 본다면 1페이지를 보는 쿼리 (0,1,2)
select * from board_table order by b_number desc limit 0, 3;    
-- 2페이지를 보는 쿼리 (3,4,5)
select * from board_table order by b_number desc limit 3, 3;        
-- 3페이지를 보는 쿼리 (6,7,8)
select * from board_table order by b_number desc limit 6, 3;        
-- 4페이지를 보는 쿼리 (9,10,11)
select * from board_table order by b_number desc limit 9, 3;    

-- 한페이지에 5개씩 글을 조회할수 있다면 1,2,3,4페이지를 어떻게 조회할지 쿼리문을 작성해봅시다. 
select * from board_table order by b_number desc limit 0, 5;    
select * from board_table order by b_number desc limit 5, 5;    
select * from board_table order by b_number desc limit 10, 5;    
select * from board_table order by b_number desc limit 15, 5;    

-- 제목에 안녕 이라는 단어가 포함된 결과를 출력하는 쿼리는?
select * from board_table where b_title like '%안녕%';
-- 내용에 안녕 이라는 단어가 포함된 결과를 출력하는 쿼리는?
select * from board_table where b_contents like '%안녕%';




