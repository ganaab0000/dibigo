
-- ROLE_CATEGORY
INSERT INTO "ROLE_CATEGORY"(ID, ROLE_CATEGORY_AUTHORITY) 
VALUES(ROLE_CATEGORY_ID_SEQ.NEXTVAL, 'ALL');

INSERT INTO "ROLE_CATEGORY"(ID, ROLE_CATEGORY_AUTHORITY) 
VALUES(ROLE_CATEGORY_ID_SEQ.NEXTVAL, 'MEMBER');

INSERT INTO "ROLE_CATEGORY"(ID, ROLE_CATEGORY_AUTHORITY) 
VALUES(ROLE_CATEGORY_ID_SEQ.NEXTVAL, 'PROJECT');

INSERT INTO "ROLE_CATEGORY"(ID, ROLE_CATEGORY_AUTHORITY) 
VALUES(ROLE_CATEGORY_ID_SEQ.NEXTVAL, 'NOTICE');

-- ROOT MEMBER
INSERT INTO "MEMBER"(ID, EMAIL, NICKNAME, PWD, IS_EMAIL_VERIFIED) 
VALUES(MEMBER_ID_SEQ.NEXTVAL, 'ADMIN@ADMIN.COM', 'ADMIN', 'ADMIN', 'Y');

-- MEMBER ROLE_CATEGORY
INSERT INTO "MEMBER_ROLE_CATEGORY"(MEMBER_ID, ROLE_CATEGORY_ID) 
VALUES(
    (SELECT ID FROM "MEMBER" WHERE NICKNAME = 'ADMIN'), 
    (SELECT ID FROM "ROLE_CATEGORY" WHERE ROLE_CATEGORY_AUTHORITY = 'ALL')
);

COMMIT;
