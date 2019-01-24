class TeamsController < ApplicationController
  before_action :is_admin, only: [:new , :create, :remove, :destroy]
  # need a is_student function for edit and update
  before_action :find_project, only: [:index, :new, :create]
  
  def index
    @teams = Team.all
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
      redirect_to :action => 'remove', :id => params[:id] , :method => :get
    end
  end
  
  private def team_params
    params.require(:team).permit(:name, :version_control_link,
      :production_link, :management_link, :scrum_location, :scrum_time)
  end
  
  private def find_project
    @project = Project.find(params[:project_id])
  end
end
