class User < ActiveRecord::Base
  has_many :extensions
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :omniauthable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  
  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password. 
      User.create(:email => data["email"], :password => Devise.friendly_token[0,20]) 
    end
  end
  
end
