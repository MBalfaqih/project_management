class V1::ProjectEmployeesController < ApplicationController

    before_action :set_selected_project 

    def show
        render_success( data: ActiveModel::Serializer::CollectionSerializer.new(
            current_company.employees , 
            serializer: V1::ProjectEmployeesSerializer, 
                 scope: {pro: @project} ))
    end

    def update
        if updated_ids = params[:ids]
            updated_ids.map! { |id| id.to_i }
            EmployeesProject.update_project_employees( updated_ids , @project)
            render_success message: I18n.t("project_updated_successfully"),
                              data: V1::ProjectSerializer.new(@project)
        else 
            EmployeesProject.remove_unchecked_employees(@project.employee_ids, @project )
            render_success data: collection_serializer(@project.employees , V1::EmployeeSerializer
        end
    end


    private
    
    def set_selected_project
        @project = current_company.projects.find(params[:project_id])
    end

end
