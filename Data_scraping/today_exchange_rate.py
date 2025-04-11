import pandas as pd
from io import StringIO

import holidays
from datetime import datetime, timedelta

from general_dbio import *

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

from selenium.webdriver.common.by import By

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

options = Options()
options.add_experimental_option("detach", True)
options.add_argument('start-maximized')

# 사람인척하기위해서 개발자도구 network에서 user-agent추가, 언어 추가
options.add_argument('Chrome/134.0.0.0')
options.add_argument('lang=ko_KR')

# 헤드리스 모드일 경우
options.add_argument('--headless')
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')

# gpu 안쓰기
options.add_argument('--disable-gpu') 

driver = webdriver.Chrome(
    service=Service(ChromeDriverManager().install()),
    options=options
    )
driver.get("https://www.kebhana.com/cont/mall/mall15/mall1501/index.jsp?_menuNo=23100&#35;//HanaBank")

columns = ['통화', '현찰_살때_환율', '현찰_살때_spread', '현찰_팔때_환율', '현찰_팔때_spread', '송금_보낼때', '송금_받을때', '외화_수표_팔때', '매매기준율', '환가료율', '미화환산율']

# 한국 공휴일 리스트 가져오기 (1995년~2025년)
kr_holidays = holidays.KR(years=[1995, 2025])

today = datetime.today()
date = today.strftime('%Y-%m-%d')


if today.weekday() >= 5 or today.date() in kr_holidays:
    print(today)
    print(today.date())
    print(today.weekday())
    print('주말 혹은 공휴일입니다')
    pass
else:
    iframe = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.TAG_NAME, 'iframe'))
    )
    driver.switch_to.frame(iframe)

    date_search_box = driver.find_element(By.CSS_SELECTOR, '#tmpInqStrDt')
    date_search_box.clear()
    date_search_box.send_keys(date)

    search_btn = driver.find_element(By.CSS_SELECTOR, '#HANA_CONTENTS_DIV > div.btnBoxCenter > a')
    search_btn.click()

    exchange_rate_table = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, '#searchContentDiv > div.printdiv > table'))
    ) #.get_attribute('outerHTML') 했어도 됐을 듯!!!

    df = pd.read_html(StringIO(driver.page_source))[1]
    df.columns = columns
    df.insert(0, '날짜', date)

    saveDB(df, 'hanabank_exchange_rate', 'exchange_rate')

    driver.switch_to.default_content()  # 원래 메인 페이지로 돌아오기
    print(date, ': 저장완료', end='\r')

driver.quit()
