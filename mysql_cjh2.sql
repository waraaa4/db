use mysql_cjh2;
select user();

drop table naver_member;
drop table naver_board;
drop table naver_comment;
drop table naver_category;

-- 네이버 회원가입
create table naver_member(
	n_id varchar(20),
    n_password varchar(16) not null,
    n_name varchar(10) not null,
    n_birth date not null,
    n_gender varchar(10) not null,
    n_email varchar(30),
    n_phone varchar(20) not null,
    constraint pk_naver_member primary key(n_id)
);

-- 게시판
create table naver_board(
	b_number int,
	b_title varchar(30) not null,
    b_writer varchar(20) not null,
    b_contents varchar(200),
    b_date datetime not null,
    b_like int default 0,
    b_hits int default 0,
    b_category int not null,
    constraint pk_naver_board primary key(b_number),
    constraint fk_naver_board foreign key(b_writer) references naver_member(n_id) on delete cascade,
    constraint foreign key(b_category) references naver_category(c_number) on delete cascade
);

-- 댓글
create table naver_comment(
-- auto_increment: 자동 번호를 입력해줌
	c_number int auto_increment,
	c_writer varchar(20) not null,
	c_date datetime not null,
	c_contents varchar(200) not null,
	b_number int,
    constraint primary key(c_number),
    constraint foreign key(c_writer) references naver_member(n_id) on delete cascade,
    constraint foreign key(b_number) references naver_board(b_number) on delete cascade
);

-- 카테고리    
create table naver_category(
	c_number int auto_increment,
	c_name varchar(30),
    constraint primary key(c_number)
);

select * from naver_member;
select * from naver_board;
select * from naver_comment;
select * from naver_category;
select * from information_schema.table_constraints;

-- 신규 회원 2명 가입
insert into naver_member(n_id, n_password, n_name, n_birth, n_gender, n_email, n_phone)
	values('id1', '1q2w3e', '회원1', str_to_date('2000-01-01', '%Y-%m-%d'), 'F', 'aa@hanmail.net', '010-1111-1111');
insert into naver_member(n_id, n_password, n_name, n_birth, n_gender, n_email, n_phone)
	values('id2', '1q2w3e', '회원2', str_to_date('2000-01-01', '%Y-%m-%d'), 'F', 'aa@hanmail.net', '010-1111-1111');
    
-- id1 회원 로그인
select * from naver_member where n_id='id1' and n_password='1234';
-- id1 상세정보 조회
select * from naver_member where n_id='id1';
-- 전체 회원 목록 조회
select * from naver_member;
-- id2 회원 비밀번호 변경
update naver_member set n_password='1234' where n_id='id2';
-- id2 회원탈퇴
delete from naver_member where n_id='id2';
-- 신규 회원  추가
insert into naver_member(n_id, n_password, n_name, n_birth, n_gender, n_email, n_phone)
	values('id3', '1q2w3e', '회원3', str_to_date('2000-01-01', '%Y-%m-%d'), 'F', 'aa@hanmail.net', '010-1111-1111');
-- 카테고리는 자유게시판, 공지사항 추가
insert into naver_category(c_name) values('자유게시판');
insert into naver_category(c_name) values('공지사항');
-- 2. id1 회원 게시글 작성, id2 회원 게시글 작성
insert into naver_board(b_number, b_title, b_writer, b_contents, b_date, b_category)
	values(1, '제목1', 'id1', '내용1', now(), 1);
insert into naver_board(b_number, b_title, b_writer, b_contents, b_date, b_category)
	values(2, '제목2', 'id3', '내용2', now(), 2);
-- 전체 게시글 조회
select * from naver_board;
-- 조회수 순으로 전체 게시글 출력
select * from naver_board order by b_hits asc;
-- 작성일자 순으로 출력
select * from naver_board order by b_date desc;
-- 자유게시판만 출력
select * from naver_board where b_category=1;
-- 두번째 게시글 상세조회
select * from naver_board where b_number=2;
-- 상세조회시 조회수 증가
update naver_board set b_hits = b_hits +1 where b_number=2;
-- id1 회원이 본인 작성 게시글 내용 수정
update naver_board set b_contents='내용수정' where b_number=1;
-- 두번째로 작성된(글번호: 2) 게시글 삭제
delete from naver_board where b_number=2;
-- 1. id1 회원이 1번 게시글에 댓글 작성, id3 회원이 1번, 2번 게시글에 댓글 각각 작성
insert into naver_comment(c_writer, c_date, c_contents, b_number)
	values('id1', now(), '댓글내용1', 1);
insert into naver_comment(c_writer, c_date, c_contents, b_number)
	values('id3', now(), '댓글내용2', 1);
insert into naver_comment(c_writer, c_date, c_contents, b_number)
	values('id3', now(), '댓글내용3', 2);
