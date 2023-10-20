--
-- maselofQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2023-10-20 18:56:20 MSK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16398)
-- Name: delivery; Type: TABLE; Schema: public; Owner: maselof
--

GRANT CONNECT ON DATABASE wb_orders TO maselof;
GRANT pg_read_all_data TO maselof;
GRANT pg_write_all_data TO maselof;
GRANT USAGE ON SCHEMA public TO maselof;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO maselof;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO maselof;


CREATE TABLE public.delivery (
    id integer NOT NULL,
    name_delivery character varying(64),
    phone character varying(32),
    zip character varying(16),
    city character varying(16),
    address character varying(64),
    region character varying(32),
    email character varying(32)
);


ALTER TABLE public.delivery OWNER TO maselof;

--
-- TOC entry 215 (class 1259 OID 16397)
-- Name: delivery_id_seq; Type: SEQUENCE; Schema: public; Owner: maselof
--

CREATE SEQUENCE public.delivery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delivery_id_seq OWNER TO maselof;

--
-- TOC entry 4387 (class 0 OID 0)
-- Dependencies: 215
-- Name: delivery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maselof
--

ALTER SEQUENCE public.delivery_id_seq OWNED BY public.delivery.id;


--
-- TOC entry 217 (class 1259 OID 16407)
-- Name: items; Type: TABLE; Schema: public; Owner: maselof
--

CREATE TABLE public.items (
    chrt_id bigint NOT NULL,
    price bigint,
    rid character varying(64),
    name_item character varying(64),
    sale integer,
    size_item character varying(8),
    total_price integer,
    nm_id bigint,
    brand character varying(64),
    status integer
);


ALTER TABLE public.items OWNER TO maselof;

--
-- TOC entry 214 (class 1259 OID 16390)
-- Name: orders; Type: TABLE; Schema: public; Owner: maselof
--

CREATE TABLE public.orders (
    order_id character varying(128) NOT NULL,
    entry character varying(64),
    locale character varying(32),
    internal_signature character varying(32),
    customer_id character varying(64),
    delivery_service character varying(32),
    shardkey character varying(16),
    sm_id integer,
    date_created timestamp with time zone,
    oof_shard character varying(16),
    delivery_id integer
);


ALTER TABLE public.orders OWNER TO maselof;

--
-- TOC entry 219 (class 1259 OID 16433)
-- Name: orders_items_relaship; Type: TABLE; Schema: public; Owner: maselof
--

CREATE TABLE public.orders_items_relaship (
    order_id character varying(128),
    item_id bigint
);


ALTER TABLE public.orders_items_relaship OWNER TO maselof;

--
-- TOC entry 218 (class 1259 OID 16410)
-- Name: payment; Type: TABLE; Schema: public; Owner: maselof
--

CREATE TABLE public.payment (
    transaction_payment character varying(128),
    request_id character varying(32),
    currency character varying(8),
    provider character varying(64),
    amount integer,
    payment_dt bigint,
    bank character varying(32),
    delivery_cost integer,
    goods_total integer,
    custom_fee integer
);


ALTER TABLE public.payment OWNER TO maselof;

--
-- TOC entry 4222 (class 2604 OID 16401)
-- Name: delivery id; Type: DEFAULT; Schema: public; Owner: maselof
--

ALTER TABLE ONLY public.delivery ALTER COLUMN id SET DEFAULT nextval('public.delivery_id_seq'::regclass);


--
-- TOC entry 4377 (class 0 OID 16398)
-- Dependencies: 216
-- Data for Name: delivery; Type: TABLE DATA; Schema: public; Owner: maselof
--

COPY public.delivery (id, name_delivery, phone, zip, city, address, region, email) FROM stdin;
1	Test Testov	+9720000000	2639809	Kiryat Mozkin	Ploshad Mira 15	Kraiot	test@gmail.com
2	Test Testov 1	+9720000000	2639801	Kiryat Mozkin 1	Ploshad Mira 11	Kraiot 1	test1@gmail.com
3	Test Testov 2	+9720000000	2639802	Kiryat Mozkin 2	Ploshad Mira 12	Kraiot 2	test2@gmail.com
4	Test Testov 3	+9720000000	2639803	Kiryat Mozkin 3	Ploshad Mira 13	Kraiot 3	test3@gmail.com
5	Test Testov 4	+9720000000	2639804	Kiryat Mozkin 4	Ploshad Mira 14	Kraiot 4	test4@gmail.com
\.


--
-- TOC entry 4378 (class 0 OID 16407)
-- Dependencies: 217
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: maselof
--

