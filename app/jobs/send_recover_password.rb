class SendRecoverPassword
  
  @queue = :mailing

  def self.perform(company_id)
    company = Company.find(company_id)
    CompanyMailer.recover_password_email(company, company.password_reset_token).deliver_now
  end
end
