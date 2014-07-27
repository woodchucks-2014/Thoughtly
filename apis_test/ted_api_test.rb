require 'httparty'
require 'launchy'
require 'open-uri'
API_KEY = 'quwm7pd4cv7du89rr98h9jt3'

# url = 'http://api.ted.com/v1/talks.json?api-key=#{API_KEY}&filter=id:>350'


url = 'http://api.ted.com/v1/talks.json?api-key=quwm7pd4cv7du89rr98h9jt3&filter=id:>350'

url =  URI.encode(url)

response = HTTParty.get(url)
videos = []

response["talks"].each do |entry|
  videos << entry["talk"]["slug"]
end

Launchy.open("http://www.ted.com/talks/#{videos[0]}")


