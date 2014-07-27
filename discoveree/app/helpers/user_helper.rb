module UserHelper

	def check_sign_in
		if !session[:user_id]
      return redirect_to users_login_path
    else
    	@user ||= User.find_by_id(session[:user_id])
  	end
  end

  def sanity_check param
    p "*"*15
    p param
    p "*"*15
  end

end
