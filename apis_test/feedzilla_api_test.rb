require 'httparty'
require 'launchy'
require 'open-uri'

search = "Malaysia"

url = "http://api.feedzilla.com/v1/categories/26/articles/search.json?q=#{search}"
url =  URI.encode(url)
response = HTTParty.get(url)


print response.body
