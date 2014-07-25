class Category < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :contents
  has_many :contents

end
