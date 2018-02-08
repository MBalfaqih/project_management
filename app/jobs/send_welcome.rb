class SendWelcome
  
  @queue = :mailing

  def self.perform(company_id)
    company = Company.find(company_id)
    CompanyMailer.welcome_email(company).deliver_now
  end
end
