class UsersController < ApplicationController
  include UserHelper


	def nodegraph
		@list = ['node1','node2','node2','node3','node4','node5','node6']
  	end

  def index

  end

  def sign_in_page
  	render :sign_in
  end

  def sign_up_page
  	render :sign_up
  end

  def login
  	@email = params[:user][:email]
  	p params[:email]
    @user = User.authenticate(@email, params[:user][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to user_categories_path(@user), flash: {notice: "Successful log in!"}
    else
      redirect_to users_login_path, flash: {notice: 'Invalid credentials!' }
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
