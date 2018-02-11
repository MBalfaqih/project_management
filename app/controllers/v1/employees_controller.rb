class V1::EmployeesController < ApplicationController

    before_action :set_company_employees, only: :index
    before_action :set_employee, except: [:index , :create ]

    # GET /v1/employees
    def index
        render_data(data: collection_serializer(@employees, V1::EmployeeSerializer), pages: paginate(@employees))
    end

    # GET /v1/employees/:id
    def show
        render_success(data: V1::EmployeeDetailsSerializer.new(@employee)) if @employee
    end

    # POST /v1/employees
    def create
        employee = Employee.new(employee_params)
        if current_company.employees << employee
            render_success message: I18n.t("new_employee_registered"),
                           data:    V1::EmployeeSerializer.new(employee)
        else
            render_failed data: employee.errors.full_messages 
        end
    end

    # PUT /v1/employees/:id
    def update
        @employee.update!(employee_params)
        render_success message: I18n.t("employee_updated_successfully"),
                       data:    V1::EmployeeSerializer.new(@employee)
    end

    # DELETE /v1/employees/:id
    def destroy
        @employee.destroy!
        render_success message: I18n.t("employee_deleted_successfully") 
    end

    private 

    def employee_params
        params.permit(:name , :birth_date , :joining_date )
    end

    def set_employee
        @employee =  current_company.employees.find(params[:id])
    end

    def set_company_employees
        @q         = current_company.employees.ransack(params[:q])
        @employees = @q.result.page(page).per(per_page)
    end

   
    
end
