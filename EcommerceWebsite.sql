CREATE TABLE product (
    id          NUMBER(10, 0) NOT NULL,
    name        VARCHAR2(255),
    type        VARCHAR2(255),
    discount    NUMBER(10, 0),
    avgrating   NUMBER(10, 0),
    material    VARCHAR2(255),
    categoryid  NUMBER(10, 0),
    height      NUMBER(10, 0),
    width       NUMBER(10, 0),
    weight      NUMBER(10, 0),
    description VARCHAR2(255),
    image       VARCHAR2(255),
    brand       VARCHAR2(255),
    madein      VARCHAR2(255),
    amount      NUMBER(10, 0),
    color       VARCHAR2(255),
    CONSTRAINT product_pk PRIMARY KEY ( id )
);
---
CREATE TABLE categories (
    categoriesid    NUMBER(20) NOT NULL,
    categories_name VARCHAR2(100),
    image           VARCHAR2(100),
    CONSTRAINT categories_pk PRIMARY KEY ( categoriesid )
);
---
CREATE TABLE bill (
    bill_id        NUMBER(10, 0) NOT NULL,
    customer_id    NUMBER(10, 0),
    id_bill_status NUMBER(10, 0),
    date_order     DATE,
    total          DECIMAL(10, 0),
    note           VARCHAR2(255),
    status         VARCHAR2(255),
    payment        VARCHAR2(255),
    codemomo       VARCHAR2(255),
    created_at     DATE,
    updated_at     DATE,
    CONSTRAINT bill_pk PRIMARY KEY ( bill_id )
);
---
CREATE TABLE bill_detail (
    id         NUMBER(10, 0) NOT NULL,
    quantity   NUMBER(10, 0),
    price      DECIMAL(10, 0),
    createdat  TIMESTAMP,
    updatedat  TIMESTAMP,
    id_bill    NUMBER(10, 0),
    id_rating  NUMBER(10, 0),
    id_product NUMBER(10, 0),
    CONSTRAINT bill_detail_pk PRIMARY KEY ( id )
);
--- 
CREATE TABLE bill_status (
    id     NUMBER(10, 0) NOT NULL,
    cartid VARCHAR(100),
    CONSTRAINT bill_status_pk PRIMARY KEY ( id )
);
---
CREATE TABLE cart_product (
    id         NUMBER(10, 0) NOT NULL,
    cart_id    NUMBER(10, 0),
    product_id NUMBER(10, 0),
    quantity   NUMBER(10, 0),
    CONSTRAINT cart_product_pk PRIMARY KEY ( id )
);
------
CREATE TABLE rating (
    id              NUMBER(10, 0) NOT NULL,
    comment_product VARCHAR2(200),
    ratescore       NUMBER(10, 0),
    iduser          NUMBER(10, 0),
    CONSTRAINT rating_pk PRIMARY KEY ( id )
);
---
CREATE TABLE cart_coupon (
    id        NUMBER(10, 0) NOT NULL,
    cart_id   NUMBER(10, 0),
    coupon_id NUMBER(10, 0),
    CONSTRAINT cart_coupon_pk PRIMARY KEY ( id )
);
--- 
CREATE TABLE coupon (
    id       NUMBER(10, 0) NOT NULL,
    name     VARCHAR2(200),
    discount NUMBER(10, 0),
    CONSTRAINT coupon_pk PRIMARY KEY ( id )
);
---
CREATE TABLE cart (
    id    NUMBER(10, 0) NOT NULL,
    total DECIMAL(10, 0),
    CONSTRAINT cart_pk PRIMARY KEY ( id )
);
---
CREATE TABLE account (
    id               NUMBER(10, 0) NOT NULL,
    email            VARCHAR2(255),
    account_password VARCHAR2(255),
    CONSTRAINT account_pk PRIMARY KEY ( id )
);
---
CREATE TABLE user_website (
    id        NUMBER(10, 0) NOT NULL,
    user_name VARCHAR2(255),
    address   VARCHAR2(255),
    phone     NUMBER(11, 0),
    idcart    NUMBER(10, 0),
    idaccount NUMBER(10, 0),
    CONSTRAINT user_website_pk PRIMARY KEY ( id )
);
--- 
CREATE TABLE user_role (
    id      NUMBER(10, 0) NOT NULL,
    id_role NUMBER(10, 0),
    iduser  NUMBER(10, 0),
    CONSTRAINT user_role_pk PRIMARY KEY ( id )
);
--
CREATE TABLE role (
    id        NUMBER(10, 0) NOT NULL,
    name_role VARCHAR2(50),
    CONSTRAINT role_pk PRIMARY KEY ( id )
);
--
CREATE TABLE function (
    id           NUMBER(10, 0) NOT NULL,
    name         VARCHAR2(255),
    display_name NUMBER(10, 0),
    CONSTRAINT function_pk PRIMARY KEY ( id )
);
--
CREATE TABLE role_function (
    id          NUMBER(10, 0) NOT NULL,
    role_id     NUMBER(10, 0),
    function_id NUMBER(10, 0),
    CONSTRAINT role_function_pk PRIMARY KEY ( id )
);



