
-- 테이블 삭제
drop table "user" cascade constraints;
drop table "project" cascade constraints;
drop table "reward" cascade constraints;
drop table "community" cascade constraints;
drop table "notice" cascade constraints;
drop table "follow" cascade constraints;
drop table "like" cascade constraints;
drop table "project_category" cascade constraints;
drop table "community_category" cascade constraints;
drop table "faq" cascade constraints;
drop table "review" cascade constraints;
drop table "project_status_category" cascade constraints;
drop table "reserve_reward" cascade constraints;
drop table "reserve" cascade constraints;
drop table "visitor_per_day" cascade constraints;
drop table "visitor_count_per_day" cascade constraints;
drop table "blame" cascade constraints;
drop table "blame_reply" cascade constraints;
drop table "auto_login" cascade constraints;
drop table "reserve_status_category" cascade constraints;
drop table "role" cascade constraints;
drop table "user_role" cascade constraints;
drop table "file" cascade constraints;
drop table "file_project" cascade constraints;
drop table "file_user" cascade constraints;
drop table "coupon" cascade constraints;
drop table "user_coupon" cascade constraints;
drop table "oauth" cascade constraints;
drop table "confirm_email" cascade constraints;
-- 테이블 생성
create table "oauth" (
	"id" number not null,
	"user_id" number not null,
	"access_token" varchar2(255) not null,
	"provider" varchar2(255) not null
);
alter table "oauth" add constraint "oauth_id_pk" primary key ( "id" );
drop sequence "oauth_id_seq";
create sequence "oauth_id_seq";

create table "confirm_email" (
	"user_id" number not null,
	"date_expired" date	default sysdate	not null,
	"secured_key" varchar2(255)	not null
);
alter table "confirm_email" add constraint "confirm_email_pk" primary key ( "user_id" );

create table "file"(
	"id" number not null,
	"upload_name" varchar2(256) not null,
	"save_name" varchar2(256) not null unique, 
	"file_size" number default 0, 
	"file_type" varchar2(256),
	"date_created" date	default sysdate	not null
);
alter table "file" add constraint "file_pk" primary key ( "id" );
drop sequence "file_id_seq";
create sequence "file_id_seq";

create table "file_project"(
	"file_id" number not null,
	"project_id" number not null
);
create table "file_user"(
	"file_id" number not null,
	"user_id" number not null
);

create table "coupon" (
	"id" number not null,
	"project_category_id" number not null,
	"discount_rate" number not null,
	"date_created" date	default sysdate	not null,
	"date_updated" date	default sysdate	not null,
	"date_expired" date	not null
);
alter table "coupon" add constraint "coupon_id_pk" primary key ( "id" );
drop sequence "coupon_id_seq";
create sequence "coupon_id_seq";

create table "user_coupon" (
	"user_id" number not null,
	"coupon_id" number not null,
	"used" varchar2(1)	default 'n'	not null
);

create table "role" (
	"id" number not null,
	"role_authority" varchar2(255) not null
);
alter table "role" add constraint "role_pk" primary key ( "id" );
drop sequence "role_id_seq";
create sequence "role_id_seq";
comment on table "role" is '권한';
comment on column "role"."role_authority" is '권한 종류 - 모든/대시보드/프로젝트/계정/공지사항';

create table "user_role" (
	"user_id" number not null,
	"role_id" number not null
);
alter table "user_role" add constraint "user_role_pk" primary key ( "id" );
comment on table "user_role" is '유저-권한 관계';
create table "auto_login" (
	"user_id" number not null,
	"sessionkey" varchar2(500) null,
	"date_expired" date null
);

-- 위부터 외래키
create table "reserve_status_category" (
	"id" number not null,
	"reserve_st_detail" varchar2(100) not null
);
alter table "reserve_status_category" add constraint "reserve_status_category_pk" primary key ( "id" );
comment on column "auto_login"."auto_login_user_id" is '카테고리 종류 - 대기/결제 완료/취소/배송완료/환불/교환 등';
create table "user" (
	"id" number not null,
	"email" varchar2(100) not null,
	"nickname" varchar2(100) not null,
	"pwd" varchar2(100) not null,
	"is_email_verified" varchar2(1) default 'n' not null,
	"is_deleted" varchar2(1)	default 'n'	not null,
	"date_loggedin" date default sysdate not null,
	"date_created" date	default sysdate	not null,
	"date_updated" date	default sysdate	not null,
	"address" varchar2(1000) null,
	"phone" varchar2(100) null,
	"profile_img" varchar2(1000) null,
	"profile_txt" varchar2(1000) null
);
alter table "user" add constraint "user_pk" primary key ( "id" );
drop sequence "user_id_seq";
create sequence "user_id_seq";

