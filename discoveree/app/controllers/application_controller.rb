class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	before_filter :goodbye_cache
  
  skip_before_filter :verify_authenticity_token

	protect_from_forgery with: :null_session
  rescue_from 'ActionController::NoMethodError' do
    redirect_to root_path
  end

  rescue_from 'ActionController::UrlGenerationError' do
    redirect_to root_path
  end

	rescue_from 'ActionController::NoMethodError' do
	 	redirect_to root_path
  end

  def goodbye_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
