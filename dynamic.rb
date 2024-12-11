require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new
options.headless!
driver = Selenium::WebDriver.for(:chrome, capabilities: [options])

driver.get 'http::/quotes.toscrape.com/js/'
