class V1::ProjectsController < ApplicationController

    before_action :set_project ,  except: [:index , :create ]
    before_action :set_company_projects, only: :index

    # GET /v1/projects
    def index
        render_data(data: collection_serializer( @projects, V1::ProjectSerializer), pages: paginate(@projects))
    end

    # GET /v1/projects/:id
    def show
        return render_success(data: V1::ProjectDetailsSerializer.new(@project)) if @project
    end

    # POST /v1/projects
    def create
        project = Project.new(project_params)
        if current_company.projects << project
            render_success message: I18n.t("new_project_registered") , 
                           data:    V1::ProjectSerializer.new(project) 
        else
            render_failed data: project.errors.full_messages 
        end
    end

    #PUT /v1/projects/:id
    def update
        @project.update!(project_params)
        render_success message: I18n.t("project_updated_successfully"),
                       data:    V1::ProjectSerializer.new(@project)
    end

    # DELETE /v1/projects/:id
    def destroy
        @project.destroy! 
        render_success message: I18n.t("project_deleted_successfully")
    end
    

    private 

    def project_params
        params.permit(:name, :description)
    end

    def set_project
        @project =  current_company.projects.find(params[:id])
    end

    def set_company_projects
        @q = current_company.projects.ransack(params[:q])
        @projects = @q.result.page(page).per(per_page)
    end

end
