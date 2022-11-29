-- 피크닉 카테고리 테이블
drop table ficnic_category purge;

create table ficnic_category(
    category_no number(5) primary key,
    category_id number(8) not null,
    category_depth number(2) default '1' not null,
    category_rank number(11) default '1' not null,
    category_name varchar2(100) not null
);

comment on column ficnic_category.category_no is '카테고리 번호';
comment on column ficnic_category.category_id is '카테고리 아이디';
comment on column ficnic_category.category_depth is '카테고리 레벨';
comment on column ficnic_category.category_rank is '카테고리 표시 순위';
comment on column ficnic_category.category_name is '카테고리 이름';


insert into ficnic_category values(1, '00000000', 0, 0, '카테고리 기본');
insert into ficnic_category values(2, '01000000', 1, 1, '아웃도어');
insert into ficnic_category values(3, '02000000', 1, 2, '피트니스');
insert into ficnic_category values(4, '02000000', 1, 3, '공예DIY');

commit;