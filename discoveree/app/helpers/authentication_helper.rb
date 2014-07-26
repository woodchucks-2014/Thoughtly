module AuthenticationHelper
  def signed_in?
    !session[:user_id].nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def ensure_admin_signed_in
    if !signed_in?
      session[:redirect_to] = request.url
      redirect_to new_session_path
    elsif User.find(session[:user_id]).role != "Administrator"
      redirect_to root_path
    end
  end
end
