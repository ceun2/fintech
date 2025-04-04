import re
import time
import requests
import pandas as pd
from datetime import datetime
from bs4 import BeautifulSoup as bs

import pymysql
from sqlalchemy import create_engine, text

url = 'https://kind.krx.co.kr/corpgeneral/corpList.do'

company_info = {}
keys = ['주식종목', '회사명', '종목코드', '주요제품', '상장일', '결산월', '대표자명', '홈페이지', '지역']
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
        product = company.select_one('.textOverflow').text
        ipo_date = company.select_one('td:nth-child(4)').text
        final_month = company.select_one('td:nth-child(5)').text
        ceo = company.select_one('td:nth-child(6)').text
        website = company.select_one('td:nth-child(7) > a')['href'] if company.select_one('td:nth-child(7) > a') else '-'
        region = company.select_one('td:nth-child(8)').text

        values = [category, name, code, product, ipo_date, final_month, ceo, website, region]
        for key, val in zip(keys, values):
            company_info.setdefault(key,[]).append(val)
    time.sleep(5)

company_info_df = pd.DataFrame(company_info)

today = datetime.now()
today = today.strftime('%Y_%m_%d')

pymysql.install_as_MySQLdb()

# localhost = 127.0.0.1
engine = create_engine('mysql+pymysql://root:1234@localhost:3306/stock_info')
# engine.connect create_engine에 있는 정보로 DB 접속
conn = engine.connect()
# 데이터프레임을 DB에 저장하기
# 데이터프레임명.to_sql('테이블명')
company_info_df.to_sql(f'stock_company_info_{today}', con=conn, if_exists='replace', index=False)
conn.close()