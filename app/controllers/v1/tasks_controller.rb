class V1::TasksController < ApplicationController

    before_action :require_login , :valid_project_id? , :set_company_project
    before_action :set_selected_task  , except: [:index , :create]
    # before_action :valid_assignee_id? , only: [ :create , :update ]

    def index
        render_success(data:  ActiveModel::Serializer::CollectionSerializer.new( @project.tasks.all , serializer: V1::TaskSerializer))
    end

    def create
        return render_success(message: "New task have been created successfully " , data: V1::TaskSerializer.new(@new_task)) if valid_creation
        render_failed(message: @new_task.errors.full_messages)
    end

    def update
        if @task.update(task_params)
            render_success(message: "#{@task.name} has been updated successfully" , data: V1::TaskSerializer.new(@task) )
        else
            render_failed(message: @task.errors.full_messages)
        end
    end

    def destroy
        @task.destroy
        render_success(message: "#{@task.name} deleted succesfully " )
    end
  
    private

    def task_params
        params.permit(:name , :description , :assignee_id  , :status)
    end

    def set_company_project
        @project = current_company.projects.find(params[:project_id])
    end

    def set_selected_task
        @task = @project.tasks.find(params[:id].to_i)
    end

    def valid_project_id?
        return render_failed(message: "There is no project with id #{params[:project_id]}" , status: 404 ) if project_not_valid
    end
    
    def project_not_valid
        !current_company.project_ids.include?(params[:project_id].to_i)
    end

    # def valid_assignee_id?
    #     if employee_not_valid then render_failed(message: "There is no employee with id #{params[:assignee_id].to_i}" , status: 404 ) else true end 
    # end

    # def employee_not_valid     
    #     return false if params[:assignee_id] == ""
    #     params[:assignee_id] ? !params[:assignee_id].to_i.in?(current_company.employee_ids) : false
    # end

    def valid_creation
        @new_task = Task.new(task_params)
        @project.tasks << @new_task
        @new_task.save
    end
end
