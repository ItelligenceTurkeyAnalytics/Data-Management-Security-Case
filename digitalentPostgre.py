from sqlalchemy import create_engine
import sqlalchemy
import seaborn as sns
################## Connecting string ##################
engine = create_engine(f'postgresql://digitalent:digitalent23@3.75.170.121:5432/test')


engine.connect()


def sqlcol(dfparam):
    dtypedict = {}
    for i,j in zip(dfparam.columns, dfparam.dtypes):

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

import pandas as pd
df = pd.read_excel('Sales_Data.xlsx')
df.info()
cols_dtype = sqlcol(df)

df.head(n=0).to_sql(name='SalesData', con=engine, if_exists='replace', index=False, dtype=cols_dtype)
df.to_sql(name='SalesData', con=engine, index=False, if_exists='append',  dtype=cols_dtype)


df.head(n=0).to_sql(name='SalesData', con=engine, if_exists="replace")

# adding the first batch of rows
df.to_sql(name='SalesData', con=engine, if_exists="append")
