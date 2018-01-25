class V1::ProjectsController < ApplicationController

    before_action :require_login 
    before_action :set_company_project ,  except: [:index , :create ]

    
    def index
        render_success(data: ActiveModel::Serializer::CollectionSerializer.new(current_company.projects, serializer: V1::ProjectSerializer))
    end


    def show
        return render_success(data: V1::ProjectSerializer.new(@project)) if @project
        render_failed(message: "You don't have record with id #{params[:id]}")
    end


    def create
        project = Project.new(project_params)
        if current_company.projects << project
            render_success( message: "A new project has been registered" , data: V1::ProjectSerializer.new(project) )
        else
            render_failed( data: project.errors.full_messages )
        end
    end


    def update
        if @project
            @project.update!(project_params)
            render_success( message: " #{@project.name} has been updated successfully " , data: V1::ProjectSerializer.new(@project))
        else
            render_failed(message: "There is no project with id #{params[:id]}" , status: 404)
        end
    end


    def destroy
        if @project
            @project.destroy! 
            render_success(message: "#{@project.name} deleted successfully " )
        else
            render_failed(message: "can not delete record with id #{params[:id]}")
        end
    end
    

    private 

    def project_params
        params.permit(:name, :description)
    end

    def set_company_project
        @project =  current_company.projects.find(params[:id])
    end

end
