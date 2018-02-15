class V1::ProjectEmployeesController < ApplicationController

    before_action :set_project_employee, only: :show
    before_action :set_selected_project 

    # GET /v1/projects/:project_id/project_employees
    def show
        render_data( data: collection_serializer( @pro_employees, 
                                                  V1::ProjectEmployeesSerializer, 
                                                  scope: {pro: @project} 
                                                ),
                     pages: paginate(@pro_employees)
        )
    end

    # PUT /v1/projects/:project_id/project_employees
    def update
        if updated_ids = params[:ids]
            updated_ids.map! { |id| id.to_i }
            EmployeesProject.update_project_employees( updated_ids , @project)

            render_success message: I18n.t("project_updated_successfully"), data: V1::ProjectDetailsSerializer.new(@project)
        else 
            EmployeesProject.remove_unchecked_employees(@project.employee_ids, @project )
            
            render_success message: I18n.t("project_employees_deleted"), data: V1::ProjectDetailsSerializer.new(@project)
        end
    end


    private
    
    def set_selected_project
        @project = current_company.projects.find(params[:project_id])
    end

    def set_project_employee
        @q = current_company.employees.ransack(params[:q])
        @pro_employees = @q.result
                           .page(page)
                           .per(per_page)
                           .order(column_name(params[:sort_by], model_name: Employee) + " " + direction(params[:direction]))
    end

end
