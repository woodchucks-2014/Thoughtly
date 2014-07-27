class CategoriesController < ApplicationController
  include UserHelper

  def index
    check_sign_in
    @current_user = User.find_by_id(session[:user_id])
    @categories = @current_user.categories
    unless @current_user.id == params[:user_id].to_i
      redirect_to user_categories_path(@current_user)
      # raise ApplicationController::RoutingError.new('Not Found')
    end
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      @category_name = Category.analyze_url(params[:url])
      @category = Category.new(name: @category_name)
      p @category
      p @category_name
      render :json => { message: "Creating a briefing on: " + @category.name + "..." }
    else
      render :json => { message: "Oops! Looks like you need to sign up first." }
    end
    Content.generate(@category, @user) if @category.save
  end

end
