class V1::EmployeeProjectsController < ApplicationController

    before_action :set_selected_employee 

    # GET /v1/employees/:employee_id/employee_projects
    def show
        emp_projects = current_company.projects.page(page).per(per_page)
        render_data( data: collection_serializer( emp_projects,
                                                  V1::EmployeeProjectsSerializer, 
                                                  scope: {emp: @employee}
                                                ),
                     pages: paginate(emp_projects)
        )
    end

    # PUT /v1/employees/:employee_id/employee_projects
    def update
        if updated_ids = params[:ids]
            updated_ids.map! { |id| id.to_i }
            EmployeesProject.update_employee_projects(updated_ids , @employee)

            render_success message: I18n.t("employee_updated_successfully"),
                              data: V1::EmployeeDetailsSerializer.new(@employee)  
        else 
            EmployeesProject.remove_unchecked_projects(@employee.project_ids , @employee)
            
            render_success message: I18n.t("employee_projects_deleted"),
                              data: V1::EmployeeDetailsSerializer.new(@employee)
        end
    end


    private

    def set_selected_employee
        @employee =  current_company.employees.find(params[:employee_id])
    end

end
