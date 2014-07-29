class User < ActiveRecord::Base
  has_many :categories, through: :contents
  has_many :contents
  has_secure_password

end
