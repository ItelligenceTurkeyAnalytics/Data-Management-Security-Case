-- Table: public.dim_customer

-- DROP TABLE IF EXISTS public.dim_customer;

CREATE TABLE IF NOT EXISTS public.dim_customer
(
    "CustomerID" double precision NOT NULL,
    "COSTUMER_LASTNAME" text COLLATE pg_catalog."default",
    "COSTUMER_FIRSTNAME" text COLLATE pg_catalog."default",
    "POSTALCODE" text COLLATE pg_catalog."default",
    CONSTRAINT dim_customer_pkey PRIMARY KEY ("CustomerID")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_customer
    OWNER to digitalent;
    
-- Table: public.dim_employee

-- DROP TABLE IF EXISTS public.dim_employee;

CREATE TABLE IF NOT EXISTS public.dim_employee
(
    "EMPLOYEE_ID" bigint NOT NULL,
    "EMPLOYEE_NAME" text COLLATE pg_catalog."default",
    "SEX" text COLLATE pg_catalog."default",
    "EMPLOYEE_REGİON" text COLLATE pg_catalog."default",
    "EMPLOYEE_POSİTİON" text COLLATE pg_catalog."default",
    "EMPLOYEE_SALARY" bigint,
    "EMPLOYEE_MANAGER" text COLLATE pg_catalog."default",
    "EMPLOYEE_DEPARTMENT" text COLLATE pg_catalog."default",
    CONSTRAINT dim_employee_pkey PRIMARY KEY ("EMPLOYEE_ID")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_employee
    OWNER to digitalent;



-- Table: public.dim_order

-- DROP TABLE IF EXISTS public.dim_order;

CREATE TABLE IF NOT EXISTS public.dim_order
(
    "ORDER_ID" bigint NOT NULL,
    "QUANTITYORDERED" bigint,
    "ORDERLINENUMBER" bigint,
    "ORDERDATE" timestamp without time zone,
    "STATUS" text COLLATE pg_catalog."default",
    CONSTRAINT dim_order_pkey PRIMARY KEY ("ORDER_ID")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_order
    OWNER to digitalent;
    
-- Table: public.dim_product

-- DROP TABLE IF EXISTS public.dim_product;

CREATE TABLE IF NOT EXISTS public.dim_product
(
    "PRODUCTCODE" text COLLATE pg_catalog."default" NOT NULL,
    "PRICEEACH" double precision,
    "PRODUCTLINE" text COLLATE pg_catalog."default",
    "MSRP" bigint,
    CONSTRAINT dim_product_pkey PRIMARY KEY ("PRODUCTCODE")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_product
    OWNER to digitalent;
    
-- Table: public.fact_sales

-- DROP TABLE IF EXISTS public.fact_sales;

CREATE TABLE IF NOT EXISTS public.fact_sales
(
    index bigint NOT NULL,
    "ORDER_ID" bigint,
    "PRODUCTCODE" text COLLATE pg_catalog."default",
    "CustomerID" bigint,
    "EMPLOYEE_ID" bigint,
    "COUNTRY" text COLLATE pg_catalog."default",
    "SALES" double precision,
    CONSTRAINT fact_sales_pkey PRIMARY KEY (index),
    CONSTRAINT "fact_sales_CustomerID_fkey" FOREIGN KEY ("CustomerID")
        REFERENCES public.dim_customer ("CustomerID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "fact_sales_EMPLOYEE_ID_fkey" FOREIGN KEY ("EMPLOYEE_ID")
        REFERENCES public.dim_employee ("EMPLOYEE_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "fact_sales_ORDER_ID_fkey" FOREIGN KEY ("ORDER_ID")
        REFERENCES public.dim_order ("ORDER_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "fact_sales_PRODUCTCODE_fkey" FOREIGN KEY ("PRODUCTCODE")
        REFERENCES public.dim_product ("PRODUCTCODE") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fact_sales
    OWNER to digitalent;

ALTER TABLE IF EXISTS public.fact_sales
    ENABLE ROW LEVEL SECURITY;

GRANT ALL ON TABLE public.fact_sales TO digitalent;

GRANT ALL ON TABLE public.fact_sales TO kuba;

GRANT ALL ON TABLE public.fact_sales TO tayland;

GRANT ALL ON TABLE public.fact_sales TO uganda;
-- POLICY: worker

-- DROP POLICY IF EXISTS worker ON public.fact_sales;

CREATE POLICY worker
    ON public.fact_sales
    AS PERMISSIVE
    FOR ALL
    TO public
    USING (("COUNTRY" = (CURRENT_USER)::text));


-- Role: kuba
-- DROP ROLE IF EXISTS kuba;

CREATE ROLE kuba WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'md5c6a5faadfb2d3c1883c776235a017dbf';

-- Role: tayland
-- DROP ROLE IF EXISTS tayland;

CREATE ROLE tayland WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'md5db8443090ce053658a487a1ba120b070';

-- Role: uganda
-- DROP ROLE IF EXISTS uganda;

CREATE ROLE uganda WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'md5cecb716f4e20961bbc04c92edd20c954';

-- POLICY: worker

-- DROP POLICY IF EXISTS worker ON public.fact_sales;

CREATE POLICY worker
    ON public.fact_sales
    AS PERMISSIVE
    FOR ALL
    TO public
    USING (("COUNTRY" = (CURRENT_USER)::text));




