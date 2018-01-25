class V1::ProjectEmployeesController < ApplicationController

    before_action :require_login
    before_action :set_selected_project #, except: [:index , :create ]

    def show
        render_success(data:  ActiveModel::Serializer::CollectionSerializer.new(@project.employees , serializer: V1::EmployeeSerializer))
    end

    def update
        @updated_ids = params[:ids]
        if @updated_ids.map! { |id| id.to_i }
            return render_failed(message: " Invalid IDs assigned " , status: :unprocessable_entity ) if assigning_invalid_ids == true  
            EmployeesProject.delete_unchecked_employees(@unchecked_ids , params[:project_id] )     if @unchecked_ids = @project.employee_ids - @updated_ids 
            EmployeesProject.assign_new_checked_employees(@new_assigned_ids , params[:project_id] ) if @new_assigned_ids = @updated_ids - @project.employee_ids
            # debugger
            render_success(message: "project employees has been updated successfully" ,data: V1::ProjectSerializer.new(Project.find(params[:project_id])) )
        #else render_failed(message: "no parameter found") 
        end
    end


    private
    
    def set_selected_project
        @project = current_company.projects.find(params[:project_id])
    end

    def assigning_invalid_ids
        # dealing with uncheck all empliyees
        return false if @updated_ids == ( nil || [0] )

        @updated_ids.each do |id| 
            return true if !id.in?( current_company.employee_ids )    
        end
    end

end
