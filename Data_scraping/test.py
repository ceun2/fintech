import re
import time
import requests
import pandas as pd
from bs4 import BeautifulSoup as bs

import pymysql
from sqlalchemy import create_engine, text
pymysql.install_as_MySQLdb()

url = 'https://kind.krx.co.kr/corpgeneral/corpList.do'
company_info = {}
keys = ['증권종류', '회사명', '종목코드', '업종', '주요제품', '상장일', '결산월', '대표자명', '홈페이지', '지역']

for page in range(1,29):
    payload = dict(method='searchCorpList',pageIndex=page,currentPageSize=100,comAbbrv='',beginIndex='',orderMode=3,orderStat='D',isurCd='',repIsuSrtCd='',searchCodeType='',marketType='',searchType=13,industry='',fiscalYearEnd='all',comAbbrvTmp='',location='all')
    req =requests.post(url, data=payload)
    soup = bs(req.text, 'lxml')
    company_list = soup.select('tbody > tr')
    print(page, ':', len(company_list), end='\r')
    for company in company_list:
        category = company.select_one('.first img')['alt']
        name = company.select_one('#companysum').text.strip()
        code = re.findall(r'\d+',company.select_one('#companysum')['onclick'])[0]
        bus_type = company.select_one('td:nth-child(2)').text
        product = company.select_one('td:nth-child(3)').text
        ipo_date = company.select_one('td:nth-child(4)').text
        final_month = company.select_one('td:nth-child(5)').text
        ceo = company.select_one('td:nth-child(6)').text
        website = company.select_one('td:nth-child(7) > a')['href'] if company.select_one('td:nth-child(7) > a') else '-'
        region = company.select_one('td:nth-child(8)').text

        values = [category, name, code, bus_type, product, ipo_date, final_month, ceo, website, region]
        for key, val in zip(keys, values):
            company_info.setdefault(key,[]).append(val)
    time.sleep(5)

company_info_df = pd.DataFrame(company_info)

db_name = 'korean_stock'
host = '127.0.0.1'
user = 'root'
password = '1234'

conn = pymysql.connect(host=host, user=user, password=password)
cursor = conn.cursor()
cursor.execute(f"CREATE DATABASE IF NOT EXISTS {db_name}")
conn.close()
print('DB 생성 완료')

engine = create_engine(f'mysql+pymysql://{user}:{password}@{host}:3306/{db_name}')
sql_conn = engine.connect()
company_info_df.to_sql('company_info', con=sql_conn, if_exists='replace', index=False)
sql_conn.close()
print('테이블 저장 완료')