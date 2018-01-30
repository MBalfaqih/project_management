class V1::ProjectEmployeesController < ApplicationController

    before_action :require_login, :set_selected_project 

    def show
        render_success(data:  collection_serializer(@project.employees , V1::EmployeeSerializer))
    end

    def update
        if updated_ids = params[:ids]
            updated_ids.map! { |id| id.to_i }
            # return render_failed(message: " Invalid IDs assigned " , status: :unprocessable_entity ) if invalid_ids_assigned? == true  
            EmployeesProject.update_project_employees( updated_ids , @project)
            render_success(message: "project employees has been updated successfully" ,data: V1::ProjectSerializer.new(@project))
        else 
            EmployeesProject.remove_unchecked_employees(@project.employee_ids, @project )
            render_success(data:  collection_serializer(@project.employees , V1::EmployeeSerializer))
        end
    end


    private
    
    def set_selected_project
        @project = current_company.projects.find(params[:project_id])
    end

    # def invalid_ids_assigned?
    #     @updated_ids.each do |id| 
    #         return true if !id.in?( current_company.employee_ids )    
    #     end
    # end

end
