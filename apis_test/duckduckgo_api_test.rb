require 'httparty'
require 'launchy'
require 'open-uri'

search = "Malaysia"

url = "http://api.duckduckgo.com/?q=DuckDuckGo&format=json?q=#{search}"
url =  URI.encode(url)
response = HTTParty.get(url)

print response.body

# https://rubygems.org/gems/duck-duck-go