create table "project_category" (
	"id" number not null,
	"name" varchar2(100) not null
);
alter table "project_category" add constraint "project_category_pk" primary key ( "id" );
drop sequence "project_category_id_seq";
create sequence "project_category_id_seq";

create table "project_status_category" (
	"id" number not null,
	"detail" varchar2(100) not null
);
alter table "project_status_category" add constraint "project_status_category_pk" primary key ( "id" );
drop sequence "project_status_category_id_seq";
create sequence "project_status_category_id_seq";
create table "project" (
	"id" number not null,
	"title" varchar2(100) not null,
	"sub_title" varchar2(200) not null,
	"target_amount" number not null,
	"date_project_started" date not null,
	"date_project_closed" date not null,
	"hashtag" varchar2(4000) null,
	"thumb_img" varchar2(400) not null,
	"main_img" varchar2(400) not null,
	"summary" varchar2(400) not null,
	"story" clob not null,
	"writer_name" varchar2(100) not null,
	"writer_profile_img" varchar2(400) not null,
	"writer_sns_instagram" varchar2(100) null,
	"writer_sns_facebook" varchar2(100) null,
	"writer_phone" varchar2(100) null,
	"writer_email" varchar2(100) null,
	"date_created" date	default sysdate	not null,
	"date_updated" date	default sysdate	not null,
	"user_id" number not null,
	"project_category_id" number not null,
	"project_status_category_id" number not null
);
alter table "project" add constraint "project_pk" primary key ( "id" );
drop sequence "project_id_seq";
create sequence "project_id_seq";

create table "reward" (
	"id" number not null,
	"price" number not null,
	"name" varchar2(200) not null,
	"detail" varchar2(4000) not null,
	"max_stock" number	default 0	not null,
	"is_address_required" varchar2(1)	default 'y'	not null,
	"date_delivery_estimated" date not null,
	"project_id" number not null,
	"option_form" varchar2(1000)
);
alter table "reward" add constraint "reward" primary key ( "id" );
drop sequence "reward_id_seq";
create sequence "reward_id_seq";


create table "reserve_reward" (
	"reserve_id" number not null,
	"reward_id" number not null,
	"reward_sum" number	default 1	not null
);
alter table "reserve_reward" add constraint "reserve_reward" primary key ( "reserve_id", "reward_id" );
create table "reserve" (
	"id" number not null,
	"billingkey" varchar2(4000) not null,
	"additional_billings" number	default 0	not null,
	"date_created" date not null,
	"receiver_name" varchar2(100) not null,
	"receiver_phone" number not null,
	"receiver_address" varchar2(4000) not null,
	"request_for_delivery" varchar2(300) null,
	"user_id" number not null
);
alter table "reserve" add constraint "reserve_pk" primary key ( "id" );
drop sequence "reserve_id_seq";
create sequence "reserve_id_seq";

create table "community_category" (
	"id" number not null,
	"name" varchar2(100) not null
);
alter table "community_category" add constraint "community_category" primary key ( "id" );
drop sequence "community_category_id_seq";
create sequence "community_category_id_seq";

comment on column "community_category"."name" is '값 종류 - 문의, 응원 등';
create table "community" (
	"id" number not null,
	"content" varchar2(4000) not null,
	"is_deleted" varchar2(1)	default 'n'	not null,
	"date_created" date	default sysdate	not null,
	"date_updated" date	default sysdate	not null,
	"project_id" number not null,
	"user_id" number not null,
	"community_category_id" number not null,
	"parent_id" number
);
alter table "community" add constraint "community_pk" primary key ( "id" );
alter table "community" add constraint "community_to_community_1_fk" foreign key ( "parent_id" ) references "community" ( "id" );
drop sequence "community_id_seq";
create sequence "community_id_seq";

create table "follow" (
	"follow" number not null,
	"follower" number not null
);
alter table "follow" add constraint "follow_pk" primary key ( "follow", "follower" );
create table "like" (
	"user_id" number not null,
	"project_id" number not null
);
alter table "like" add constraint "like_pk" primary key ( "user_id", "project_id" );
create table "review" (
	"id" number not null,
	"title" varchar2(300) not null,
	"content" clob not null,
	"date_created" date	default sysdate	not null,
	"date_updated" date	default sysdate	not null,
	"is_deleted" varchar2(1)	default 'n'	not null,
	"project_id" number not null,
	"user_id" number not null
);
alter table "review" add constraint "review_pk" primary key ( "id" );
drop sequence "review_id_seq";
create sequence "review_id_seq";

create table "blame" (
	"id" number not null,
	"date_created" date	default sysdate	not null,
	"content" varchar2(4000) not null,
	"project_id" number not null,
	"user_id" number not null
);
alter table "blame" add constraint "blame_pk" primary key ( "id" );
drop sequence "blame_id_seq";
create sequence "blame_id_seq";

