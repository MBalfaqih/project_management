class User < ApplicationRecord
  has_secure_password   #provides authenticate method to check if the password provided by the user is correct
  has_secure_token


  def self.valid_login?(login_info , password)
      user = User.where(email: login_info).or(User.where(username: login_info )).first
      if user && user.authenticate(password)
        user
      end
  end

end
