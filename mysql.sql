-- database 생성
create database mysql_cjh;
create database mysql_cjh2;
create database spring_study;
create database memberBoard;

-- 사용자 생성
create user user_cjh@localhost identified by '1234';
create user user_cjh2@localhost identified by '1234';
create user spring_cjh@localhost identified by '1234';
create user memberBoard_cjh@localhost identified by '1234';

-- 사용자 삭제
drop user user_cjh@localhost;
drop user user_cjh@localhost;
drop user spring_cjh@localhost;
drop user memberBoard_cjh@localhost;

-- user_cjh에게 mysql_cjh 사용 권한 부여
grant all privileges on mysql_cjh.* to user_cjh@localhost;
grant all privileges on mysql_cjh2. * to user_cjh2@localhost;
grant all privileges on spring_study.* to spring_cjh@localhost;
grant all privileges on memberBoard.* to memberBoard_cjh@localhost;

select user();