create table "blame_reply" (
	"id" number not null,
	"content" varchar2(4000) null,
	"date_created" date	default sysdate	not null,
	"blame_id" number not null,
	"user_id" number not null
);
alter table "blame_reply" add constraint "blame_reply_pk" primary key ( "id" );
drop sequence "blame_reply_id_seq";
create sequence "blame_reply_id_seq";

create table "faq" (
	"id" number not null,
	"title" varchar2(300) not null,
	"content" clob not null,
	"date_created" date	default sysdate	not null,
	"date_updated" date	default sysdate	not null,
	"is_deleted" varchar2(1) default 'n' not null,
	"user_id" number not null
);
alter table "faq" add constraint "faq_pk" primary key ( "id" );
drop sequence "faq_id_seq";
create sequence "faq_id_seq";

create table "notice" (
	"id" number not null,
	"title" varchar2(300) not null,
	"content" clob not null,
	"date_created" date	default sysdate	not null,
	"date_updated" date	default sysdate	not null,
	"is_deleted" varchar2(1)	default 'n'	not null,
	"user_id" number not null
);
alter table "notice" add constraint "notice_pk" primary key ( "id" );
drop sequence "notice_id_seq";
create sequence "notice_id_seq";

create table "visitor_per_day" (
	"date_visited" date	default sysdate	not null,
	"user_id" number not null
);
alter table "visitor_per_day" add constraint "visitor_per_day_pk" primary key ( "date_visited", "user_id" );
create table "visitor_count_per_day" (
	"date_visited" date	default sysdate	not null,
	"count" number not null
);
alter table "visitor_count_per_day" add constraint "visitor_count_per_day_pk" primary key ( "date_visited" );

-- table constraint
-- fk
alter table "project" add constraint "fk_user_to_project_1" foreign key ( "user_id" ) references "user" ( "id" );
alter table "project" add constraint "fk_project_category_to_project_1" foreign key ( "project_category_id" ) references "project_category" ( "id" );
alter table "project" add constraint "fk_project_status_category_to_project_1" foreign key ( "project_status_category_id" ) references "project_status_category" ( "id" );
alter table "reward" add constraint "fk_project_to_reward_1" foreign key ( "project_id" ) references "project" ( "id" );
alter table "community" add constraint "fk_project_to_community_1" foreign key ( "project_id" ) references "project" ( "project_id" );
alter table "community" add constraint "fk_user_to_community_1" foreign key ( "user_id" ) references "user" ( "user_id" );
alter table "community" add constraint "fk_community_category_to_community_1" foreign key ( "community_category_id" ) references "community_category" ( "id" );
alter table "notice" add constraint "fk_user_to_notice_1" foreign key ( "user_id" ) references "user" ( "id" );
alter table "follow" add constraint "fk_user_to_follow_1" foreign key ( "follow" ) references "user" ( "id" );
alter table "follow" add constraint "fk_user_to_follow_2" foreign key ( "follower" ) references "user" ( "id" );
alter table "like" add constraint "fk_user_to_like_1" foreign key ( "user_id" ) references "user" ( "id" );
alter table "like" add constraint "fk_project_to_like_1" foreign key ( "project_id" ) references "project" ( "id" );
alter table "faq" add constraint "fk_user_to_faq_1" foreign key ( "user_id" ) references "user" ( "id" );
alter table "review" add constraint "fk_project_to_review_1" foreign key ( "project_id" ) references "project" ( "id" );
alter table "review" add constraint "fk_user_to_review_1" foreign key ( "user_id" ) references "user" ( "id" );
alter table "reserve_reward" add constraint "fk_reserve_to_reserve_reward_1" foreign key ( "reserve_id" ) references "reserve" ( "id" );
alter table "reserve_reward" add constraint "fk_reward_to_reserve_reward_1" foreign key ( "reward_id" ) references "reward" ( "id" );
alter table "reserve" add constraint "fk_user_to_reserve_1" foreign key ( "user_id" ) references "user" ( "id" );
alter table "visitor_per_day" add constraint "fk_user_to_visitor_per_day_1" foreign key ( "user_id" ) references "user" ( "id" );
alter table "blame" add constraint "fk_project_to_blame_1" foreign key ( "project_id" ) references "project" ( "id" );
alter table "blame" add constraint "fk_user_to_blame_1" foreign key ( "user_id" ) references "user" ( "id" );
alter table "blame_reply" add constraint "fk_blame_to_blame_reply_1" foreign key ( "blame_id" ) references "blame" ( "id" );
alter table "blame_reply" add constraint "fk_user_to_blame_reply_1" foreign key ( "user_id" ) references "user" ( "id" );
alter table "auto_login" add constraint "fk_user_to_auto_login_1" foreign key ( "user_id" ) references "user" ( "id" );
