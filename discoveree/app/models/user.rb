class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, #:omniauthable, #omniauthable is for oauth for google
         :recoverable, :rememberable, :trackable, :validatable #:omniauth_providers => [:google_oauth2] #oauth
         #:provider, :uid #provider and uid are for oauth
  has_many :categories, through: :contents
  has_many :contents
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

end
