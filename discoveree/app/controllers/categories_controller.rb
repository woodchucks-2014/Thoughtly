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
    @user = User.find_by_email(params[:extension_email])
    if @user && @user.authenticate(params[:extension_password])
      @category_array = Category.analyze_url(params[:url])
      @category = Category.new(name: @category_array[0], related_categories: @category_array[1..-1])
      render :json => { message: "Creating a briefing on: " + @category.name + "..." }
    else
      render :json => { message: "Oops! Looks like you need to sign up first." }
    end
    Content.generate(@category, @user) if @category.save
    render :json => { message: "Created a briefing on: " + @category.name + ". ", anchor: "http://localhost:3000#{user_category_path(@user, @category)}" }
  end

  def show
    check_sign_in
    @category = Category.find_by_id(params[:id])
    if validate_user_against(params[:user_id].to_i)
      unless Category.exists?(params[:id].to_i)
        not_found
      end
      @summary = Category.generate_summary(@category.name)[0..500] + ". . ."
    else
      redirect_to user_categories_path(@user)
    end
  end

  def nodegraph
    puts params["current"]
    @category = Category.find_by(name: params["name"])
    render :json => {main_category: @category.name, related_categories: @category.related_categories}
  end

  def childnodes
    text = Category.generate_summary(params["data"])
    child_node_array = Category.analyze_text(text)
        render :json => {related_categories:
      child_node_array
      }.to_json
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to user_categories_path
    # redirect_to :root
  end
end