-- Khoa ngoai -> khoa chinh
--
SELECT a.table_name,a.constraint_name
  FROM all_cons_columns a;

                     
  
--
--  Role_Function - Role 
ALTER TABLE role_function
    ADD CONSTRAINT fk01_r_rf FOREIGN KEY ( role_id )
        REFERENCES role ( id );
         
-- USER_ROLE - Role 
ALTER TABLE user_role
    ADD CONSTRAINT fk02 FOREIGN KEY ( id_role )
        REFERENCES role ( id );

-- ROLE_FUNCTION - FUNCTION
ALTER TABLE role_function
    ADD CONSTRAINT fk03_rf_f FOREIGN KEY ( function_id )
        REFERENCES function ( id );
        
-- USER_ROLE - USER_WEBSITE
ALTER TABLE user_role
    ADD CONSTRAINT fk04 FOREIGN KEY ( iduser )
        REFERENCES user_website ( id );
        
--  USER_WEBSITE- ACCOUNT
ALTER TABLE user_website
    ADD CONSTRAINT fk05 FOREIGN KEY ( idaccount )
        REFERENCES account ( id );
--USER_WEBSITE - CART
ALTER TABLE user_website
    ADD CONSTRAINT fk06 FOREIGN KEY ( idcart )
        REFERENCES cart ( id );
-- CART_COUPON - CART
ALTER TABLE cart_coupon
    ADD CONSTRAINT fk07 FOREIGN KEY ( cart_id )
        REFERENCES cart ( id );
-- CART_COUPON - COUPON
ALTER TABLE cart_coupon
    ADD CONSTRAINT fk08 FOREIGN KEY ( coupon_id )
        REFERENCES coupon ( id );
-- BILL - USER_WEBSITE
ALTER TABLE bill
    ADD CONSTRAINT fk09 FOREIGN KEY ( customer_id )
        REFERENCES user_website ( id );
        
-- RATING - USER_WEBSITE
ALTER TABLE rating
    ADD CONSTRAINT fk10 FOREIGN KEY ( iduser )
        REFERENCES user_website ( id );

-- CART_PRODUCT - CART
ALTER TABLE cart_product
    ADD CONSTRAINT fk11 FOREIGN KEY ( cart_id )
        REFERENCES cart ( id );

-- BILL - BILL_STATUS
ALTER TABLE bill
    ADD CONSTRAINT fk12 FOREIGN KEY ( id_bill_status )
        REFERENCES bill_status ( id );

--  BILL_DETAIL - BILL 
ALTER TABLE bill_detail
    ADD CONSTRAINT fk13 FOREIGN KEY ( id_bill )
        REFERENCES bill ( bill_id );

-- BILL_DETAIL - RATING
ALTER TABLE bill_detail
    ADD CONSTRAINT fk14 FOREIGN KEY ( id_rating )
        REFERENCES rating ( id );

--BILL_DETAIL - PRODUCT
ALTER TABLE bill_detail
    ADD CONSTRAINT fk15 FOREIGN KEY ( id_product )
        REFERENCES product ( id );

--CART_PRODUCT - PRODUCT
ALTER TABLE cart_product
    ADD CONSTRAINT fk16 FOREIGN KEY ( product_id )
        REFERENCES product ( id );

--PRODUCT - CATEGORIES
ALTER TABLE product
    ADD CONSTRAINT fk17 FOREIGN KEY ( categoryid )
        REFERENCES categories ( categoriesid );
        
--INSERT DATA

