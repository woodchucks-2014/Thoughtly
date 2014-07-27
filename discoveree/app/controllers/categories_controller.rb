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
      @category_array = Category.analyze_url(params[:url])
      @category = Category.new(name: @category_array[0], related_categories:@category_array[1..-1].join("%"))
      render :json => { message: "Creating a briefing on: " + @category.name + "..." }
    else
      render :json => { message: "Oops! Looks like you need to sign up first." }
    end
    Content.generate(@category, @user) if @category.save
  end

  def nodegraph
    # array = []
    # 999.times do
    #   array << (1..1000).to_a.sample.to_s
    # end
    render :json => {related_categories: ["blue", "red", "green", "yellow", "pink"]}.to_json
     # render :json => {related_categories: array}.to_json

  end


end