COPY public.items (chrt_id, price, rid, name_item, sale, size_item, total_price, nm_id, brand, status) FROM stdin;
9934930	453	ab4219087a764ae0btest	Mascaras	30		317	2389212	Vivienne Sabo	202
9934931	1500	ab4219087a764ae0btest1	shirt	0		1500	2389212	Adidas	202
9934932	2000	ab4219087a764ae0btest2	shorts	0		2000	2389212	Nike	202
9934933	3000	ab4219087a764ae0btest3	blouse	0		3000	2389212	Levi`s	202
9934934	3500	ab4219087a764ae0btest4	jacket	0		3500	2389212	Kappa	202
\.


--
-- TOC entry 4375 (class 0 OID 16390)
-- Dependencies: 214
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: maselof
--

COPY public.orders (order_id, entry, locale, internal_signature, customer_id, delivery_service, shardkey, sm_id, date_created, oof_shard, delivery_id) FROM stdin;
b563feb7b2b84b6test	WBIL		en	test	meest	9	99	2023-10-19 13:58:17.355241+03	1	1
b563feb7b2b84b6test1	WBIL1		en	test1	meest	10	99	2023-10-19 13:59:45.70693+03	1	2
b563feb7b2b84b6test2	WBIL2		en	test2	meest	11	100	2023-10-19 13:59:45.70693+03	2	3
b563feb7b2b84b6test3	WBIL3		en	test3	meest	12	101	2023-10-19 13:59:45.70693+03	3	4
b563feb7b2b84b6test4	WBIL4		en	test4	meest	13	102	2023-10-19 13:59:45.70693+03	4	5
\.


--
-- TOC entry 4380 (class 0 OID 16433)
-- Dependencies: 219
-- Data for Name: orders_items_relaship; Type: TABLE DATA; Schema: public; Owner: maselof
--

COPY public.orders_items_relaship (order_id, item_id) FROM stdin;
b563feb7b2b84b6test	9934930
b563feb7b2b84b6test1	9934931
b563feb7b2b84b6test2	9934932
b563feb7b2b84b6test3	9934933
b563feb7b2b84b6test4	9934934
b563feb7b2b84b6test1	9934934
b563feb7b2b84b6test2	9934933
b563feb7b2b84b6test3	9934932
b563feb7b2b84b6test4	9934931
\.


--
-- TOC entry 4379 (class 0 OID 16410)
-- Dependencies: 218
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: maselof
--

COPY public.payment (transaction_payment, request_id, currency, provider, amount, payment_dt, bank, delivery_cost, goods_total, custom_fee) FROM stdin;
b563feb7b2b84b6test		USD	wbpay	1817	1637907727	alpha	1500	317	0
b563feb7b2b84b6test1		USD	wbpay	1818	1637907728	alpha	1600	318	0
b563feb7b2b84b6test2		USD	wbpay	1819	1637907729	alpha	1700	319	0
b563feb7b2b84b6test3		USD	wbpay	1820	1637907730	alpha	1800	320	0
b563feb7b2b84b6test4		USD	wbpay	1821	1637907731	alpha	1900	321	0
\.


--
-- TOC entry 4392 (class 0 OID 0)
-- Dependencies: 215
-- Name: delivery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maselof
--

SELECT pg_catalog.setval('public.delivery_id_seq', 5, true);


--
-- TOC entry 4226 (class 2606 OID 16403)
-- Name: delivery delivery_pkey; Type: CONSTRAINT; Schema: public; Owner: maselof
--

ALTER TABLE ONLY public.delivery
    ADD CONSTRAINT delivery_pkey PRIMARY KEY (id);


--
-- TOC entry 4228 (class 2606 OID 16432)
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: maselof
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (chrt_id);


--
-- TOC entry 4224 (class 2606 OID 16396)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: maselof
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4229 (class 2606 OID 16418)
-- Name: orders orders_delivery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maselof
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES public.delivery(id);


--
-- TOC entry 4231 (class 2606 OID 16441)
-- Name: orders_items_relaship orders_items_relaship_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maselof
--

ALTER TABLE ONLY public.orders_items_relaship
    ADD CONSTRAINT orders_items_relaship_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(chrt_id);


--
-- TOC entry 4232 (class 2606 OID 16436)
-- Name: orders_items_relaship orders_items_relaship_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maselof
--

ALTER TABLE ONLY public.orders_items_relaship
    ADD CONSTRAINT orders_items_relaship_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 4230 (class 2606 OID 16413)
-- Name: payment payment_transaction_payment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maselof
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_transaction_payment_fkey FOREIGN KEY (transaction_payment) REFERENCES public.orders(order_id);


--
-- TOC entry 4386 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE delivery; Type: ACL; Schema: public; Owner: maselof
--

GRANT ALL ON TABLE public.delivery TO maselof;


--
-- TOC entry 4388 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE items; Type: ACL; Schema: public; Owner: maselof
--

GRANT ALL ON TABLE public.items TO maselof;


--
-- TOC entry 4389 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: maselof
--

GRANT ALL ON TABLE public.orders TO maselof;


--
-- TOC entry 4390 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE orders_items_relaship; Type: ACL; Schema: public; Owner: maselof
--

GRANT ALL ON TABLE public.orders_items_relaship TO maselof;


--
-- TOC entry 4391 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE payment; Type: ACL; Schema: public; Owner: maselof
--

GRANT ALL ON TABLE public.payment TO maselof;


-- Completed on 2023-10-20 18:56:20 MSK

--
-- maselofQL database dump complete
--

