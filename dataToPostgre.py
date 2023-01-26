from sqlalchemy import create_engine
import sqlalchemy
import pandas as pd
import json

################## Connecting string ##################
with open('config.json') as f:
    engine_data = json.load(f)

    username = engine_data.username
    password = engine_data.password
    IP = engine_data.IP
    port = engine_data.port
    database_name = engine_data.database_name

    engine = create_engine(f'postgresql://username:password@IP:port/database_name')
    engine.connect()


def sqlcol(dfparam):
    dtypedict = {}
    for i, j in zip(dfparam.columns, dfparam.dtypes):

        if i == "description_text":
            dtypedict.update({i: sqlalchemy.types.Text()})

        if i != "description_text" and "object" in str(j):
            dtypedict.update({i: sqlalchemy.types.VARCHAR(length=255)})

        if i == "jobPostingUrl":
            dtypedict.update({i: sqlalchemy.types.Text()})

        if i == "companyName":
            dtypedict.update({i: sqlalchemy.types.Text()})

        if "datetime" in str(j):
            dtypedict.update({i: sqlalchemy.types.DATE()})

        if "float" in str(j):
            dtypedict.update({i: sqlalchemy.types.Float(precision=3, asdecimal=True)})

        if "int" in str(j):
            dtypedict.update({i: sqlalchemy.types.INT()})

        if "int" in str(j):
            dtypedict.update({i: sqlalchemy.types.BIGINT()})

    return dtypedict


fact_sales = pd.read_excel('ntt_rlsCase/fact_sales.xlsx')
dim_customer = pd.read_excel('ntt_rlsCase/dim_customer.xlsx')
dim_employee = pd.read_excel('ntt_rlsCase/dim_employee.xlsx')
dim_order = pd.read_excel('ntt_rlsCase/dim_order.xlsx')
dim_product = pd.read_excel('ntt_rlsCase/dim_product.xlsx')

data = [["fact_sales", fact_sales], ["dim_customer", dim_customer], ["dim_employee", dim_employee], ["dim_order", dim_order], ["dim_product", dim_product]]
for i in data:
    name = i[0]
    df = i[1]
    cols_dtype = sqlcol(df)
    df.head(n=0).to_sql(name=f'{name}', con=engine, if_exists='replace', index=False, dtype=cols_dtype)
    df.to_sql(name=f'{name}', con=engine, index=False, if_exists='append', dtype=cols_dtype)
    df.head(n=0).to_sql(name=f'{name}', con=engine, if_exists="replace")
    df.to_sql(name=f'{name}', con=engine, if_exists="append")
