class V1::EmployeesController < ApplicationController

    before_action :set_company_employee , except: [:index , :create ]

    
    def index
        @employees = current_company.employees.page(page).per(per_page)
        render_data(data: collection_serializer(@employees, V1::EmployeeSerializer), pages: paginate(@employees))
    end

  
    def show
        return render_success(data: V1::EmployeeDetailsSerializer.new(@employee)) if @employee
        # render_failed(message: "You don't have record with id #{params[:id]}")
    end


    def create
        employee = Employee.new(employee_params)
        if current_company.employees << employee
            render_success message: I18n.t("new_employee_registered"),
                              data: V1::EmployeeSerializer.new(employee)
        else
            render_failed data: employee.errors.full_messages 
        end
    end


    def update
        @employee.update!(employee_params)
        render_success message: I18n.t("employee_updated_successfully"),
                          data: V1::EmployeeSerializer.new(@employee)
    end


    def destroy
        @employee.destroy!
        render_success message: I18n.t("employee_deleted_successfully") 
        # else
        #     render_failed(message: "can not delete record with id #{params[:id]}")
        # end
    end

    private 

    def employee_params
        params.permit(:name , :birth_date , :joining_date )
    end

    def set_company_employee
        @employee =  current_company.employees.find(params[:id])
    end

   
    
end
