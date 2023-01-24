
![Logo](https://github.com/ItelligenceTurkeyAnalytics/Data-Management-Security-Case/blob/main/Documents/base_logo_white_background.png)


# Data-Management-Security-Case

This case contains applying RLS to tables on the SQL side, creating policies and roles to apply RLS, adding data to PowerBI with the created roles. Thus, the roles that log in from Power BI receive only the part of SQL table that they are authorized to see. The reason for using RLS here is to increase performance.

## Step By Step

Creating "salesdataattempt" table

```bash
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
);
```

Role Creation

```bash
CREATE ROLE uganda
LOGIN
PASSWORD '*****';

CREATE ROLE kuba
LOGIN
PASSWORD '*****';

CREATE ROLE tayland
LOGIN
PASSWORD '*****';
```

Activating Row Level Securiity (RLS) for "salesdataattempt" table.

```bash
ALTER TABLE IF EXISTS public.salesdataattempt
    ENABLE ROW LEVEL SECURITY;
```

Creating Policy for RLS

```bash
CREATE POLICY worker
    ON public.salesdataattempt
    AS PERMISSIVE
    FOR ALL
    TO public
    USING (((country)::name = CURRENT_USER));
```   

Granting Access for role's on "salesdataattempt" table

```bash
GRANT ALL ON TABLE public.salesdataattempt TO digitalent;

GRANT ALL ON TABLE public.salesdataattempt TO kuba;

GRANT ALL ON TABLE public.salesdataattempt TO tayland;

GRANT ALL ON TABLE public.salesdataattempt TO uganda;
-- POLICY: worker
```    

Then We used ODBC to add these roles to PowerBI. EMİR CAN U TAKE FROM HERE.
## Usage

![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)
You can upload photos to Documents folder and use it's url here. Also You can sample from top of this file, where I added Our logo.

## Achievements

- SQL RLS
- Multiple SQL Role Control
- SQL Role Permissions
- PowerBI 
- EC2
- SHH Connection
- Postgre SQL
- ODBC
- Connection of PostgreSQL and PowerBI

## Optimizations

While We creating SQL table from Excel table, We have converted Text variables into varchar variable and bigint variables into int variables for faster queries and to take up less storage space. 


## Documentation

[Documentation](https://linktodocumentation)
I'm adding this as a template too incase we create a pdf folder as a Documentation.

## Authors

- [@GULKANberkan](https://www.github.com/GULKANberkan)
- [@emirefeerez](https://www.github.com/emirefeerez)
- [@kumruo](https://www.github.com/kumruo)
- [@durmuselin](https://www.github.com/durmuselin)
