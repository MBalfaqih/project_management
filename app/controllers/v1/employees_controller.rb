class V1::EmployeesController < ApplicationController

    before_action :require_login
    before_action :set_company_employee , except: [:index , :create ]
    

    def index
        render_success(data: current_company.employees)
    end

  
    def show
        return render_success(data: @employee) if @employee
        render_failed(message: "You don't have record with id #{params[:id]}")
    end


    def create
        employee = Employee.new(employee_params)
        if current_company.employees << employee
            render_success( message: "A new employee has been registered" , data: employee )
        else
            render_failed( data: employee.errors.full_messages )
        end
    end


    def update
        if @employee
            @employee.update!(employee_params)
            render_success( message: " #{@employee.name} has been updated successfully " , data: @employee)
        else
            render_failed(message: "There is no employee with id #{params[:id]}" , status: 404)
        end
    end


    def destroy
        if @employee
            @employee.destroy! 
            render_success(message: "#{@employee.name} deleted successfully " )
        else
            render_failed(message: "can not delete record with id #{params[:id]}")
        end
    end

    def get_employee_projects
        render_success(data: @employee.projects)
    end

    def edit_employee_projects
        ###
    end

    
    private 

    def employee_params
        params.permit(:name , :birth_date , :joining_date )
    end

    def set_company_employee
        @employee =  current_company.employees.find_by(id: params[:id])
    end
    
end