--TABLE ACCOUNT
CREATE SEQUENCE account_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;
    
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, 'darklord0305@gmail.com', '123456789');
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, 'thelionking0305@gmail.com', '123456789');
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, 'thanhluan130201@gmail.com', '123456789');
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, '0.199qui@gmail.com', '123456789');
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, 'nguyenvanan@gmail.com', '123456789');
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, 'nguyenthiphuong123@gmail.com', '123456789');
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, 'dinhvanbua125@gmail.com', '123456789');
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, 'helloworld125@gmail.com', '123456789');
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, 'nguyenvanhieu123@gmail.com', '123456789');
INSERT INTO account ( id, email, account_password) values (account_seq.NEXTVAL, 'buivantinh123@gmail.com', '123456789');

--TABLE CART
CREATE SEQUENCE cart_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;

INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 100000);
INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 200000);
INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 123000);
INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 400000);
INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 1000000);
INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 2000000);
INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 10000000);
INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 10000);
INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 13548125);
INSERT INTO CART (ID, TOTAL) VALUES (cart_seq.NEXTVAL, 15489641);

--TABLE USER_WEBSITE
CREATE SEQUENCE user_website_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;
    
--CHANGE DATATYPE OF COLUMN PHONE
ALTER TABLE user_website
    MODIFY PHONE VARCHAR2(15);
    
INSERT INTO user_website values (user_website_seq.NEXTVAL, 'Nguy?n Vi?t Qu�', 'Ch? Puh, Gia Lai', '0134567896', 1, 1);
INSERT INTO user_website values (user_website_seq.NEXTVAL, 'Ph?m Ph�c H?u', 'V?ng T�u', '0125487898', 2, 2);
INSERT INTO user_website values (user_website_seq.NEXTVAL, 'L� Th�nh Lu�n', 'V?ng T�u', '0125487897', 3, 3);
INSERT INTO user_website values (user_website_seq.NEXTVAL, 'Nguy?n V?n A', 'TP.H? Ch� Minh', '0125487154', 4, 4);
INSERT INTO user_website values (user_website_seq.NEXTVAL, '?inh C�ng L??ng', 'Qu?ng B�nh', '0125487458', 5, 5);
INSERT INTO user_website values (user_website_seq.NEXTVAL, 'Duy M?nh', 'Ngh? An', '0125487487', 6, 6);
INSERT INTO user_website values (user_website_seq.NEXTVAL, 'Nguy?n V?n Minh', 'B�nh Thu?n', '0125487879', 7, 7);
INSERT INTO user_website values (user_website_seq.NEXTVAL, 'Nguy?n V?n S�', 'L�o Cai', '0125487147', 8, 8);
INSERT INTO user_website values (user_website_seq.NEXTVAL, 'Aladin', 'B�nh D??ng', '0125484587', 9, 9);
INSERT INTO user_website values (user_website_seq.NEXTVAL, 'Nguy?n V?n Hi?u', 'Dak Lak', '0125487852', 10, 10);

--TABLE COUPON
--ADD COLUMN FOR COUPON TABLE
ALTER TABLE COUPON
    ADD (MIN_PRICE_APPLY NUMBER(10,0),
         MAX_PRICE NUMBER(10,0),
         CODE VARCHAR2(20),
         AMOUNT NUMBER(10,0));
         
ALTER TABLE COUPON
    MODIFY DISCOUNT NUMBER(3,2);
    
CREATE SEQUENCE coupon_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;
    
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Khuy?n m�i cho kh�ch h�ng m?i', 0.1, 0, 50000, 'KMKHM', 50);
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Gi?m 10% Gi?m t?i ?a 50,000? ??n t?i thi?u 99,000?', 0.1, 99000, 50000, 'HUJUI', 30);
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Gi?m 20,000? ??n t?i thi?u 199,000?', 0, 199000, 20000, 'HUYEJ', 30);
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Gi?m 10% Gi?m t?i ?a 300,000? ??n t?i thi?u 499,000?', 0.1, 499000, 300000, 'YUITLR', 30);
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Gi?m 50,000? ??n t?i thi?u 0?', 0, 0, 50000, 'QIEHFU', 30);
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Gi?m 10,000? ??n t?i thi?u 120,000?', 0, 120000, 10000, 'TEWUYG', 30);
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Gi?m 5% Gi?m t?i ?a 500,000? ??n t?i thi?u 300,000?', 0.05, 300000, 500000, 'OIUYTR', 30);
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Gi?m 150,000? ??n t?i thi?u 1,500,000?', 0, 1500000, 150000, 'RTEGDT', 30);
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Gi?m 10% Gi?m t?i ?a 60,000? ??n t?i thi?u 400,000?', 0.1, 400000, 60000, 'YEUWGY', 30);
INSERT INTO coupon VALUES (coupon_seq.NEXTVAL, 'Gi?m 10% Gi?m t?i ?a 100,000? ??n t?i thi?u 600,000?', 0.1, 600000, 100000, 'EGYFGE', 30);

