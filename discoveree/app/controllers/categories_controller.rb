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
    @user = User.find_by(email: "rjny@wiggidy.com")
    @category_name = Category.analyze_url(params[:url])
    @category = Category.new(name: @category_name)
    if @category.save
      # @content = Content.generate(@category, @user)  To do - See Content model. This will return content we find for a given category.
      @user.categories << @category
    else
      @content = Content.generate(@category, @user)
    end
    render :json => { category: @category.name }
  end

end
