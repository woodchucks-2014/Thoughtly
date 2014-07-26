class CategoriesController < ApplicationController
  include AuthenticationHelper

  def index
    p session[:user_id]
    @user = current_user
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
