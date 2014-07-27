class CategoriesController < ApplicationController
  include UserHelper

  def index
    check_sign_in
    @current_user = User.find_by_id(session[:user_id])
    @user = User.find_by_id(params[:user_id])
    if @current_user.id != @user.id
      redirect_to user_categories_path(@current_user)
    else 
      @categories = @current_user.categories
    end
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      @category_name = Category.analyze_url(params[:url])
      p @category_name
      p "*"*100
      @category = Category.new(name: @category_name)
    else 
      render :json => { message: "Oops! Looks like you need to sign up first." }
    end
    if @category.save
      @user.categories << @category
      # @content = Content.generate(@category, @user)  To do - See Content model. This will return content we find for a given category.
    end
    render :json => { message: "Created a briefing on: " + @category.name }
  end

end
