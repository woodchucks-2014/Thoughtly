require 'httparty'
require 'launchy'
require 'open-uri'

url = 'https://api.coursera.org/api/catalog.v1/courses?fields=language,shortDescription'
url =  URI.encode(url)
response = HTTParty.get(url)
videos = []
# print response.body
response["elements"].each do |entry|
  videos << entry["shortName"]
end



 Launchy.open("https://www.coursera.org/course/#{videos[0]}")


