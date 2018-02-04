class V1::TasksController < ApplicationController

    before_action :set_company_project #, :valid_project_id? 
    before_action :set_selected_task  , except: [:index , :create]
    # before_action :valid_assignee_id? , only: [ :create , :update ]

    def index
        @tasks = @project.tasks.order(:id).page(page).per(per_page)
        render_data data: collection_serializer( @tasks, V1::TaskSerializer), pages: paginate(@tasks)
    end

    def create
        @project.tasks.create!(task_params)
        render_success message: I18n.t("New_task_created_successfully"),
                          data: collection_serializer(@project.tasks.order(:id), V1::TaskSerializer)
    end

    def update
        @task.update!(task_params)
        render_success message: I18n.t("task_updated_successfully"),
                          data: V1::TaskSerializer.new(@task)
    end

    def destroy
        @task.destroy!
        render_success message: I18n.t("task_deleted_succesfully")
    end
  

    private

    def task_params
        params.permit(:name, :description, :assignee_id , :status)
    end

    def set_company_project
        @project = current_company.projects.find(params[:project_id])
    end

    def set_selected_task
        @task = @project.tasks.find(params[:id].to_i)
    end

    # def valid_project_id?
    #     return render_failed(message: "There is no project with id #{params[:project_id]}" , status: 404 ) if project_not_valid
    # end

    # def project_not_valid
    #     !current_company.project_ids.include?(params[:project_id].to_i)
    # end
    
    # def valid_assignee_id?
    #     if employee_not_valid then render_failed(message: "There is no employee with id #{params[:assignee_id].to_i}" , status: 404 ) else true end 
    # end

    # def employee_not_valid     
    #     return false if params[:assignee_id] == ""
    #     params[:assignee_id] ? !params[:assignee_id].to_i.in?(current_company.employee_ids) : false
    # end

end
