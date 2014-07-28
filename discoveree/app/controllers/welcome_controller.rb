class WelcomeController < ApplicationController
include UserHelper

	def index
    if session[:user_id]
      redirect_to user_categories_path(session[:user_id])
    end
	end

end
