class Category < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :contents
  has_many :contents
  include ActionView::Helpers


  def self.analyze_url(url)
    request = 'http://access.alchemyapi.com/calls/url/URLGetRankedConcepts?apikey=' + ENV['ALCHEMY_KEY'] + '&url=' + url + '&outputMode=json'
    keywords = JSON.parse(RestClient.get request, :content_type => :json, :accept => :json)
    keywords_array = keywords["concepts"].map {|concept| concept["text"]}
    return keywords_array
  end

  def self.analyze_text(text)
      keywords_array = []
      text = text.gsub(/(\"|\')/, "")
      AlchemyAPI.key = ENV['ALCHEMY_KEY']
      AlchemyAPI.search(:concept_tagging, :text => text).each do |key|
      keywords_array << key["text"]
    end
    keywords_array
  end

  def self.generate_summary(search_term = self)
    query = search_term.gsub(" ", "_").downcase
    request = 'https://www.googleapis.com/freebase/v1/topic/en/' + query + '?filter=suggest' + '&key=' + ENV['FREEBASE']
    results = JSON.parse(RestClient.get(request, :format => :json))
    summary = results["property"]["/common/topic/article"]["values"][0]["property"]["/common/document/text"]["values"][0]["value"]
  end
end
