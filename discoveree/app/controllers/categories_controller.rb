class CategoriesController < ApplicationController
  include UserHelper
  include ApplicationHelper

  def index
    check_sign_in
    unless validate_user_against(params[:user_id].to_i)
      redirect_to user_categories_path(@current_user)
    end
    @categories = @current_user.categories
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      @category_array = Category.analyze_url(params[:url])
      @category = Category.new(name: @category_array[0], related_categories: @category_array[1..-1])
      render :json => { message: "Creating a briefing on: " + @category.name + "..." }
    else
      render :json => { message: "Oops! Looks like you need to sign up first." }
    end
    Content.generate(@category, @user) if @category.save
  end

  def show
    check_sign_in
    @category = Category.find_by_id(params[:id])
    if validate_user_against(params[:user_id].to_i)
      unless Category.exists?(params[:id].to_i)
        not_found
      end
      @summary = @category.generate_summary
    else
      redirect_to user_categories_path(@user)
    end
  end

  def nodegraph
    @category = Category.find_by(name: params["name"])
    puts params
    puts @category.inspect
    puts @category
    puts @category.class
    render :json => {main_category: @category.name, related_categories: @related_categories}
    # array = []
    # 999.times do
    #   array << (1..1000).to_a.sample.to_s
    # end
    # render :json => {related_categories:
    #   ["blue", "red", "green", "yellow", "pink", "purple", "blue", "fuschia", "shuff", "magenta", "green", "orange"]
    #   }.to_json
    # render :json => {related_categories: array}.to_json

  end

  def childnodes
    render :json => {childnodes: ["red","blue","green","purple","shuff","fuschia","megenta"]}
  end
end

