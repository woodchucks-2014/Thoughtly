module UserHelper

	# def check_sign_in
	# 	if !session[:user_id]
 #      return redirect_to :root
 #    else
 #    	@current_user ||= User.find_by_id(session[:user_id])
 #  	end
 #  end

  def is_signed_in?
    if !session[:user_id].nil?
      true
    else
      # redirect_to :root
      false
    end
  end

  def check_sign_in
    if is_signed_in?
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  def validate_user_against params
    unless @current_user.id == params
      redirect_to user_categories_path
    end
  end

  def sanity_check param
    p "*"*15
    p param
    p "*"*15
  end

end
