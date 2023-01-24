-- Table: public.salesdataattempt

-- DROP TABLE IF EXISTS public.salesdataattempt;

CREATE TABLE IF NOT EXISTS public.salesdataattempt
(
    index integer,
    order_id integer,
    quantityordered integer,
    priceeach integer,
    orderlinenumber integer,
    sales integer,
    orderdate date,
    status character varying(255) COLLATE pg_catalog."default",
    qtr_id integer,
    month_id integer,
    year_id integer,
    productline character varying(255) COLLATE pg_catalog."default",
    msrp integer,
    productcode character varying(255) COLLATE pg_catalog."default",
    customername character varying(255) COLLATE pg_catalog."default",
    postalcode character varying(255) COLLATE pg_catalog."default",
    country character varying(255) COLLATE pg_catalog."default",
    costumer_lastname character varying(255) COLLATE pg_catalog."default",
    costumer_firstname character varying(255) COLLATE pg_catalog."default",
    employee_id integer
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE ROLE uganda
LOGIN
PASSWORD '*****';

CREATE ROLE kuba
LOGIN
PASSWORD '*****';

CREATE ROLE tayland
LOGIN
PASSWORD '*****';

ALTER TABLE IF EXISTS public.salesdataattempt
    OWNER to digitalent;

ALTER TABLE IF EXISTS public.salesdataattempt
    ENABLE ROW LEVEL SECURITY;

GRANT ALL ON TABLE public.salesdataattempt TO digitalent;

GRANT ALL ON TABLE public.salesdataattempt TO kuba;

GRANT ALL ON TABLE public.salesdataattempt TO tayland;

GRANT ALL ON TABLE public.salesdataattempt TO uganda;
-- POLICY: worker

-- DROP POLICY IF EXISTS worker ON public.salesdataattempt;

CREATE POLICY worker
    ON public.salesdataattempt
    AS PERMISSIVE
    FOR ALL
    TO public
    USING (((country)::name = CURRENT_USER));
    
-- Table: public.EmployeeData

-- DROP TABLE IF EXISTS public."EmployeeData";

CREATE TABLE IF NOT EXISTS public."EmployeeData"
(
    index bigint,
    "EMPLOYEE_ID" bigint,
    "EMPLOYEE_NAME" text COLLATE pg_catalog."default",
    "SEX" text COLLATE pg_catalog."default",
    "EMPLOYEE_REGÝON" text COLLATE pg_catalog."default",
    "EMPLOYEE_POSÝTÝON" text COLLATE pg_catalog."default",
    "EMPLOYEE_SALARY" bigint,
    "EMPLOYEE_MANAGER" text COLLATE pg_catalog."default",
    "EMPLOYEE_DEPARTMENT" text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."EmployeeData"
    OWNER to digitalent;

ALTER TABLE IF EXISTS public."EmployeeData"
    ENABLE ROW LEVEL SECURITY;
-- Index: ix_EmployeeData_index

-- DROP INDEX IF EXISTS public."ix_EmployeeData_index";

CREATE INDEX IF NOT EXISTS "ix_EmployeeData_index"
    ON public."EmployeeData" USING btree
    (index ASC NULLS LAST)
    TABLESPACE pg_default;