-- 1번 게시글에 대한 댓글 목록 출력
select * from naver_comment where b_number=1;
-- 2번 게시글에 대한 댓글 목록 출력
select * from naver_comment where b_number=2;


-- --------------------------------------------------------------------------------------
-- 컬럼 추가, 삭제 등
select * from naver_member;
-- 회원 주소를 저장할 컬럼 필요
-- n_address varchar(50)
alter table naver_member add n_address varchar(50);
-- 컬럼 이름 변경
alter table naver_member change n_address n_add varchar(50);
-- 컬럼의 타입, 크기 변경
alter table naver_member modify n_add varchar(100);
alter table naver_member modify n_password varchar(30);
desc naver_member;
-- 컬럼삭제
alter table naver_member drop n_add;

-- db 쿼리 카테고리 정리
/*
	1. DDL: create, alter, drop
	2. DML: insert, select, update, delete
    3. DCL: grant, revoke, commit, rollback
    commit: DB에 쿼리 수행결과를 완전히 반영하는 것
    rollback: commit 이후 수행한 내용을 되돌림.
    ddl, dcl: commit이 같이 수행됨.
    dml 
    commit - commit: transaction(트랜잭션)
*/
 
 -- 커밋, 롤백
 drop table test1;
 create table test1(
	col1 varchar(10),
    col2 varchar(20)
 );
insert into test1(col1, col2) values('aa','aa');
select*from test1;
commit;
rollback;
select @@autocommit; -- 1: autocommit
set autocommit = false;
set autocommit = true;






drop table orders;
drop table book;
drop table customer;

create table orders(
	o_id int auto_increment,
    c_id int,
    b_id int,
    o_saleprice int,
    o_orderdate date,
    constraint primary key(o_id),
    constraint foreign key(c_id) references customer(c_id) on delete cascade,
    constraint foreign key(b_id) references book(b_id) on delete cascade
);
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(1, 1, 6000, str_to_date('2021-07-01', '%Y-%m-%d'));
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(1, 3, 21000, str_to_date('2021-07-03', '%Y-%m-%d'));
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(2, 5, 8000, str_to_date('2021-07-03', '%Y-%m-%d'));
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(3, 6, 6000, str_to_date('2021-07-04', '%Y-%m-%d'));
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(4, 7, 20000, str_to_date('2021-07-05', '%Y-%m-%d'));
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(1, 2, 12000, str_to_date('2021-07-07', '%Y-%m-%d'));
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(4, 8, 13000, str_to_date('2021-07-07', '%Y-%m-%d'));
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(3, 10, 12000, str_to_date('2021-07-08', '%Y-%m-%d'));
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(2, 10, 7000, str_to_date('2021-07-09', '%Y-%m-%d'));
insert into orders(c_id, b_id, o_saleprice, o_orderdate)
	values(3, 8, 13000, str_to_date('2021-07-10', '%Y-%m-%d'));

create table book(
	b_id int auto_increment,
    b_bookname varchar(40),
    b_publisher varchar(40),
    b_price int,
    constraint primary key(b_id)
);
insert into book(b_bookname, b_publisher, b_price)
	values('축구의 역사', '굿스포츠', 7000);
insert into book(b_bookname, b_publisher, b_price)
	values('축구스카우팅 리포트', '나무수', 13000);
insert into book(b_bookname, b_publisher, b_price)
	values('축구의 이해', '대한미디어', 22000);
insert into book(b_bookname, b_publisher, b_price)
	values('배구 바이블', '대한미디어', 35000);
insert into book(b_bookname, b_publisher, b_price)
	values('피겨 교본', '굿스포츠', 8000);
insert into book(b_bookname, b_publisher, b_price)
	values('피칭 단계별기술', '굿스포츠', 6000);
insert into book(b_bookname, b_publisher, b_price)
	values('야구의 추억', '이상미디어', 20000);
insert into book(b_bookname, b_publisher, b_price)
	values('야구를 부탁해', '이상미디어', 13000);
insert into book(b_bookname, b_publisher, b_price)
	values('올림픽 이야기', '삼성당', 7500);
insert into book(b_bookname, b_publisher, b_price)
	values('olympic champions', 'pearson', 13000);

create table customer(
	c_id int auto_increment,
    c_name varchar(40),
    c_address varchar(50),
    c_phone varchar(20),
    constraint primary key(c_id)
);
insert into customer(c_name, c_address, c_phone)
	values('손흥민', '영국 런던', '000-5000-0001');
insert into customer(c_name, c_address, c_phone)
	values('김연아', '대한민국 서울', '000-6000-0001');
insert into customer(c_name, c_address, c_phone)
	values('김연경', '중국 상하이', '000-7000-0001');
