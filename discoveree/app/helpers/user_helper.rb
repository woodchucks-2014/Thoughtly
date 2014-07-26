module UserHelper

	def check_sign_in
		if !session[:user_id]
      redirect_to :root
    else
    	@user = User.find_by_id(session[:user_id])
  	end
  end

end
