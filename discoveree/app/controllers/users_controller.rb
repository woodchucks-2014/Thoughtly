class UsersController < ApplicationController
  
  include UserHelper

  def index
    redirect_to :root
  end

  def sign_in_page
  	render :sign_in, :layout => false
  end

  def sign_up_page
  	render :sign_up, :layout => false
  end

  def login
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user), flash: {notice: "Successful log in!"}
    else
      redirect_to users_path, flash: {notice: 'Invalid credentials!' }
    end
  end

  def create
    @user = User.new(user_params(params))
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), flash: {notice: 'Successful log in!'}
    else
      redirect_to new_user_path, flash: {notice: 'Failed'}
    end
  end


  def show
    check_sign_in
    redirect_to user_categories_path(@current_user)
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

 private

  def user_params(params)
    params.require(:user).permit(:email, :password, :password_confirmation)
  end


end
