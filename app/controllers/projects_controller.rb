class ProjectsController < ApplicationController
  before_action :is_admin, only: [:new , :create]
  before_action :find_section
  
  def index
    @projects = @section.projects
  end
  
  def new
    @project = Project.new
    @project.skills.build
  end
  
  def create
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
    params.require(:project).permit(:name, :description, :difficulty, 
                                    skills_attributes: [:name, :description])
  end
  
  private def find_section
    @section = Section.find(params[:section_id])
  end
end
