class Content < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  require 'open-uri'
  require 'wikipedia'
  require 'google/api_client'
  require 'trollop'

  def self.youtube_search(query)
    youtube_service_api_name = "youtube"
    youtube_api_version = "v3"
    opts = Trollop::options do
      opt :p, 'Search term', :source => String, :default => query
      opt :maxResults, 'Max results', :source => :int, :default => 25
    end

    client = Google::APIClient.new(:key => ENV['YOUTUBE_DEVELOPER_KEY'],
     :authorization => nil)

    youtube = client.discovered_api(youtube_service_api_name, youtube_api_version)
    opts[:part] = 'id,snippet'
    search_response = client.execute!(
      :api_method => youtube.search.list,
      :parameters => opts
      )

    videos = []
    search_response.data.items.each do |search_result|
      case search_result.id.kind
      when 'youtube#video'
        videos << {:url => "http://www.youtube.com/watch?v=#{search_result.id.videoId})", :name => "#{search_result.snippet.title}", :description=> "#{search_result.snippet.description}"}
      end
    end
    return videos[0..2]
  end

  def self.coursera(query)
    url = 'https://api.coursera.org/api/catalog.v1/courses?q=search&query=' + query
    url =  URI.encode(url)
    response = HTTParty.get(url)
    videos = []
    unless response["elements"] == nil
      response["elements"].each do |entry|
        videos << {:url => "https://www.coursera.org/course/#{entry['shortName']}", :name => entry['name']}
      end
    end
    return [videos[0]]
  end

  def self.new_york_times(query)
    subject = query
    url = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{subject}&page=2&api-key=#{ENV['NY_TIMES_API_KEY']}"
    url =  URI.encode(url)
    response = HTTParty.get(url)
    articles = []
    response["response"]["docs"].each do |article|
      articles << {:url => article["web_url"], :name => article["headline"]["main"], :description=> article["lead_paragraph"]}
    end
    return articles[0..2]
  end

  def self.ted_search(query)
    url = "https://api.ted.com/v1/search.json?q=" + query + "&categories=talks&api-key=" + ENV['TED_API_KEY']
    url = URI.encode(url)
    response = HTTParty.get(url)
    videos = []
    response["results"].each do |result|
      videos << {:url => "http://www.ted.com/talks/#{result["talk"]["slug"]}", :name=> result["talk"]["name"]}
    end
    results = []
    videos[0..1].each do |video|
      video[:description] = Content.scrape_description(video[:url], "ted")
      results << video
    end
    return results
  end

  def self.wikipedia_search(query)
    page = Wikipedia.find(query)
    ["http://en.wikipedia.org/wiki?curid=" + page.page["pageid"].to_s]
  end


  def self.financial_times_search(query)
    url =  URI.encode('http://api.pearson.com/v2/ft/articles?search=' + query + '&apikey=' + ENV['FINANCIAL_TIMES'])
    response = HTTParty.get(url)
    articles = []
    results = []
    response["results"].each do |article|
      articles << {:url => article['article_url'], :name=> article['headline'], :description=> "The latest UK and international business, finance, economic and political news, comment and analysis from the Financial Times on FT.com."}
    end
    return articles[0..1]
  end

  def self.scrape_description(url, source)
    case
    when url =~ /ted/
      request = 'http://access.alchemyapi.com/calls/url/URLGetConstraintQuery?apikey='+ ENV['ALCHEMY_KEY'] +'&url=' + url + '&outputMode=json&cquery=P'
      results = JSON.parse(RestClient.get request, :content_type => :json, :accept => :json)
      return results["queryResults"][0]["resultText"]
    when url =~ /coursera/
      request = 'http://access.alchemyapi.com/calls/url/URLGetConstraintQuery?apikey='+ ENV['ALCHEMY_KEY'] +'&url=' + url + '&outputMode=json&cquery=DIV'
      results = JSON.parse(RestClient.get request, :content_type => :json, :accept => :json)
      return results["queryResults"][0]["resultText"] unless results["queryResults"]
      return "Coursera is an education platform that partners with top universities and organizations worldwide, to offer courses online for anyone to take, for free."
    else
      return "nada"
    end
  end

  def self.generate(category, user)
    query = category.name
    results = { "nytimes" => Content.new_york_times(query),
    "youtube" => Content.youtube_search(query),
    "coursera" => Content.coursera(query),
    "ted" => Content.ted_search(query),
    "financial times" => Content.financial_times_search(query),
    "wikipedia" => Content.wikipedia_search(query) }
    user.categories << category
    results.each_pair do |source, contents|
      unless contents == nil
        contents.each do |content|
          if source == "ted" || source == "youtube" || source == "nytimes"
            user.categories.last.contents << Content.create(url: content[:url], source: source, name: content[:name], description: content[:description])
          elsif source == "wikipedia"
            user.categories.last.contents << Content.create(url: content, source: source)
          else
            user.categories.last.contents << Content.create(url: content[:url], source: source, name: content[:name])
          end
        end
      end
    end
  end


end
