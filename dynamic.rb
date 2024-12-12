require 'selenium-webdriver'
require 'csv'

driver = Selenium::WebDriver.for :firefox
#driver = Selenium::WebDriver.for(:chrome, capabilities: [options])

driver.get 'http://quotes.toscrape.com/'

quotes = []
while true do
  quote_container = driver.find_elements(css: '.quote')

  quote_container.each do |quote_el|
    quote_text = quote_el.find_element(css: '.text').text
    author = quote_el.find_element(css: '.author').text
    quotes << { quote: quote_text, author: author }
  end

  begin
    driver.find_element(css: '.next >a').click
  rescue
    break 
  end
end

CSV.open(
  'quotes.csv',
  'w+',
  write_headers: true,
  headers: %w[Quote Author]
) do |csv|
  quotes.each do |quote|
    csv << [quote[:quote], quote[:author]]
  end
end

driver.quit
