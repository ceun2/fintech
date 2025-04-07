from sqlalchemy import create_engine
import pymysql
pymysql.install_as_MySQLdb()
from datetime import datetime

engine = create_engine('mysql+pymysql://root:1234@localhost:3306/stock_info')

def saveDB(df, file_name):
    today = datetime.now()
    today = today.strftime('%Y_%m_%d')
    conn = engine.connect()
    df.to_sql(f'{file_name}_{today}', con=conn, index=False, if_exists="append")
    conn.close()