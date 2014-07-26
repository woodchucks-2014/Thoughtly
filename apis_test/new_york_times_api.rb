require 'httparty'
require 'launchy'
require 'open-uri'

API_KEY = '9e933811a63a4a5d1b53efdd2c66d870:18:69605261'
subject = "isis"
url = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{subject}&page=2&api-key=#{API_KEY}"
url =  URI.encode(url)
response = HTTParty.get(url)
article_urls = []

#We're accessing the response key inside the hash. We've assigned the has the variable
#response because that's what it is in the other API methods, even though it's slightly
#confusing here.

response["response"]["docs"].each do |article|
  article_urls << article["web_url"]
end

Launchy.open(article_urls[0])

# response["elements"].each do |entry|
#   videos << entry["shortName"]
# end



 # Launchy.open("https://www.coursera.org/course/#{videos[0]}")


