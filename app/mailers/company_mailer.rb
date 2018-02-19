class CompanyMailer < ApplicationMailer

    default from: 'project_management@Info.com'
 
    def welcome_email(company)
        @company = company
        @url  = 'localhost:3000/v1/sessions/'
        attachments["ico.png"] = File.read("#{Rails.root}/public/images/ico.png")

        mail(to: @company.email, subject: 'Thanks for registeration')
    end

    def send_report(company, report)
        @company = company

        attachments["report_#{Time.now}.pdf"] = {
            mime_type: "application/pdf",
            content: report
        }

        mail(to: @company.email, subject: "Report")
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
