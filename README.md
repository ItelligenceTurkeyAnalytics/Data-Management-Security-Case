
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

Then, we used ODBC to connect PostgreSQL to PowerBI. With this, our dataset and created roles are all came to the PowerBI. Below, this will be explained.

PostgreSQL

PostgreSQL is an open-source relational database management system. Also, it has an API which provide you to load your data into the database and writing queries using Python.

PowerBI

Microsoft Power BI is a business intelligence (BI) platform that provides nontechnical business users with tools for aggregating, analysing, visualizing and sharing data. It provides the visualization of the data which is pulled from database, or any excel file.

ODBC

Open Database Connectivity (ODBC) is an open standard Application Programming Interface (API) for accessing a database. Using ODBC, you can create database applications with access to any database for which your end user has an ODBC driver. 
ODBC is designed to expose database capabilities, not supplement them. According to this, we can say that ODBC will not suddenly transform a simple database into a fully featured relational database engine; but applications that use ODBC are responsible for any cross-database functionality.

Connection of PostgreSQL with PowerBI using ODBC

Most BI tools allow connections to several databases and APIs. Microsoft Power BI is a very extensively used BI tool and PostgreSQL is a very popular database. So, of course, there is a method used to connect PostgreSQL to Power BI. You can provide the connection between PostgreSQL and PowerBI using ODBC.
Steps are:
1.	Run Power BI Desktop and click Get Data.
2.	Select the Other category in the Get Data dialog box, then select ODBC. Click Connect to confirm the choice.
3.	In the From ODBC dialog box, expand the Data Source Name drop-down list and select the previously configured data source for PostgreSQL.
4.	If you would like to enter a SQL statement to narrow down the returned results, click the Advanced options arrow, which expands the dialog box, and type or paste your SQL statement.
5.	Click OK. If your data source is password-protected, Power BI will prompt you for user credentials. Type your Username and Password in the respective fields and click.
6.	Now you should see the data structures in your data source. You can preview the contents of the database objects by clicking on them.
7.	To load the PostgreSQL data into Power BI for analysis, select the needed table and click Load.
In the third step you are selecting a data source that you configured it in the ODBC as in the Figure 2. While configuring it, you must make a log-in for user. This user can be the admin user which provide you to see all records in the data source. But, also, this user can be a previously created role in database which provide you to see the records as much as you're authorized. This called Row Level Security (RLS). Row-Level Security (RLS) simplifies the design and coding of security in your application. RLS helps you implement restrictions on data row access. For example, you can ensure that workers access only those data rows that are pertinent to their country.


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
