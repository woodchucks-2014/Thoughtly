class Content < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  def self.generate(category, user) # to do
    ## generate content using Google API, YouTube, NYTimes, etc.
    ## use the category input ID to associate content with the category.
    ## use the user input ID to associate content with the user.
    ## return the pieces of content back to the Category controller.
  end

end
