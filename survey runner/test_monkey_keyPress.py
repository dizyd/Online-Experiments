

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time


def hasxpath(xpath):
    try:
        driver.find_element_by_xpath(xpath)
        return True
    except:
        return False

driver = webdriver.Chrome("survey runner\chromedriver.exe")

driver.get("https://consurvey.sowi.uni-mannheim.de/publix/251/start?batchId=334&generalMultiple")


time.sleep(0.2)
count = 0


button = driver.find_element_by_xpath('//*[@id="next"]')
button.click()

while(count < 10):
    time.sleep(0.2)
    webdriver.ActionChains(driver).send_keys(Keys.SPACE).perform()
    count += 1




