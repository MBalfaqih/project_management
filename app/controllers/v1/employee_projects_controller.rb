class V1::EmployeeProjectsController < ApplicationController

    before_action :set_selected_employee 

    def show
        render_success data: ActiveModel::Serializer::CollectionSerializer.new( 
            current_company.projects,
            serializer: V1::EmployeeProjectsSerializer, 
            scope: {emp: @employee} 
        )
    end

    def update
        if updated_ids = params[:ids]
            updated_ids.map! { |id| id.to_i }
            EmployeesProject.update_employee_projects(updated_ids , @employee)
            render_success message: I18n.t("employee_updated_successfully"),
                              data: V1::EmployeeSerializer.new(@employee)  
            
        else 
            EmployeesProject.remove_unchecked_projects(@employee.project_ids , @employee)
            render_successdata: collection_serializer(@employee.projects, V1::ProjectSerializer)
        end
    end


    private

    def set_selected_employee
        @employee =  current_company.employees.find(params[:employee_id])
    end

end
