require "test_helper"
require "selenium-webdriver"

#Webdrivers::Chromedriver.required_version = '135.0.7049.95'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [ 1400, 1400 ]  do | options |
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument("--disable-dev-shm-usage")

    Selenium::WebDriver::Chrome::Service.driver_path = "C:\\chromedriver.exe"
  end
end
