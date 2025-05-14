from sqlalchemy import create_engine
import pymysql
pymysql.install_as_MySQLdb()

def saveDB(df, db_name, table_name):
    """
    DB에 저장하는 함수
    df, db_name, table_name을 argument로
    """
    engine = create_engine(f'mysql+pymysql://root:1234@localhost:3306/{db_name}')
    conn = engine.connect()
    df.to_sql(f'{table_name}', con=conn, index=False, if_exists="append")
    conn.close()