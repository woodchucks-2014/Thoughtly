class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include GoogleHelper

	CLIENT_ID = '817679787149-8k3c1jelf8u6oprp5vvljlgt53lppb75.apps.googleusercontent.com'
  CLIENT_SECRET = 'mHYBIpWOS9rCAWNWTe2ye5s4'
  CLIENT_SCOPE = 'https://www.googleapis.com/auth/userinfo.email'
  BASEURL = 'http://127.0.0.1:3000/'

end
