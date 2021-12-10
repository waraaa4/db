use memberBoard;
select user();

drop table member_table;
create table member_table(
	m_number bigint auto_increment,
    m_id varchar(20),
    m_password varchar(20),
    m_name varchar(20),
    m_email varchar(20),
    m_phone varchar(20),
    m_filename varchar(100),
    constraint primary key(m_number)
);
select * from member_table;

drop table board_table;
create table board_table(
	b_number bigint auto_increment,
    b_writer varchar(20),
    b_title varchar(50),
    b_contents varchar(1000),
    b_hits int default 0,
    b_date datetime,
    b_filename varchar(100),
    constraint primary key(b_number)
);
select * from board_table;

drop table comment_table;
create table comment_table(
	c_number bigint auto_increment,
    b_number bigint,
    c_writer varchar(20),
    c_contents varchar(200),
    c_date datetime,
    constraint primary key(c_number)
);
select * from comment_table;






























