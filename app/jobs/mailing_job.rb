class MailingJob < ApplicationJob
  queue_as :default

  def perform company: company, mail_type: mail_type
    
    if mail_type == "recover_password_email"
      CompanyMailer.recover_password_email(company, company.password_reset_token).deliver_now
    elsif mail_type == "password_change_alert"
      CompanyMailer.password_change_alert(company).deliver_now
    elsif mail_type == "welcome_email"
      CompanyMailer.welcome_email(company).deliver_now
    end

  end
end
