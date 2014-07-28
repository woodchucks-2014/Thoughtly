module UserHelper

	def check_sign_in
		if !session[:user_id]
      return redirect_to :root
    else
    	@current_user ||= User.find_by_id(session[:user_id])
  	end
  end

  def validate_user_against params
    # unless user.id == params[:user_id].to_i
    unless @current_user.id == params
      redirect_to :root
    end
  end

  def sanity_check param
    p "*"*15
    p param
    p "*"*15
  end

end
