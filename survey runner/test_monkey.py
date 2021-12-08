from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time


def hasxpath(xpath):
    try:
        driver.find_element_by_xpath(xpath)
        return True
    except:
        return False

driver = webdriver.Chrome()
driver.get("https://consurvey.sowi.uni-mannheim.de/publix/244/start?batchId=325&generalMultiple")

count = 0

while(count < 30):

    print(count)
    
    if hasxpath('//*[@id="next"]'):
        button = driver.find_element_by_xpath('//*[@id="next"]')
        button.click()

    elif hasxpath('/html/body/div[1]/canvas'):
        time.sleep(1.5)
        print("canvas")   

    elif hasxpath('//*[@id="page-item-percent"]/input'): 
        input = driver.find_element_by_xpath('//*[@id="page-item-percent"]/input')
        input.send_keys("50")   

        time.sleep(0.1)

        button = driver.find_element_by_xpath('/html/body/div/footer/button')
        button.click()

    else:
        time.sleep(1.5)
        print("nothing")

    count += 1
    time.sleep(0.5)



