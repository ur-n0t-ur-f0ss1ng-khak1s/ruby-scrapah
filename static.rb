require 'httparty'
require 'nokogiri'
require 'csv'

filename = 'books.csv'

CSV.open(
  filename,
  'w+',
  write_headers: true,
  headers: %w[Title Price Availability]
) do |csv|
  50.times do |i|
    response = HTTParty.get("https://books.toscrape.com/catalogue/page-#{i+1}.html")
    if response.code == 200
      puts response.body
    else
      puts "error: #{response.code}"
    end

    document = Nokogiri::HTML4(response.body)
    all_book_containers = document.css('article.product_pod')
    books = []
    all_book_containers.each do |container|
      title = container.css('h3 a').first['title']
      price = container.css('.price_color').text.delete('^0-9.')
      availability = container.css('.availability').text.strip
      book = [title, price, availability]
      csv << book
    end
  end
end