insert into customer(c_name, c_address, c_phone)
	values('류현진', '캐나다 토론토', '000-8000-0001');
insert into customer(c_name, c_address, c_phone)
	values('이강인', '스페인 마요르카', null);
    
select*from orders;
select*from book;
select*from customer;

-- 1. 모든 도서의 가격과 도서명 조회 
	select b_price, b_bookname from book;
-- 2. 모든 출판사 이름 조회 
	select b_publisher from book;
-- 2.1 중복값을 제외한 출판사 이름 조회 
	select distinct b_publisher from book;
-- 3. BOOK테이블의 모든 내용 조회 
	select * from book;
-- 4. 20000원 미만의 도서만 조회 
	select * from book where b_price<20000;
-- 5. 10000원 이상 20000원 이하인 도서만 조회
	select * from book where b_price>=10000 and b_price<=20000;
    select * from book where b_price between 10000 and 20000;
-- 6. 출판사가 굿스포츠 또는 대한미디어인 도서 조회 
	select * from book where b_publisher='굿스포츠' or b_publisher='대한미디어';
-- 7. 도서명에 축구가 포함된 모든 도서를 조회
	select * from book where b_bookname like '%축구%';
-- 8. 도서명의 두번째 글자가 구인 도서 조회
	select * from book where b_bookname like '_구%';
-- 9. 축구 관련 도서 중 가격이 20000원 이상인 도서 조회
	select * from book where b_bookname like '%축구%' and b_price>20000;
-- 10. 책 이름순으로 전체 도서 조회
	select * from book order by b_bookname asc;
-- 11. 도서를 가격이 낮은 것 부터 조회하고 같은 가격일 경우 도서명을 가나다 순으로 조회
	select * from book order by b_price asc, b_bookname asc;
    
-- 집계함수, GROUP BY
-- 12. 주문 도서의 총 판매액 조회 
	select sum(o_saleprice) from orders;
    select sum(o_saleprice) as '총판매액' from orders;
-- 13. 1번 고객이 주문한 도서 총 판매액 조회 
	select sum(o_saleprice) from orders where c_id='1';
-- 14. ORDERS 테이블로 부터 평균판매가, 최고판매가, 최저판매가 조회 
	select avg(o_saleprice), min(o_saleprice), max(o_saleprice) from orders; 
-- 15. 고객별로 주문한 도서의 총 수량과 총 판매액 조회 (GROUP BY 활용)
    select c_id, count(o_id), sum(o_saleprice) from orders group by c_id; 
-- 16. 가격이 8,000원 이상인 도서를 구매한 고객에 대해 고객별 주문 도서의 총 수량 조회 (GROUP BY 활용)
--    (단, 8,000원 이상 도서 두 권 이상 구매한 고객만) 
	select c_id, count(o_id) from orders where o_saleprice>=8000 group by c_id having count(o_id)>=2;
-- 17. 2번 고객 총 구매액
	select sum(o_saleprice) from orders where c_id=2;
-- 18. 2번 고객이 구매한 도서의 수
	select count(o_id) from orders where c_id=2;
-- 19. 서점에 있는 도서의 총 권수
	select count(b_id) from book;
-- 20. 출판사의 총 수 
	select count(b_publisher) from book;    
	select count(distinct b_publisher) from book;  

-- 21. 7월 4일 ~ 7일 사이에 주문한 도서의 주문번호 조회 
	select * from orders where o_orderdate between str_to_date('2021-07-04','%Y-%m-%d') and str_to_date('2021-07-07','%Y-%m-%d');
-- 22. 7월 4일 ~ 7일 사이에 주문하지 않은 도서의 주문번호 조회 
	select * from orders where o_orderdate not between str_to_date('2021-07-04','%Y-%m-%d') and str_to_date('2021-07-07','%Y-%m-%d');
-- 23번 부터는 조인 활용 
-- 23. 고객, 주문 테이블 조인하여 고객번호 순으로 정렬
	select * from customer c, orders o where c.c_id=o.c_id order by c.c_id asc;
-- 24. 고객이름(CUSTOMER), 고객이 주문한 도서 가격(ORDERS) 조회 
-- 고객이름: customer, 주문도서가격(orderprice): orders
	select c.c_name, o.o_saleprice from customer c, orders o where c.c_id=o.c_id;
-- 25. 고객별(GROUP)로 주문한 도서의 총 판매액(SUM)과 고객이름을 조회하고 조회 결과를 가나다 순으로 정렬 
	select c.c_name, sum(o.o_saleprice) from customer c, orders o where c.c_id=o.o_id group by c.c_name order by c.c_name;
-- 26. 고객명과 고객이 주문한 도서명을 조회(3테이블 조인)
-- 고객명: customer, 도서명: book, 주문: orders
	select c.c_name, b.b_bookname from book b, customer c, orders o where b.b_id=o.b_id and c.c_id=o.c_id;
    select * from book b, customer c, orders o where b.b_id=o.b_id and c.c_id=o.c_id;
