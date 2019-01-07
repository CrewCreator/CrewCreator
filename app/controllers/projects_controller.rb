class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end
  
  def new
    @project = Project.new
    @difficulties = Project.difficulties
  end
  
  def create
    @project = Project.new(project_params)
    @project.students_rated = 0
    @project.total_interest = 0
    if @project.save
      redirect_to projects_path
    else
      render 'new'
    end
  end
  
  private def project_params
    params.require(:project).permit(:name, :description, :difficulty)
  end
end
