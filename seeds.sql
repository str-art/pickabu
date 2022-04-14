--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

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

--
-- Name: reaction_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.reaction_type_enum AS ENUM (
    'LIKE',
    'DISLIKE'
);


ALTER TYPE public.reaction_type_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    text character varying NOT NULL,
    "postId" integer NOT NULL,
    "dateCreated" timestamp without time zone DEFAULT now() NOT NULL,
    "authorId" integer NOT NULL
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: comment_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.comment_view AS
SELECT
    NULL::integer AS id,
    NULL::timestamp without time zone AS "dateCreated",
    NULL::integer AS "postId",
    NULL::character varying AS text,
    NULL::integer AS "authorId",
    NULL::bigint AS likes,
    NULL::bigint AS dislikes;


ALTER TABLE public.comment_view OWNER TO postgres;

--
-- Name: file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file (
    id integer NOT NULL,
    key uuid NOT NULL,
    "postId" integer,
    "commentId" integer,
    mimetype character varying DEFAULT 'image/jpeg'::character varying NOT NULL
);


ALTER TABLE public.file OWNER TO postgres;

--
-- Name: file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_id_seq OWNER TO postgres;

--
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_id_seq OWNED BY public.file.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    id integer NOT NULL,
    text character varying NOT NULL,
    title character varying NOT NULL,
    "dateCreated" timestamp without time zone DEFAULT now() NOT NULL,
    "authorId" integer NOT NULL
);


ALTER TABLE public.post OWNER TO postgres;

--
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_id_seq OWNER TO postgres;

--
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_id_seq OWNED BY public.post.id;


--
-- Name: post_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_tags (
    id integer NOT NULL,
    "postId" integer NOT NULL,
    "tagId" integer NOT NULL
);


ALTER TABLE public.post_tags OWNER TO postgres;

--
-- Name: post_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_tags_id_seq OWNER TO postgres;

--
-- Name: post_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_tags_id_seq OWNED BY public.post_tags.id;


--
-- Name: post_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.post_view AS
SELECT
    NULL::integer AS id,
    NULL::character varying AS text,
    NULL::character varying AS title,
    NULL::timestamp without time zone AS "dateCreated",
    NULL::integer AS "authorId",
    NULL::bigint AS "totalComments",
    NULL::bigint AS "commentsInLast24",
    NULL::bigint AS likes,
    NULL::bigint AS dislikes,
    NULL::bigint AS "likesIn24",
    NULL::bigint AS "dislikesIn24",
    NULL::boolean AS "createdIn24",
    NULL::text AS tags,
    NULL::character varying[] AS tag;


ALTER TABLE public.post_view OWNER TO postgres;

