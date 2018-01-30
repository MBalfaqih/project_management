class V1::EmployeeProjectsController < ApplicationController

    before_action :require_login , :set_selected_employee 

    def show
        render_success(data:  collection_serializer(@employee.projects , V1::ProjectSerializer))
    end

    def update
        if updated_ids = params[:ids]
            updated_ids.map! { |id| id.to_i }
            # return render_failed(message: " Invalid IDs assigned " , status: :unprocessable_entity ) if invalid_ids_assigned? == true  
            EmployeesProject.update_employee_projects(updated_ids , @employee)
            render_success(message: "His projects has been updated successfully" ,data: V1::EmployeeSerializer.new(@employee))
        else 
            EmployeesProject.remove_unchecked_projects( @employee.project_ids , @employee )
            render_success(data:  collection_serializer(@employee.projects , V1::ProjectSerializer))
        end
    end


    private

    def set_selected_employee
        @employee =  current_company.employees.find(params[:employee_id])
    end

    # def invalid_ids_assigned?
    #     @updated_ids.each do |id| 
    #         return true if !id.in?( current_company.project_ids )    
    #     end
    # end

end
