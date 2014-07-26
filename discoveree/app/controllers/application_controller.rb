class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include GoogleHelper

	CLIENT_ID = ENV['oauth2_client_id']
  CLIENT_SECRET = ENV['oauth2_client_secret']
  CLIENT_SCOPE = 'https://www.googleapis.com/auth/userinfo.email'
  BASEURL = 'http://127.0.0.1:3000/'

end
