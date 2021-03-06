-- DROP TABLE
DROP TABLE "MEMBER" CASCADE CONSTRAINTS;
DROP TABLE "PROJECT" CASCADE CONSTRAINTS;
DROP TABLE "REWARD" CASCADE CONSTRAINTS;
DROP TABLE "COMMUNITY" CASCADE CONSTRAINTS;
DROP TABLE "NOTICE" CASCADE CONSTRAINTS;
DROP TABLE "FOLLOW" CASCADE CONSTRAINTS;
DROP TABLE "VOTE" CASCADE CONSTRAINTS;
DROP TABLE "PROJECT_CATEGORY" CASCADE CONSTRAINTS;
DROP TABLE "COMMUNITY_CATEGORY" CASCADE CONSTRAINTS;
DROP TABLE "FAQ" CASCADE CONSTRAINTS;
DROP TABLE "REVIEW" CASCADE CONSTRAINTS;
DROP TABLE "PROJECT_STATUS_CATEGORY" CASCADE CONSTRAINTS;
DROP TABLE "RESERVE_REWARD" CASCADE CONSTRAINTS;
DROP TABLE "RESERVE" CASCADE CONSTRAINTS;
DROP TABLE "VISITOR_PER_DAY" CASCADE CONSTRAINTS;
DROP TABLE "VISITOR_COUNT_PER_DAY" CASCADE CONSTRAINTS;
DROP TABLE "BLAME" CASCADE CONSTRAINTS;
DROP TABLE "BLAME_REPLY" CASCADE CONSTRAINTS;
DROP TABLE "AUTO_LOGIN" CASCADE CONSTRAINTS;
DROP TABLE "RESERVE_STATUS_CATEGORY" CASCADE CONSTRAINTS;
DROP TABLE "ROLE_CATEGORY" CASCADE CONSTRAINTS;
DROP TABLE "MEMBER_ROLE_CATEGORY" CASCADE CONSTRAINTS;
DROP TABLE "FILE" CASCADE CONSTRAINTS;
DROP TABLE "FILE_PROJECT" CASCADE CONSTRAINTS;
DROP TABLE "FILE_MEMBER" CASCADE CONSTRAINTS;
DROP TABLE "COUPON" CASCADE CONSTRAINTS;
DROP TABLE "MEMBER_COUPON" CASCADE CONSTRAINTS;
DROP TABLE "OAUTH" CASCADE CONSTRAINTS;
DROP TABLE "CONFIRM_EMAIL" CASCADE CONSTRAINTS;
-- CREATE TABLE
-- DROP SEQUENCE
-- CREATE SEQUENCE
-- PK
CREATE TABLE "OAUTH" (
	"ID" NUMBER NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL,
	"ACCESS_TOKEN" VARCHAR2(255) NOT NULL,
	"PROVIDER" VARCHAR2(255) NOT NULL
);
ALTER TABLE "OAUTH" ADD CONSTRAINT "OAUTH_ID_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "OAUTH_ID_SEQ";
CREATE SEQUENCE "OAUTH_ID_SEQ";
CREATE TABLE "CONFIRM_EMAIL" (
	"MEMBER_ID" NUMBER NOT NULL,
	"DATE_EXPIRED" DATE	DEFAULT SYSDATE	NOT NULL,
	"SECURED_KEY" VARCHAR2(255)	NOT NULL
);
ALTER TABLE "CONFIRM_EMAIL" ADD CONSTRAINT "CONFIRM_EMAIL_PK" PRIMARY KEY ( "MEMBER_ID" );
CREATE TABLE "FILE"(
	"ID" NUMBER NOT NULL,
	"UPLOAD_NAME" VARCHAR2(256) NOT NULL,
	"SAVE_NAME" VARCHAR2(256) NOT NULL UNIQUE, 
	"FILE_SIZE" NUMBER DEFAULT 0, 
	"FILE_TYPE" VARCHAR2(256),
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL
);
ALTER TABLE "FILE" ADD CONSTRAINT "FILE_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "FILE_ID_SEQ";
CREATE SEQUENCE "FILE_ID_SEQ";
CREATE TABLE "FILE_PROJECT"(
	"FILE_ID" NUMBER NOT NULL,
	"PROJECT_ID" NUMBER NOT NULL
);
CREATE TABLE "FILE_MEMBER"(
	"FILE_ID" NUMBER NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL
);
CREATE TABLE "COUPON" (
	"ID" NUMBER NOT NULL,
	"PROJECT_CATEGORY_ID" NUMBER NOT NULL,
	"DISCOUNT_RATE" NUMBER NOT NULL,
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"DATE_UPDATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"DATE_EXPIRED" DATE	NOT NULL
);
ALTER TABLE "COUPON" ADD CONSTRAINT "COUPON_ID_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "COUPON_ID_SEQ";
CREATE SEQUENCE "COUPON_ID_SEQ";
CREATE TABLE "MEMBER_COUPON" (
	"MEMBER_ID" NUMBER NOT NULL,
	"COUPON_ID" NUMBER NOT NULL,
	"USED" VARCHAR2(1)	DEFAULT 'N'	NOT NULL
);
CREATE TABLE "ROLE_CATEGORY" (
	"ID" NUMBER NOT NULL,
	"ROLE_CATEGORY_AUTHORITY" VARCHAR2(255) NOT NULL
);
ALTER TABLE "ROLE_CATEGORY" ADD CONSTRAINT "ROLE_CATEGORY_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "ROLE_CATEGORY_ID_SEQ";
CREATE SEQUENCE "ROLE_CATEGORY_ID_SEQ";
COMMENT ON TABLE "ROLE_CATEGORY" IS '권한';
COMMENT ON COLUMN "ROLE_CATEGORY"."ROLE_CATEGORY_AUTHORITY" IS '권한 종류 - 모든/대시보드/프로젝트/계정/공지사항';
CREATE TABLE "MEMBER_ROLE_CATEGORY" (
	"MEMBER_ID" NUMBER NOT NULL,
	"ROLE_CATEGORY_ID" NUMBER NOT NULL
);
COMMENT ON TABLE "MEMBER_ROLE_CATEGORY" IS '유저-권한 관계';
CREATE TABLE "AUTO_LOGIN" (
	"MEMBER_ID" NUMBER NOT NULL,
	"SESSIONKEY" VARCHAR2(500) NULL,
	"DATE_EXPIRED" DATE NULL
);
CREATE TABLE "RESERVE_STATUS_CATEGORY" (
	"ID" NUMBER NOT NULL,
	"DETAIL" VARCHAR2(100) NOT NULL
);
ALTER TABLE "RESERVE_STATUS_CATEGORY" ADD CONSTRAINT "RESERVE_STATUS_CATEGORY_PK" PRIMARY KEY ( "ID" );
COMMENT ON COLUMN "RESERVE_STATUS_CATEGORY"."DETAIL" IS '카테고리 종류 - 대기/결제 완료/취소/배송완료/환불/교환 등';
CREATE TABLE "MEMBER" (
	"ID" NUMBER NOT NULL,
	"EMAIL" VARCHAR2(100) NOT NULL,
	"NICKNAME" VARCHAR2(100) NOT NULL,
	"PWD" VARCHAR2(100) NOT NULL,
	"IS_EMAIL_VERIFIED" VARCHAR2(1) DEFAULT 'N' NOT NULL,
	"IS_DELETED" VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	"DATE_LOGGEDIN" DATE DEFAULT SYSDATE NOT NULL,
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"DATE_UPDATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"ADDRESS" VARCHAR2(1000) NULL,
	"PHONE" VARCHAR2(100) NULL,
	"PROFILE_IMG" VARCHAR2(1000) NULL,
	"PROFILE_DETAIL" VARCHAR2(1000) NULL
);
ALTER TABLE "MEMBER" ADD CONSTRAINT "MEMBER_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "MEMBER_ID_SEQ";
CREATE SEQUENCE "MEMBER_ID_SEQ";
CREATE TABLE "PROJECT_CATEGORY" (
	"ID" NUMBER NOT NULL,
	"NAME" VARCHAR2(100) NOT NULL
);
ALTER TABLE "PROJECT_CATEGORY" ADD CONSTRAINT "PROJECT_CATEGORY_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "PROJECT_CATEGORY_ID_SEQ";
CREATE SEQUENCE "PROJECT_CATEGORY_ID_SEQ";
CREATE TABLE "PROJECT_STATUS_CATEGORY" (
	"ID" NUMBER NOT NULL,
	"DETAIL" VARCHAR2(100) NOT NULL
);
ALTER TABLE "PROJECT_STATUS_CATEGORY" ADD CONSTRAINT "PROJECT_STATUS_CATEGORY_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "PROJECT_STATUS_CATEGORY_ID_SEQ";
CREATE SEQUENCE "PROJECT_STATUS_CATEGORY_ID_SEQ";
CREATE TABLE "PROJECT" (
	"ID" NUMBER NOT NULL,
	"TITLE" VARCHAR2(100) NOT NULL,
	"SUB_TITLE" VARCHAR2(200) NOT NULL,
	"TARGET_AMOUNT" NUMBER NOT NULL,
	"DATE_PROJECT_STARTED" DATE NOT NULL,
	"DATE_PROJECT_CLOSED" DATE NOT NULL,
	"HASHTAG" VARCHAR2(4000) NULL,
	"THUMB_IMG" VARCHAR2(400) NOT NULL,
	"MAIN_IMG" VARCHAR2(400) NOT NULL,
	"SUMMARY" VARCHAR2(400) NOT NULL,
	"STORY" CLOB NOT NULL,
	"WRITER_NAME" VARCHAR2(100) NOT NULL,
	"WRITER_PROFILE_IMG" VARCHAR2(400) NOT NULL,
	"WRITER_SNS_INSTAGRAM" VARCHAR2(100) NULL,
	"WRITER_SNS_FACEBOOK" VARCHAR2(100) NULL,
	"WRITER_PHONE" VARCHAR2(100) NULL,
	"WRITER_EMAIL" VARCHAR2(100) NULL,
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"DATE_UPDATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL,
	"PROJECT_CATEGORY_ID" NUMBER NOT NULL,
	"PROJECT_STATUS_CATEGORY_ID" NUMBER NOT NULL
);
ALTER TABLE "PROJECT" ADD CONSTRAINT "PROJECT_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "PROJECT_ID_SEQ";
CREATE SEQUENCE "PROJECT_ID_SEQ";
CREATE TABLE "REWARD" (
	"ID" NUMBER NOT NULL,
	"PRICE" NUMBER NOT NULL,
	"NAME" VARCHAR2(200) NOT NULL,
	"DETAIL" VARCHAR2(4000) NOT NULL,
	"MAX_STOCK" NUMBER	DEFAULT 0	NOT NULL,
	"IS_ADDRESS_REQUIRED" VARCHAR2(1)	DEFAULT 'Y'	NOT NULL,
	"DATE_DELIVERY_ESTIMATED" DATE NOT NULL,
	"PROJECT_ID" NUMBER NOT NULL,
	"OPTION_FORM" VARCHAR2(1000)
);
ALTER TABLE "REWARD" ADD CONSTRAINT "REWARD" PRIMARY KEY ( "ID" );
DROP SEQUENCE "REWARD_ID_SEQ";
CREATE SEQUENCE "REWARD_ID_SEQ";
CREATE TABLE "RESERVE_REWARD" (
	"RESERVE_ID" NUMBER NOT NULL,
	"REWARD_ID" NUMBER NOT NULL,
	"REWARD_SUM" NUMBER	DEFAULT 1	NOT NULL
);
ALTER TABLE "RESERVE_REWARD" ADD CONSTRAINT "RESERVE_REWARD" PRIMARY KEY ( "RESERVE_ID", "REWARD_ID" );
CREATE TABLE "RESERVE" (
	"ID" NUMBER NOT NULL,
	"BILLINGKEY" VARCHAR2(4000) NOT NULL,
	"ADDITIONAL_BILLINGS" NUMBER	DEFAULT 0	NOT NULL,
	"DATE_CREATED" DATE NOT NULL,
	"RECEIVER_NAME" VARCHAR2(100) NOT NULL,
	"RECEIVER_PHONE" NUMBER NOT NULL,
	"RECEIVER_ADDRESS" VARCHAR2(4000) NOT NULL,
	"REQUEST_FOR_DELIVERY" VARCHAR2(300) NULL,
	"MEMBER_ID" NUMBER NOT NULL
);
ALTER TABLE "RESERVE" ADD CONSTRAINT "RESERVE_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "RESERVE_ID_SEQ";
CREATE SEQUENCE "RESERVE_ID_SEQ";
CREATE TABLE "COMMUNITY_CATEGORY" (
	"ID" NUMBER NOT NULL,
	"NAME" VARCHAR2(100) NOT NULL
);
ALTER TABLE "COMMUNITY_CATEGORY" ADD CONSTRAINT "COMMUNITY_CATEGORY" PRIMARY KEY ( "ID" );
DROP SEQUENCE "COMMUNITY_CATEGORY_ID_SEQ";
CREATE SEQUENCE "COMMUNITY_CATEGORY_ID_SEQ";
COMMENT ON COLUMN "COMMUNITY_CATEGORY"."NAME" IS '값 종류 - 문의, 응원 등';
CREATE TABLE "COMMUNITY" (
	"ID" NUMBER NOT NULL,
	"CONTENT" VARCHAR2(4000) NOT NULL,
	"IS_DELETED" VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"DATE_UPDATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"PROJECT_ID" NUMBER NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL,
	"COMMUNITY_CATEGORY_ID" NUMBER NOT NULL,
	"PARENT_ID" NUMBER
);
ALTER TABLE "COMMUNITY" ADD CONSTRAINT "COMMUNITY_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "COMMUNITY_ID_SEQ";
CREATE SEQUENCE "COMMUNITY_ID_SEQ";
CREATE TABLE "FOLLOW" (
	"FOLLOW" NUMBER NOT NULL,
	"FOLLOWER" NUMBER NOT NULL
);
ALTER TABLE "FOLLOW" ADD CONSTRAINT "FOLLOW_PK" PRIMARY KEY ( "FOLLOW", "FOLLOWER" );
CREATE TABLE "VOTE" (
	"MEMBER_ID" NUMBER NOT NULL,
	"PROJECT_ID" NUMBER NOT NULL
);
ALTER TABLE "VOTE" ADD CONSTRAINT "VOTE_PK" PRIMARY KEY ( "MEMBER_ID", "PROJECT_ID" );
CREATE TABLE "REVIEW" (
	"ID" NUMBER NOT NULL,
	"TITLE" VARCHAR2(300) NOT NULL,
	"CONTENT" CLOB NOT NULL,
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"DATE_UPDATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"IS_DELETED" VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	"PROJECT_ID" NUMBER NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL
);
ALTER TABLE "REVIEW" ADD CONSTRAINT "REVIEW_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "REVIEW_ID_SEQ";
CREATE SEQUENCE "REVIEW_ID_SEQ";
CREATE TABLE "BLAME" (
	"ID" NUMBER NOT NULL,
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"CONTENT" VARCHAR2(4000) NOT NULL,
	"PROJECT_ID" NUMBER NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL
);
ALTER TABLE "BLAME" ADD CONSTRAINT "BLAME_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "BLAME_ID_SEQ";
CREATE SEQUENCE "BLAME_ID_SEQ";
CREATE TABLE "BLAME_REPLY" (
	"ID" NUMBER NOT NULL,
	"CONTENT" VARCHAR2(4000) NULL,
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"BLAME_ID" NUMBER NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL
);
ALTER TABLE "BLAME_REPLY" ADD CONSTRAINT "BLAME_REPLY_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "BLAME_REPLY_ID_SEQ";
CREATE SEQUENCE "BLAME_REPLY_ID_SEQ";
CREATE TABLE "FAQ" (
	"ID" NUMBER NOT NULL,
	"TITLE" VARCHAR2(300) NOT NULL,
	"CONTENT" CLOB NOT NULL,
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"DATE_UPDATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"IS_DELETED" VARCHAR2(1) DEFAULT 'N' NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL
);
ALTER TABLE "FAQ" ADD CONSTRAINT "FAQ_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "FAQ_ID_SEQ";
CREATE SEQUENCE "FAQ_ID_SEQ";
CREATE TABLE "NOTICE" (
	"ID" NUMBER NOT NULL,
	"TITLE" VARCHAR2(300) NOT NULL,
	"CONTENT" CLOB NOT NULL,
	"DATE_CREATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"DATE_UPDATED" DATE	DEFAULT SYSDATE	NOT NULL,
	"IS_DELETED" VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL
);
ALTER TABLE "NOTICE" ADD CONSTRAINT "NOTICE_PK" PRIMARY KEY ( "ID" );
DROP SEQUENCE "NOTICE_ID_SEQ";
CREATE SEQUENCE "NOTICE_ID_SEQ";
CREATE TABLE "VISITOR_PER_DAY" (
	"DATE_VISITED" DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_ID" NUMBER NOT NULL
);
ALTER TABLE "VISITOR_PER_DAY" ADD CONSTRAINT "VISITOR_PER_DAY_PK" PRIMARY KEY ( "DATE_VISITED", "MEMBER_ID" );
CREATE TABLE "VISITOR_COUNT_PER_DAY" (
	"DATE_VISITED" DATE	DEFAULT SYSDATE	NOT NULL,
	"COUNT" NUMBER NOT NULL
);
ALTER TABLE "VISITOR_COUNT_PER_DAY" ADD CONSTRAINT "VISITOR_COUNT_PER_DAY_PK" PRIMARY KEY ( "DATE_VISITED" );
-- FK
ALTER TABLE "PROJECT" ADD CONSTRAINT "FK_MEM_TO_PROJECT_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "PROJECT" ADD CONSTRAINT "FK_PJT_CATE_TO_PJT_1" FOREIGN KEY ( "PROJECT_CATEGORY_ID" ) REFERENCES "PROJECT_CATEGORY" ( "ID" );
ALTER TABLE "PROJECT" ADD CONSTRAINT "FK_PJT_STAT_CATE_TO_PJT_1" FOREIGN KEY ( "PROJECT_STATUS_CATEGORY_ID" ) REFERENCES "PROJECT_STATUS_CATEGORY" ( "ID" );
ALTER TABLE "REWARD" ADD CONSTRAINT "FK_PJT_TO_REWARD_1" FOREIGN KEY ( "PROJECT_ID" ) REFERENCES "PROJECT" ( "ID" );
ALTER TABLE "COMMUNITY" ADD CONSTRAINT "FK_PJT_TO_COMM_1" FOREIGN KEY ( "PROJECT_ID" ) REFERENCES "PROJECT" ( "ID" );
ALTER TABLE "COMMUNITY" ADD CONSTRAINT "FK_MEM_TO_COMM_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "COMMUNITY" ADD CONSTRAINT "FK_COMM_CATE_TO_COMM_1" FOREIGN KEY ( "COMMUNITY_CATEGORY_ID" ) REFERENCES "COMMUNITY_CATEGORY" ( "ID" );
ALTER TABLE "NOTICE" ADD CONSTRAINT "FK_MEM_TO_NOTICE_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "FOLLOW" ADD CONSTRAINT "FK_MEM_TO_FOLLOW_1" FOREIGN KEY ( "FOLLOW" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "FOLLOW" ADD CONSTRAINT "FK_MEM_TO_FOLLOW_2" FOREIGN KEY ( "FOLLOWER" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "VOTE" ADD CONSTRAINT "FK_MEM_TO_VOTE_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "VOTE" ADD CONSTRAINT "FK_PJT_TO_VOTE_1" FOREIGN KEY ( "PROJECT_ID" ) REFERENCES "PROJECT" ( "ID" );
ALTER TABLE "FAQ" ADD CONSTRAINT "FK_MEM_TO_FAQ_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_PJT_TO_REVIEW_1" FOREIGN KEY ( "PROJECT_ID" ) REFERENCES "PROJECT" ( "ID" );
ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_MEM_TO_REVIEW_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "RESERVE_REWARD" ADD CONSTRAINT "FK_RSV_TO_RSV_RWD_1" FOREIGN KEY ( "RESERVE_ID" ) REFERENCES "RESERVE" ( "ID" );
ALTER TABLE "RESERVE_REWARD" ADD CONSTRAINT "FK_RSV_TO_RSV_RWD_2" FOREIGN KEY ( "REWARD_ID" ) REFERENCES "REWARD" ( "ID" );
ALTER TABLE "RESERVE" ADD CONSTRAINT "FK_MEM_TO_RESERVE_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "VISITOR_PER_DAY" ADD CONSTRAINT "FK_MEM_TO_VISITOR_PER_DAY_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "BLAME" ADD CONSTRAINT "FK_PJT_TO_BLAME_1" FOREIGN KEY ( "PROJECT_ID" ) REFERENCES "PROJECT" ( "ID" );
ALTER TABLE "BLAME" ADD CONSTRAINT "FK_MEM_TO_BLAME_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "BLAME_REPLY" ADD CONSTRAINT "FK_BLAME_TO_BLM_RPL_1" FOREIGN KEY ( "BLAME_ID" ) REFERENCES "BLAME" ( "ID" );
ALTER TABLE "BLAME_REPLY" ADD CONSTRAINT "FK_MEM_TO_BLM_RPL_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "AUTO_LOGIN" ADD CONSTRAINT "FK_MEM_TO_AUTO_LOGIN_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "FILE_PROJECT" ADD CONSTRAINT "FK_FILE_PJT_TO_FILE_1" FOREIGN KEY ( "FILE_ID" ) REFERENCES "FILE" ( "ID" );
ALTER TABLE "FILE_PROJECT" ADD CONSTRAINT "FK_FILE_PJT_TO_PJT_1" FOREIGN KEY ( "PROJECT_ID" ) REFERENCES "PROJECT" ( "ID" );
ALTER TABLE "FILE_MEMBER" ADD CONSTRAINT "FK_FILE_MEM_TO_FILE_1" FOREIGN KEY ( "FILE_ID" ) REFERENCES "FILE" ( "ID" );
ALTER TABLE "FILE_MEMBER" ADD CONSTRAINT "FK_FILE_MEM_TO_MEM_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "MEMBER_COUPON" ADD CONSTRAINT "FK_MEM_COUP_TO_MEM_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "MEMBER_COUPON" ADD CONSTRAINT "FK_MEM_COUP_TO_COUP_1" FOREIGN KEY ( "COUPON_ID" ) REFERENCES "COUPON" ( "ID" );
ALTER TABLE "MEMBER_ROLE_CATEGORY" ADD CONSTRAINT "FK_MEM_TO_MEM_1" FOREIGN KEY ( "MEMBER_ID" ) REFERENCES "MEMBER" ( "ID" );
ALTER TABLE "MEMBER_ROLE_CATEGORY" ADD CONSTRAINT "FK_MEM_TO_MEM_ROLE_CATE_1" FOREIGN KEY ( "ROLE_CATEGORY_ID" ) REFERENCES "ROLE_CATEGORY" ( "ID" );
ALTER TABLE "COMMUNITY" ADD CONSTRAINT "COMM_TO_COMM_1_FK" FOREIGN KEY ( "PARENT_ID" ) REFERENCES "COMMUNITY" ( "ID" );
