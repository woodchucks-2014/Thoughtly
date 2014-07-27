class Category < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :contents
  has_many :contents
  has_many :related_categories

  def self.analyze_url(url)
    request = 'http://access.alchemyapi.com/calls/url/URLGetRankedConcepts?apikey=' + ENV['alchemy_key'] + '&url=' + url + '&outputMode=json'
    keywords = JSON.parse(RestClient.get request, :content_type => :json, :accept => :json)
    keywords_array = keywords["concepts"].map {|concept| concept["text"]}
    puts "*" * 1000
    puts keywords_array
    puts "*" * 1000
    return keywords_array
  end

  def self.node_keywords
    ['red', 'blue', 'green', 'purple', 'shuff']
  end
end
