class Company < ApplicationRecord

  has_many :employees
  has_many :projects

  ############################################

  has_secure_password   validations: false 
  validates :company_name , presence: true
  has_secure_token
  validates_confirmation_of :password
  validates :company_name, presence: true 
  validates :username   , length: { maximum: 20 },
                          presence: true  ,
                          uniqueness: true

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  validates :email, presence: true, 
                    length: { :maximum => 100 }, 
                    format: EMAIL_REGEX , 
                    uniqueness: true

  has_attached_file     :logo, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment  :logo , presence: true,
                         content_type: { :content_type => "image/png" },
                         size:         { :in => 0..100.kilobytes }

  #############################################
                         
  def generate_password_token
    self.password_reset_token = generate_token
    save!
  end

  def reset_password(password, password_confirmation)
    self.password_reset_token = nil
    update_attributes(password: password , password_confirmation: password_confirmation)
  end

  def self.logout(current_company)
    current_company.update_columns(token: nil)
  end
  
  
  private

  def generate_token
    SecureRandom.hex(10)
  end

end
