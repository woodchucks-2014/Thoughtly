class ArticleController < ActionController::Base
require 'json'

  def read
     render :read
     puts "this is the get route"
    {:hello => "this is the get route"}.to_json
  end

  def post
    print "*"*100
    p params
    puts "This is the post route"

    render json: {:hello => "this is the post route"}
  end

end
