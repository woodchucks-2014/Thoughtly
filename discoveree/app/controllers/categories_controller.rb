class CategoriesController < ApplicationController
  include UserHelper

  def index
    check_sign_in
    @current_user = User.find_by_id(session[:user_id])
    @categories = @current_user.categories
    unless @current_user.id == params[:user_id].to_i
      redirect_to user_categories_path(@current_user)
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

  def show
    @current_user = User.find_by_id(session[:user_id])
    @user = User.find_by_id(params[:user_id])
    if @current_user.id != @user.id
      redirect_to user_categories_path(@current_user)
    else
      @category = Category.find_by_id(params[:id])
    end
  end

end
