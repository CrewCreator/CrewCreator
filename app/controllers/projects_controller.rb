class ProjectsController < ApplicationController
  before_action :is_admin, only: [:new , :create]
  before_action :find_section, only: [:index, :new, :create]
  
  def index
    @projects = @section.projects
  end
  
  def new
    @project = Project.new
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def create
    @project = @section.projects.build(project_params)
    @project.students_rated = 0
    @project.total_interest = 0
    if @project.save
      redirect_to section_projects_path
    else
      render 'new'
    end
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:notice] = "#{@project.name} was successfully updated."
      redirect_to section_projects_path(@project.section)
    else
      render 'edit'
    end
  end
  
  private def project_params
    params.require(:project).permit(:name, :description, :difficulty, skill_ids: [])
  end
  
  private def find_section
    @section = Section.find(params[:section_id])
  end
end
