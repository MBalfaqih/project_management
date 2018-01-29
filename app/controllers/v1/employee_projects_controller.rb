class V1::EmployeeProjectsController < ApplicationController

    before_action :require_login
    before_action :set_selected_employee #, except: 

    def show
        render_success(data:  collection_serializer(@employee.projects , V1::ProjectSerializer))
    end

    def update
        if  @updated_ids = params[:ids]
            @updated_ids.map! { |id| id.to_i }
            return render_failed(message: " Invalid IDs assigned " , status: :unprocessable_entity )    if assigning_invalid_ids == true  
            EmployeesProject.delete_unchecked_projects(@unchecked_ids , @employee ) if @unchecked_ids = @employee.project_ids - @updated_ids 
            EmployeesProject.assign_new_projects(@new_assigned_ids , @employee ) if @new_assigned_ids = @updated_ids - @employee.project_ids
            render_success(message: "His projects has been updated successfully" ,data: V1::EmployeeSerializer.new(Employee.find(params[:employee_id])) )
        else 
            EmployeesProject.delete_unchecked_projects( @employee.project_ids , @employee )
            render_success(data:  collection_serializer(@employee.projects , V1::ProjectSerializer))
        end
    end


    private

    def set_selected_employee
        @employee =  current_company.employees.find(params[:employee_id])
    end

    def assigning_invalid_ids
        @updated_ids.each do |id| 
            return true if !id.in?( current_company.project_ids )    
        end
    end

end
