class SendPdfReport
    
    @queue = :mailing

    def self.perform(company_id)
        company = Company.find(company_id)

        rendered = ActionController::Base.new.render_to_string(
            template: "reports/show", 
            layout: "show.html.erb", 
            assigns: {company_id: company_id}
        )
        
        report = WickedPdf.new.pdf_from_string(rendered)

        CompanyMailer.send_report(company, report).deliver_now
        puts "Report sent"
    end
    
end