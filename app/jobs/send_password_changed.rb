class SendPasswordChanged
  
  @queue = :mailing

  def self.perform(company_id)
    company = Company.find(company_id)
    CompanyMailer.password_change_alert(company).deliver_now
  end
end
