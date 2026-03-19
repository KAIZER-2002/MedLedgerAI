--
-- PostgreSQL database dump
--

\restrict NQPrhXP0taGcbueacfEZ8skfsCaGoIHBfku3yBgER7i9yDKdHAG1zmERaCdD7ZQ

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: blockchain_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blockchain_records (
    blockchain_id integer NOT NULL,
    prescription_id integer,
    transaction_hash character varying(255),
    block_number integer,
    network character varying(100),
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.blockchain_records OWNER TO postgres;

--
-- Name: blockchain_records_blockchain_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blockchain_records_blockchain_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blockchain_records_blockchain_id_seq OWNER TO postgres;

--
-- Name: blockchain_records_blockchain_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blockchain_records_blockchain_id_seq OWNED BY public.blockchain_records.blockchain_id;


--
-- Name: medicines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicines (
    medicine_id integer NOT NULL,
    name character varying(120) NOT NULL,
    dosage character varying(100),
    description text,
    side_effects text
);


ALTER TABLE public.medicines OWNER TO postgres;

--
-- Name: medicines_medicine_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medicines_medicine_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medicines_medicine_id_seq OWNER TO postgres;

--
-- Name: medicines_medicine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medicines_medicine_id_seq OWNED BY public.medicines.medicine_id;


--
-- Name: predictions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.predictions (
    prediction_id integer NOT NULL,
    symptom_id integer,
    predicted_disease character varying(120),
    confidence_score numeric(5,2),
    model_version character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.predictions OWNER TO postgres;

--
-- Name: predictions_prediction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.predictions_prediction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.predictions_prediction_id_seq OWNER TO postgres;

--
-- Name: predictions_prediction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.predictions_prediction_id_seq OWNED BY public.predictions.prediction_id;


--
-- Name: prescription_med; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescription_med (
    id integer NOT NULL,
    prescription_id integer,
    medicine_id integer,
    dosage_instruction text
);


ALTER TABLE public.prescription_med OWNER TO postgres;

--
-- Name: prescription_med_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescription_med_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prescription_med_id_seq OWNER TO postgres;

--
-- Name: prescription_med_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescription_med_id_seq OWNED BY public.prescription_med.id;


--
-- Name: prescriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescriptions (
    prescription_id integer NOT NULL,
    user_id integer,
    prediction_id integer,
    doctor_id integer,
    doctor_notes text,
    blockchain_hash character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.prescriptions OWNER TO postgres;

--
-- Name: prescriptions_prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescriptions_prescription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prescriptions_prescription_id_seq OWNER TO postgres;

--
-- Name: prescriptions_prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescriptions_prescription_id_seq OWNED BY public.prescriptions.prescription_id;


--
-- Name: symptoms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.symptoms (
    symptom_id integer NOT NULL,
    user_id integer,
    symptom_text text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.symptoms OWNER TO postgres;

--
-- Name: symptoms_symptom_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.symptoms_symptom_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.symptoms_symptom_id_seq OWNER TO postgres;

--
-- Name: symptoms_symptom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.symptoms_symptom_id_seq OWNED BY public.symptoms.symptom_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(120) NOT NULL,
    email character varying(120) NOT NULL,
    password_hash text NOT NULL,
    role character varying(20),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['patient'::character varying, 'doctor'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: blockchain_records blockchain_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blockchain_records ALTER COLUMN blockchain_id SET DEFAULT nextval('public.blockchain_records_blockchain_id_seq'::regclass);


--
-- Name: medicines medicine_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines ALTER COLUMN medicine_id SET DEFAULT nextval('public.medicines_medicine_id_seq'::regclass);


--
-- Name: predictions prediction_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predictions ALTER COLUMN prediction_id SET DEFAULT nextval('public.predictions_prediction_id_seq'::regclass);


--
-- Name: prescription_med id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_med ALTER COLUMN id SET DEFAULT nextval('public.prescription_med_id_seq'::regclass);


--
-- Name: prescriptions prescription_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions ALTER COLUMN prescription_id SET DEFAULT nextval('public.prescriptions_prescription_id_seq'::regclass);


--
-- Name: symptoms symptom_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.symptoms ALTER COLUMN symptom_id SET DEFAULT nextval('public.symptoms_symptom_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: blockchain_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blockchain_records (blockchain_id, prescription_id, transaction_hash, block_number, network, "timestamp") FROM stdin;
1	1	0x9ab23c88d	45822	Hyperledger	2026-03-06 15:46:05.231865
2	1	0x9ab23c88d123	45678	Hyperledger	2026-03-06 15:54:19.444482
\.


--
-- Data for Name: medicines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicines (medicine_id, name, dosage, description, side_effects) FROM stdin;
1	Paracetamol	500mg	Pain relief	nausea
2	Paracetamol	500mg	Pain reliever	Nausea
\.


--
-- Data for Name: predictions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.predictions (prediction_id, symptom_id, predicted_disease, confidence_score, model_version, created_at) FROM stdin;
1	1	Flu	87.50	v1.0	2026-03-06 15:45:39.149661
2	1	Flu	88.50	v1.0	2026-03-06 15:54:19.427307
\.


--
-- Data for Name: prescription_med; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescription_med (id, prescription_id, medicine_id, dosage_instruction) FROM stdin;
1	1	1	Take twice daily after meal
2	1	1	Take twice daily after meals
\.


--
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescriptions (prescription_id, user_id, prediction_id, doctor_id, doctor_notes, blockchain_hash, created_at) FROM stdin;
1	1	1	2	Take rest and drink water	\N	2026-03-06 15:45:52.100775
2	1	1	2	Take rest and drink plenty of fluids	\N	2026-03-06 15:54:19.435247
\.


--
-- Data for Name: symptoms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.symptoms (symptom_id, user_id, symptom_text, created_at) FROM stdin;
1	1	fever cough headache	2026-03-06 15:45:36.807816
2	1	fever cough headache	2026-03-06 15:54:19.421149
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, email, password_hash, role, created_at) FROM stdin;
1	Swapnil	swapnil@email.com	hashed_pw	patient	2026-03-06 15:45:23.085738
2	Dr John	doctor@email.com	hashed_pw	doctor	2026-03-06 15:45:23.085738
3	Swapnil	swapnil@test.com	hashed_pw	patient	2026-03-06 15:54:19.415908
4	Dr Smith	doctor@test.com	hashed_pw	doctor	2026-03-06 15:54:19.415908
\.


--
-- Name: blockchain_records_blockchain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blockchain_records_blockchain_id_seq', 2, true);


--
-- Name: medicines_medicine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medicines_medicine_id_seq', 2, true);


--
-- Name: predictions_prediction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.predictions_prediction_id_seq', 2, true);


--
-- Name: prescription_med_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescription_med_id_seq', 2, true);


--
-- Name: prescriptions_prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescriptions_prescription_id_seq', 2, true);


--
-- Name: symptoms_symptom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.symptoms_symptom_id_seq', 2, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 4, true);


--
-- Name: blockchain_records blockchain_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blockchain_records
    ADD CONSTRAINT blockchain_records_pkey PRIMARY KEY (blockchain_id);


--
-- Name: blockchain_records blockchain_records_transaction_hash_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blockchain_records
    ADD CONSTRAINT blockchain_records_transaction_hash_key UNIQUE (transaction_hash);


--
-- Name: medicines medicines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines
    ADD CONSTRAINT medicines_pkey PRIMARY KEY (medicine_id);


--
-- Name: predictions predictions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT predictions_pkey PRIMARY KEY (prediction_id);


--
-- Name: prescription_med prescription_med_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_med
    ADD CONSTRAINT prescription_med_pkey PRIMARY KEY (id);


--
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (prescription_id);


--
-- Name: symptoms symptoms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.symptoms
    ADD CONSTRAINT symptoms_pkey PRIMARY KEY (symptom_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: idx_blockchain_tx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blockchain_tx ON public.blockchain_records USING btree (transaction_hash);


--
-- Name: idx_medicine_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_medicine_name ON public.medicines USING btree (name);


--
-- Name: idx_predictions_symptom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_predictions_symptom ON public.predictions USING btree (symptom_id);


--
-- Name: idx_prescription_medicine; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prescription_medicine ON public.prescription_med USING btree (prescription_id);


--
-- Name: idx_prescription_prediction; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prescription_prediction ON public.prescriptions USING btree (prediction_id);


--
-- Name: idx_prescription_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prescription_user ON public.prescriptions USING btree (user_id);


--
-- Name: idx_symptoms_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_symptoms_user ON public.symptoms USING btree (user_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: blockchain_records blockchain_records_prescription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blockchain_records
    ADD CONSTRAINT blockchain_records_prescription_id_fkey FOREIGN KEY (prescription_id) REFERENCES public.prescriptions(prescription_id);


--
-- Name: predictions predictions_symptom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT predictions_symptom_id_fkey FOREIGN KEY (symptom_id) REFERENCES public.symptoms(symptom_id) ON DELETE CASCADE;


--
-- Name: prescription_med prescription_med_medicine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_med
    ADD CONSTRAINT prescription_med_medicine_id_fkey FOREIGN KEY (medicine_id) REFERENCES public.medicines(medicine_id);


--
-- Name: prescription_med prescription_med_prescription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_med
    ADD CONSTRAINT prescription_med_prescription_id_fkey FOREIGN KEY (prescription_id) REFERENCES public.prescriptions(prescription_id) ON DELETE CASCADE;


--
-- Name: prescriptions prescriptions_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.users(user_id);


--
-- Name: prescriptions prescriptions_prediction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_prediction_id_fkey FOREIGN KEY (prediction_id) REFERENCES public.predictions(prediction_id);


--
-- Name: prescriptions prescriptions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: symptoms symptoms_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.symptoms
    ADD CONSTRAINT symptoms_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict NQPrhXP0taGcbueacfEZ8skfsCaGoIHBfku3yBgER7i9yDKdHAG1zmERaCdD7ZQ

