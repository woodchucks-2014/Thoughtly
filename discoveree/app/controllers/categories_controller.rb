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
      @related_categories = Category.format_related(@category_array)
      @category = Category.new(name: @category_array[0], related_categories: @related_categories, url: params[:url])
    else
      render :json => { message: "Oops! Looks like you need to sign up first." }
    end
    Content.generate(@category, @user) if @category.save
    render :json => { message: "Created a briefing on: " + @category.name + ". ", anchor: "http://localhost:3000#{user_category_path(@user, @category)}" }
  end

  def update
    check_sign_in
    @category = Category.find(params[:id])
    @category.contents.each {|content| content.destroy}
    if validate_user_against(params[:user_id].to_i)
      @category_array = Category.analyze_url(@category.url)
      @related_categories = Category.format_related(@category_array)
      @category.update(related_categories: @related_categories)
    else
      render :json => { message: "Oops! Looks like you need to sign up first." }
    end
    Content.generate(@category, @user)
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
    puts params["name"]
    @category = Category.find_by(name: params["name"])
    render :json => {main_category: @category.name, related_categories: @category.related_categories.split("%")}.to_json
  end

  def childnodes
    render :json => {childnodes: ["red","blue","green","purple","shuff","fuschia","megenta"]}
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to user_categories_path
    # redirect_to :root
  end
end
