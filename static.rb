require 'httparty'

response = HTTParty.get('https://books.toscrape.com/')
if response.code == 200
  puts response.body
else
  puts "error: #{response.code}"
end