--
-- Name: reaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reaction (
    id integer NOT NULL,
    type public.reaction_type_enum DEFAULT 'LIKE'::public.reaction_type_enum NOT NULL,
    "userId" integer NOT NULL,
    "commentId" integer,
    "postId" integer,
    "dateCreated" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.reaction OWNER TO postgres;

--
-- Name: reaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reaction_id_seq OWNER TO postgres;

--
-- Name: reaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reaction_id_seq OWNED BY public.reaction.id;


--
-- Name: saved; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved (
    id integer NOT NULL,
    "postId" integer,
    "commentId" integer,
    "userId" integer NOT NULL
);


ALTER TABLE public.saved OWNER TO postgres;

--
-- Name: saved_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.saved_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.saved_id_seq OWNER TO postgres;

--
-- Name: saved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.saved_id_seq OWNED BY public.saved.id;


--
-- Name: saved_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.saved_view AS
 SELECT s.id,
    s."userId",
    pv.id AS "postId",
    pv.text AS "postText",
    pv.title AS "postTitle",
    pv."authorId" AS "postAuthorid",
    pv.likes AS "postLikes",
    pv.dislikes AS "postDislikes",
    pv.tag AS "postTag",
    pv."dateCreated" AS "postDatecreated",
    pv."totalComments" AS "postTotalcomments",
    pv."commentsInLast24" AS "postCommentsinlast24",
    pv."createdIn24" AS "postCreatedin24",
    pv."likesIn24" AS "postLikesin24",
    cv.id AS "commentId",
    cv.text AS "commentText",
    cv.likes AS "commentLikes",
    cv.dislikes AS "commentDislikes",
    cv."authorId" AS "commentAuthorid",
    cv."postId" AS "commentPostid",
    cv."dateCreated" AS "commentDatecreated"
   FROM ((public.saved s
     LEFT JOIN public.post_view pv ON ((s."postId" = pv.id)))
     LEFT JOIN public.comment_view cv ON ((s."commentId" = cv.id)));


ALTER TABLE public.saved_view OWNER TO postgres;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    tag character varying NOT NULL
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: typeorm_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.typeorm_metadata (
    type character varying NOT NULL,
    database character varying,
    schema character varying,
    "table" character varying,
    name character varying,
    value text
);


ALTER TABLE public.typeorm_metadata OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file ALTER COLUMN id SET DEFAULT nextval('public.file_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: post id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post ALTER COLUMN id SET DEFAULT nextval('public.post_id_seq'::regclass);


--
-- Name: post_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_tags ALTER COLUMN id SET DEFAULT nextval('public.post_tags_id_seq'::regclass);


--
-- Name: reaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reaction ALTER COLUMN id SET DEFAULT nextval('public.reaction_id_seq'::regclass);


--
-- Name: saved id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved ALTER COLUMN id SET DEFAULT nextval('public.saved_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (id, text, "postId", "dateCreated", "authorId") FROM stdin;
1	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:10.996544	32
2	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:12.204822	32
3	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:13.26494	32
4	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:14.077458	32
5	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:14.944656	32
6	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:15.77154	32
7	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:16.462491	32
8	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:17.131361	32
9	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:17.951518	32
10	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:18.635555	32
11	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:19.412302	32
12	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:20.241542	32
13	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:20.980574	32
14	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:21.836219	32
15	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:22.484095	32
16	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:23.190663	32
17	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:23.823388	32
18	PLOHAJA PASTA OSUZHDAU	40	2022-04-14 03:51:24.734554	32
19	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:39.221697	32
20	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:40.174223	32
21	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:40.849575	32
22	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:41.557685	32
23	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:42.247756	32
24	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:42.880176	32
25	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:43.670154	32
26	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:44.697558	32
27	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:45.508588	32
28	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:46.249704	32
29	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:46.865086	32
30	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:47.543845	32
31	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:48.221333	32
32	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:48.775582	32
33	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:49.436441	32
34	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:50.355559	32
35	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:51.040219	32
36	NU ETO NICHO TAK PASTA OSUZHDAU	39	2022-04-14 03:51:51.650252	32
37	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:51:59.861914	32
38	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:52:01.26828	32
39	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:52:02.006366	32
40	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:52:02.919992	32
41	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:52:03.629751	32
42	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:52:04.237755	32
43	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:52:04.842684	32
44	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:52:05.332666	32
45	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:52:05.991455	32
46	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	35	2022-04-14 03:52:06.833587	32
47	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:52:32.380919	33
48	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:52:33.025428	33
49	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:52:34.201897	33
50	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:52:34.823855	33
51	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:52:35.476274	33
52	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:52:36.527455	33
53	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:53:09.725935	33
54	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:53:10.780914	33
55	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:53:11.461926	33
56	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:53:12.184477	33
57	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:53:12.911667	33
58	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	30	2022-04-14 03:53:13.81325	33
59	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	29	2022-04-14 03:53:20.707852	33
60	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	29	2022-04-14 03:53:21.420921	33
61	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	29	2022-04-14 03:53:22.268369	33
62	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	29	2022-04-14 03:53:50.88517	34
63	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	29	2022-04-14 03:53:51.794307	34
64	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	29	2022-04-14 03:53:52.473337	34
65	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	27	2022-04-14 03:53:59.844936	34
66	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	27	2022-04-14 03:54:00.538529	34
67	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	27	2022-04-14 03:54:01.372396	34
68	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	27	2022-04-14 03:54:02.040698	34
69	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	24	2022-04-14 03:54:05.945551	34
70	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	24	2022-04-14 03:54:06.705713	34
71	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	24	2022-04-14 03:54:07.732847	34
72	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	24	2022-04-14 03:54:08.919507	34
73	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	22	2022-04-14 03:54:12.998914	34
74	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	22	2022-04-14 03:54:13.824786	34
75	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	22	2022-04-14 03:54:14.761059	34
76	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	22	2022-04-14 03:54:15.672668	34
77	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	22	2022-04-14 03:54:16.312776	34
78	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	22	2022-04-14 03:54:17.06716	34
79	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	22	2022-04-14 03:54:17.833675	34
80	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	12	2022-04-14 03:54:22.630814	34
81	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	12	2022-04-14 03:54:23.552344	34
82	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	12	2022-04-14 03:54:24.458882	34
83	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	12	2022-04-14 03:54:25.158871	34
84	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	12	2022-04-14 03:54:26.077743	34
85	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	12	2022-04-14 03:54:27.072617	34
86	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	12	2022-04-14 03:54:28.00192	34
87	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	11	2022-04-14 03:54:33.587536	34
88	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	11	2022-04-14 03:54:34.378223	34
89	NU ASDASDETO NICHO TAK PASTA OSUZHDAU	11	2022-04-14 03:54:35.04731	34
90	Все будет хорошо	5	2022-04-14 03:54:50.942771	34
91	Все будет хорошо	5	2022-04-14 03:54:51.910121	34
92	Все будет хорошо	41	2022-04-14 03:54:58.24647	34
93	Все будет хорошо	41	2022-04-14 03:54:59.062213	34
94	Як по Украiнскi пысатъ???	40	2022-04-14 03:56:38.565763	35
95	Як по Украiнскi пысатъ???	40	2022-04-14 03:56:40.026987	35
96	Як по Украiнскi пысатъ???	40	2022-04-14 03:56:40.895102	35
97	Як по Украiнскi пысатъ???	39	2022-04-14 03:56:45.636157	35
98	Як по Украiнскi пысатъ???	39	2022-04-14 03:56:46.697862	35
99	Як по Украiнскi пысатъ???	39	2022-04-14 03:56:47.354819	35
100	Як по Украiнскi пысатъ???	37	2022-04-14 03:56:53.094747	35
101	Як по Украiнскi пысатъ???	37	2022-04-14 03:56:53.809207	35
102	Як по Украiнскi пысатъ???	37	2022-04-14 03:56:57.572525	35
103	Як по Украiнскi пысатъ???	37	2022-04-14 03:56:58.236401	35
104	Як по Украiнскi пысатъ???	37	2022-04-14 03:56:58.917183	35
105	Як по Украiнскi пысатъ???	37	2022-04-14 03:56:59.73218	35
106	Як по Украiнскi пысатъ???	36	2022-04-14 03:57:04.272728	35
107	Як по Украiнскi пысатъ???	36	2022-04-14 03:57:05.165297	35
108	жить жить пожить	50	2022-04-14 03:59:16.680396	36
109	жить жить пожить	50	2022-04-14 03:59:17.836694	36
110	жить жить пожить	50	2022-04-14 03:59:18.689799	36
111	жить жить пожить	50	2022-04-14 03:59:19.676353	36
112	жить жить пожить	50	2022-04-14 03:59:20.64468	36
113	жить жить пожить	49	2022-04-14 03:59:25.328048	36
114	жить жить пожить	49	2022-04-14 03:59:26.152071	36
115	жить жить пожить	49	2022-04-14 03:59:26.865753	36
116	жить жить пожить	47	2022-04-14 03:59:33.425277	36
117	жить жить пожить	47	2022-04-14 03:59:34.426353	36
118	жить жить пожить	47	2022-04-14 03:59:35.037081	36
119	жить жить пожить	47	2022-04-14 03:59:36.323623	36
\.


--
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file (id, key, "postId", "commentId", mimetype) FROM stdin;
1	63618179-1ca1-427a-b4d1-98d9b0d6f04f	1	\N	image/jpeg
2	e9f50ead-9cb9-4dd4-b1a0-2ddabf028c92	1	\N	image/png
3	0fa8ebfc-cfaf-464e-b2d8-b545f5968f49	2	\N	image/jpeg
4	bc1a64fb-db86-4a3a-82b2-1bd85a20e310	2	\N	image/png
5	d090042f-fefb-42c2-88ad-faf2d5fff037	3	\N	image/jpeg
6	f8daeee5-cb79-4dfc-838e-d702a5019031	3	\N	image/png
7	dffb513b-d1f6-4c63-a381-7541f5106155	4	\N	image/jpeg
8	a5326053-9048-4f90-a014-304cfd00bc5b	4	\N	image/png
9	c4b25da5-c390-4e52-a007-df145d469d31	5	\N	image/jpeg
10	f34ae1fc-a59c-48e1-b085-553052469374	5	\N	image/png
11	aef2df2f-fabc-43de-9041-51c30d452bd9	6	\N	image/jpeg
12	4b32233c-a50a-4450-9172-8cddb120f9ed	6	\N	image/png
13	4aaebc5f-a227-45e2-9636-dcc7fb33f5f6	7	\N	image/jpeg
14	a21e79a9-dc37-485d-88c9-d57e4a7b3313	7	\N	image/png
15	ed2f2d96-282e-4db0-99f2-2505df948157	8	\N	image/jpeg
16	e1df6991-c181-446d-8f8c-5f38b8b7e4bb	8	\N	image/png
17	3c949e93-fab6-4fdc-9a58-3123b14f8b47	9	\N	image/jpeg
18	9c16c0a1-f2e4-4d13-905b-7402a978203c	9	\N	image/png
19	e1767b86-6d7c-43a7-89ea-ed7079b0973e	10	\N	image/jpeg
20	d5e21c08-fdeb-46fc-b01a-6f8c07332de5	10	\N	image/png
21	b5bc41ae-f368-4584-a490-4a891d06e8bf	11	\N	image/jpeg
22	aab5767e-6d17-4a25-a6a4-85b7ba6573ab	11	\N	image/png
23	eef8cbea-53e2-4df1-a1d1-2d0109ea2bb4	12	\N	image/jpeg
24	60c878c7-0faf-4748-a1e3-58142236aef7	12	\N	image/png
25	355d4031-db4b-49a0-b81e-6ab0327206c8	13	\N	image/jpeg
26	a70f671f-37c5-466b-b837-f21579f27c44	13	\N	image/png
27	cd82bf03-644c-458b-88c5-9ffa31b39331	14	\N	image/jpeg
28	bf6a8e9e-6b4d-4705-a8c6-3a6e34c0889c	14	\N	image/png
29	b93c5721-3ca7-4b92-a128-c3aad1662369	15	\N	image/jpeg
30	d52832ff-db03-4072-92b6-d11ff1516965	15	\N	image/png
31	fa1968e2-8d25-4520-a434-561e6593d385	16	\N	image/png
32	9a5aaef0-95b4-4bf7-9892-6ba891fff51a	16	\N	image/jpeg
33	563e8c67-4dc2-4240-afc5-aecfa9d13205	17	\N	image/jpeg
34	8b3f31f2-e655-47be-a6e9-c13ba5e83c48	17	\N	image/png
35	0af62fd4-33c5-499b-80e1-697031901eb5	18	\N	image/jpeg
36	50c2c7a4-f3a8-45cf-bc9d-66f2a736a9fe	18	\N	image/png
37	4638c60f-d45c-4f6c-ac80-61f609c35331	19	\N	image/jpeg
38	3dee7f25-d839-4528-a06a-69a03ef17c21	19	\N	image/png
39	0cb87647-9fce-455c-ac51-931734425ccd	20	\N	image/jpeg
40	bd659f24-65f3-4d06-b055-743f24556344	20	\N	image/png
41	8ef93bec-53e4-496c-840c-955b08765220	21	\N	image/jpeg
42	d0f540a8-ea8a-440a-b9f4-75af82c06c76	21	\N	image/png
43	525e7c71-e59c-40d8-ab65-41aad16d093a	22	\N	image/jpeg
44	5d8e8c08-d652-40be-a227-4ba9a0a139a3	22	\N	image/png
45	2749229b-3cbe-498e-a5ad-07c16fe19f40	23	\N	image/jpeg
46	a3573fff-1f93-4bf0-9fae-49a0b4f721f7	23	\N	image/png
47	afade81d-135d-4d75-964a-24fe6e5ac31f	24	\N	image/jpeg
48	56252ee5-2ab6-4e31-8c14-6271ff6de36e	24	\N	image/png
49	dc37039d-1e14-4b85-83b5-f17bbab7fc4a	25	\N	image/jpeg
50	65bf767b-b72e-4ea0-8675-7f1419114fe2	25	\N	image/png
51	eec3a93c-29a7-43f3-866f-817d7b8902cb	26	\N	image/jpeg
52	533e1036-9b95-4b1a-94a0-5ee9df3e88b5	26	\N	image/png
53	8cd57f87-e9ce-4bd4-a8d8-3b92862c2a38	27	\N	image/jpeg
54	d3c58ae6-0541-465c-9fda-2d0880244159	27	\N	image/png
55	a23c84b9-f70b-4e24-8592-c7577c8ca6bc	28	\N	image/jpeg
56	955be447-0ad0-4da6-b737-d6351797cbeb	28	\N	image/png
57	ac92c961-903c-4b76-8068-24e92eceac94	29	\N	image/png
58	74d792ec-4cef-4c97-85b8-6abf16227c85	29	\N	image/jpeg
59	33238f7c-68f0-4580-9b4a-dc645987895f	30	\N	image/jpeg
60	ea9d0e0c-a1d1-4c62-a59f-74d6aa920984	30	\N	image/png
61	26230374-5f2b-44b5-b078-ebb2d65cc4de	31	\N	image/jpeg
62	dead4c2d-0a57-4977-890b-7fe3d4d221e1	31	\N	image/png
63	fcce74b8-0947-47c2-9959-63598a855201	32	\N	image/jpeg
64	a14c52a9-f36a-4af4-acc9-0c14b94c6d88	32	\N	image/png
65	d5062a50-689e-40eb-812f-9821563accf6	33	\N	image/jpeg
66	c1af3df6-714c-4938-8723-063e089dc34e	33	\N	image/png
67	0bbcdea5-fa37-467a-b360-3f320cb22ec6	34	\N	image/jpeg
68	e7c1ee4a-ee29-4872-9e40-5c6b15fe6897	34	\N	image/png
69	72a59e15-5fc5-46f1-8e49-ef314f2a55cb	35	\N	image/png
70	78cee890-75b7-43e0-8e9f-55843b1b867c	35	\N	image/jpeg
71	29eef30a-7587-4f8e-a34c-ffab44c005b8	36	\N	image/jpeg
72	518e8dbc-a4ad-46aa-a67b-105056bf07c6	36	\N	image/png
73	da57b61f-098b-44e9-821a-6177c76ca14b	37	\N	image/jpeg
74	b6d6c881-57a0-4f95-bd4f-a2d1a0d8eecd	37	\N	image/png
75	97c70210-c7df-450b-a4ab-58396f021039	38	\N	image/png
76	e6229025-93a6-4b1e-aa92-e5a372635d6c	38	\N	image/jpeg
77	d4fa5c04-36b4-499e-a2d5-07e0323fc4ba	39	\N	image/jpeg
78	f8d04286-af86-4e64-82a8-5040c42eac6f	39	\N	image/png
79	a1e63bac-6322-4852-beca-4c45b412ca56	40	\N	image/jpeg
80	13090ed6-235b-4fec-8474-079a2a532599	40	\N	image/png
81	98cd7313-3c48-4507-a993-c57f34fc2c65	41	\N	image/jpeg
82	19d5c26c-d8fe-4f4a-aa85-c4e0444a4157	41	\N	image/png
83	a842e181-eff9-43e3-ba85-4cb2107bc899	42	\N	image/jpeg
84	7c0e345b-28a7-44df-836c-8efec2ba8f3b	42	\N	image/png
85	5d38397c-c0fe-4c3f-9bfb-4c48d7d455e6	43	\N	image/jpeg
86	b4ec4938-dd87-46ab-8875-8e7665a9e378	43	\N	image/png
87	cfc76af2-863b-4dd1-a97a-52330f71e1a3	44	\N	image/jpeg
88	48055b7b-73ba-4c53-a805-89d92e948e63	44	\N	image/png
89	d78ac31d-5c29-4692-a558-298b758465aa	45	\N	image/jpeg
90	a80cea76-471d-460d-b5df-acd69f658fcd	45	\N	image/png
91	322085c7-ad9c-4691-853e-1f2b665fe6c9	46	\N	image/jpeg
92	338e86a8-4283-4ff5-94b6-14a560d150a0	46	\N	image/png
93	8fd2c623-9e77-4a2b-87d1-8a3892d3444d	47	\N	image/jpeg
94	98b0fdb4-1dcb-49a2-8396-d05a767c4443	47	\N	image/png
95	d6ddc317-3452-416f-b3ce-8663de400f39	48	\N	image/jpeg
96	39c96dda-8d79-4340-89d1-450c2532426b	49	\N	image/jpeg
97	3a12b8ab-42d3-47df-8cdf-ea35ebc25afe	49	\N	image/png
98	92bdcd3d-4cb1-4e24-8d59-62bec9c87325	50	\N	image/jpeg
99	42d13833-12ee-4681-b0df-0cc0c0435d2b	50	\N	image/png
100	127d10d2-1c4e-4bbf-9de9-f6d2a96c25ff	48	\N	image/png
101	a17f29ba-6cd0-499b-a004-9abfbbfba70f	\N	1	image/jpeg
102	42d3b462-7910-4073-b666-684f1a2c5c14	\N	2	image/jpeg
103	ab0af7fb-4da7-4851-8fac-57583a2bd29a	\N	3	image/jpeg
104	cfdadd23-8a77-4813-9291-be09a3447fb1	\N	4	image/jpeg
105	36a0d4bf-b071-4ccf-9eae-d4eb879d75fd	\N	5	image/jpeg
106	1ae3a8d4-4f28-4a9d-acb6-43170095538b	\N	6	image/jpeg
107	f165166e-4b4e-40fb-a686-3d3f95c58b35	\N	7	image/jpeg
108	fad223e4-b1f4-432a-a41a-2e451165ee3a	\N	8	image/jpeg
109	bcb1fd19-f761-4b59-9bc6-5b15d19c971a	\N	9	image/jpeg
110	87c14e9a-ff9e-499f-bed7-b65b6cf57258	\N	10	image/jpeg
111	86690210-2138-450e-8940-1b9ec33e4ad0	\N	11	image/jpeg
112	638c200d-dc61-443d-9b7c-d18764e51478	\N	12	image/jpeg
113	35b0f5db-6281-4c08-88e8-483714cc9e8f	\N	13	image/jpeg
114	9642dfa7-6e01-422a-940f-0aa391ac7444	\N	14	image/jpeg
115	3b947321-b7b1-4ae0-b3b1-6c1ee11ce53b	\N	15	image/jpeg
116	b3728f5d-f70d-430e-8f5c-4c3d833a577a	\N	16	image/jpeg
117	d50f5e1d-47f2-4328-b2aa-8a8f5743725a	\N	17	image/jpeg
118	8b8039e8-9bc7-458a-a394-d104e1a49be4	\N	18	image/jpeg
119	d8c726de-9af5-4081-8e77-e368ef08bc28	\N	19	image/jpeg
120	82986c8d-b9b5-4da7-81ee-dd1243665ea7	\N	20	image/jpeg
121	9ca81726-7dc4-49d2-a4ba-9d6d4ef04990	\N	21	image/jpeg
122	c9bc7ba4-2c50-4ef0-b61d-7ea80c6f06ee	\N	22	image/jpeg
123	1596b98f-90b1-431a-acd5-664d21338031	\N	23	image/jpeg
124	8f429724-b75b-474c-a11c-ee943ce9f9ef	\N	24	image/jpeg
125	648cc94f-ba82-4fa0-9291-2a4662d9b87b	\N	25	image/jpeg
126	4b3f86ba-60f3-4a95-95c4-741c133cc169	\N	26	image/jpeg
127	1d3458e1-ab70-4adf-b0dc-4dc2ff6f618b	\N	27	image/jpeg
128	6ee6fe54-a43c-4286-9ee2-db273296ac03	\N	28	image/jpeg
129	e0c9fc58-f720-471b-b5a2-6f7b8631c44b	\N	29	image/jpeg
130	5fe51bfd-72e9-48d9-8ca2-f34fab23a194	\N	30	image/jpeg
131	1c7a7bfc-cf8b-4615-8013-f5a331d59a84	\N	31	image/jpeg
132	ec87666a-8e07-49a2-b703-9e13d3fad9f2	\N	32	image/jpeg
133	d720b89a-ae7f-42f8-92f5-dde97dcb74a3	\N	33	image/jpeg
134	26581ad4-8d06-443b-bc21-5c5fbd207bb4	\N	34	image/jpeg
135	f3a87b08-8118-4807-a984-19ec791d9a82	\N	35	image/jpeg
136	51c3df26-5277-4878-9321-e6bbd99ebfcd	\N	36	image/jpeg
137	35a49f9f-4a28-4ca6-942f-3803bc2f2ade	\N	37	image/jpeg
138	f246b735-df28-419c-88fc-4ad53aecff31	\N	38	image/jpeg
139	91b868e4-f9e2-4cd2-b6ff-ad8fa5c0450e	\N	39	image/jpeg
140	298c6f3b-e002-4ca0-9c8e-7ee31d43d324	\N	40	image/jpeg
141	e0ada67a-c96e-4bb0-ac7d-7e8eba838705	\N	41	image/jpeg
142	9019062e-5bf2-4fb5-9e2c-961a5967f14d	\N	42	image/jpeg
143	f22aa206-1f50-4708-ac11-2acb8d1c0194	\N	43	image/jpeg
144	9e04cf61-1bec-4014-afbd-96716d8c40e5	\N	44	image/jpeg
145	3f5cb60c-d672-47aa-a0a6-faeb1072a53a	\N	45	image/jpeg
146	088328a5-5e71-4289-8c03-bce024f58c2c	\N	46	image/jpeg
147	651b8eb2-1571-4bce-95e2-e7d0c0f4294b	\N	47	image/jpeg
148	27f31276-3f8f-4d25-bcf1-873762420894	\N	48	image/jpeg
149	b8450bd7-b567-4d4e-96a7-caa83bf2f910	\N	49	image/jpeg
150	984f6033-5d31-4b98-9a9f-033963615c6d	\N	50	image/jpeg
151	9be93786-e6f8-4a27-bd08-1b8ac41ab88c	\N	51	image/jpeg
152	e52ff8f4-6611-4fe4-bdea-8208c27a21be	\N	52	image/jpeg
153	ded6b601-6def-4c93-b8bb-63777ab69ae0	\N	53	image/jpeg
154	23a34911-00a0-4767-8f68-dad6e2354f1b	\N	53	image/jpeg
155	b90c5889-d6fb-4869-9703-6ac3dd14418b	\N	54	image/jpeg
156	4545c5ff-b069-4b16-bc47-c7424ac4d6f5	\N	54	image/jpeg
157	10aed2b2-97ba-457a-aee6-e3eaad931fc1	\N	55	image/jpeg
158	44c1ba53-f5cb-4656-978e-c503ce930718	\N	55	image/jpeg
159	6d128881-b808-4468-86e4-1a73d0fee757	\N	56	image/jpeg
160	600f6b60-3e38-429d-9a5e-723f58dc8681	\N	56	image/jpeg
161	796c357a-4f9b-4347-a999-7d60ac41e0ac	\N	57	image/jpeg
162	53d16cb0-bf29-4a2e-a1e6-c9e4e94a8d7b	\N	57	image/jpeg
163	e0a05849-2c6f-46f5-9a7f-0eb167681b67	\N	58	image/jpeg
164	ab39258f-5903-43f0-994e-556364cdefbb	\N	58	image/jpeg
165	ccf6a21f-f01a-4bbb-a818-6c0b425e516b	\N	59	image/jpeg
166	948c4aa9-1edd-417d-ac61-b1f77fcbcac3	\N	59	image/jpeg
167	92fdffb8-4785-4dcd-b1d7-604e76adec2f	\N	60	image/jpeg
168	5fb7cf87-8091-482c-a551-39aa90a407ef	\N	60	image/jpeg
169	600f6857-d71c-4ec5-819b-9640d5d7ee8d	\N	61	image/jpeg
170	b4a6cb35-a75d-48f0-a03f-d586664070a9	\N	61	image/jpeg
171	9781b16c-235c-4e1c-863e-ffdb6f9a477c	\N	62	image/jpeg
172	d1bda4a0-3677-4b30-b89e-87b2b1b8dec1	\N	62	image/jpeg
173	018ba1a2-bfdf-46dc-9226-1129f5098593	\N	63	image/jpeg
174	1f05aadb-633b-48ee-938e-7ebdef3f0521	\N	63	image/jpeg
175	b6f262e4-f7c5-4269-9b00-a80f26eb495f	\N	64	image/jpeg
176	f59c7d5c-26a1-47c5-84e1-6f2aedd098fa	\N	64	image/jpeg
177	09e7fc9e-def7-4c8f-b62e-359d1f38e299	\N	65	image/jpeg
178	bc11d6d5-105d-4f0e-a2a0-eaab44cc4f6c	\N	65	image/jpeg
179	dc4d14c4-365b-448b-a986-07f4a2a79120	\N	66	image/jpeg
180	f8382f03-f874-4f41-8f51-55a3dc8bfb76	\N	66	image/jpeg
181	0ebd6e91-f3dd-47a3-8436-15c967e3c687	\N	67	image/jpeg
182	02c07452-3ac3-47d5-b236-7a6f2b454112	\N	67	image/jpeg
183	bf1b3ab0-d940-412a-b412-bb5257bfac61	\N	68	image/jpeg
184	0c534eb3-0a73-4434-8bba-2d5a3bad520a	\N	68	image/jpeg
185	5208c401-01e1-41a8-97a9-28844c2e61a9	\N	69	image/jpeg
186	8bddbc4f-32fa-4297-a731-a175728330e2	\N	69	image/jpeg
187	208dca6e-4a77-49e9-b2ec-cfbaa48d3a65	\N	70	image/jpeg
188	6afa9890-2b83-4f37-b77b-bea1b5c79846	\N	70	image/jpeg
189	deff7b2f-d664-4299-bbd2-92cbc04eb663	\N	71	image/jpeg
190	02e5866e-5dd8-4776-ad0b-1b257ce10ce3	\N	71	image/jpeg
191	7b50c58c-ee9d-47a9-ba44-b2bdc9a85a9f	\N	72	image/jpeg
192	03209fd8-b895-48c1-b6eb-16f3d65ce6d1	\N	72	image/jpeg
193	ca2ef0bf-f5b3-417d-91f2-fc3d0f7b5d4f	\N	73	image/jpeg
194	37fe40e8-555c-4385-9b90-704de95f58ab	\N	73	image/jpeg
195	eebee5b5-5d74-4457-909a-fe8f20a344b2	\N	74	image/jpeg
196	c5f3af14-9e0c-48b5-939f-0bf50ba742b9	\N	74	image/jpeg
197	e0133829-6015-4cd4-aad2-0ca32c4ebf5c	\N	75	image/jpeg
198	af5ae68b-f479-4813-9bf2-98f4b7572aa1	\N	75	image/jpeg
199	93478a98-f5f9-4830-bb41-dc813b16be16	\N	76	image/jpeg
200	440d3ca7-aaab-43b1-ba15-af9ef42ceadd	\N	76	image/jpeg
201	833fdb2b-c310-4480-beaf-0ee3ea3ec78a	\N	77	image/jpeg
202	82915ff3-c4d7-4cca-8cb1-2343d41cfefe	\N	77	image/jpeg
203	9eb38950-49b9-46c8-9338-1a798cb4aafd	\N	78	image/jpeg
204	9f8f8b40-bed2-426e-994f-677aa674d776	\N	78	image/jpeg
205	51ae4d56-bfe5-45ea-89eb-c9ccd3aa8044	\N	79	image/jpeg
206	762f859b-f2ca-4148-b135-28a8f2c002f6	\N	79	image/jpeg
207	1f23b1dc-036e-430f-b8f4-ed8679c7e26f	\N	80	image/jpeg
208	92c616f9-f26b-42fa-b95c-7ea34a024f9f	\N	80	image/jpeg
209	b70cdfee-944a-4467-9a8e-0a119e67ec9f	\N	81	image/jpeg
210	e0f478ee-fbdc-4a2a-920c-bbee93e3dccb	\N	81	image/jpeg
211	68ca8e1d-cf33-4370-9313-ac8d7ae18032	\N	82	image/jpeg
212	11a7881e-89bc-4ee0-8d4d-cbb3ee726405	\N	82	image/jpeg
213	d8dac8af-b255-4af4-bce2-0aba1853a300	\N	83	image/jpeg
214	5d276ff5-1c02-458d-9de2-4e94c4a73ef7	\N	83	image/jpeg
215	29a7c7c6-bbe3-4858-8da3-c904228f49fe	\N	84	image/jpeg
216	cbf3afbf-da7e-42e5-959d-120013d54af3	\N	84	image/jpeg
217	f89ca726-6773-4342-8ed5-2cee11f92ca5	\N	85	image/jpeg
218	d168d175-f5bc-44df-ae02-5f240da67459	\N	85	image/jpeg
219	b0f83bd2-51ef-4ccd-8e08-75728bc4b4dc	\N	86	image/jpeg
220	05275439-fc80-4f63-a511-bfe284c56cd9	\N	86	image/jpeg
221	da8f5cdd-e789-433d-abf4-808f6576728a	\N	87	image/jpeg
222	0a350053-eefa-4d50-9246-95daba2c939e	\N	87	image/jpeg
223	db4672f7-ca49-4fbb-8456-a34cae15c0bc	\N	88	image/jpeg
224	634b723f-cc3b-478b-91e9-b0db27b947f3	\N	88	image/jpeg
225	44d36020-f759-4567-ad06-e3cd4e1f6553	\N	89	image/jpeg
226	f6dc0bab-d73a-4f13-994e-e1e8fb6a3b67	\N	89	image/jpeg
227	0942b49d-1613-4a1b-bd83-4bb8c9f9f50b	\N	90	image/jpeg
228	478192c3-a9e0-4a15-a4e4-32159feb687b	\N	90	image/jpeg
229	5859666b-72a1-4c5d-92a9-ec19e1dc6fe7	\N	91	image/jpeg
230	e8172e73-6f7a-414c-a74a-ce2cef9723d1	\N	91	image/jpeg
231	ddc8cf78-568c-4335-aab4-c6c0dbd2503e	\N	92	image/jpeg
232	706ede8a-a083-47fd-804a-538a0ec58c2a	\N	92	image/jpeg
233	fdde22e9-eefa-4b48-9009-57e5f84f867b	\N	93	image/jpeg
234	9ba11a25-4849-4fca-8283-752053775ee8	\N	93	image/jpeg
235	a4ed954e-38b7-4a8f-a680-3d9852a5c8d2	\N	94	image/jpeg
236	266d1355-9987-4eaa-9371-8cc5ca93507f	\N	94	image/jpeg
237	5cf98206-d62a-4a83-aa8b-92d7c3f178af	\N	95	image/jpeg
238	83e77149-9833-4d11-9ada-51a46448cd0c	\N	95	image/jpeg
239	198a8604-1a9e-42b8-a9ec-af64ef7c4c9d	\N	96	image/jpeg
240	5bb420ec-3393-4b5a-b0ac-4166314d967f	\N	96	image/jpeg
241	c84c12f6-bf47-494f-984c-748eefc3c870	\N	97	image/jpeg
243	7f473ecd-27cc-4cb6-94b2-dd9a1bf8194a	\N	98	image/jpeg
245	0fb0d5a3-0d93-470a-93f2-2df0b38982a2	\N	99	image/jpeg
247	7a484d79-791b-4254-8867-8af6a11814e3	\N	100	image/jpeg
250	11101c96-eae4-4e3c-b28e-a17abeee9b81	\N	101	image/jpeg
251	6f4c22f0-954b-47e2-8239-bde6bcc6def2	\N	102	image/jpeg
253	7ccdd7b0-ad19-4914-91c6-432a537b9303	\N	103	image/jpeg
255	9c8e8b27-711d-4879-b06e-55f0198aafc5	\N	104	image/jpeg
258	6ab54e74-bc0b-452d-a11a-b268d7931c6a	\N	105	image/jpeg
260	5f34effa-0f65-4ab0-815a-fc827af4a165	\N	106	image/jpeg
262	9a8e5374-9a56-4c82-949e-dc7186cf3411	\N	107	image/jpeg
242	e4d4f0df-87d6-4438-9bdf-ca7a7850992e	\N	97	image/jpeg
244	2098126c-a839-4e18-9a42-73336837d1b5	\N	98	image/jpeg
246	f47a0896-2310-49d0-af36-cf751a598eb1	\N	99	image/jpeg
248	51307bce-8d4c-4c3d-b95d-d8df7564ab07	\N	100	image/jpeg
249	47ffb41b-c89f-452e-a9fb-77cd9917cf62	\N	101	image/jpeg
252	d74b7cac-60cc-4527-9a83-ba0b61c70fe1	\N	102	image/jpeg
254	63a3583a-e309-43bf-bfcf-a39f99321a2b	\N	103	image/jpeg
256	b9f917ce-26a8-4f1a-a111-e7a23277dd36	\N	104	image/jpeg
257	d0a8f18f-fe4a-49b2-a8a0-c671dd0a6500	\N	105	image/jpeg
259	d68698e1-6815-41bd-9a49-5386fb2521aa	\N	106	image/jpeg
261	58a7f354-5072-4d2f-8b7d-01c4e5da6eb8	\N	107	image/jpeg
263	71b08dfc-d084-42ec-b3d4-c276f35446c3	51	\N	image/jpeg
264	f9299d2b-362b-4701-98bc-57a079ae56e3	51	\N	image/png
265	319e6271-3d95-4549-89e8-4e8b97b3ddf8	52	\N	image/jpeg
266	e9baa5ed-9457-4f35-9cfa-84ff991a0821	52	\N	image/png
267	d38f76a7-ea79-4efb-84f0-f38a712e682d	53	\N	image/jpeg
268	d956f10a-ba03-4e0a-b755-f4bceb015452	53	\N	image/png
269	79f16e57-ab77-4715-89de-a17500274796	54	\N	image/jpeg
270	facb887f-f45a-4ea6-b21c-528362834c3c	54	\N	image/png
271	92d5afac-8c23-44e5-bd3a-4ea58be76889	55	\N	image/jpeg
272	5e538e21-85a2-4fff-a64d-328832cbe491	55	\N	image/png
273	649e09a6-c1a5-4069-8e8a-6be493fdd403	56	\N	image/jpeg
274	530255f5-6a0d-4897-b6a1-dba29d4e882a	56	\N	image/png
275	6c285f18-4eae-4497-83aa-f6b4ce6ba636	57	\N	image/jpeg
276	0bf2cc82-ecbd-452e-a808-e5bfd33d1eb6	57	\N	image/png
277	9a441a5b-cee1-46c8-bf3f-e5448b652fa5	58	\N	image/jpeg
278	589272ef-e41a-41b8-b8ee-7ca11df809c3	58	\N	image/png
279	2fb04a03-1f39-496a-be45-e25be795d580	59	\N	image/jpeg
280	ca61c102-1548-44f3-95f7-fb1d9da6bc84	59	\N	image/png
281	2d7ad8da-bd4c-4a23-a44e-357cf24bacfa	60	\N	image/jpeg
282	71cfe06f-79f5-43af-9f00-cea517a20d14	60	\N	image/png
283	23841b0d-0be2-4abe-921d-1c99b726cf27	61	\N	image/jpeg
284	b975e89a-3d42-421f-9583-b8565d33c732	61	\N	image/png
285	85eef8c8-3aa4-4a6e-88fa-9ab619c5b845	62	\N	image/jpeg
286	0392d49d-bc5a-496b-826d-b3810f105304	62	\N	image/png
287	bfb58186-bcdb-45c2-87e2-4eb2cddc1b98	\N	108	image/jpeg
288	73dd7d2b-a293-4c99-b0f6-a0bceb473210	\N	108	image/jpeg
289	1c3ae968-a2c4-4ddc-9d02-f089f37da735	\N	109	image/jpeg
290	aec9bbd5-4ffe-4e00-8b79-f203a4d62564	\N	109	image/jpeg
291	d5a3861e-4369-4596-906e-7ba8f7925a2a	\N	110	image/jpeg
292	61636bd0-1d71-430f-8c86-e90710488a89	\N	110	image/jpeg
293	690aa103-4313-4fd0-942e-34c865205393	\N	111	image/jpeg
294	6afdb8cb-9d50-4ddd-90de-8b9074945585	\N	111	image/jpeg
295	fd2232e8-1245-4379-90d8-352683787f6c	\N	112	image/jpeg
296	da61decd-555e-4590-8f12-a8285255424e	\N	112	image/jpeg
297	3da1c0e6-3323-4a74-9d78-fd4d3d508e45	\N	113	image/jpeg
298	5fbd61dc-1576-430b-857b-32b4e9a760e2	\N	113	image/jpeg
299	b32c53a2-f59d-43ac-ba54-ce2bfac37ec1	\N	114	image/jpeg
300	f042a31e-1356-4bfd-bb74-1f20baef6c2a	\N	114	image/jpeg
301	45f2513a-f8ff-4318-94b2-db83b63198e1	\N	115	image/jpeg
302	87b067a8-35eb-499c-877c-15d0662db26d	\N	115	image/jpeg
303	38833b88-8ba2-4af8-8f90-11ede1552596	\N	116	image/jpeg
304	05b0e898-848c-4813-b03f-93f8fe0c8ad7	\N	116	image/jpeg
305	e5e91073-f423-4038-b28c-0118c1eadf18	\N	117	image/jpeg
306	def94472-79eb-429d-9c72-10589f603f41	\N	117	image/jpeg
307	71855f76-3be8-4a12-9f9b-711a5d31ca35	\N	118	image/jpeg
308	04d55c89-93c5-4ee2-ae13-a98ede3560ec	\N	118	image/jpeg
309	ec307be6-3faf-4021-b282-e5283b578ac5	\N	119	image/jpeg
310	d0ab6a19-d99d-4c9a-b6ff-14f90480cd97	\N	119	image/jpeg
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
\.


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post (id, text, title, "dateCreated", "authorId") FROM stdin;
1	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Pistoleti v karmanah	2022-04-14 03:36:05.402477	20
2	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:24.688641	20
3	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:26.523789	20
4	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:27.482333	20
5	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:28.523032	20
6	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:30.15145	20
7	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:31.233164	20
8	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:32.40793	20
9	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:33.368668	20
10	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:34.587382	20
11	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:35.554556	20
12	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:36.506046	20
13	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:38.673156	20
14	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:39.77886	20
15	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:41.119987	20
16	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:42.153761	20
17	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:43.112987	20
18	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:44.442514	20
19	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:45.412299	20
20	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:46.517645	20
21	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:47.616418	20
22	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:48.643146	20
23	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:36:49.770017	20
24	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:37:24.193129	20
25	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:37:25.839722	20
26	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:37:26.903639	20
27	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:37:28.271197	20
28	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:37:29.000089	20
29	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:37:30.588615	20
30	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:37:31.543894	20
31	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:37:32.439894	20
32	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:41:52.906972	31
33	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:41:55.139869	31
34	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:41:56.443757	31
35	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:42:02.140784	31
36	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:47.354995	31
37	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:49.291031	31
38	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:50.590058	31
39	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:51.76475	31
40	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:53.125327	31
41	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:54.603172	31
42	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:55.791123	31
43	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:56.906513	31
49	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:50:04.320767	31
44	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:58.321581	31
45	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:45:59.553122	31
46	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:50:00.331852	31
47	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:50:01.638743	31
48	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:50:02.860405	31
50	Ребята, я новенький на твиче, почему у меня одинаковые сообщения от разных ников отображаются? я надеюсь это баг, вы же не дибилы ебаные чтобы одно и то же сообщение отправлять?.	Paste	2022-04-14 03:50:05.65619	31
51	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:22.34803	35
52	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:24.15901	35
53	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:25.357531	35
54	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:26.274807	35
55	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:27.161639	35
56	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:28.413367	35
57	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:29.755928	35
58	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:30.745686	35
59	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:31.816026	35
60	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:32.856493	35
61	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:33.751522	35
62	KAZAKHSTAN OBJAVLYAET BOMBARDIROVKU	Za Warudooo	2022-04-14 03:58:34.663061	35
\.


--
-- Data for Name: post_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_tags (id, "postId", "tagId") FROM stdin;
1	24	8
2	24	9
3	25	8
4	25	9
5	26	8
6	26	9
7	27	8
8	27	9
9	28	8
10	28	9
11	29	8
12	29	9
13	30	8
14	30	9
15	31	8
16	31	9
17	32	8
18	32	9
19	33	8
20	33	9
21	34	8
22	34	9
23	35	8
24	35	9
25	36	8
26	36	9
27	37	8
28	37	9
29	38	8
30	38	9
31	39	8
32	39	9
33	40	8
34	40	9
35	41	8
36	41	9
37	42	8
38	42	9
39	43	8
40	43	9
41	44	8
42	44	9
43	45	8
44	45	9
45	46	8
46	46	9
47	47	8
48	47	9
49	48	8
50	48	9
51	49	8
52	49	9
53	50	8
54	50	9
55	51	62
56	51	63
57	51	64
58	52	62
59	52	63
60	52	64
61	53	62
62	53	63
63	53	64
64	54	62
65	54	63
66	54	64
67	55	62
68	55	63
69	55	64
70	56	62
71	56	63
72	56	64
73	57	62
74	57	63
75	57	64
76	58	62
77	58	63
78	58	64
79	59	62
80	59	63
81	59	64
82	60	62
83	60	63
84	60	64
85	61	62
86	61	63
87	61	64
88	62	62
89	62	63
90	62	64
\.


--
-- Data for Name: reaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reaction (id, type, "userId", "commentId", "postId", "dateCreated") FROM stdin;
1	LIKE	36	\N	13	2022-04-14 04:00:14.223624
2	LIKE	36	\N	14	2022-04-14 04:00:17.521323
3	LIKE	36	\N	15	2022-04-14 04:00:19.927864
4	LIKE	36	\N	16	2022-04-14 04:00:22.315343
5	LIKE	36	\N	17	2022-04-14 04:00:25.087815
6	LIKE	36	\N	18	2022-04-14 04:00:28.068995
7	LIKE	36	\N	19	2022-04-14 04:00:31.472527
8	LIKE	36	\N	20	2022-04-14 04:00:35.585048
9	LIKE	36	\N	21	2022-04-14 04:00:38.316954
10	LIKE	36	\N	22	2022-04-14 04:00:41.30212
11	LIKE	36	\N	23	2022-04-14 04:00:44.097918
12	LIKE	36	\N	24	2022-04-14 04:00:46.558963
13	LIKE	36	\N	25	2022-04-14 04:00:49.003437
14	LIKE	36	\N	26	2022-04-14 04:00:51.50998
15	LIKE	36	\N	27	2022-04-14 04:00:54.621592
16	LIKE	36	\N	28	2022-04-14 04:00:57.372515
17	LIKE	36	\N	29	2022-04-14 04:01:00.559078
18	LIKE	36	\N	30	2022-04-14 04:01:03.482082
19	LIKE	36	\N	31	2022-04-14 04:01:05.819408
20	LIKE	36	\N	32	2022-04-14 04:01:08.756314
21	LIKE	36	\N	33	2022-04-14 04:01:10.875717
22	LIKE	36	\N	34	2022-04-14 04:01:13.224346
23	LIKE	36	\N	35	2022-04-14 04:01:15.498074
24	LIKE	36	\N	36	2022-04-14 04:01:18.069557
25	LIKE	36	\N	37	2022-04-14 04:01:20.80797
26	LIKE	36	\N	38	2022-04-14 04:01:23.538413
27	LIKE	36	\N	39	2022-04-14 04:01:26.152338
28	LIKE	36	\N	40	2022-04-14 04:01:29.246348
29	LIKE	36	\N	41	2022-04-14 04:01:31.730772
30	LIKE	36	\N	42	2022-04-14 04:02:37.204491
31	LIKE	36	\N	43	2022-04-14 04:02:40.396852
32	LIKE	34	\N	43	2022-04-14 04:04:18.821165
33	LIKE	34	\N	42	2022-04-14 04:04:21.735252
34	LIKE	34	\N	51	2022-04-14 04:04:24.01854
35	LIKE	34	\N	22	2022-04-14 04:04:27.290358
36	LIKE	34	\N	23	2022-04-14 04:04:29.91745
38	LIKE	34	23	\N	2022-04-14 04:04:36.097481
39	LIKE	34	25	\N	2022-04-14 04:04:40.219802
40	LIKE	34	22	\N	2022-04-14 04:04:43.077798
41	LIKE	34	99	\N	2022-04-14 04:04:47.575287
43	LIKE	34	13	\N	2022-04-14 04:04:57.053455
44	LIKE	34	19	\N	2022-04-14 04:05:01.021753
45	LIKE	34	28	\N	2022-04-14 04:05:05.352326
\.


--
-- Data for Name: saved; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved (id, "postId", "commentId", "userId") FROM stdin;
1	15	\N	1
2	16	\N	1
3	17	\N	1
4	18	\N	1
5	19	\N	1
6	20	\N	1
7	21	\N	1
8	22	\N	1
9	23	\N	1
10	24	\N	1
11	25	\N	1
12	26	\N	1
13	51	\N	1
14	\N	51	34
15	\N	52	34
16	\N	53	34
17	\N	55	34
18	\N	59	34
19	\N	60	34
20	\N	71	34
22	51	\N	34
23	45	\N	34
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, tag) FROM stdin;
62	alga
63	kz
64	vperedkz
8	twitch
9	pasta
\.


--
-- Data for Name: typeorm_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.typeorm_metadata (type, database, schema, "table", name, value) FROM stdin;
VIEW	\N	public	\N	comment_view	SELECT\n    "c".id AS "id",\n    "c"."dateCreated" AS "dateCreated",\n    "c"."postId" AS "postId",\n    "c"."text" AS "text",\n    "c"."authorId" AS "authorId",\n    COUNT(\n        DISTINCT\n        CASE\n        WHEN "r"."type" = 'LIKE' THEN "r"."id"\n        END\n    ) AS "likes",\n    COUNT(\n        DISTINCT\n        CASE\n        WHEN "r"."type" = 'DISLIKE' THEN "r"."id"\n        END\n    ) AS "dislikes"\n    FROM comment AS "c"\n    LEFT JOIN reaction AS "r"\n    ON "r"."commentId" = "c"."id"\n    GROUP BY "c"."id";
VIEW	\N	public	\N	post_view	SELECT \n        "Post".id AS "id",\n        "Post".text AS "text",\n        "Post".title AS "title",\n        "Post"."dateCreated"::timestamp AS "dateCreated",\n        "Post"."authorId" AS "authorId",\n        COUNT(DISTINCT "Comment".id) AS "totalComments",\n        COUNT(DISTINCT\n            CASE\n            WHEN EXTRACT(DAY FROM CURRENT_TIMESTAMP::timestamp - "Comment"."dateCreated"::timestamp) = 0 THEN "Comment".id\n            END) AS "commentsInLast24",\n        COUNT(DISTINCT\n            CASE \n            WHEN "Reaction".type = 'LIKE' THEN "Reaction".id\n            END) AS "likes",\n        COUNT(DISTINCT\n            CASE\n            WHEN "Reaction".type = 'DISLIKE' THEN "Reaction".id\n            END) AS "dislikes",\n        COUNT(DISTINCT\n            CASE\n            WHEN EXTRACT(DAY FROM CURRENT_TIMESTAMP::timestamp - "Reaction"."dateCreated"::timestamp) = 0 AND "Reaction".type = 'LIKE' THEN "Reaction".id\n            END) AS "likesIn24",\n        COUNT(DISTINCT\n            CASE\n            WHEN EXTRACT(DAY FROM CURRENT_TIMESTAMP::timestamp - "Reaction"."dateCreated"::timestamp) = 0 AND "Reaction".type = 'DISLIKE' THEN "Reaction".id\n            END) AS "dislikesIn24",\n        CASE\n        WHEN EXTRACT(DAY FROM CURRENT_TIMESTAMP::timestamp - "Post"."dateCreated"::timestamp) = 0 THEN TRUE\n        ELSE FALSE\n        END AS "createdIn24",\n        STRING_AGG(\n            "Tag".tag ,\n            '#'\n        ) AS "tags",\n        ARRAY_REMOVE(ARRAY_AGG(\n           DISTINCT "Tag".tag\n        ),NULL) AS "tag"\n        FROM post AS "Post"\n        LEFT JOIN comment AS "Comment"\n        ON "Post".id = "Comment"."postId"\n        LEFT JOIN reaction AS "Reaction"\n        ON "Post".id = "Reaction"."postId"\n        LEFT JOIN "user" AS "User"\n        ON "Reaction"."userId" = "User".id\n        LEFT JOIN post_tags AS "pt"\n        ON "Post".id = "pt"."postId"\n        LEFT JOIN tag AS "Tag"\n        ON "pt"."tagId" = "Tag".id\n        GROUP BY "Post".id;
VIEW	\N	public	\N	saved_view	SELECT\n    "s"."id" AS "id",\n    "s"."userId" AS "userId",\n    "pv"."id" AS "postId",\n    "pv"."text" AS "postText",\n    "pv"."title" AS "postTitle",\n    "pv"."authorId" AS "postAuthorid",\n    "pv"."likes" AS "postLikes",\n    "pv"."dislikes" AS "postDislikes",\n    "pv"."tag" AS "postTag",\n    "pv"."dateCreated" AS "postDatecreated",\n    "pv"."totalComments" AS "postTotalcomments",\n    "pv"."commentsInLast24" AS "postCommentsinlast24",\n    "pv"."createdIn24" AS "postCreatedin24",\n    "pv"."likesIn24" AS "postLikesin24",\n    "cv"."id" AS "commentId",\n    "cv"."text" AS "commentText",\n    "cv"."likes" AS "commentLikes",\n    "cv"."dislikes" AS "commentDislikes",\n    "cv"."authorId" AS "commentAuthorid",\n    "cv"."postId" AS "commentPostid",\n    "cv"."dateCreated" AS "commentDatecreated"\n    FROM saved AS "s"\n    LEFT JOIN post_view AS "pv"\n    ON "s"."postId" = "pv"."id"\n    LEFT JOIN comment_view AS "cv"\n    ON "s"."commentId" = "cv"."id";
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, password) FROM stdin;
1	artem.martem@biba.raisa	pe34m230KKl
2	artem.martem@biba.raisa2	pe34m230KKl
3	artem.msm@biba.raisa2	pe34m230KKl
4	artem2msm@biba.raisa2	pe34m230KKl
8	artem2m2sm@biba.raisa2	pe34m230KKl
9	artem2m2sam@biba.raisa2	pe34m230KKl
10	asd2sam@biba.raisa2	pe34m230KKl
11	asd4bbm@biba.raisa2	pe34m230KKl
12	asd123@biba.raisa2	pe34m230KKl
13	asd2332323@biba.raisa2	pe34m230KKl
14	asxdsds132323@biba.raisa2	pe34m230KKl
16	asxsss132323@biba.raisa2	pe34m230KKl
17	asx123132323@biba.raisa2	pe34m230KKl
18	asdsdsd2323@biba.raisa2	pe34m230KKl
19	assdsd2323@biba.raisa2	pe34m230KKl
20	as2323@biba.raisa2	pe34m230KKl
21	elecktron4@Mail.ru	pe34m230KKl
22	elecktro3@Mail.ru	pe34m230KKl
23	eleck5ro3@Mail.ru	pe34m230KKl
24	eleck51o3@Mail.ru	pe34m230KKl
25	elecdasd51o3@Mail.ru	pe34m230KKl
26	glovasd51o3@Mail.ru	pe34m230KKl
27	glovpervJI51o3@Mail.ru	pe34m230KKl
28	gloASDo3@Mail.ru	pe34m230KKl
29	gda@Mail.ru	pe34m230KKl
30	g132323@Mail.ru	pe34m230KKl
31	g1kaskdkaksd3@Mail.ru	pe34m230KKl
32	g1kassdsadasdaksd3@Mail.ru	pe34m230KKl
33	g1kassSDASDASDdaksd3@Mail.ru	pe34m230KKl
34	vladimirputin@Mail.ru	pe34m230KKl
35	zelensky@Mail.ru	pe34m230KKl
36	zhirinovsky@Mail.ru	pe34m230KKl
\.


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_id_seq', 119, true);


--
-- Name: file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.file_id_seq', 310, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 1, false);


--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_id_seq', 62, true);


--
-- Name: post_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_tags_id_seq', 90, true);


--
-- Name: reaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reaction_id_seq', 45, true);


--
-- Name: saved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.saved_id_seq', 23, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 97, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 36, true);


--
-- Name: comment PK_0b0e4bbc8415ec426f87f3a88e2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT "PK_0b0e4bbc8415ec426f87f3a88e2" PRIMARY KEY (id);


--
-- Name: post_tags PK_0c750579b992a52b24d18ec3431; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_tags
    ADD CONSTRAINT "PK_0c750579b992a52b24d18ec3431" PRIMARY KEY (id);


--
-- Name: file PK_36b46d232307066b3a2c9ea3a1d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT "PK_36b46d232307066b3a2c9ea3a1d" PRIMARY KEY (id);


--
-- Name: reaction PK_41fbb346da22da4df129f14b11e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reaction
    ADD CONSTRAINT "PK_41fbb346da22da4df129f14b11e" PRIMARY KEY (id);


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: tag PK_8e4052373c579afc1471f526760; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT "PK_8e4052373c579afc1471f526760" PRIMARY KEY (id);


--
-- Name: post PK_be5fda3aac270b134ff9c21cdee; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT "PK_be5fda3aac270b134ff9c21cdee" PRIMARY KEY (id);


--
-- Name: user PK_cace4a159ff9f2512dd42373760; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY (id);


--
-- Name: saved PK_cb4672121c11ed3824acc8d0985; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved
    ADD CONSTRAINT "PK_cb4672121c11ed3824acc8d0985" PRIMARY KEY (id);


--
-- Name: tag UQ_9dbf61b2d00d2c77d3b5ced37c6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT "UQ_9dbf61b2d00d2c77d3b5ced37c6" UNIQUE (tag);


--
-- Name: user UQ_e12875dfb3b1d92d7d7c5377e22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE (email);


--
-- Name: comment_view _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.comment_view AS
 SELECT c.id,
    c."dateCreated",
    c."postId",
    c.text,
    c."authorId",
    count(DISTINCT
        CASE
            WHEN (r.type = 'LIKE'::public.reaction_type_enum) THEN r.id
            ELSE NULL::integer
        END) AS likes,
    count(DISTINCT
        CASE
            WHEN (r.type = 'DISLIKE'::public.reaction_type_enum) THEN r.id
            ELSE NULL::integer
        END) AS dislikes
   FROM (public.comment c
     LEFT JOIN public.reaction r ON ((r."commentId" = c.id)))
  GROUP BY c.id;


--
-- Name: post_view _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.post_view AS
 SELECT "Post".id,
    "Post".text,
    "Post".title,
    "Post"."dateCreated",
    "Post"."authorId",
    count(DISTINCT "Comment".id) AS "totalComments",
    count(DISTINCT
        CASE
            WHEN (EXTRACT(day FROM ((CURRENT_TIMESTAMP)::timestamp without time zone - "Comment"."dateCreated")) = (0)::numeric) THEN "Comment".id
            ELSE NULL::integer
        END) AS "commentsInLast24",
    count(DISTINCT
        CASE
            WHEN ("Reaction".type = 'LIKE'::public.reaction_type_enum) THEN "Reaction".id
            ELSE NULL::integer
        END) AS likes,
    count(DISTINCT
        CASE
            WHEN ("Reaction".type = 'DISLIKE'::public.reaction_type_enum) THEN "Reaction".id
            ELSE NULL::integer
        END) AS dislikes,
    count(DISTINCT
        CASE
            WHEN ((EXTRACT(day FROM ((CURRENT_TIMESTAMP)::timestamp without time zone - "Reaction"."dateCreated")) = (0)::numeric) AND ("Reaction".type = 'LIKE'::public.reaction_type_enum)) THEN "Reaction".id
            ELSE NULL::integer
        END) AS "likesIn24",
    count(DISTINCT
        CASE
            WHEN ((EXTRACT(day FROM ((CURRENT_TIMESTAMP)::timestamp without time zone - "Reaction"."dateCreated")) = (0)::numeric) AND ("Reaction".type = 'DISLIKE'::public.reaction_type_enum)) THEN "Reaction".id
            ELSE NULL::integer
        END) AS "dislikesIn24",
        CASE
            WHEN (EXTRACT(day FROM ((CURRENT_TIMESTAMP)::timestamp without time zone - "Post"."dateCreated")) = (0)::numeric) THEN true
            ELSE false
        END AS "createdIn24",
    string_agg(("Tag".tag)::text, '#'::text) AS tags,
    array_remove(array_agg(DISTINCT "Tag".tag), NULL::character varying) AS tag
   FROM (((((public.post "Post"
     LEFT JOIN public.comment "Comment" ON (("Post".id = "Comment"."postId")))
     LEFT JOIN public.reaction "Reaction" ON (("Post".id = "Reaction"."postId")))
     LEFT JOIN public."user" "User" ON (("Reaction"."userId" = "User".id)))
     LEFT JOIN public.post_tags pt ON (("Post".id = pt."postId")))
     LEFT JOIN public.tag "Tag" ON ((pt."tagId" = "Tag".id)))
  GROUP BY "Post".id;


--
-- Name: comment FK_276779da446413a0d79598d4fbd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT "FK_276779da446413a0d79598d4fbd" FOREIGN KEY ("authorId") REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: reaction FK_4584f851fc6471f517d9dad8966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reaction
    ADD CONSTRAINT "FK_4584f851fc6471f517d9dad8966" FOREIGN KEY ("commentId") REFERENCES public.comment(id) ON DELETE CASCADE;


--
-- Name: file FK_55d5da8dc1a7684074998cd7e85; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT "FK_55d5da8dc1a7684074998cd7e85" FOREIGN KEY ("commentId") REFERENCES public.comment(id);


--
-- Name: post_tags FK_76e701b89d9bba541e1543adfac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_tags
    ADD CONSTRAINT "FK_76e701b89d9bba541e1543adfac" FOREIGN KEY ("postId") REFERENCES public.post(id) ON DELETE CASCADE;


--
-- Name: post_tags FK_86fabcae8483f7cc4fbd36cf6a2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_tags
    ADD CONSTRAINT "FK_86fabcae8483f7cc4fbd36cf6a2" FOREIGN KEY ("tagId") REFERENCES public.tag(id) ON DELETE CASCADE;


--
-- Name: saved FK_920dd054f0294f7a36ba136151f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved
    ADD CONSTRAINT "FK_920dd054f0294f7a36ba136151f" FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: comment FK_94a85bb16d24033a2afdd5df060; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT "FK_94a85bb16d24033a2afdd5df060" FOREIGN KEY ("postId") REFERENCES public.post(id) ON DELETE CASCADE;


--
-- Name: saved FK_a6dcd809df725dcf7ffe5051dbe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved
    ADD CONSTRAINT "FK_a6dcd809df725dcf7ffe5051dbe" FOREIGN KEY ("postId") REFERENCES public.post(id);


--
-- Name: saved FK_b28606d0b7ab060e21870b7b2a7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved
    ADD CONSTRAINT "FK_b28606d0b7ab060e21870b7b2a7" FOREIGN KEY ("commentId") REFERENCES public.comment(id);


--
-- Name: post FK_c6fb082a3114f35d0cc27c518e0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT "FK_c6fb082a3114f35d0cc27c518e0" FOREIGN KEY ("authorId") REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: reaction FK_dc3aeb83dc815f9f22ebfa7785f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reaction
    ADD CONSTRAINT "FK_dc3aeb83dc815f9f22ebfa7785f" FOREIGN KEY ("postId") REFERENCES public.post(id) ON DELETE CASCADE;


--
-- Name: reaction FK_e58a09ab17e3ce4c47a1a330ae1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reaction
    ADD CONSTRAINT "FK_e58a09ab17e3ce4c47a1a330ae1" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: file FK_f0f2188b3e254ad31ba2b95ec4b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT "FK_f0f2188b3e254ad31ba2b95ec4b" FOREIGN KEY ("postId") REFERENCES public.post(id);


--
-- PostgreSQL database dump complete
--

