class CompanyMailer < ApplicationMailer

    default from: 'project_management@Info.com'
 
    def welcome_email(company)
        @company = company
        @url  = 'localhost:3000/v1/sessions/'
        mail(to: @company.email, subject: 'Thanks for registeration')
    end

    def recover_password_email(company,token)
        @company = company
        @url = "localhost:3000/v1/passwords/recover?token=#{token}"
        mail(to: @company.email, subject: 'Recovering password')
    end

    def password_change_alert(company)
        @company = company
        @url = "localhost:3000/v1/passwords/forgot"
        mail(to: @company.email, subject: "Alert: Your password has been changed")
    end

end
