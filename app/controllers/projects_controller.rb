class ProjectsController < ApplicationController
  before_action :is_admin, only: [:new , :create]
  
  def index
    @section = Section.find(params[:section_id])
    @projects = @section.projects
  end
  
  def new
    @section = Section.find(params[:section_id])
    @project = Project.new
  end
  
  def create
    @section = Section.find(params[:section_id])
    @project = @section.projects.build(project_params)
    @project.students_rated = 0
    @project.total_interest = 0
    if @project.save
      redirect_to course_section_projects_path
    else
      render 'new'
    end
  end
  
  private def project_params
    params.require(:project).permit(:name, :description, :difficulty)
  end
end
