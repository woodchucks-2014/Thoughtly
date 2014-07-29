class UsersController < ApplicationController
  include UserHelper

  def index
    redirect_to :root
  #   if check_sign_in
  #     @current_user = User.find(session[:user_id])
  #     redirect_to user_categories_path(@current_user)
  #   else
  #     # idealy sends them back to login
  #     # render root_path
  #   end
  #   # if session[:user_id]
  #   #   redirect_to user_categories_path(@current_user)
  #   # end
  #   # # check_sign_in #commented these out because of redirect loop
  #   # # redirect_to user_categories_path(@user)
  end

  def sign_in_page
  	render :sign_in, :layout => false
  end

  def sign_up_page
  	render :sign_up, :layout => false
  end

  def login
  	@email = params[:user][:email]
    @user = User.authenticate(@email, params[:user][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to user_categories_path(@user), flash: {notice: "Successful log in!"}
    else
      redirect_to :root, flash: {notice: 'Invalid credentials!' }
    end
  end

  def create
    @user = User.new(user_params(params))
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_categories_path(@user), flash: {notice: 'Successful log in!'}
    else
      redirect_to users_signup_path, flash: {notice: 'Failed'}
    end
  end


  def show
    check_sign_in
    redirect_to user_categories_path(@current_user)
  end

  def destroy
    session.clear
    redirect_to :root
  end

 private

  def user_params(params)
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
