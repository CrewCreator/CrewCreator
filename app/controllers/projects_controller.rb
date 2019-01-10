class ProjectsController < ApplicationController
  before_action :is_admin, only: [:new , :create, :edit, :update, :remove, :destroy]
  before_action :find_section, only: [:index, :new, :create]
  
  def index
    @projects = @section.projects
  end
  
  def new
    @project = Project.new
  end
  
  def edit
    @project = Project.find_by_id(params[:id])
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
    @project = Project.find_by_id(params[:id])
    if @project.update_attributes(project_params)
      flash[:notice] = "#{@project.name} was successfully updated."
      redirect_to section_projects_path(@project.section)
    else
      render 'edit'
    end
  end
  
  def remove
    @project = Project.find_by_id(params[:id])
  end
  
  def destroy
    removed_project = Project.find_by_id(params[:admin][:id])
    if Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      flash[:notice] = "#{removed_project.name} was successfully deleted."
      #section = removed_project.section
      removed_project.destroy
      redirect_to section_projects_path(removed_project.section)
    else
      flash[:notice] = "Incorrect Password!"
      redirect_to :action => 'remove', :id => params[:id] , :method => :get
    end
  end
  
  private def project_params
    params.require(:project).permit(:name, :description, :difficulty, skill_ids: [])
  end
  
  private def find_section
    @section = Section.find(params[:section_id])
  end
end
