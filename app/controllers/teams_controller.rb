class TeamsController < ApplicationController
  before_action :is_admin, only: [:new , :create, :remove, :destroy]
  # is_user function for edit and update since studets can edit/update teams info
  before_action :is_user, only: [:edit, :update]
  before_action :find_project, only: [:new, :create]
  
  def index
    @section = Section.find(params[:section_id])
    @teams = @section.teams
  end
  
  def show
    @team = Team.find(params[:id])
  end
  
  def new
    @team = Team.new
  end
  
  def edit
    @team = Team.find(params[:id])
  end
  
  def create
    @team = @project.teams.build(team_params)
    if @team.save
      redirect_to section_projects_path(section_id: @project.section)
    else
      render 'new'
    end
  end
  
  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      flash[:notice] = "#{@team.name} was successfully updated."
      redirect_to team_path
    else
      render 'edit'
    end
  end
  
  def remove
    @team = Team.find_by_id(params[:id])
  end
  
  def destroy
    removed_team = Team.find_by_id(params[:admin][:id])
    if Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      flash[:notice] = "#{removed_team.name} was successfully deleted."
      removed_team.destroy
      redirect_to section_projects_path(removed_team.project.section)
    else
      flash[:notice] = "Incorrect Password!"
      redirect_to remove_team_path(removed_team)
    end
  end
  
  private def team_params
    params.require(:team).permit(:name, :version_control_link,
      :production_link, :management_link, :scrum_location, :scrum_time, student_ids: [])
  end
  
  private def student_params
    params.require(:team).permit(student_ids: [])
  end
  
  private def find_project
    @project = Project.find(params[:project_id])
  end
end
