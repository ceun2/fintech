from sqlalchemy import create_engine
import pymysql
pymysql.install_as_MySQLdb()
from datetime import datetime

engine = create_engine('mysql+pymysql://root:1234@localhost:3306/book_info')

def saveDB(df, book_name):
    conn = engine.connect()
    df.to_sql(f'{book_name}_book_info', con=conn, index=False, if_exists="append")
    conn.close()