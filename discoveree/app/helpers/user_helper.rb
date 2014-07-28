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
      false
    end
  end

  def check_sign_in
    if is_signed_in?
      @current_user ||= User.find_by_id(session[:user_id])
    end
    nil 
  end 

  def validate_user_against params
    return true if @current_user.id == params
  end

  def sanity_check param
    p "*"*15
    p param
    p "*"*15
  end

end
