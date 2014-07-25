class CategoryController < ActionController::Base
  include UserHelper

  def index
    @user = current_user
    @categories = @user.categories
  end

  def create
    @user = User.find_by(email: params[:email])
    @url = params[:url]
    @category = Category.new(name: analyze_url(@url))
    if @category.save ## if category isn't already in the database
      @content = Content.generate(@category, @user) ## See Content model. This will return content we find for a given category.
    else ## if category is in the database
      @content = Content.generate(@category, @user)
    end
    redirect_to user_category(@category)
  end

end
