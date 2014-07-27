class User < ActiveRecord::Base
  has_many :categories, through: :contents
  has_many :contents
 
  # validates :email, format: {with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,}/}
  # validates_presence_of :email, :first_name, :password, :password_confirmation

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil 
  end

end
