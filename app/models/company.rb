# == Schema Information
#
# Table name: companies
#
#  id              :integer          not null, primary key
#  username        :string
#  company_name    :string
#  email           :string
#  token           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Company < ApplicationRecord

  has_secure_password  
  has_secure_token


  validates :company_name , presence: true 
  validates :username, length: { maximum: 20 }, uniqueness: true

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  validates :email, presence: true, length: { :maximum => 100 }, format: EMAIL_REGEX , uniqueness: true



  def self.valid_login?(login_info , password)    
      company = Company.where(email: login_info).or(Company.where(username: login_info )).first
      if company && company.authenticate(password)
        company
      end
  end


  def generate_password_token
    self.password_reset_token = generate_token
    save!
  end

  private
  def generate_token
    SecureRandom.hex(10)
  end

end
