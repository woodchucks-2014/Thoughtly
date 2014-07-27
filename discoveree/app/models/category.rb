class Category < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :contents
  has_many :contents

  def self.analyze_url(url)
    request = 'http://access.alchemyapi.com/calls/url/URLGetRankedConcepts?apikey=' + ENV['alchemy_key'] + '&url=' + url + '&outputMode=json'
    keywords = JSON.parse(RestClient.get request, :content_type => :json, :accept => :json)
    result = keywords["concepts"].map {|concept| concept["text"]}[0]
  end

  def generate_summary
    query = self.name.gsub(" ", "_").downcase
    request = 'https://www.googleapis.com/freebase/v1/topic/en/' + query + '?filter=suggest' + '&key=' + ENV['FREEBASE']
    results = JSON.parse(RestClient.get(request, :format => :json))
    summary = results["property"]["/common/topic/article"]["values"][0]["property"]["/common/document/text"]["values"][0]["value"]
  end

end
