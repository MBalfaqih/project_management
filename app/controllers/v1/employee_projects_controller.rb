class V1::EmployeeProjectsController < ApplicationController

    before_action :require_login
    before_action :set_selected_employee #, except: 

    def show
        render_success(data:  ActiveModel::Serializer::CollectionSerializer.new(@employee.projects , serializer: V1::ProjectSerializer))
    end

    def update
        @updated_ids = params[:ids]
        if @updated_ids.map! { |id| id.to_i }
            return render_failed(message: " Invalid IDs assigned " , status: :unprocessable_entity ) if assigning_invalid_ids == true  
            EmployeesProject.delete_unchecked_projects(@unchecked_ids , params[:employee_id] )     if @unchecked_ids = @employee.project_ids - @updated_ids 
            EmployeesProject.assign_new_checked_projects(@new_assigned_ids , params[:employee_id] ) if @new_assigned_ids = @updated_ids - @employee.project_ids
            render_success(message: "His projects has been updated successfully" ,data: V1::EmployeeSerializer.new(Employee.find(params[:employee_id])) )
        #else render_failed(message: "no parameter found") 
        end
    end



    private

    def set_selected_employee
        @employee =  current_company.employees.find(params[:employee_id])
    end

    def assigning_invalid_ids
        # dealing with uncheck all projects
        return false if @updated_ids == ( nil || [0] )

        @updated_ids.each do |id| 
            return true if !id.in?( current_company.project_ids )    
        end
    end

end