--TABLE CART_COUPON
CREATE SEQUENCE cart_coupon_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;
    
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 1, 1);
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 2, 1);
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 3, 3);
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 4, 7);
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 5, 6);
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 6, 9);
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 7, 10);
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 8, 1);
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 9, 1);
INSERT INTO cart_coupon VALUES (cart_coupon_seq.NEXTVAL, 10, 1);

--TABLE ROLE
CREATE SEQUENCE role_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;
    
INSERT INTO role VALUES (role_seq.NEXTVAL, 'Admin');
INSERT INTO role VALUES (role_seq.NEXTVAL, 'Kh�ch');
INSERT INTO role VALUES (role_seq.NEXTVAL, 'Qu?n l� kho');
INSERT INTO role VALUES (role_seq.NEXTVAL, 'Nh�n vi�n b�n h�ng');
INSERT INTO role VALUES (role_seq.NEXTVAL, 'Thu ng�n');
INSERT INTO role VALUES (role_seq.NEXTVAL, 'Qu?n l� nh�n s?');

--TABLE ROLE_USER
CREATE SEQUENCE role_user_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;

INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 1, 1);
INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 2, 2);
INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 1, 3);
INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 1, 4);
INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 2, 5);
INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 2, 6);
INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 3, 7);
INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 4, 8);
INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 5, 9);
INSERT INTO user_role VALUES (role_user_seq.NEXTVAL, 6, 10);

--TABLE FUNCTION
CREATE SEQUENCE function_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;
    
--ALTER DATATYPE OF COLUMN DISPLAY_NAME
ALTER TABLE function
    MODIFY display_name varchar2(200);
    
INSERT INTO function VALUES (function_seq.NEXTVAL, 'Qu?n l� s?n ph?m', 'Th�m, x�a, s?a s?n ph?m');
INSERT INTO function VALUES (function_seq.NEXTVAL, 'Qu?n l� kh�ch h�ng', 'Tra c?u c�c th�ng tin c?a kh�ch h�ng');
INSERT INTO function VALUES (function_seq.NEXTVAL, 'Ph�n quy?n', 'Gi?i h?n ch?c n?ng cho m?t ng??i d�ng');
INSERT INTO function VALUES (function_seq.NEXTVAL, 'Mua h�ng', 'Xem v� th�m s?n ph?m v�o gi? v� ti?n h�nh thanh to�n');
INSERT INTO function VALUES (function_seq.NEXTVAL, 'Qu?n l� khuy?n m�i', 'Th�m, x�a, s?a khuy?n m�i');
INSERT INTO function VALUES (function_seq.NEXTVAL, 'Qu?n l� ??n h�ng', 'Xem, tra c?u t?t c? ??n h�ng c?a c?a h�ng');
INSERT INTO function VALUES (function_seq.NEXTVAL, 'Tra c?u s?n ph?m', 'Tra c?u th�ng tin s?n ph?m');
INSERT INTO function VALUES (function_seq.NEXTVAL, 'Qu?n l� kho h�ng', 'Thay ??i s? l??ng s?n ph?m ?ang c� trong c?a h�ng');
INSERT INTO function VALUES (function_seq.NEXTVAL, 'Th?ng k� v� b�o c�o', 'Xem b�o c�o kinh doanh c?a c?a h�ng');
INSERT INTO function VALUES (function_seq.NEXTVAL, '?�nh gi� s?n ph?m', '?�nh gi� s?n ph?m');

--TABLE ROLE_FUNCTION
CREATE SEQUENCE role_function_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;
    
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 1, 1);
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 1, 2);
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 1, 3);
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 1, 5);
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 1, 6);
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 2, 4);
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 2, 7);
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 3, 8);
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 1, 9);
INSERT INTO role_function VALUES (role_function_seq.NEXTVAL, 2, 2);

