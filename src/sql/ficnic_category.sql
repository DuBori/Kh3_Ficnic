-- 피크닉 카테고리 테이블
drop table ficnic_category purge;

create table ficnic_category(
    category_no number(5) primary key,
    category_id varchar2(8) not null,
    category_depth number(2) default '1' not null,
    category_id_up varchar2(8) not null,
    category_rank number(11) default '1' not null,
    category_name varchar2(100) not null
);

comment on column ficnic_category.category_no is '카테고리 번호';
comment on column ficnic_category.category_id is '카테고리 아이디';
comment on column ficnic_category.category_depth is '카테고리 레벨';
comment on column ficnic_category.category_id_up is '부모 카테고리 아이디';
comment on column ficnic_category.category_rank is '카테고리 표시 순위';
comment on column ficnic_category.category_name is '카테고리 이름';


insert into ficnic_category values(1, '00000000', 0, 'M', 0, '카테고리 기본');
insert into ficnic_category values(2, '01000000', 1, 'M', 1, '아웃도어');
insert into ficnic_category values(3, '01010000', 2, '01000000', 2, '서핑');
insert into ficnic_category values(4, '01020000', 2, '01000000', 3, '등산·트레킹');
insert into ficnic_category values(5, '01030000', 2, '01000000', 4, '캠핑');
insert into ficnic_category values(6, '02000000', 1, 'M', 5, '피트니스');
insert into ficnic_category values(7, '03000000', 1, 'M', 6, '공예DIY');

commit;