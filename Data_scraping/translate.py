# 구글 번역기에 한국어 넣고 영어로 번역 후 결고 가져오는 함수 만들기

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

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

def ko2eng(keyword):
    try:
        driver = webdriver.Chrome(
            service=Service(ChromeDriverManager().install()),
            options=options
        )
        driver.get("https://translate.google.com/?hl=ko&sl=ko&tl=en&op=translate")
        
        ko_textarea = driver.find_element(By.CSS_SELECTOR, '#yDmH0d .ToWKne .OlSOob .ccvoYb > div.AxqVh > div.OPPzxe > div > c-wiz > span > span > div > textarea')
        ko_textarea.send_keys(keyword)

        eng_selector='#yDmH0d .ToWKne .OlSOob .ccvoYb > div.AxqVh > div.OPPzxe > c-wiz > div > div.usGWQd .lRu31 > span.HwtZe > span > span'

        WebDriverWait(driver, 10).until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, eng_selector)))

        result = driver.find_element(By.CSS_SELECTOR, eng_selector).text
        print(f'번역 결과 : {keyword} → {result}')
    finally:
        driver.quit()
    return result

ko2eng('여름이었다')