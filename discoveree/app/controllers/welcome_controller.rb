class WelcomeController < ApplicationController
include UserHelper

	def index
    check_sign_in
	end

end
