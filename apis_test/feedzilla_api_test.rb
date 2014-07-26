require 'httparty'
require 'launchy'
require 'open-uri'

search = "Malaysia"

url = "http://api.feedzilla.com/v1/articles/search.json?q=#{search}"
url =  URI.encode(url)
response = HTTParty.get(url)

articles = []
response["articles"].each do |article|
	p article["author"]
	p article["publish_date"]
	p article["author"]
	p article["source_url"]
	p article["summary"]
	p article["title"]
	p article["url"]
end

#Additional APIs to add:
# NPR: http://www.npr.org/api/index
# Goodreads: 
# rdio: http://www.rdio.com/developers/docs/
# bing http://datamarket.azure.com/dataset/bing/search (5,000 per month)