-- 27. 2만원(SALEPRICE) 이상 도서를 주문한 고객의 이름과 도서명을 조회 
	select c.c_name, b.b_bookname from customer c, book b, orders o where o.b_id=b.b_id and c.c_id=o.c_id and o.o_saleprice>=20000;
-- 28. 손흥민 고객의 총 구매액과 고객명을 함께 조회
	select c.c_name, sum(o.o_saleprice) from customer c, orders o where c.c_id=o.c_id and c.c_name='손흥민' group by c.c_name;
    select c.c_name, sum(o.o_saleprice) from customer c, orders o where c.c_id=o.c_id group by c.c_name;
-- 29. 손흥민 고객의 총 구매수량과 고객명을 함께 조회
    select c.c_name, sum(o.o_saleprice), count(o.o_id) from customer c, orders o where c.c_id=o.c_id and c.c_name='손흥민' group by c.c_name;

-- 30. 가장 비싼 도서의 이름을 조회
	select b_bookname from book where b_price = (select max(b_price) from book);
-- 31. 책을 구매한 이력이 있는 고객의 이름을 조회
-- orders 테이블에 있는 고객번호(구매이력이 있는 고객): 1,2,3,4
-- 1,2,3,4, 고객의 이름을 조회
	select c_name from customer where c_id=1 or c_id=2 or c_id=3 or c_id=4;
    select c_name from customer where c_id in(1,2,3,4);
    select c_name from customer where c_id in(select c_id from orders);
-- 32. 도서의 가격(PRICE)과 판매가격(SALEPRICE)의 차이가 가장 많이 나는 주문 조회 
	 select b.b_price-o.o_saleprice from book b, orders o where b.b_id=o.b_id;
     select max(b.b_price-o.o_saleprice) from book b, orders o where b.b_id=o.b_id;
     select * from book b, orders o where b.b_id=o.b_id and b.b_price-o.o_saleprice=6000;
     select * from book b, orders o 
		where b.b_id=o.b_id and b.b_price-o.o_saleprice=(select max(b.b_price-o.o_saleprice) 
			from book b, orders o where b.b_id=o.b_id);
-- 33. 고객별 평균 구매 금액이 도서의 판매 평균 판매 금액 보다 높은 고객의 이름 조회 
-- 도서 판매 평균 금액
	select avg(o_saleprice) from orders;
-- 고객별 평균 구매 금액(orders), 고객이름(cutomer)
	select c.c_name, avg(o.o_saleprice) from orders o, customer c
		where o.c_id=c.c_id group by c.c_name;
-- 그룹핑 결과에서 조건
	select c.c_name, avg(o.o_saleprice) from orders o, customer c
		where o.c_id=c.c_id group by c.c_name 
			having avg(o.o_saleprice)>11800;
-- 서브쿼리 적용
	select c.c_name, avg(o.o_saleprice) from orders o, customer c
		where o.c_id=c.c_id 
			group by c.c_name having avg(o.o_saleprice)>
				(select avg(o_saleprice) from orders);
-- 34. 고객번호가 5인 고객의 주소를 대한민국 인천으로 변경 
    update customer set c_address='대한민국 인천' where c_id=5;
-- 35. 이강인 고객의 주소를 손흥민 고객 주소와 똑같은 값으로 변경 
	update customer set c_address='영국 런던' where c_name='이강인';
    select c_address from customer where c_name='손흥민';
-- mysql(x), oracle(o)
    update customer set c_address=(select c_address from customer where c_name='손흥민') where c_id=5;
-- mysql(o), oracle(x)
    update customer set c_address=(select c_address from (select c_address from customer where c_name='손흥민') temp) where c_id=5;
-- 36. 김씨 성을 가진 고객이 주문한 총 판매액 조회 
-- 김씨 고객 번호 조회
	select c_id from customer where c_name like '김%';
	select sum(o_saleprice) from orders where c_id=2 or c_id=3;
	select sum(o_saleprice) from orders where c_id in(2,3);
	select sum(o_saleprice) from orders where c_id in(select c_id from customer where c_name like '김%');
-- 37. BOOK테이블에 b_isbn 이라는 컬럼 추가 (varchar타입에 크기는 20)
	alter table book add b_isbn varchar(20);
-- 38. b_isbn 컬럼의 타입을 int로 변경 
	alter table book modify b_isbn int;
-- 39. b_isbn 컬럼 이름을 b_isbn1 으로 변경 
	alter table book change b_isbn b_isbn1 int;
-- 40. b_isbn1 컬럼 삭제 
	alter table book drop b_isbn1;
    
    
-- 페이징처리
    
    
    
    
    
    