class V1::ProjectsController < ApplicationController

    before_action :set_company_project ,  except: [:index , :create ]

    # GET /v1/projects
    def index
        @projects = current_company.projects.page(page).per(per_page)
        render_data(data: collection_serializer( @projects, V1::ProjectSerializer), pages: paginate(@projects))
    end

    # GET /v1/projects/:id
    def show
        return render_success(data: V1::ProjectDetailsSerializer.new(@project)) if @project
        # render_failed(message: "You don't have record with id #{params[:id]}")
    end

    # POST /v1/projects
    def create
        project = Project.new(project_params)
        if current_company.projects << project
            render_success message: I18n.t("new_project_registered") , 
                              data: V1::ProjectSerializer.new(project) 
        else
            render_failed data: project.errors.full_messages 
        end
    end

    #PUT /v1/projects/:id
    def update
        @project.update!(project_params)
        render_success message: I18n.t("project_updated_successfully"),
                          data: V1::ProjectSerializer.new(@project)
    end

    # DELETE /v1/projects/:id
    def destroy
        @project.destroy! 
        render_success message: I18n.t("project_deleted_successfully")
        # else
        #     render_failed(message: "can not delete record with id #{params[:id]}")
        # end
    end
    

    private 

    def project_params
        params.permit(:name, :description)
    end

    def set_company_project
        @project =  current_company.projects.find(params[:id])
    end

end
