class Category < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :contents
  has_many :contents

  def self.analyze_url(url)
    request = 'http://access.alchemyapi.com/calls/url/URLGetRankedConcepts?apikey=802a1e81b3fd9a6dde49541520a09b2172c57a2e&url=' + url + '&outputMode=json'
    keywords = JSON.parse(RestClient.get request, :content_type => :json, :accept => :json)
    result = keywords["concepts"].map {|concept| concept["text"]}[0]
  end

end
