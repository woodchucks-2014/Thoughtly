class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	skip_before_filter :verify_authenticity_token
	protect_from_forgery with: :null_session
 #  rescue_from 'ActionController::NoMethodError' do
 #    redirect_to root_path
 #  end

 #  rescue_from 'ActionController::UrlGenerationError' do
 #    redirect_to root_path
 #  end

	# rescue_from 'ActionController::NoMethodError' do
	#  	redirect_to root_path
 #  end
end
