class Category < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :contents
  has_many :contents
  include ActionView::Helpers

  def self.analyze_url(url)
    request = 'http://access.alchemyapi.com/calls/url/URLGetRankedConcepts?apikey=' + ENV['alchemy_key'] + '&url=' + url + '&outputMode=json'
    keywords = JSON.parse(RestClient.get request, :content_type => :json, :accept => :json)
    keywords_array = keywords["concepts"].map {|concept| concept["text"]}
    return keywords_array
  end

  def self.format_related(categories)
    if categories.class == Array && categories.length > 1
      return categories.join("%")
    else
      return ""
    end
  end

  def generate_summary
    query = self.name.gsub(" ", "_").downcase
    request = 'https://www.googleapis.com/freebase/v1/topic/en/' + query + '?filter=suggest' + '&key=' + ENV['FREEBASE']
    results = JSON.parse(RestClient.get(request, :format => :json))
    summary = results["property"]["/common/topic/article"]["values"][0]["property"]["/common/document/text"]["values"][0]["value"][0..500]
  end

end
