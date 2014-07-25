module CategoryHelper


  def analyze_url(url)
    request = 'http://access.alchemyapi.com/calls/url/URLGetRankedConcepts?apikey=802a1e81b3fd9a6dde49541520a09b2172c57a2e&url=' + url + '&outputMode=json'
    keywords = JSON.parse(RestClient.get url, :content_type => :json, :accept => :json)
    result = keywords["concepts"].map {|concept| concept["text"]}[0]
  end

end
