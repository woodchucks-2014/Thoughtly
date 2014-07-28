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
    @user = User.authenticate(params[:extension_email], params[:extension_password])
    if @user
      @category_array = Category.analyze_url(params[:url])
      @related_categories = Category.format_related(@category_array)
      @category = Category.new(name: @category_array[0], related_categories: @related_categories)
    else
      render :json => { message: "Oops! Looks like you need to sign up first." }
    end
    Content.generate(@category, @user) if @category.save
    render :json => { message: "Created a briefing on: " + @category.name + ". ", anchor: "http://127.0.0.1:3000#{user_category_path(@user, @category)}" }
  end

  def show
    @current_user = User.find_by_id(session[:user_id])
    p @current_user
    @category = Category.find_by_id(params[:id])
    @summary = @category.generate_summary
    unless @current_user.id == params[:user_id].to_i
      redirect_to user_categories_path(@current_user, @category)
    end
    unless Category.exists?(params[:id])
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def nodegraph
    puts params["name"]
    @category = Category.find_by(name: params["name"])
    puts @category.class
    render :json => {related_categories: @category.related_categories.split("%")}.to_json
    # array = []
    # 999.times do
    #   array << (1..1000).to_a.sample.to_s
    # end
    # render :json => {related_categories:
    #   ["blue", "red", "green", "yellow", "pink", "purple", "blue", "fuschia", "shuff", "magenta", "green", "orange"]
    #   }.to_json
    # render :json => {related_categories: array}.to_json

  end

end

