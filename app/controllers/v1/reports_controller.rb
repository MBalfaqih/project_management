class V1::ReportsController < ApplicationController

    def show
        Resque.enqueue(SendPdfReport, current_company.id)
        render_success( message: "test", data: V1::CompanySerializer.new(current_company))
    
        ### To Save it locally
        # respond_to do |format|
        #     format.pdf do
        #         pdf = WickedPdf.new.pdf_from_string(
        #            ActionController::Base.new.render_to_string(template: "reports/show", layout: "show.html.erb", assigns: {x: 111})
        #         )
        #        send_data( pdf, filename: "report.pdf" , type: :pdf)
        #     end

            # format.html do
            #     render html: "<h1>Heeeellllo</h1>".html_safe
            # end
        # end

    end
    
end